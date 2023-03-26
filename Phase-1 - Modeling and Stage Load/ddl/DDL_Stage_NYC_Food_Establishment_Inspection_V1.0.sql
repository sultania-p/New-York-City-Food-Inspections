/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      NYC_Food_Establishment_Inspection_DataModel.DM1
 *
 * Date Created : Wednesday, October 05, 2022 22:40:33
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: STG_NYC_FOOD_ESTD_INS 
 */

CREATE TABLE nyc_ins.STG_NYC_FOOD_ESTD_INS(
    STG_NYC_FOOD_ESTD_INS_ID    int               NOT NULL,
    DI_FILENAME                 varchar(255)      NULL,
    DI_WORKFLOWFILENAME         varchar(255)      NULL,
    DI_CREATEDATE               datetime          NULL,
    CAMIS                       int               NULL,
    DBA                         nvarchar(255)     NULL,
    BORO                        varchar(50)       NULL,
    BUILDING                    varchar(20)       NULL,
    STREET                      nvarchar(255)     NULL,
    ZIPCODE                     char(10)          NULL,
    PHONE                       char(12)          NULL,
    CUISINE_DESCRIPTION         varchar(50)       NULL,
    INSPECTION_DATE             char(10)          NULL,
    INSPECTION_DATE_OUT         date              NULL,
    ACTION                      varchar(255)      NULL,
    VIOLATION_CODE              char(10)          NULL,
    VIOLATION_DESCRIPTION       nvarchar(1000)    NULL,
    CRITICAL_FLAG               char(14)          NULL,
    SCORE                       tinyint           NULL,
    GRADE                       char(1)           NULL,
    GRADE_DATE                  char(10)          NULL,
    GRADE_DATE_OUT              date              NULL,
    RECORD_DATE                 char(10)          NULL,
    RECORD_DATE_OUT             date              NULL,
    INSPECTION_TYPE             varchar(100)      NULL,
    LATITUDE                    float             NULL,
    LONGITUDE                   float             NULL,
    COMMUNITY_BOARD             int               NULL,
    COUNCIL_DISTRICT            char(6)           NULL,
    CENSUS_TRACT                char(10)          NULL,
    BIN                         int               NULL,
    BBL                         bigint            NULL,
    NTA                         char(6)           NULL,
    LOCATION_POINT              varchar(50)       NULL,
    CONSTRAINT PK_STG_NYC_FOOD_ESTD_INS PRIMARY KEY CLUSTERED (STG_NYC_FOOD_ESTD_INS_ID)
)

go


IF OBJECT_ID('STG_NYC_FOOD_ESTD_INS') IS NOT NULL
    PRINT '<<< CREATED TABLE STG_NYC_FOOD_ESTD_INS >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE STG_NYC_FOOD_ESTD_INS >>>'
go

