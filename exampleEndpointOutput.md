
=================================================================================================================
=================================================================================================================
                                                    LOGIN           
=================================================================================================================
=================================================================================================================

http://localhost/getUserLogin
request body =>
      username : johnAcad 
      password : johnAcad 

OUTPUT
{"result":[{"description":"Academic Officer","email":"johnAcad@utm.com","full_name":"John Academic","login_name":"johnAcad","session_id":"313"}],"success":1}



=================================================================================================================
=================================================================================================================
                                                    SEMESTER             
=================================================================================================================
=================================================================================================================

=================================================================================================================
http://localhost/getSemester
OUTPUT
["2024/2025-1","2024/2025-2"]

=================================================================================================================


http://localhost/getAllCategoriesWithinSemesterCount    COUNT OF ALL VIEWABLE CATEGORY IN THAT SEMESTER
request body =>
    session_id  : 313                   ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'

Output
6

=================================================================================================================



http://localhost/getViewableCategoriesWithinSemesterCount       COUNT OF ALL CATEGORIES
request body =>
    session_id : 313                    ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'

OUTPUT
5

=================================================================================================================

http://localhost/createSemester              ACADEMIC OFFICER ONLY
request body =>
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : 2099/2025-1       ======= get from fill form

OUTPUT
{"message":"Semester 2099/2025-1 added successfully"}

OUTPUT
{"error":"Semester ID 2099/2025-1 already exists"}

OUTPUT
{"error":"Insufficient role privileges"}

=================================================================================================================

http://localhost/deleteSemester              ACADEMIC OFFICER ONLY
request body =>
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : '2099/2025-1'     ======= get from click
WARNING : DELETING SEMESTER ALSO DELETE ALL THINGS INSIDE OF IT

OUTPUT
{"message":"Semester 2099/2025-1 deleted successfully"}

OUTPUT
{"error":"Semester ID 2099/2025-1 doesnt exists, Cannot delete"}

OUTPUT
{"error":"Insufficient role privileges"}

OUTPUT
{"error":"Invalid semester_id. It must be 11 characters. 2099/2012 , 9"} 


=================================================================================================================

http://localhost/updateSemester              ACADEMIC OFFICER ONLY
request body =>
    session_id :          313           ======= get from localStorage/sessionStorage
    semester_id :         2099/2025-1   ======= get from click
    new_semester_id :     2099/2012-3   ====== get from fill form


OUTPUT
{"message":"Semester updated from 2099/2025-1 to 2099/2012-3 successfully"}

OUTPUT
{"error":"Semester ID 2099/2025-1 doesnt exists, Cannot Update"}

OUTPUT
{"error":"Insufficient role privileges"}

OUTPUT
{"error":"Invalid semester_id. It must be 11 characters. 2099/2012 , 9"} 

=================================================================================================================
=================================================================================================================
                                                    CATEGORY                   
=================================================================================================================
=================================================================================================================



http://localhost/getCategory             CAN VIEW PERMISSIBLE CATEGORY ONLY
request body =>
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : 2024/2025-1       ======= get from localStorage/sessionStorage  

OUTPUT
{"categoriesPermission":["PSM 1","Research","Timetable","Course Coordination","Course Files"]}

=================================================================================================================

CATEGORY CARD

http://localhost/getAllLinksWithinCategoryCount    COUNT OF ALL VIEWABLE LINKS IN THAT CATEGORY
request body =>
    session_id : 313             ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'     ======= get from localStorage/sessionStorage
    category_name : 'PSM 1'         ======= get from category card or something

OUTPUT
41

=================================================================================================================


http://localhost/getViewableLinksWithinCategoryCount     COUNT OF ALL LINK  IN THAT CATEGORY
request body =>
    session_id :  313               ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'     ======= get from localStorage/sessionStorage
    category_name : 'PSM 1'         ======= get from category card or something

OUTPUT
40

=================================================================================================================


http://localhost/createCategory          ACADEMIC OFFICER ONLY
request body =>
    session_id : 313                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage
    category_name : 'Kuching'         ======= get from fill form

