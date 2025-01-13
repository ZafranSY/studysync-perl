-- Drop triggers
DROP TRIGGER IF EXISTS trg_after_category_insert;
DROP TRIGGER IF EXISTS trg_after_link_insert;
DROP TRIGGER IF EXISTS trg_prevent_insert_category_permission;
DROP TRIGGER IF EXISTS trg_prevent_insert_link_permission;
DROP TRIGGER IF EXISTS trg_prevent_delete_category_permission;
DROP TRIGGER IF EXISTS trg_prevent_delete_link_permission;

-- Drop tables in reverse dependency order
DROP TABLE IF EXISTS linkPermission;
DROP TABLE IF EXISTS categoryPermission;
DROP TABLE IF EXISTS gdlinks;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS sessionSemester;