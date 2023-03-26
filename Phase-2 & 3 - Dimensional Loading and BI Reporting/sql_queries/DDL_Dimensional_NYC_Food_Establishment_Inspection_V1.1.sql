-- NYC Food Inspections
-- Dimensional Model
-- 2022-10-11

/*
-- CHange Log
	Dim_NYC_Violation_Codes.VIOLATION_DESCRIPTION from 255 -> 1000 (truncation in ETL)
	FCT_NYC_Food_Inspections.Inspection_Date_SK removed as Dim_Date not modeled
*/

/*
--	Drop Statements
	drop table dbo.Dim_NYC_Violation_Codes
*/
CREATE TABLE dbo.Dim_NYC_Food_Places (
	FoodPlacesSK int NOT NULL,
	CAMIS int NULL,
	DBA nvarchar(95) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (FoodPlacesSK)
);

CREATE TABLE dbo.Dim_NYC_Borough (
	BoroSK int NOT NULL,
	BORO varchar(13) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (BoroSK)
);

CREATE TABLE dbo.Dim_NYC_Addresses (
	AddressSK int NOT NULL,
	BUILDING nvarchar(10) NULL,
	BBL bigint NULL,
	BIN int NULL,
	STREET varchar(40) NULL,
	ZIPCODE char(5) NULL,
	BORO varchar(13) NULL,
	NTA char(4) NULL,
	Latitude float NULL,
	Longitude float NULL,
	Census_Tract char(6) NULL,
	Community_Board smallint NULL,
	Council_District char(2) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (AddressSK)
);

CREATE TABLE dbo.Dim_NYC_Critical_Flag (
	CRITICAL_FLAG_SK int NOT NULL,
	CRITICAL_FLAG char(14) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL
	PRIMARY KEY (CRITICAL_FLAG_SK)
);


CREATE TABLE dbo.Dim_NYC_Cuisine (
	CUISINE_DESCRIPTION_SK int NOT NULL,
	CUISINE_DESCRIPTION varchar(30) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (CUISINE_DESCRIPTION_SK)
);


CREATE TABLE dbo.Dim_NYC_Inspection_Actions (
	ActionSK int NOT NULL,
	ACTION varchar(130) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (ActionSK)
);

CREATE TABLE dbo.Dim_NYC_Inspection_Grades (
	GradeSK int  NOT NULL,
	GRADE char(1) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	CONSTRAINT pk_Dim_NYC_Inspection_Grades_GradeSK PRIMARY KEY (GradeSK)
);

CREATE TABLE dbo.Dim_NYC_Inspection_Type (
	InspectionTypeSK int NOT NULL,
	INSPECTION_TYPE varchar(59) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	CONSTRAINT pk_Dim_NYC_Inspection_Type_InspectionTypeSK PRIMARY KEY (InspectionTypeSK)
);

CREATE TABLE dbo.Dim_NYC_Violation_Codes (
	ViolationCodeSK int NOT NULL,
	VIOLATION_CODE char(5) NULL,
	VIOLATION_DESCRIPTION nvarchar(1000) NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	CONSTRAINT pk_Dim_NYC_Violation_Codes_ViolationCodeSK PRIMARY KEY (ViolationCodeSK)
);

CREATE TABLE dbo.FCT_NYC_Food_Inspections (
	InspectionSK int  NOT NULL,
	Inspection_Date date NULL,
	FoodPlacesSK int NULL,
	BoroSK int NULL,
	AddressSK int NULL,
	PHONE char(12) NULL,
	CUISINE_DESCRIPTION_SK int NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (InspectionSK)
);

CREATE TABLE dbo.FCT_NYC_FoodInspection_Violations (
	InspectionViolationSK int NOT NULL,
	InspectionSK int NULL,
	InspectionTypeSK int NULL,
	ActionSK int NULL,
	CRITICAL_FLAG_SK int NULL,
	SCORE smallint NULL,
	GradeSK int NULL,
	Grade_Date date NULL,
	ViolationCodeSK int NULL,
	Record_Date date NULL,
	DI_CreateDate datetime NULL,
	DI_WorkflowDirectory nvarchar(256) NULL,
	DI_WorkflowFileName nvarchar(256) NULL,
	PRIMARY KEY (InspectionViolationSK)
);

ALTER TABLE dbo.FCT_NYC_Food_Inspections 
ADD CONSTRAINT fk_Dim_NYC_Addresses_FCT_NYC_Food_Inspections FOREIGN KEY (AddressSK)
REFERENCES dbo.Dim_NYC_Addresses (AddressSK);

ALTER TABLE dbo.FCT_NYC_Food_Inspections 
ADD CONSTRAINT fk_Dim_NYC_Borough_FCT_NYC_Food_Inspections FOREIGN KEY (BoroSK)
REFERENCES dbo.Dim_NYC_Borough (BoroSK);

ALTER TABLE dbo.FCT_NYC_Food_Inspections 
ADD CONSTRAINT fk_Dim_NYC_Cuisine_FCT_NYC_Food_Inspections FOREIGN KEY (CUISINE_DESCRIPTION_SK)
REFERENCES dbo.Dim_NYC_Cuisine (CUISINE_DESCRIPTION_SK);

ALTER TABLE dbo.FCT_NYC_Food_Inspections 
ADD CONSTRAINT fk_Dim_NYC_Food_Places_FCT_NYC_Food_Inspections FOREIGN KEY (FoodPlacesSK)
REFERENCES dbo.Dim_NYC_Food_Places (FoodPlacesSK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_Dim_NYC_Critical_Flag_FCT_NYC_FoodInspection_Violations FOREIGN KEY (CRITICAL_FLAG_SK)
REFERENCES dbo.Dim_NYC_Critical_Flag (CRITICAL_FLAG_SK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_Dim_NYC_Inspection_Actions_FCT_NYC_FoodInspection_Violations FOREIGN KEY (ActionSK)
REFERENCES dbo.Dim_NYC_Inspection_Actions (ActionSK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_Dim_NYC_Inspection_Grades_FCT_NYC_FoodInspection_Violations FOREIGN KEY (GradeSK)
REFERENCES dbo.Dim_NYC_Inspection_Grades (GradeSK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_Dim_NYC_Inspection_Type_FCT_NYC_FoodInspection_Violations FOREIGN KEY (InspectionTypeSK)
REFERENCES dbo.Dim_NYC_Inspection_Type (InspectionTypeSK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_Dim_NYC_Violation_Codes_FCT_NYC_FoodInspection_Violations FOREIGN KEY (ViolationCodeSK)
REFERENCES dbo.Dim_NYC_Violation_Codes (ViolationCodeSK);

ALTER TABLE dbo.FCT_NYC_FoodInspection_Violations 
ADD CONSTRAINT fk_FCT_NYC_Food_Inspections_FCT_NYC_FoodInspection_Violations FOREIGN KEY (InspectionSK)
REFERENCES dbo.FCT_NYC_Food_Inspections (InspectionSK);