OUTPUT
{"message":"Category KUCHING on 2024/2025-1 added successfully"}

OUTPUT
{"error":"Category KUCHING in 2024/2025-1 already exists"}

OUTPUT
{"error":"Insufficient role privileges"}

=================================================================================================================

http://localhost/deleteCategory          ACADEMIC OFFICER ONLY
request body =>
    session_id : 313                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage
    category_name : 'Kuching'         ======= get from click
 WARNING : DELETING CATEGORY ALSO DELETE ALL THINGS INSIDE OF IT

OUTPUT
{"message":"Category KUCHING on 2024/2025-1 deleted successfully"}

OUTPUT
{"error":"Category KUCHING in 2024/2025-1 doesnt exists, Cannot Delete"}

OUTPUT
{"error":"Insufficient role privileges"}

=================================================================================================================

http://localhost/updateCategory          ACADEMIC OFFICER ONLY
request body =>
    session_id : 313                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage
    category_name : 'Kuching'         ======= get from click
    new_category_name : 'Meow'        ======= get from fill form

OUTPUT
{"message":"Category updated from KUCHING on 2024/2025-1 to Meow successfully"}

OUTPUT
{"error":"Category KUCHING in 2024/2025-1 doesnt exists, Cannot Update"}

OUTPUT
{"error":"Insufficient role privileges"}

=================================================================================================================
=================================================================================================================
                                                    LINKS                        
=================================================================================================================
=================================================================================================================


http://localhost/getLink             CAN VIEW PERMISSIBLE LINKS ONLY
request body =>
    session_id : 313                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage
    category_name : 'PSM 1'           ======= get from localStorage/sessionStorage

OUTPUT
{"linkViewable":[[84,"PSM 1","2024/2025-1","Marks Rubric","PSM 1 marking sheets","johnAcad@utm.com","http://google.com"],[85,"PSM 1","2024/2025-1","List of Approved Titles","PSM Titles approved by the board","johnAcad@utm.com","http://google.com"],[86,"PSM 1","2024/2025-1","List of Candidates","Candidates List","johnAcad@utm.com","http://google.com"]]}


=================================================================================================================


http://localhost/getAllLink             CAN VIEW PERMISSIBLE LINKS ONLY
request body =>
    session_id : ab     ======= get from localStorage/sessionStorage


