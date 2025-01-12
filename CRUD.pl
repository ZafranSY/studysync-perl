package CRUD;

use JSON::XS;
use Data::Dumper;
print Dumper($json);

sub create {
    my $dbh = shift(@_);

    print "Category: ";
    my $category = <STDIN>;
    $category =~ s/\n//;

    print "Ref. Name: ";
    my $ref_name = <STDIN>;
    $ref_name =~ s/\n//;

    print "Session-Semester: ";
    my $sessem = <STDIN>;
    $sessem =~ s/\n//;

    print "Description: ";
    my $description = <STDIN>;
    $description =~ s/\n//;


    print "Owner: ";
    my $owner = <STDIN>;
    $owner =~ s/\n//;

    print "Link: ";
    my $link = <STDIN>;
    $link =~ s/\n//;

    my $sth = $dbh->prepare(
        'INSERT INTO gdlinks (category, ref_name, sessem, description, owner, link) values (?, ?, ?, ?, ?, ?)'
    ) or die 'prepare statement failed: ' . $dbh->errstr();

    $sth->execute($category, $ref_name, $sessem, $description, $owner, $link) or die 'execution failed: ' . $dbh->errstr();
}

sub createJSON {
    my $dbh = shift(@_);
    my $json = shift(@_);

    my $table = $json->{'table'};
    my $data = $json->{'data'};

    print "\$table = $table\n";

    if ($table eq "gdlinks") {
        my $sth = $dbh->prepare(
            'INSERT INTO gdlinks (category, ref_name, sessem, description, owner, link) values (?, ?, ?, ?, ?, ?)'
        ) or die 'prepare statement failed: ' . $dbh->errstr();

        $sth->execute($data->{'category'}, $data->{'ref_name'}, $data->{'sessem'}, 
                      $data->{'description'}, $data->{'owner'}, $data->{'link'}) or die 'execution failed: ' . $dbh->errstr();


        $json->{'operation'} = "CREATE";
        return $json;
    }
}

sub readJSON {
    my $dbh = shift(@_);
    my $json = shift(@_);

    my $table = $json->{'table'};
    my $data = $json->{'data'};

    print "\$table = $table\n";

    if ($table eq "gdlinks") {
        my $sth = $dbh->prepare(
            'SELECT * FROM gdlinks'
        ) or die 'prepare statement failed: ' . $dbh->errstr();

        $sth->execute() or die 'execution failed: ' . $dbh->errstr();

        return $sth->fetchall_arrayref({});
    }
}

sub updateJSON {
    my $dbh = shift(@_);
    my $json = shift(@_);

    my $table = $json->{'table'};
    my $data = $json->{'data'};
    my $id =  $json->{'id'};

    print "\$table = $table\n";

    if ($table eq "gdlinks") {
        my $sth = $dbh->prepare(
            'UPDATE gdlinks SET category=?, ref_name=?, sessem=?, description=?, owner=?, link=? WHERE id_gdlink=?'
        ) or die 'prepare statement failed: ' . $dbh->errstr();

        $sth->execute($data->{'category'}, $data->{'ref_name'}, $data->{'sessem'}, 
                      $data->{'description'}, $data->{'owner'}, $data->{'link'}, $id) or die 'execution failed: ' . $dbh->errstr();


        $json->{'operation'} = "UPDATE";
        return $json;
    }
}

sub deleteJSON {
    my $dbh = shift(@_);
    my $json = shift(@_);

    my $table = $json->{'table'};
    my $id = $json->{'id'};

    print "\$table = $table\n";

    if ($table eq "gdlinks") {
        my $sth = $dbh->prepare(
            'DELETE FROM gdlinks WHERE id_gdlink=?'
        ) or die 'prepare statement failed: ' . $dbh->errstr();

        $sth->execute($id) or die 'execution failed: ' . $dbh->errstr();

        $json->{'operation'} = "DELETE";
        return $json;
    }
}
sub getCategory {
    my $dbh = shift(@_);

    # Prepare the SQL statement to get unique categories
    my $sth = $dbh->prepare('SELECT DISTINCT category FROM gdlinks')
        or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();

    # Fetch all unique categories
    my @categories = ();
    while (my $row = $sth->fetchrow_hashref()) {
        push @categories, $row->{'category'};
    }

    return \@categories;
}
sub getSemester {
    my $dbh = shift(@_);

    # Prepare the SQL statement to get unique session-semester values
    my $sth = $dbh->prepare('SELECT DISTINCT sessem FROM gdlinks')
        or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();

    # Fetch all unique session-semester values
    my @semesters = ();
    while (my $row = $sth->fetchrow_hashref()) {
        push @semesters, $row->{'sessem'};
    }

    return \@semesters;
}
sub getBySemesterAndCategory {
    my ($dbh, $semester, $category) = @_;

    # Prepare the SQL query with placeholders for semester and category
    my $sth = $dbh->prepare(
        'SELECT * FROM gdlinks WHERE sessem = ? AND category = ?'
    ) or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query with the provided semester and category
    $sth->execute($semester, $category) or die 'execution failed: ' . $dbh->errstr();

    # Fetch all matching rows
    return $sth->fetchall_arrayref({});
}

