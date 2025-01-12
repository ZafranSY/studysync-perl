package Categories;

# NO LONGER USED
# sub getCategory {
#     my ($dbh, $semester_id) = @_;
#     my $sth = $dbh->prepare('SELECT * FROM Categories where semester_id= ? ')
#         or die 'prepare statement failed: ' . $dbh->errstr();
#     $sth->execute($semester_id) 
#         or die 'execution failed: ' . $dbh->errstr();
#     my @categories;
#     while (my $row = $sth->fetchrow_hashref) {
#         push @categories, $row->{category};
#     }
#     return \@categories;
# }

sub getAllLinksWithinCategoryCount {
    my ($dbh,$session_id,$semester_id,$category_name) = @_;
    my $sth = $dbh->prepare('SELECT COUNT(*) AS link_count FROM gdlinks WHERE sessem = ?')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id) or die 'execution failed: ' . $dbh->errstr();
    my $row = $sth->fetchrow_hashref;
    return $row->{link_count};
}


sub getViewableLinksWithinCategoryCount {
    my ($dbh,$session_id,$semester_id,$category_name) = @_;
    my $role_name=Authorization::getRoleName($dbh, $session_id);
    my $email=Authorization::getEmail($dbh, $session_id);
    my $sth = $dbh->prepare('SELECT COUNT(DISTINCT gdlink_id) AS link_count FROM linkPermission where (semester_id= ?  AND category=?) AND (user_email= ? OR role_name= ? OR role_name=\'Everyone\' OR \'Academic Officer\'=?) AND (can_read=1 OR \'Academic Officer\'=?) ')
        or die 'prepare statement failed: ' . $dbh->errstr();
    $sth->execute($semester_id,$category_name,$email,$role_name,$role_name,$role_name) or die 'execution failed: ' . $dbh->errstr();
    my $row = $sth->fetchrow_hashref;
    return $row->{link_count};
}

sub CreateCategory {
    my ($dbh, $semester_id, $category) = @_;
    
    my $sth_check = $dbh->prepare('SELECT 1 FROM Categories WHERE semester_id = ? AND category = ? ')
                or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id,$category)
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if ($exists) {
        return { error => "Category $category in $semester_id already exists" };
    }
    my $sth_insert = $dbh->prepare('INSERT INTO Categories (semester_id,category) VALUES (?,?)')
                or die 'prepare statement failed: ' . $dbh->errstr();
    $result=$sth_insert->execute($semester_id,$category)
                or die 'prepare statement failed: ' . $dbh->errstr();
    if ($result) {
        return { message => "Category $category on $semester_id added successfully" };
    } else {
        return { error => "Failed to add Category $category on $semester_id" };
    }
}

sub DeleteCategory {
    my ($dbh, $semester_id, $category) = @_;
    
    my $sth_check = $dbh->prepare('SELECT 1 FROM Categories WHERE semester_id = ? AND category = ? ') 
                or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id,$category) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if (!$exists) {
        return { error => "Category $category in $semester_id doesnt exists, Cannot Delete" };
    }
    my $sth_insert = $dbh->prepare('DELETE FROM Categories where semester_id = ? AND category = ?') 
                or die 'prepare statement failed: ' . $dbh->errstr();
    $result=$sth_insert->execute($semester_id,$category) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    if ($result) {
        return { message => "Category $category on $semester_id deleted successfully" };
    } else {
        return { error => "Failed to delete category $category on $semester_id" };
    }
}

sub UpdateCategory {
    my ($dbh, $semester_id,$category,$new_category_name) = @_;
    
    my $sth_check = $dbh->prepare('SELECT 1 FROM Categories WHERE semester_id = ? AND category = ?') or die 'prepare statement failed: ' . $dbh->errstr();
    $sth_check->execute($semester_id,$category) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    my $exists = $sth_check->fetchrow_array;
    if (!$exists) {
        return { error => "Category $category in $semester_id doesnt exists, Cannot Update" };
    }
    my $sth_insert = $dbh->prepare('UPDATE Categories SET category=? where semester_id = ? AND category = ?') or die 'prepare statement failed: ' . $dbh->errstr();
    $result=$sth_insert->execute($new_category_name,$semester_id,$category) 
                or die 'prepare statement failed: ' . $dbh->errstr();
    if ($result) {
        return { message => "Category updated from $category on $semester_id to $new_category_name successfully" };
    } else {
        return { error => "Failed to Update semester from $category on $semester_id to $new_category_name" };
    }
}
1;