OUTPUT
{"allLinks":[[84,"PSM 1","2024/2025-1","Marks Rubric","PSM 1 marking sheets","johnAcad@utm.com","http://google.com"],[85,"PSM 1","2024/2025-1","List of Approved Titles","PSM Titles approved by the board","johnAcad@utm.com","http://google.com"],[86,"PSM 1","2024/2025-1","List of Candidates","Candidates List","johnAcad@utm.com","http://google.com"],[87,"Research","2024/2025-1","Marks Rubric","Research marking sheets","johnAcad@utm.com","http://google.com"],[88,"Research","2024/2025-1","List of Approved Titles","Research Titles approved by the board","johnAcad@utm.com","http://google.com"],[89,"Research","2024/2025-1","List of Candidates","Candidates List","johnAcad@utm.com","http://google.com"],[90,"Training","2024/2025-1","List of Deliverables","Details on the deliverables during training","johnAcad@utm.com","http://google.com"],[91,"Training","2024/2025-1","List of Approved Companies","Companies approved by the faculty","johnAcad@utm.com","http://google.com"],[92,"Training","2024/2025-1","List of Candidates","Candidates List enlisted for training","johnAcad@utm.com","http://google.com"],[93,"Timetable","2024/2025-1","SECJH-1st","Timetable for secjh 1st year","johnAcad@utm.com","http://google.com"],[94,"Timetable","2024/2025-1","SECJH-2nd","Timetable for secjh 2nd year","johnAcad@utm.com","http://google.com"],[95,"Timetable","2024/2025-1","SECJH-3rd","Timetable for secjh 3rd year","johnAcad@utm.com","http://google.com"],[96,"Timetable","2024/2025-1","SECJH-4th","Timetable for secjh 4th year","johnAcad@utm.com","http://google.com"],[97,"Timetable","2024/2025-1","FSEK-1st","Timetable for FSEK 1st year","johnAcadowo@utm.com","http://google.com"],[98,"Timetable","2024/2025-1","FSEK-2nd","Timetable for FSEK 2nd year","johnAcadowo@utm.com","http://google.com"],[99,"Timetable","2024/2025-1","FSEK-3rd","Timetable for FSEK 3rd year","johnAcadowo@utm.com","http://google.com"],[100,"Timetable","2024/2025-1","FSEK-4th","Timetable for FSEK 4th year","johnAcadowo@utm.com","http://google.com"],[101,"Course Coordination","2024/2025-1","FC CC","Course Coordination for Computing Students","johnAcad@utm.com","http://google.com"],[102,"Course Coordination","2024/2025-1","FKE CC","Course Coordination for Electrical Students","johnAcadowo@utm.com","http://google.com"],[103,"Course Coordination","2024/2025-1","FS CC","Course Coordination for Science Students","johnOFF@utm.com","http://google.com"],[104,"Course Files","2024/2025-1","SECJ3104-01","Topic 01 for App Dev ","johnPen@utm.com","http://google.com"],[105,"Course Files","2024/2025-1","SECJ3104-02","Topic 02 for App Dev ","johnPen@utm.com","http://google.com"],[106,"Course Files","2024/2025-1","SECJ3104-03","Topic 03 for App Dev ","johnPen@utm.com","http://google.com"],[107,"Course Files","2024/2025-1","SECJ3104-04","Topic 04 for App Dev ","johnPen@utm.com","http://google.com"],[108,"Course Files","2024/2025-1","SECJ3303-01","Topic 01 for Internet Programming ","johnLect@utm.com","http://google.com"],[109,"Course Files","2024/2025-1","SECJ3303-02","Topic 02 for Internet Programming ","johnLect@utm.com","http://google.com"],[110,"Course Files","2024/2025-1","SECJ3303-03","Topic 03 for Internet Programming ","johnLect@utm.com","http://google.com"],[111,"Course Files","2024/2025-1","SECJ3303-04","Topic 04 for Internet Programming ","johnLect@utm.com","http://google.com"],[112,"Course Files","2024/2025-1","SECR3432-01","Topic 01 for Cryptography ","johnDr@utm.com","http://google.com"],[113,"Course Files","2024/2025-1","SECR3432-02","Topic 02 for Cryptography ","johnDr@utm.com","http://google.com"],[114,"Course Files","2024/2025-1","SECR3432-03","Topic 03 for Cryptography ","johnDr@utm.com","http://google.com"],[115,"Course Files","2024/2025-1","SECR3432-04","Topic 04 for Cryptography ","johnDr@utm.com","http://google.com"],[116,"Course Files","2024/2025-1","FESM2301-01","Topic 01 for Material Science ","johnCeg@utm.com","http://google.com"],[117,"Course Files","2024/2025-1","FESM2301-02","Topic 02 for Material Science ","johnCeg@utm.com","http://google.com"],[118,"Course Files","2024/2025-1","FESM2301-03","Topic 03 for Material Science ","johnCeg@utm.com","http://google.com"],[119,"Course Files","2024/2025-1","FESM2301-04","Topic 04 for Material Science ","johnCeg@utm.com","http://google.com"],[120,"Course Files","2024/2025-1","FEVK2431-01","Topic 01 for Electronics ","johnPeng@utm.com","http://google.com"],[121,"Course Files","2024/2025-1","FEVK2431-02","Topic 02 for Electronics ","johnPeng@utm.com","http://google.com"],[122,"Course Files","2024/2025-1","FEVK2431-03","Topic 03 for Electronics ","johnPeng@utm.com","http://google.com"],[123,"Course Files","2024/2025-1","FEVK2431-04","Topic 04 for Electronics ","johnPeng@utm.com","http://google.com"],[124,"PSM 2","2024/2025-2","Marks Rubric","PSM 2 marking sheets","johnAcad@utm.com","http://google.com"],[125,"PSM 2","2024/2025-2","List of Approved Titles","PSM Titles approved by the board","johnAcad@utm.com","http://google.com"],[126,"PSM 2","2024/2025-2","List of Candidates","Candidates List","johnAcad@utm.com","http://google.com"],[127,"Course Coordination","2024/2025-2","FC CC","Course Coordination for Computing Students","johnAcad@utm.com","http://google.com"],[128,"Course Coordination","2024/2025-2","FKE CC","Course Coordination for Electrical Students","johnAcadowo@utm.com","http://google.com"],[129,"Course Coordination","2024/2025-2","FS CC","Course Coordination for Science Students","johnOFF@utm.com","http://google.com"],[130,"Timetable","2024/2025-2","SECJH-1st","Timetable for secjh 1st year","johnAcad@utm.com","http://google.com"],[131,"Timetable","2024/2025-2","SECJH-2nd","Timetable for secjh 2nd year","johnAcad@utm.com","http://google.com"],[132,"Timetable","2024/2025-2","SECJH-3rd","Timetable for secjh 3rd year","johnAcad@utm.com","http://google.com"],[133,"Timetable","2024/2025-2","SECJH-4th","Timetable for secjh 4th year","johnAcad@utm.com","http://google.com"],[134,"Timetable","2024/2025-2","FSEK-1st","Timetable for FSEK 1st year","johnAcadowo@utm.com","http://google.com"],[135,"Timetable","2024/2025-2","FSEK-2nd","Timetable for FSEK 2nd year","johnAcadowo@utm.com","http://google.com"],[136,"Timetable","2024/2025-2","FSEK-3rd","Timetable for FSEK 3rd year","johnAcadowo@utm.com","http://google.com"],[137,"Timetable","2024/2025-2","FSEK-4th","Timetable for FSEK 4th year","johnAcadowo@utm.com","http://google.com"],[138,"Course Files","2024/2025-2","SECJ2104-01","Topic 01 for Data Structure ","johnPen@utm.com","http://google.com"],[139,"Course Files","2024/2025-2","SECJ2104-02","Topic 02 for Data Structure ","johnPen@utm.com","http://google.com"],[140,"Course Files","2024/2025-2","SECJ2104-03","Topic 03 for Data Structure ","johnPen@utm.com","http://google.com"],[141,"Course Files","2024/2025-2","SECJ2104-04","Topic 04 for Data Structure ","johnPen@utm.com","http://google.com"],[142,"Course Files","2024/2025-2","SECJ1023-01","Topic 01 for Technique Programming ","johnLect@utm.com","http://google.com"],[143,"Course Files","2024/2025-2","SECJ1023-02","Topic 02 for Technique Programming ","johnLect@utm.com","http://google.com"],[144,"Course Files","2024/2025-2","SECJ1023-03","Topic 03 for Technique Programming ","johnLect@utm.com","http://google.com"],[145,"Course Files","2024/2025-2","SECJ1023-04","Topic 04 for Technique Programming ","johnLect@utm.com","http://google.com"],[146,"Course Files","2024/2025-2","SECR4123-01","Topic 01 for RSA  ","johnDr@utm.com","http://google.com"],[147,"Course Files","2024/2025-2","SECR4123-02","Topic 02 for RSA  ","johnDr@utm.com","http://google.com"],[148,"Course Files","2024/2025-2","SECR4123-03","Topic 03 for RSA  ","johnDr@utm.com","http://google.com"],[149,"Course Files","2024/2025-2","SECR4123-04","Topic 04 for RSA  ","johnDr@utm.com","http://google.com"],[150,"Course Files","2024/2025-2","FQEW2121-01","Topic 01 for Quantum Physics ","johnCeg@utm.com","http://google.com"],[151,"Course Files","2024/2025-2","FQEW2121-02","Topic 02 for Quantum Physics ","johnCeg@utm.com","http://google.com"],[152,"Course Files","2024/2025-2","FQEW2121-03","Topic 03 for Quantum Physics ","johnCeg@utm.com","http://google.com"],[153,"Course Files","2024/2025-2","FQEW2121-04","Topic 04 for Quantum Physics ","johnCeg@utm.com","http://google.com"],[154,"Course Files","2024/2025-2","FERR2325-01","Topic 01 for Motors and Robots ","johnPeng@utm.com","http://google.com"],[155,"Course Files","2024/2025-2","FERR2325-02","Topic 02 for Motors and Robots ","johnPeng@utm.com","http://google.com"],[156,"Course Files","2024/2025-2","FERR2325-03","Topic 03 for Motors and Robots ","johnPeng@utm.com","http://google.com"],[157,"Course Files","2024/2025-2","FERR2325-04","Topic 04 for Motors and Robots ","johnPeng@utm.com","http://google.com"],[158,"Workshop","2024/2025-2","WORKSHOP-AD-01","Workshop on Application Development","johnAcad@utm.com","http://google.com"],[159,"Workshop","2024/2025-2","WORKSHOP-IP-01","Workshop on Internet Programming","johnLect@utm.com","http://google.com"],[160,"Workshop","2024/2025-2","WORKSHOP-CR","Workshop on Cryptography","johnDr@utm.com","http://google.com"],[161,"Internship","2024/2025-2","Opportunities","Internship Opportunities for Students","johnAcad@utm.com","http://google.com"],[162,"Internship","2024/2025-2","Placement","Internship Placements for Engineering Students","johnAcad@utm.com","http://google.com"],[163,"Personal","2024/2025-2","Daily Schedule","Personal daily schedule","johnStu@utm.com","http://google.com"],[164,"Personal","2024/2025-2","To-Do List","Tasks and reminders for the semester","johnStu@utm.com","http://google.com"],[165,"Personal","2024/2025-2","Notes Archive","Collection of personal notes","johnStu@utm.com","http://google.com"],[166,"Personal","2024/2025-2","Resource Links","Bookmarks for useful resources","johnStu@utm.com","http://google.com"],[11222,"Internship","2024/2025-1","21",null,"johnOFF@utm.com",null],[11225,"Personal","2024/2025-2","My Marks ","Marks for all subject","johnAcad@utm.com","google.com"],[11226,"Personal","2024/2025-2","My Marks ","Marks for all subject","johnAcad@utm.com","google.com"],[11227,"Personal","2024/2025-2","My Marks ","Marks for all subject","johnStu@utm.com","google.com"]]}