# Function to handle search
sub getSearch {
    my ($dbh, $search) = @_;

    # Prepare the SQL query to search for entries that match the search term
    my $sth = $dbh->prepare(
        'SELECT * FROM gdlinks WHERE category LIKE ? OR ref_name LIKE ? OR description LIKE ?'
    ) or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query with the search term
    my $search_term = "%$search%"; # Use wildcards for partial matches
    $sth->execute($search_term, $search_term, $search_term) or die 'execution failed: ' . $dbh->errstr();

    # Fetch matching rows
    return $sth->fetchall_arrayref({});
}
sub addLinkWithDesc {
    my ($dbh, $link, $Desc) = @_;

    # Prepare the SQL statement to insert the link and message into the database
    my $sth = $dbh->prepare('INSERT INTO gdlinks (link, message) VALUES (?, ?)')
        or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query
    $sth->execute($link, $Desc) or die 'execution failed: ' . $dbh->errstr();

    # Return a success status
    return 1;
}

sub getCategoryBySemester {
    my ($dbh, $semester) = @_;

    # Prepare the SQL statement to fetch unique categories for the given semester
    my $sth = $dbh->prepare(
        'SELECT DISTINCT category FROM gdlinks WHERE sessem = ?'
    ) or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query with the provided semester
    $sth->execute($semester) or die 'execution failed: ' . $dbh->errstr();

    # Fetch the unique categories
    my @categories = ();
    while (my $row = $sth->fetchrow_hashref()) {
        push @categories, $row->{'category'};
    }

    return \@categories;
}
sub getRefnameByCategory {
    my ($dbh, $category) = @_;  # Get the database handle and category from the caller

    # SQL query to select the desired columns (ref_name, description, owner) where the category matches
    my $sql = 'SELECT ref_name, description, owner FROM gdlinks WHERE category = ?';
    
    # Prepare the statement and execute it with the provided category
    my $sth = $dbh->prepare($sql) or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($category) or die 'execution failed: ' . $dbh->errstr();
    
    # Fetch all results
    my @files;
    while (my $row = $sth->fetchrow_hashref) {
        push @files, {
            ref_name    => $row->{ref_name},
            sessem => $row->{sessem},
            description => $row->{description},
            owner       => $row->{owner},
        };
    }
    
    # Return the results as an array of hashes
    return \@files;
}


sub getlinkbyRefname {
    my ($dbh, $category) = @_;  # Get the database handle and category from the caller

    # SQL query to select the desired columns (ref_name, description, owner) where the category matches
my $sql = 'SELECT link_refName, link_description, link_posted, owner, link_url FROM link_details WHERE link_refName = ?';

    
    # Prepare the statement and execute it with the provided category
    my $sth = $dbh->prepare($sql) or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($category) or die 'execution failed: ' . $dbh->errstr();
    
    # Fetch all results
    my @files;
    while (my $row = $sth->fetchrow_hashref) {
        push @files, {
            link_refName    => $row->{link_refName},
            link_description => $row->{link_description},
            link_posted     => $row->{link_posted},
            owner           => $row->{owner},
            link_url        => $row->{link_url},
        };
    }
    
    # Return the results as an array of hashes
    return \@files;
}

sub createUser {
    my ($dbh, $json) = @_;

    my $full_name = $json->{full_name};
    my $login_name = $json->{login_name};
    my $email = $json->{email};
    my $role = $json->{role} // '';  
    my $session_id = $json->{session_id};
    my $successful_logins = $json->{successful_logins} // 0;  
    my $last_login = $json->{last_login} // 'CURRENT_TIMESTAMP';  

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
        $sth = $dbh->prepare(
            'INSERT INTO user (full_name, login_name, email, role_name, session_id, successful_logins, last_login)
            VALUES (?, ?, ?, ?, ?, ?, ?)'
        ) or die 'prepare statement failed: ' . $dbh->errstr();
        $sth->execute($full_name, $login_name, $email, $role, $session_id, $successful_logins, $last_login)
            or die 'execution failed: ' . $dbh->errstr();
        
        return { success => 1, message => "User created successfully" };
    }
}

sub getAllLinks {
    my $dbh = shift(@_);  # Database handle

    # Prepare the SQL statement to get all rows from gdlinks
    my $sth = $dbh->prepare('SELECT * FROM gdlinks')
        or die 'prepare statement failed: ' . $dbh->errstr();

    # Execute the query
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();

    # Fetch all rows as an array of hashes
    my @files = ();
    while (my $row = $sth->fetchrow_hashref()) {
        push @files, $row;
    }

    return \@files;  # Return the array reference containing all records
}




1;