USE sarthak_db;

-- Allow larger image BLOB uploads for this MySQL server.
-- If this fails in phpMyAdmin/MySQL Workbench, run it as root/admin or set max_allowed_packet=64M in my.ini.
SET GLOBAL max_allowed_packet = 67108864;

-- Update users table to store images in database as BLOB.
-- Run only the ADD statements for columns that do not already exist.
-- If a column already exists, run only the MODIFY statement for that column.
ALTER TABLE users ADD COLUMN profile_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN profile_image LONGBLOB NULL;

ALTER TABLE users ADD COLUMN cover_image LONGBLOB NULL;
ALTER TABLE users MODIFY COLUMN cover_image LONGBLOB NULL;

-- Ensure session persistence isn't literally about the session but the data being stored
-- The user mentioned "stored image in database"