=================================================================================================================

http://localhost/getAllLinkCount             CAN VIEW COUNT OF PERMISSIBLE LINKS ONLY
request body =>
    session_id : 313                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage

OUTPUT
{"linkCount":87}

=================================================================================================================

http://localhost/getALLlinkIdRead            CAN VIEW PERMISSIBLE LINKS ID ONLY
request body =>
    session_id : ab                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage  

OUTPUT
{"readbleLinkId":[84,86,87,88,89,93,94,95,96,101,124,125,126,127,130,131,132,133,158,161,162]}

=================================================================================================================


http://localhost/getALLlinkIdDelete             CAN VIEW DELETEABLE LINKS ID ONLY
request body =>
    session_id : ab                  ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage  

OUTPUT
{"deleteableLinkId":[84,11228,11229,11230,11231,11232,163,164,165,166]}

=================================================================================================================

http://localhost/getALLlinkIdUpdate             CAN VIEW UPDATABLE LINKS ID ONLY
request body =>
    session_id : ab                   ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage   

OUTPUT
{"updateableLinkId":[84,11228,11230,11235,11237,11238,11239,11241,11243,11245,163,164,165,166]}

=================================================================================================================

http://localhost/getALLlinkCreateWhere             CAN VIEW THE CREATE BUTTON AT WHERE RETURN CATEGORY AND SSEM ONLY
request body =>
    session_id : ab                   ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'       ======= get from localStorage/sessionStorage   

