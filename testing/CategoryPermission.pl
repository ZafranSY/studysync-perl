package CategoryPermission;
use Log::Log4perl;
# Initialize Log4perl with a configuration
Log::Log4perl->init(\ q(
    log4perl.rootLogger              = DEBUG, Screen
    log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.layout  = Log::Log4perl::Layout::SimpleLayout
));

# Get a logger object
my $logger = Log::Log4perl->get_logger();


sub getCategoryPermission {
    my ($dbh,$session_id, $semester_id,$category_name) = @_;
    $role_name=Authorization::getRoleName($dbh, $session_id);
    $email=Authorization::getEmail($dbh, $session_id);
    my $sth = $dbh->prepare('
                            SELECT * 
                            FROM categoryPermission 
                            WHERE semester_id = ? 
                            AND category =?;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id,$category_name) 
        or die 'execution failed: ' . $dbh->errstr();
    my @categoryPermission;
    while (my $row = $sth->fetchrow_hashref) {
        push @categoryPermission, $row;
    }
    # return \@categoryPermission;
    return \@categoryPermission;
}

sub CheckInsertPermission {
    my ($dbh, $semester_id, $category_name, $email,$role_name) = @_;

    # First, check if the user is an Academic Officer
    my $sth_role_check = $dbh->prepare('
        SELECT 1
        FROM user
        WHERE email = ?
        AND role_id = (SELECT role_id FROM roles WHERE role_name = "Academic Officer")
        LIMIT 1
    ') or die 'Prepare failed: ' . $dbh->errstr();

    # Execute the role check query
    $sth_role_check->execute($email)
        or die 'Execution failed: ' . $dbh->errstr();

    # If the user is an Academic Officer, return permission granted
    if (my $row = $sth_role_check->fetchrow_arrayref) {
        return 1;  # Academic Officer has permission
    }

    # If not an Academic Officer, check the category permission
    my $sth = $dbh->prepare('
        SELECT 1
        FROM categoryPermission
        WHERE category = ?
            AND can_create_links = 1
            AND semester_id = ?
            AND (
            role_name = ? OR 
            role_name = \'Everyone\'   OR
            user_email = ?
            )
        LIMIT 1
    ') or die 'Prepare failed: ' . $dbh->errstr();

    $sth->execute($category_name, $semester_id,$role_name,$email)
        or die 'Execution failed: ' . $dbh->errstr();

    my $row = $sth->fetchrow_hashref();
    if ($row) {
        $logger->info('Permission granted: ' . join(', ', map { "$_ => $row->{$_}" } keys %$row));
    } else {
        $logger->info('Permission denied.'." \nCat : ".$category_name." \nSEm: ".$semester_id." \nEmail: ".$email." \nRole:".$role_name);
    }

    # Check if permission was granted
    if ($row) {
        return 1;  # Permission granted
    } else {
        return 0;  # Permission denied
    }
}

sub getCategoryPermissionRead {
    my ($dbh, $session_id, $semester_id) = @_;
    $role_name=Authorization::getRoleName($dbh, $session_id);
    $email=Authorization::getEmail($dbh, $session_id);
    my $sth = $dbh->prepare('SELECT * 
                            FROM categoryPermission 
                            WHERE semester_id = ? 
                            AND (user_email = ? OR role_name = ? OR role_name=\'Everyone\') 
                            AND (can_read_category = 1 or \'Academic Officer\'=?);')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id,$email,$role_name,$role_name) 
        or die 'execution failed: ' . $dbh->errstr();
    my @categoryPermission;
    my %seen; # Hash to track seen categories

    while (my $row = $sth->fetchrow_hashref) {
        my $category = $row->{category};
        unless ($seen{$category}++) { # Add category if not seen before
            push @categoryPermission, $category;
        }
    }
    # return \@categoryPermission;
    return \@categoryPermission;
}


sub getCategoryPermissionCreate {
    my ($dbh, $session_id, $semester_id) = @_;
    $role_name=Authorization::getRoleName($dbh, $session_id);
    $email=Authorization::getEmail($dbh, $session_id);
    my $sth = $dbh->prepare('SELECT * 
                            FROM categoryPermission 
                            WHERE semester_id = ? 
                            AND (user_email = ? OR role_name = ? OR role_name=\'Everyone\') 
                            AND can_read_category = 1 AND can_create = 1;')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id,$email,$role_name) 
        or die 'execution failed: ' . $dbh->errstr();
    my @categoryPermission;
    while (my $row = $sth->fetchrow_hashref) {
        push @categoryPermission, $row->{category};
    }
    # return \@categoryPermission;
    return \@categoryPermission;
}



sub CreateCategoryPermissionRole {
    my ($dbh,$session_id, $semester_id,$category_name,$insert_user_role,$can_read_category,$can_create_links) = @_;

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
        SELECT COUNT(*) FROM categoryPermission 
        WHERE role_name = ? AND semester_id = ? AND category = ?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_role, $semester_id, $category_name)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Category Permission for role $insert_user_role already exists in category $category_name, $semester_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            INSERT INTO categoryPermission 
                            (category, semester_id, role_name, can_read_category, can_create_links)
                            VALUES (?,?,?,?,?);
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$insert_user_role,$can_read_category,$can_create_links) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for role $insert_user_role created successfully" };
    } else {
        return { error => "Category Permission for role $insert_user_role failed to be created" };
    }
    
    return $result;
}

sub CreateCategoryPermissionUser {
    my ($dbh,$session_id, $semester_id,$category_name,$insert_user_email,$can_read_category,$can_create_links) = @_;

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM user 
        WHERE email = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_email)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot add permission $insert_user_email for user that doesnt exist. " };
    }

    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM categoryPermission 
        WHERE user_email = ? AND semester_id = ? AND category = ?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($insert_user_email, $semester_id, $category_name)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if ($exists) {
        return { error => "Category Permission for email $insert_user_email already exists in category $category_name, $semester_id . Try editing existing Perm instead" };
    }

    my $sth = $dbh->prepare('
                            INSERT INTO categoryPermission 
                            (category, semester_id, user_email, can_read_category, can_create_links)
                            VALUES (?,?,?,?,?);
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$insert_user_email,$can_read_category,$can_create_links) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for email $insert_user_email created successfully" };
    } else {
        return { error => "Category Permission for email $insert_user_email failed to be created" };
    }
    
    return $result;
}


