
-- Drop all the triggers first
DROP TRIGGER IF EXISTS before_insert_link_permission_AcademicOfficerNoOverride;
DROP TRIGGER IF EXISTS before_update_link_permission_AcademicOfficerNoOverride;
DROP TRIGGER IF EXISTS before_insert_category_permission_ReadFalseAllFalse;
DROP TRIGGER IF EXISTS before_update_category_permission_ReadFalseAllFalse;
DROP TRIGGER IF EXISTS before_insert_link_permission_NoOverrideOwner;
DROP TRIGGER IF EXISTS before_delete_link_permission_NoDeleteEveryone;
DROP TRIGGER IF EXISTS before_delete_category_permission_NoDeleteEveryone;
DROP TRIGGER IF EXISTS after_insert_categories_grant_academic_officer_permissions;
DROP TRIGGER IF EXISTS after_insert_gdlinks_grant_owner_permissions;



DROP TABLE IF EXISTS linkPermission;
DROP TABLE IF EXISTS categoryPermission;
DROP TABLE IF EXISTS gdlinks;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS sessionSemester;