OUTPUT
{"createAbleLinkWhere":["PSM 1","2024/2025-1","Research","2024/2025-1","Training","2024/2025-1","Timetable","2024/2025-1","Course Coordination","2024/2025-1","Course Files","2024/2025-1","PSM 2","2024/2025-2","Course Coordination","2024/2025-2","Timetable","2024/2025-2","Course Files","2024/2025-2","Workshop","2024/2025-2","Internship","2024/2025-2","Personal","2024/2025-2","Meow","2024/2025-1"]}     

=================================================================================================================


http://localhost/createLink         ONLY FOR ACADEMIC OFFICER & PEOPLE WITH CREATE PERM WITHIN CATEGORY
request body =>
    session_id : ab                         ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'             ======= get from localStorage/sessionStorage   
    category_name : 'Meow'                  ======= get from localStorage/sessionStorage
    ref_name : 'History Black Catto'        ======= get from fill form
    desc : 'The detailed untold history'    ======= get from fill form
    link : 'https://google.com'             ======= get from fill form

OUTPUT
{"result":{"message":"Link History Black Catto, google.com inserted successfully"}}

OUTPUT
{"result":{"error":"Link History Black Catto, google.com failed to be inserted, NOT ENOUGH PERM"}}

REMARKS
If available,, it will still say success LOL