sub UpdateCategoryPermissionRole {
    my ($dbh,$session_id, $semester_id,$category_name,$user_role,$can_read_category,$can_create_links) = @_;

    my $check_sth = $dbh->prepare('
    SELECT COUNT(*) FROM roles 
    WHERE role_name = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($user_role)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot edit permission $user_role for roles that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM categoryPermission 
        WHERE role_name = ? AND semester_id = ? AND category = ?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($user_role, $semester_id, $category_name)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Category Permission for role $user_role does not exists in category $category_name, $semester_id . CANNOT update Perm . Try inserting instead." };
    }

    my $sth = $dbh->prepare('
                            UPDATE categoryPermission
                            SET can_read_category = ?,
                                can_create_links=  ?
                            WHERE 
                                category= ?     
                                AND semester_id= ? 
                                AND role_name= ?
                                ;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($can_read_category,$can_create_links,$category_name,$semester_id,$user_role,) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for role $user_role updated successfully" };
    } else {
        return { error => "Category Permission for role $user_role failed to be updated" };
    }
    
    return $result;
}

sub UpdateCategoryPermissionUser {
    my ($dbh,$session_id, $semester_id,$category_name,$user_email,$can_read_category,$can_create_links) = @_;

    my $check_sth = $dbh->prepare('
    SELECT COUNT(*) FROM user 
    WHERE email = ? ;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($user_email)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Cannot edit permission $user_email for user that doesnt exist. " };
    }


    my $check_sth = $dbh->prepare('
        SELECT COUNT(*) FROM categoryPermission 
        WHERE user_email = ? AND semester_id = ? AND category = ?;
    ') or die 'prepare statement failed: ' . $dbh->errstr();

    $check_sth->execute($user_email, $semester_id, $category_name)
        or die 'execution failed: ' . $dbh->errstr();

    my ($exists) = $check_sth->fetchrow_array();
    if (!$exists) {
        return { error => "Category Permission for user $user_email does not exists in category $category_name, $semester_id . CANNOT update Perm . Try inserting instead." };
    }

    my $sth = $dbh->prepare('
                            UPDATE categoryPermission
                            SET can_read_category = ?,
                                can_create_links=  ?
                            WHERE 
                                category= ?     
                                AND semester_id= ? 
                                AND user_email= ?
                                ;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($can_read_category,$can_create_links,$category_name,$semester_id,$user_email,) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for user $user_email updated successfully" };
    } else {
        return { error => "Category Permission for user $user_email failed to be updated" };
    }
    
    return $result;
}

sub DeleteCategoryPermissionUser {
    my ($dbh,$session_id, $semester_id,$category_name,$user_email) = @_;
    
    my $sth = $dbh->prepare('
                            DELETE from categoryPermission 
                            where category=? 
                            AND semester_id =? 
                            AND user_email=?;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$user_email) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for user $user_email  for $category_name ,$semester_id deleted successfully" };
    } else {
        return { error => "Category Permission for user $user_email for $category_name ,$semester_id failed to be deleted" };
    }
    
    return $result;
}

sub DeleteCategoryPermissionRole {
    my ($dbh,$session_id, $semester_id,$category_name,$user_role) = @_;
    
    my $sth = $dbh->prepare('
                            DELETE from categoryPermission 
                            where category=? 
                            AND semester_id =? 
                            AND role_name=?;
                            ')
                            or die 'prepare statement failed: ' . $dbh->errstr();
    my $result=$sth->execute($category_name,$semester_id,$user_role) 
        or die 'execution failed: ' . $dbh->errstr();
    
    if ($result) {
        return { message => "Category Permission for role $user_role  for $category_name ,$semester_id deleted successfully" };
    } else {
        return { error => "Category Permission for role $user_role for $category_name ,$semester_id failed to be deleted" };
    }
    
    return $result;
}


1;


