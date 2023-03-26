-- NewYorkcity Stage, Dimensions and Fact tables count

/* Change Log */
--alter table [nyc_ins].[STG_NYC_FOOD_ESTD_INS] alter column [BUILDING] nvarchar(40)

select count(*) as Count_Stg_NYC_Food_Estd_Ins from [nyc_ins].[STG_NYC_FOOD_ESTD_INS]
select count(*) as Count_Dim_NYC_Food_Places from dbo.Dim_NYC_Food_Places
select count(*) as Count_Dim_NYC_Borough from dbo.Dim_NYC_Borough
select count(*) as Count_Dim_NYC_Addresses from dbo.Dim_NYC_Addresses
select count(*) as Count_Dim_NYC_Cuisine from dbo.Dim_NYC_Cuisine
select count(*) as Count_Dim_NYC_Critical_Flag from dbo.Dim_NYC_Critical_Flag
select count(*) as Count_Dim_NYC_Violation_Codes from dbo.Dim_NYC_Violation_Codes
select count(*) as Count_Dim_NYC_Inspection_Actions from dbo.Dim_NYC_Inspection_Actions
select count(*) as Count_Dim_Dim_NYC_Inspection_Grades from dbo.Dim_NYC_Inspection_Grades
select count(*) as Count_Dim_NYC_Inspection_Type from dbo.Dim_NYC_Inspection_Type

select count(*) as Count_FCT_NYC_Food_Inspections from dbo.FCT_NYC_Food_Inspections
select count(*) as Count_FCT_NYC_FoodInspection_Violations from dbo.FCT_NYC_FoodInspection_Violations


/*
--> Truncate Table Script
Truncate table dbo.Dim_NYC_Food_Places
Truncate table dbo.Dim_NYC_Borough
Truncate table dbo.Dim_NYC_Addresses
Truncate table dbo.Dim_NYC_Cuisine
Truncate table dbo.Dim_NYC_Critical_Flag
Truncate table dbo.Dim_NYC_Violation_Codes
Truncate table dbo.Dim_NYC_Inspection_Actions
Truncate table dbo.Dim_NYC_Inspection_Grades
Truncate table dbo.Dim_NYC_Inspection_Type

Truncate table dbo.FCT_Chicago_FoodInspections
Truncate table dbo.FCT_Chicago_FoodInspections_Violations
*/

/* 
Data Validations Post Load
*/

select 
	FV.[InspectionSK], 
	FI.PHONE,
	FP.CAMIS, FP.DBA,
	B.BORO,
	C.CUISINE_DESCRIPTION,
	A.STREET, A.BUILDING, A.ZIPCODE, A.BBL, A.BIN,
	FI.Inspection_Date, 
	VC.VIOLATION_CODE, VC.VIOLATION_DESCRIPTION,
	CF.CRITICAL_FLAG,
	IT.INSPECTION_TYPE,
	[SCORE], [Grade_Date], IG.GRADE,
	IA.ACTION
from  [dbo].[FCT_NYC_Food_Inspections] FI
join  [dbo].[FCT_NYC_FoodInspection_Violations] FV on FI.InspectionSK = FV.InspectionSK
join [dbo].[Dim_NYC_Violation_Codes] VC on FV.ViolationCodeSK = VC.ViolationCodeSK
join [dbo].[Dim_NYC_Critical_Flag] CF on CF.[CRITICAL_FLAG_SK] = FV.CRITICAL_FLAG_SK
join [dbo].[Dim_NYC_Inspection_Grades] IG on FV.GradeSK = IG.GradeSK
join [dbo].[Dim_NYC_Inspection_Type] IT on IT.InspectionTypeSK = FV.InspectionTypeSK
join [dbo].[Dim_NYC_Inspection_Actions] IA on FV.ActionSK = IA.ActionSK
join [dbo].[Dim_NYC_Food_Places] FP on FI.FoodPlacesSK = FP.FoodPlacesSK
join [dbo].[Dim_NYC_Borough] B on FI.BoroSK = B.BoroSK
join [dbo].[Dim_NYC_Addresses] A on FI.AddressSK = A.AddressSK
join [dbo].[Dim_NYC_Cuisine] C on FI.CUISINE_DESCRIPTION_SK = C.CUISINE_DESCRIPTION_SK
where FI.InspectionSK = 5