=================================================================================================================


http://localhost/deleteLink        ONLY FOR ACADEMIC OFFICER & PEOPLE WITH DELETE PERM WITHIN CATEGORY & LINK OWNER
request body =>
    session_id : 'ab'             ======= get from localStorage/sessionStorage
    semester_id :  2024/2025-1    ======= get from localStorage/sessionStorage
    category_name : 'Meow'        ======= get from localStorage/sessionStorage
    link id       : '11237'       ======= get from click

OUTPUT
{"result":{"message":"gdlink_id 11237 in Meow, 2024/2025-1 deleted successfully"}}

OUTPUT
{"result":{"message":"YOU DO NOT HAVE PERMISSION TO DELETE gdlink_id 11237 OR IT DOESNT EXIST"}}

REMARKS 
If link doesnt exist , it will say it delete successfully

=================================================================================================================


http://localhost/updateLink          ONLY FOR ACADEMIC OFFICER & PEOPLE WITH UPDATE PERM WITHIN CATEGORY & LINK OWNER
request body =>
    session_id : ??    ======= get from localStorage/sessionStorage
    semester_id : ??   ======= get from localStorage/sessionStorage  
    category_name : ?? ======= get from localStorage/sessionStorage
    new_ref_name : ??  ======= get from form
    new_desc : ??      ======= get from form
    new_link : ??      ======= get from form
    gdlink_id : ????   ======= get when u click the delete button

OUTPUT
{"result":{"message":"gdlink_id 11230 in Meow, 2024/2025-1 edited successfully"}}

OUTPUT
{"result":{"message":"YOU DO NOT HAVE PERMISSION TO EDIT gdlink_id 84 OR IT DOESNT EXIST"}}

=================================================================================================================

=================================================================================================================
=================================================================================================================
                                                    CATEGORY PERMISSION
=================================================================================================================
=================================================================================================================


http://localhost/getCategoryPermission              ONLY FOR ACADEMIC OFFICER 
request body =>
    session_id : 313               ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'    ======= get from localStorage/sessionStorage       
    category_name : 'PSM 1'        ======= get from click

OUTPUT
{"categoriesPermission":[{"can_create_links":0,"can_read_category":1,"category":"PSM 1","category_perm_id":1,"role_name":"Everyone","semester_id":"2024/2025-1","user_email":null},{"can_create_links":1,"can_read_category":1,"category":"PSM 1","category_perm_id":14,"role_name":null,"semester_id":"2024/2025-1","user_email":"johnPeng@utm.com"},{"can_create_links":1,"can_read_category":1,"category":"PSM 1","category_perm_id":17,"role_name":null,"semester_id":"2024/2025-1","user_email":"tonianwar@utm.my"}]}

OUTPUT
{"error":"Insufficient role privileges"}

