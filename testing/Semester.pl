package Semester;

sub getSemester {
    my $dbh = shift(@_);
    my $sth = $dbh->prepare('SELECT * FROM sessionSemester')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute() or die 'execution failed: ' . $dbh->errstr();
    my @semesters;
    while (my $row = $sth->fetchrow_hashref) {
        push @semesters, $row->{semester_id};
    }
    return \@semesters;
}

sub getAllCategoriesWithinSemesterCount {
    my ($dbh,$session_id,$semester_id) = @_;
    my $sth = $dbh->prepare('SELECT COUNT(*) AS category_count FROM Categories WHERE semester_id = ?')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id) or die 'execution failed: ' . $dbh->errstr();
    my $row = $sth->fetchrow_hashref;
    return $row->{category_count};
}


sub getViewableCategoriesWithinSemesterCount {
    my ($dbh,$session_id,$semester_id) = @_;
    my $role_name=Authorization::getRoleName($dbh, $session_id);
    my $email=Authorization::getEmail($dbh, $session_id);
    my $sth = $dbh->prepare('SELECT COUNT(DISTINCT category) AS category_count FROM categoryPermission where semester_id= ? AND (user_email= ? OR role_name= ? OR role_name=\'Everyone\') AND (can_read_category=1 or \'Academic Officer\'=?)  ')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id,$email,$role_name,$role_name) or die 'execution failed: ' . $dbh->errstr();
    my $row = $sth->fetchrow_hashref;
    return $row->{category_count};
}

sub CreateSemester {
    my ($dbh, $semester_id) = @_;
    $semester_id =~ s/^\s+|\s+$//g;
    
    if (!$semester_id || length($semester_id) != 11) {
        $len=length($semester_id);
        return { error => "Invalid semester_id. It must be 11 characters. $semester_id , $len" };
    }
    my $sth_check = $dbh->prepare('SELECT 1 FROM sessionSemester WHERE semester_id = ?')
                or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if ($exists) {
        return { error => "Semester ID $semester_id already exists" };
    }
    my $sth_insert = $dbh->prepare('INSERT INTO sessionSemester (semester_id) VALUES (?)');
    $result=$sth_insert->execute($semester_id);
    if ($result) {
        return { message => "Semester $semester_id added successfully" };
    } else {
        return { error => "Failed to add semester $semester_id" };
    }
}

sub DeleteSemester {
    my ($dbh, $semester_id) = @_;
    
    my $sth_check = $dbh->prepare('SELECT 1 FROM sessionSemester WHERE semester_id = ?') or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if (!$exists) {
        return { error => "Semester ID $semester_id doesnt exists, Cannot delete" };
    }
    my $sth_insert = $dbh->prepare('DELETE FROM sessionSemester where semester_id = ? ') or die 'prepare statement failed: ' . $dbh->errstr();
    $result=$sth_insert->execute($semester_id) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    if ($result) {
        return { message => "Semester $semester_id deleted successfully" };
    } else {
        return { error => "Failed to delete semester $semester_id" };
    }
}

sub UpdateSemester {
    my ($dbh, $semester_id,$new_semester_id) = @_;
    
    if (!$new_semester_id || length($new_semester_id) != 11) {
        $len=length($new_semester_id);
        return { error => "Invalid semester_id. It must be 11 characters. $semester_id , $len" };
    }

    my $sth_check = $dbh->prepare('SELECT 1 FROM sessionSemester WHERE semester_id = ?') or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if (!$exists) {
        return { error => "Semester ID $semester_id doesnt exists, Cannot Update" };
    }
    my $sth_insert = $dbh->prepare('UPDATE sessionSemester SET semester_id=? where semester_id = ? ') or die 'prepare statement failed: ' . $dbh->errstr();
    $result=$sth_insert->execute($new_semester_id,$semester_id) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    if ($result) {
        return { message => "Semester updated from $semester_id to $new_semester_id successfully" };
    } else {
        return { error => "Failed to Update semester $semester_id" };
    }
}

1;