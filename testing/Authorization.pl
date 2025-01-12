package Authorization;

use DBI;
use Log::Log4perl;

# Initialize Log4perl with a configuration
Log::Log4perl->init(\ q(
    log4perl.rootLogger              = DEBUG, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.layout  = Log::Log4perl::Layout::SimpleLayout
));

# Get a logger object
my $logger = Log::Log4perl->get_logger();

sub check_session_role {
    my ($dbh, $session_id, $required_rolename) = @_;

    $logger->info("Checking session role for session_id: $session_id, required role: $required_rolename");

    my $sth = $dbh->prepare('SELECT * FROM roles WHERE role_name=?')
        or do return { error => 'Failed to prepare statement: ' . $dbh->errstr };
    
    $sth->execute($required_rolename)
        or do return { error => 'Execution failed: ' . $dbh->errstr };
    
    my $req_role_id = $sth->fetchrow_hashref;
    
    $sth = $dbh->prepare('SELECT * FROM user WHERE session_id=?');
    $sth->execute($session_id)
        or do return { error => 'Execution failed: ' . $dbh->errstr };
        
    my $user_role_id = $sth->fetchrow_hashref;

    if (!$user_role_id) {
        return { error => 'Invalid session_id' };
    }

    if ($user_role_id->{role_id} ne $req_role_id->{role_id}) {
        $logger->error("Insufficient role privileges for session_id: $session_id  $user_role_id->{role_id}  $req_role_id->{role_id}");
        return { error => 'Insufficient role privileges' };
    }

    return { message => 'Authentication successful' };
}

sub getRoleName {
    my ($dbh, $session_id) = @_;
    my $sth = $dbh->prepare('select * from roles where role_id= (
            select role_id from user where session_id=?
        )')
        or do return { error => 'Failed to prepare statement: ' . $dbh->errstr };
    $sth->execute($session_id)
        or do return { error => 'Execution failed: ' . $dbh->errstr };
    my $row = $sth->fetchrow_hashref;
    my $role_name = $row->{role_name};
    
    $logger->info("Checking session role for session_id: $session_id, role_name: $role_name");
    return $role_name;
}

sub getEmail {
    my ($dbh, $session_id) = @_;
    $logger->info("ssid : $session_id");
    my $sth = $dbh->prepare('SELECT * FROM user WHERE session_id=?')
        or do return { error => 'Failed to prepare statement: ' . $dbh->errstr };
    $sth->execute($session_id)
        or do return { error => 'Execution failed: ' . $dbh->errstr };
    $email=$sth->fetchrow_hashref->{email};
    
    return $email;
}


sub isLinkOwner {
    my ($dbh, $gdlink_id,$email) = @_;
    my $sth = $dbh->prepare('SELECT * FROM gdlinks WHERE gdlink_id=?')
        or do return { error => 'Failed to prepare statement: ' . $dbh->errstr };
    $sth->execute($gdlink_id)
        or do return { error => 'Execution failed: ' . $dbh->errstr };
    my $oe=$sth->fetchrow_hashref;
    my $owner_email=$oe->{owner};
    $logger->info("$email,, $owner_email");
    if($owner_email eq $email){
        return {success => ' gdlink owner'}
    }
    return { error => 'Not gdlinks owner' };
    
}

1;
