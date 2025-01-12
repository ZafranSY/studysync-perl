package User;
use URI::Escape;
use JSON;
use Time::Piece;
use Log::Log4perl;
# Initialize Log4perl with a configuration
Log::Log4perl->init(\ q(
    log4perl.rootLogger              = DEBUG, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.layout  = Log::Log4perl::Layout::SimpleLayout
));

# Get a logger object
my $logger = Log::Log4perl->get_logger();

sub callAuthAPI {
    my ($dbh,$username, $password) = @_;

    if($username==$password){
        my $sth = $dbh->prepare('
        SELECT * from user where login_name=?;
        ') or die 'Prepare failed: ' . $dbh->errstr();

        $sth->execute($username) or die 'Execution failed: ' . $dbh->errstr();

        my $row = $sth->fetchrow_hashref;
        $result=GetUserData($dbh,$row->{session_id});
        return $result;
    }

    my $base_url = 'http://web.fc.utm.my/ttms/web_man_webservice_json.cgi';
    my $entity = 'authentication';
    my $url = "$base_url?entity=$entity&login=" . uri_escape($username) . "&password=" . uri_escape($password);
    my $ua = LWP::UserAgent->new;

    my $response = $ua->get($url);

    if ($response->is_success) {
        my $userdata_text = $response->decoded_content;  # Raw JSON text
        my $result;

        eval {
            $result = decode_json($userdata_text);
        };
        if ($@) {
            return {
                success => 0,
                error   => "Failed to decode JSON: $@"
            };
        }

        return {
            success => 1,
            result  => $result
        };
    } else {
        return {
            success => 0,
            error   => {
                code    => $response->code,
                message => $response->message
            }
        };
    }
}


sub userToDB {
    my ($dbh, $json) = @_;
    my $userdata=$json->{result}[0];
    my $full_name = $userdata->{full_name};
    my $login_name = $userdata->{login_name};
    my $email = $userdata->{email};
    my $role_name = $userdata->{description} // '';  
    my $session_id = $userdata->{session_id};

    my $successful_logins = $userdata->{successful_logins} // 0;  
    my $last_login = localtime->strftime('%Y-%m-%d %H:%M:%S'); 
    
    my $sth = $dbh->prepare(
        'SELECT user_id, successful_logins FROM user WHERE login_name = ? OR email = ?'
    ) or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($login_name, $email) or die 'execution failed: ' . $dbh->errstr();
    my $existing_user = $sth->fetchrow_hashref();
    
    if ($existing_user) {
        my $new_successful_logins = $existing_user->{successful_logins} + 1;

        $sth = $dbh->prepare(
            'UPDATE user SET successful_logins = ?, session_id = ?, last_login = ? WHERE user_id = ?'
        ) or die 'prepare statement failed: ' . $dbh->errstr();
        $sth->execute($new_successful_logins, $session_id, $last_login, $existing_user->{user_id}) 
            or die 'execution failed: ' . $dbh->errstr();
        
        return { success => 1, message => "User updated successfully" };
    } else {

        my $sth = $dbh->prepare(
            'SELECT COUNT(*) FROM roles WHERE role_name = ?'
        ) or die 'prepare statement failed: ' . $dbh->errstr;

        $sth->execute($role_name) or die 'execution failed: ' . $dbh->errstr;

        my ($role_count) = $sth->fetchrow_array();

        if ($role_count == 0) {
            $sth = $dbh->prepare(
                'INSERT INTO roles (role_name) VALUES (?)'
            ) or die 'prepare statement failed: ' . $dbh->errstr;
            $sth->execute($role_name) or die 'execution failed: ' . $dbh->errstr;
        }

        my $sth = $dbh->prepare(
            'SELECT * FROM roles WHERE role_name = ?'
        ) or die 'prepare statement failed: ' . $dbh->errstr;

        $sth->execute($role_name) or die 'execution failed: ' . $dbh->errstr;

        my $row = $sth->fetchrow_hashref;
        my $role_id= $row->{role_id};
        
        $sth = $dbh->prepare(
            'INSERT INTO user (full_name, login_name, email, role_id, session_id, successful_logins, last_login)
            VALUES (?, ?, ?, ?, ?, ?, ?)'
        ) or die 'prepare statement failed: ' . $dbh->errstr();
        $sth->execute($full_name, $login_name, $email, $role_id, $session_id, $successful_logins, $last_login)
            or die 'execution failed: ' . $dbh->errstr();
        
        return { success => 1, message => "User created successfully" };
    }
}


sub GetUserData {
    my ($dbh, $session_id) = @_;
    
    my $sth = $dbh->prepare('
        SELECT u.full_name, u.login_name, u.email, u.session_id, r.role_name AS description
        FROM user u
        JOIN roles r ON u.role_id = r.role_id
        WHERE u.session_id = ?
    ') or die 'Prepare failed: ' . $dbh->errstr();

    $sth->execute($session_id) or die 'Execution failed: ' . $dbh->errstr();

    my @result;
    
    # Fetch the data and store it in a structured format
    while (my $row = $sth->fetchrow_hashref) {
        push @result, {
            description  => $row->{description},
            email        => $row->{email},
            full_name    => $row->{full_name},
            login_name   => $row->{login_name},
            session_id   => $row->{session_id},
        };
    }
    
    # Return the result in the desired format
    return { result => \@result, success => 1 };
}


sub getAllRoles {
    my $dbh = shift(@_);
    my $sth = $dbh->prepare('SELECT * FROM roles')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();
    my @rolelist;
    while (my $row = $sth->fetchrow_hashref) {
        push @rolelist, $row->{role_name};
    }
    return \@rolelist;
}

sub getAllEmails {
    my $dbh = shift(@_);
    my $sth = $dbh->prepare('SELECT * FROM user')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();
    my @emaillist;
    while (my $row = $sth->fetchrow_hashref) {
        push @emaillist, $row->{email};
    }
    return \@emaillist;
}

1;