=================================================================================================================

http://localhost/createCategoryPermission
request body =>
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'     ======= get from localStorage/sessionStorage       
    category_name : 'PSM 1'         ======= get from click
    insert_user_role : 'Student'    ======= get from fill form     
    insert_user_email :             ======= get from fill form     
    can_read_category : 'true'        ======= get from fill form,,, boolean (true/false)
    can_create_links : 'true'         ======= get from fill form,,, boolean (true/false)

WARNING,, can only have insert_user_role OR insert_user_email only

OUTPUT
{"result":{"error":"Insufficient role privileges"}}

OUTPUT
{"result":{"error":"Only one of insert_user_email or insert_user_role can be updated at a time","success":false}}

OUTPUT
{"result":{"message":"Category Permission for role Pelajar FSKSM created successfully"}}

OUTPUT
{"result":{"error":"Category Permission for role Pelajar FSKSM already exists in category PSM 1, 2024/2025-1 . Try editing existing Perm instead"}}

OUTPUT
{"result":{"message":"Category Permission for email johnStu@utm.com created successfully"}}

OUTPUT
{"result":{"error":"Category Permission for email johnStu@utm.com already exists in category PSM 1, 2024/2025-1 . Try editing existing Perm instead"}}

OUTPUT
{"result":{"error":"Cannot add permission Student for roles that doesnt exist. "}}

OUTPUT
{"result":{"error":"Cannot add permission johnStu@utm.cm for user that doesnt exist. "}}

=================================================================================================================

http://localhost/updateCategoryPermission
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'     ======= get from localStorage/sessionStorage       
    category_name : 'PSM 1'         ======= get from click
    selected_user_role : 'Student'    ======= get from fill form     
    selected_user_email :             ======= get from fill form     
    can_read_category : 'true'        ======= get from fill form,,, boolean (true/false)
    can_create_links : 'true'         ======= get from fill form,,, boolean (true/false)

WARNING
can only update if and only if   EITHER selected_user_email OR selected_user_role    , cannot update if both have value, 

OUTPUT
{"result":{"error":"Insufficient role privileges"}}

OUTPUT
{"result":"Only one of user_email or user_role can be updated at a time"}

OUTPUT
{"result":{"error":"Category Permission for role Academic Officer does not exists in category Meow, 2024/2025-1 . CANNOT update Perm . Try inserting instead."}}

OUTPUT
{"result":{"message":"Category Permission for role Academic Officer updated successfully"}}

OUTPUT
{"result":{"error":"Category Permission for user johnStud@utm.com does not exists in category Meow, 2024/2025-1 . CANNOT update Perm . Try inserting instead."}}

OUTPUT
{"result":{"message":"Category Permission for user johnStu@utm.com updated successfully"}}

OUTPUT
{"result":{"error":"Cannot edit permission Student for roles that doesnt exist. "}}

OUTPUT
{"result":{"error":"Cannot edit permission johnStu@utm.cm for user that doesnt exist. "}}

WARNING
if doesnt exist then it still said success???

=================================================================================================================

http://localhost/deleteCategoryPermission
    session_id : 313                ======= get from localStorage/sessionStorage
    semester_id : '2024/2025-1'     ======= get from localStorage/sessionStorage       
    category_name : 'Meow'         ======= get from click
    selected_user_role : 'Student'    ======= get from fill form     
    selected_user_email :             ======= get from fill form     

WARNING
can only delete if and only if   EITHER selected_user_email OR selected_user_role    , cannot update if both have value, 

OUTPUT
{"result":{"error":"Insufficient role privileges"}}

OUTPUT
{"result":"Only one of user_email or user_role can be updated at a time"}

OUTPUT
{"result":{"message":"Category Permission for role Academic Officer  for Meow ,2024/2025-1 deleted successfully"}}

OUTPUT
{"result":{"message":"Category Permission for user johnStu@utm.com  for Meow ,2024/2025-1 deleted successfully"}}

REMARKS
if the permission doesnt exist,, it will still output deleted successfully

