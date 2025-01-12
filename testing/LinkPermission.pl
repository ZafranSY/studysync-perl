package LinkPermission;
use Log::Log4perl;
# Initialize Log4perl with a configuration
Log::Log4perl->init(\ q(
    log4perl.rootLogger              = DEBUG, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.layout  = Log::Log4perl::Layout::SimpleLayout
));

# Get a logger object
my $logger = Log::Log4perl->get_logger();


sub getLinkPermission {
    my ($dbh,$gdlink_id) = @_;
    my $sth = $dbh->prepare('
                            SELECT * 
                            FROM linkPermission 
                            WHERE gdlink_id = ?
                            ;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($gdlink_id) 
        or die 'execution failed: ' . $dbh->errstr();

    my @result;
    while (my @row = $sth->fetchrow_array) {
        push @result, \@row;  
    }
    return \@result;
}


sub CreateLinkPermissionRole {
    my ($dbh, $semester_id,$category_name,$gdlink_id,$insert_user_role,$can_read,$can_update,$can_delete) = @_;

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM roles 
        WHERE role_name = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot add permission $insert_user_role for roles that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM linkPermission 
        WHERE role_name = ? AND semester_id = ? AND category = ? AND gdlink_id=?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role, $semester_id, $category_name,$gdlink_id)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Category Permission for role $insert_user_role already exists in in gdlink id $gdlink_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            INSERT INTO linkPermission 
                            (category, semester_id, role_name,gdlink_id, can_read, can_update,can_delete)
                            VALUES (?,?,?,?,?,?,?);
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$insert_user_role,$gdlink_id,$can_read,$can_update,$can_delete) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for role $insert_user_role created successfully" };
    } else {
        return { error => "Category Permission for role $insert_user_role failed to be created" };
    }
    
    return $result;
}

sub CreateLinkPermissionUser {
    my ($dbh, $semester_id,$category_name,$gdlink_id,$insert_user_role,$can_read,$can_update,$can_delete) = @_;

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM user 
        WHERE email = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot add permission $insert_user_role for email that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM linkPermission 
        WHERE user_email = ? AND semester_id = ? AND category = ? AND gdlink_id=?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role, $semester_id, $category_name,$gdlink_id)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Category Permission for email $insert_user_role already exists in gdlink id $gdlink_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            INSERT INTO linkPermission 
                            (category, semester_id, user_email,gdlink_id, can_read, can_update,can_delete)
                            VALUES (?,?,?,?,?,?,?);
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$insert_user_role,$gdlink_id,$can_read,$can_update,$can_delete) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for email $insert_user_role created successfully" };
    } else {
        return { error => "Category Permission for email $insert_user_role failed to be created" };
    }
    
    return $result;
}

sub UpdateLinkPermissionRole {
    my ($dbh,$gdlink_id,$insert_user_role,$can_read,$can_update,$can_delete) = @_;

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM roles 
        WHERE role_name = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot add permission $insert_user_role for roles that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM linkPermission 
        WHERE role_name = ? AND semester_id = ? AND category = ? AND gdlink_id=?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role, $semester_id, $category_name,$gdlink_id)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Link Permission for role $insert_user_role already exists in in gdlink id $gdlink_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            UPDATE linkPermission
                            SET can_read = ?,
                                can_update=  ?,
                                can_delete=?
                            WHERE 
                                
                                role_name= ?
                                AND gdlink_id=?
                                ;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($can_read,$can_update,$can_delete,$insert_user_role,$gdlink_id) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Link Permission for role $insert_user_role updated successfully" };
    } else {
        return { error => "Link Permission for role $insert_user_role failed to be updated" };
    }
    
    return $result;
}

sub UpdateLinkPermissionUser {
    my ($dbh,$gdlink_id,$insert_user_role,$can_read,$can_update,$can_delete) = @_;

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM user 
        WHERE email = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot add permission $insert_user_role for email that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM linkPermission 
        WHERE user_email = ? AND semester_id = ? AND category = ? AND gdlink_id=?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role, $semester_id, $category_name,$gdlink_id)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Link Permission for email $insert_user_role already exists in gdlink id $gdlink_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            UPDATE linkPermission
                            SET can_read = ?,
                                can_update=  ?,
                                can_delete=?
                            WHERE 
                                
                                user_email= ?
                                AND gdlink_id=?
                                ;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($can_read,$can_update,$can_delete,$insert_user_role,$gdlink_id) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Link Permission for email $insert_user_role updated successfully" };
    } else {
        return { error => "Link Permission for email $insert_user_role failed to be updated" };
    }
    
    return $result;
}


sub DeleteLinkPermissionUser {
    my ($dbh, $session_id, $semester_id, $category_name, $user_email) = @_;

    # Log the operation
    $logger->info("Attempting to delete link permission for user_email: $user_email in category: $category_name, semester: $semester_id");

    # Validate input
    if (!$user_email || !$semester_id || !$category_name) {
        $logger->error("Invalid parameters provided for deleting link permission");
        return { error => "Missing required parameters: user_email, category_name, or semester_id." };
    }

    # Prepare and execute the SQL query
    my $sth = $dbh->prepare('
        DELETE FROM linkPermission 
        WHERE category = ? 
        AND semester_id = ? 
        AND user_email = ?;
    ') or do {
        $logger->error("SQL prepare failed: " . $dbh->errstr);
        return { error => "Failed to prepare SQL statement." };
    };

    my $result = $sth->execute($category_name, $semester_id, $user_email) or do {
        $logger->error("SQL execution failed: " . $dbh->errstr);
        return { error => "Failed to execute SQL statement." };
    };

    if ($result) {
        $logger->info("Link permission for user_email: $user_email successfully deleted.");
        return { message => "Link permission for $user_email in $category_name, $semester_id deleted successfully." };
    } else {
        $logger->error("Failed to delete link permission for user_email: $user_email");
        return { error => "Failed to delete link permission for $user_email in $category_name, $semester_id." };
    }
}

sub DeleteLinkPermissionRole {
    my ($dbh, $session_id, $semester_id, $category_name, $user_role) = @_;

    # Log the operation
    $logger->info("Attempting to delete link permission for user_role: $user_role in category: $category_name, semester: $semester_id");

    # Validate input
    if (!$user_role || !$semester_id || !$category_name) {
        $logger->error("Invalid parameters provided for deleting link permission");
        return { error => "Missing required parameters: user_role, category_name, or semester_id." };
    }

    # Prepare and execute the SQL query
    my $sth = $dbh->prepare('
        DELETE FROM linkPermission 
        WHERE category = ? 
        AND semester_id = ? 
        AND role_name = ?;
    ') or do {
        $logger->error("SQL prepare failed: " . $dbh->errstr);
        return { error => "Failed to prepare SQL statement." };
    };

    my $result = $sth->execute($category_name, $semester_id, $user_role) or do {
        $logger->error("SQL execution failed: " . $dbh->errstr);
        return { error => "Failed to execute SQL statement." };
    };

    if ($result) {
        $logger->info("Link permission for user_role: $user_role successfully deleted.");
        return { message => "Link permission for $user_role in $category_name, $semester_id deleted successfully." };
    } else {
        $logger->error("Failed to delete link permission for user_role: $user_role");
        return { error => "Failed to delete link permission for $user_role in $category_name, $semester_id." };
    }
}


1;


