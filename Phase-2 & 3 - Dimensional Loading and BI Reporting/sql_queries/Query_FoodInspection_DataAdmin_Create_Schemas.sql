/* Script to create database, users, logins and schemas for assignments and project 
* Database	--> DAMG7370
* Schemas	--> nyc_ins - NYC Food Establishment Inspection
			--> chicago_ins - Chicago Food Establishment Inspection
			--> dallas_ins - Dallas Food Establishment Inspection
*/

-- 1. Create database in local sql server instance // We will use this database for all the data loads
CREATE DATABASE DAMG7370;

-- 2. Create users and logins
CREATE LOGIN damg7370 WITH PASSWORD = 'password';

-- 3. Create schemas in below DAMG7370 database */
CREATE SCHEMA nyc_ins;
CREATE SCHEMA chicago_ins;
CREATE SCHEMA dallas_ins;

-- 4. Crete user with the nyc_ins/chicago_ins/dallas_ins schema
-- ** We just create one user with any default schema but we can use the specific schema while defining output tables in Alteryx workflow for different data sources
CREATE USER damg7370 
FOR LOGIN damg7370
WITH DEFAULT_SCHEMA = nyc_ins;

-- 5. Provide persmissions to damg7370 user
ALTER ROLE db_datareader ADD MEMBER damg7370;
ALTER ROLE db_datawriter ADD MEMBER damg7370;
ALTER ROLE db_ddladmin ADD MEMBER damg7370;