REMARKS
role "Everyone" CANNOT be deleted

=================================================================================================================
=================================================================================================================
             LINK PERMISSION
=================================================================================================================
=================================================================================================================

http://localhost/getLinkPermission
    session_id : 313                ======= get from localStorage/sessionStorage
    gdlink_id : 11335     ======= get from localStorage/sessionStorage  

OUTPUT
{"error":"No permission ."}

OUTPUT
{"result":[[196,"Personal","2099/2012-3",11335,null,"Everyone",1,0,0]]}
1 0 0 ,, is can_read,can_update,can_delete

=================================================================================================================

http://localhost/createLinkPermission
request body =>
    session_id : ??     ======= get from localStorage/sessionStorage
    semester_id : ??    ======= get from localStorage/sessionStorage       
    category_name : ??    ======= get from localStorage/sessionStorage     
    gdlink_id : ??    ======= get from click     
    insert_user_role : ????    ======= get from fill form     
    insert_user_email : ????   ======= get from fill form     
    can_read : ????   ======= get from fill form,,, boolean (0/1 true/false)
    can_update : ????   ======= get from fill form,,, boolean (0/1 true/false)
    can_delete : ????   ======= get from fill form,,, boolean (0/1 true/false)

OUTPUT
{"error":"No permission ."}

OUTPUT
{"result":"Only one of insert_user_email or insert_user_role can be updated at a time"}

OUTPUT
{"result":{"error":"Cannot add permission johnStu@utm.cm for email that doesnt exist. "}}

OUTPUT
{"result":{"error":"Cannot add permission Acadmic Officer for roles that doesnt exist. "}}

OUTPUT
{"result":{"message":"Category Permission for role Academic Officer created successfully"}}

OUTPUT
{"result":{"error":"Category Permission for role Academic Officer already exists in in gdlink id 84 . Try editing existing Perm instead"}}

OUTPUT
{"result":{"message":"Category Permission for email johnStu@utm.com created successfully"}}

OUTPUT
{"result":{"error":"Category Permission for email johnStu@utm.com already exists in gdlink id 84 . Try editing existing Perm instead"}}

=================================================================================================================

http://localhost/updateLinkPermission
request body =>
    session_id : ??     ======= get from localStorage/sessionStorage    
    gdlink_id : ??    ======= get from click     
    selected_user_role : ????    ======= get from fill form     
    selected_user_email : ????   ======= get from fill form     
    can_read : ????   ======= get from fill form,,, boolean (0/1 true/false)
    can_update : ????   ======= get from fill form,,, boolean (0/1 true/false)
    can_delete : ????   ======= get from fill form,,, boolean (0/1 true/false)

OUTPUT
{"error":"No permission ."}

OUTPUT
{"result":"Only one of insert_user_email or insert_user_role can be updated at a time"}

OUTPUT
{"result":{"message":"Link Permission for email johnStu@utm.com updated successfully"}}

OUTPUT
{"result":{"message":"Link Permission for role Academic Officer updated successfully"}}

OUTPUT
{"result":{"error":"Cannot add permission Academic Oficer for roles that doesnt exist. "}}

OUTPUT
{"result":{"error":"Cannot add permission johnStu@utm.cm for email that doesnt exist. "}}

=================================================================================================================

http://localhost/deleteLinkPermission



=================================================================================================================
=================================================================================================================
                        EXTRA OPTION MENU
=================================================================================================================
=================================================================================================================


http://localhost/getAllRoles         FOR EVERYONE

OUTPUT
{"result":["Academic Officer","Everyone","Pelajar FSKSM","Pensyarah"]}
=================================================================================================================


http://localhost/getAllEmails      FOR EVERYONE

OUTPUT
{"result":["johnAcad@utm.com","johnAcadowo@utm.com","johnOFF@utm.com","johnPen@utm.com","johnLect@utm.com","johnDr@utm.com","johnPeng@utm.com","johnCeg@utm.com","johnStu@utm.com","msmd2@live.utm.my","tonianwar@utm.my"]}

=================================================================================================================