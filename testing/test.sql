    
    
    
    
    
select gdlink_id from gdlinks 
            where owner='johnStu@utm.com'
            or gdlink_id IN (
                select gdlink_id from linkPermission 
                    where (user_email='johnStu@utm.com' 
                            OR role_name='Everyone' 
                            OR role_name='Pelajar')
                    AND can_read=1)
                    AND category IN (
                        select DISTINCT category from categoryPermission 
                            where can_read_category=1 
                            AND (
                            role_name='Everyone' 
                            OR role_name='Student' 
                            OR user_email='johnStu@utm.my'
                            )
                    )
                    OR EXISTS (
                        SELECT 1 FROM user 
                        WHERE email = 'johnStu@utm.my'
                            AND role_id = (SELECT role_id FROM roles WHERE role_name = "Academic Officer")
                        );


select DISTINCT * from categoryPermission 
where can_read_category=1 AND can_create_links=1 AND 
            (user_email='johnPeng@utm.com' 
            OR role_name='Everyone' or 
            role_name='Academic Officer') 
OR 'Academic Officer' = 'Academic Officer';;



select * from roles where role_id= (
    select role_id from user where session_id='313'
)


INSERT INTO categoryPermission (category, semester_id, user_email, can_read_category, can_create_links)
VALUES ();




UPDATE categoryPermission
SET can_read_category = FALSE,
    can_create_links=  FALSE
WHERE 
    category='PSM 1'    AND
    semester_id='2024/2025-1' AND
    user_email='johnStu@utm.com'
    ;
