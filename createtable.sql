CREATE DATABASE testing;
use testing;

-- Create the user adj2425 with access from any host
CREATE USER 'adj2425'@'%' IDENTIFIED BY 'adj2425';

-- Grant privileges on the database 'testing' to the user
GRANT ALL PRIVILEGES ON testing.* TO 'adj2425'@'%';

-- Apply changes
FLUSH PRIVILEGES;

CREATE TABLE sessionSemester (
    semester_id VARCHAR(11) PRIMARY KEY
);

CREATE TABLE Categories(
    category VARCHAR(100),
    semester_id VARCHAR(11) not null,
    PRIMARY KEY (category, semester_id),
    FOREIGN KEY (semester_id) REFERENCES sessionSemester(semester_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE roles (
    role_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE user (
    user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    login_name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id INT NOT NULL,
    session_id VARCHAR(255) NOT NULL,
    successful_logins INT DEFAULT 0,
    last_login TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


create table gdlinks (
    gdlink_id int not null auto_increment, 
    category varchar(100), 
    sessem varchar(15), 
    ref_name varchar(50), 
    description varchar(255), 
    owner varchar(255) not null, 
    link varchar(255), 
    primary key(gdlink_id),
    FOREIGN KEY (sessem) REFERENCES sessionSemester(semester_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES Categories(category) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (owner) REFERENCES user(email)
);

CREATE TABLE categoryPermission (
    category_perm_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    semester_id VARCHAR(11) NOT NULL,
    user_email VARCHAR(255),
    role_name VARCHAR(255),
    can_read_category BOOLEAN DEFAULT FALSE,
    can_create_links BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_email) REFERENCES user(email),
    FOREIGN KEY (role_name) REFERENCES roles(role_name),
    FOREIGN KEY (semester_id) REFERENCES sessionSemester(semester_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES Categories(category) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (user_email IS NULL OR role_name IS NULL)
);


CREATE TABLE linkPermission (
    link_perm_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    semester_id VARCHAR(11) NOT NULL,
    gdlink_id int NOT NULL,
    user_email VARCHAR(255),
    role_name VARCHAR(255),
    can_read BOOLEAN DEFAULT FALSE,
    can_update BOOLEAN DEFAULT FALSE,
    can_delete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_email) REFERENCES user(email),
    FOREIGN KEY (role_name) REFERENCES roles(role_name),
    FOREIGN KEY (semester_id) REFERENCES sessionSemester(semester_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (category) REFERENCES Categories(category) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gdlink_id) REFERENCES gdlinks(gdlink_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (user_email IS NULL OR role_name IS NULL)
);


-- Ensure the role "Everyone" exists in the roles table
INSERT INTO roles (role_name) VALUES ('Everyone') ON DUPLICATE KEY UPDATE role_name = role_name;

DELIMITER $$

-- Trigger for inserting into categoryPermission when a new category is added
CREATE TRIGGER trg_after_category_insert
AFTER INSERT ON Categories
FOR EACH ROW
BEGIN
    -- Check if "Everyone" already exists in categoryPermission for the category and semester_id
    IF NOT EXISTS (SELECT 1 FROM categoryPermission WHERE category = NEW.category AND semester_id = NEW.semester_id AND role_name = 'Everyone') THEN
        INSERT INTO categoryPermission (category, semester_id, role_name, can_read_category, can_create_links)
        VALUES (NEW.category, NEW.semester_id, 'Everyone', TRUE, FALSE);
    END IF;
END$$

-- Trigger for inserting into linkPermission when a new link is added
CREATE TRIGGER trg_after_link_insert
AFTER INSERT ON gdlinks
FOR EACH ROW
BEGIN
    -- Check if "Everyone" already exists in linkPermission for the category, semester_id, and gdlink_id
    IF NOT EXISTS (SELECT 1 FROM linkPermission WHERE category = NEW.category AND semester_id = NEW.sessem AND gdlink_id = NEW.gdlink_id AND role_name = 'Everyone') THEN
        INSERT INTO linkPermission (category, semester_id, gdlink_id, role_name, can_read, can_update, can_delete)
        VALUES (NEW.category, NEW.sessem, NEW.gdlink_id, 'Everyone', TRUE, FALSE, FALSE);
    END IF;
END$$

-- Trigger to prevent insertion of "Everyone" role into categoryPermission if it already exists for that category and semester
CREATE TRIGGER trg_prevent_insert_category_permission
BEFORE INSERT ON categoryPermission
FOR EACH ROW
BEGIN
    -- Check if "Everyone" already exists for the category and semester
    IF NEW.role_name = 'Everyone' AND EXISTS (SELECT 1 FROM categoryPermission WHERE category = NEW.category AND semester_id = NEW.semester_id AND role_name = 'Everyone') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion of "Everyone" role is not allowed as it already exists in categoryPermission for this category and semester.';
    END IF;
END$$

-- Trigger to prevent insertion of "Everyone" role into linkPermission if it already exists for that category, semester, and link
CREATE TRIGGER trg_prevent_insert_link_permission
BEFORE INSERT ON linkPermission
FOR EACH ROW
BEGIN
    -- Check if "Everyone" already exists for the category, semester, and gdlink_id
    IF NEW.role_name = 'Everyone' AND EXISTS (SELECT 1 FROM linkPermission WHERE category = NEW.category AND semester_id = NEW.semester_id AND gdlink_id = NEW.gdlink_id AND role_name = 'Everyone') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion of "Everyone" role is not allowed as it already exists in linkPermission for this category, semester, and link.';
    END IF;
END$$

-- Trigger to prevent deletion of "Everyone" role from categoryPermission
CREATE TRIGGER trg_prevent_delete_category_permission
BEFORE DELETE ON categoryPermission
FOR EACH ROW
BEGIN
    IF OLD.role_name = 'Everyone' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Deletion of "Everyone" role is not allowed in categoryPermission.';
    END IF;
END$$

-- Trigger to prevent deletion of "Everyone" role from linkPermission
CREATE TRIGGER trg_prevent_delete_link_permission
BEFORE DELETE ON linkPermission
FOR EACH ROW
BEGIN
    IF OLD.role_name = 'Everyone' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Deletion of "Everyone" role is not allowed in linkPermission.';
    END IF;
END$$

DELIMITER ;
