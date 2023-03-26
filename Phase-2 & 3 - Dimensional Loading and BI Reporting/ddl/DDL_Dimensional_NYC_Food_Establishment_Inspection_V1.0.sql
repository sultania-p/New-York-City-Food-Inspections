/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      NYC_Food_Establishment_Inspection_DimensionalDataModel.DM1
 *
 * Date Created : Wednesday, October 05, 2022 22:38:55
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: DimAddress 
 */

CREATE TABLE nyc_ins.DimAddress(
    AddressSK                         int              NOT NULL,
    RestaurantSK                      int              NULL,
    StreetAddress                     nvarchar(255)    NULL,
    BuildingNumber                    varchar(20)      NULL,
    City                              varchar(255)     NULL,
    State                             varchar(255)     NULL,
    Country                           varchar(255)     NULL,
    ZipCode                           char(10)         NULL,
    BuildingIdentificationNumber      int              NULL,
    BoroughLocationName               varchar(50)      NULL,
    BoroughBlockLotNumber             bigint           NULL,
    NeighborhoodTabulationAreaCode    char(6)          NULL,
    Latitude                          float            NULL,
    Longitude                         float            NULL,
    DI_JobID                          varchar(255)     NULL,
    DI_CreateDate                     datetime         NULL,
    DI_ModifiedDate                   datetime         NULL,
    CONSTRAINT PK_DimAddress PRIMARY KEY CLUSTERED (AddressSK)
)

go


IF OBJECT_ID('DimAddress') IS NOT NULL
    PRINT '<<< CREATED TABLE DimAddress >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimAddress >>>'
go

/* 
 * TABLE: DimDate 
 */

CREATE TABLE nyc_ins.DimDate(
    DateSK               int             NOT NULL,
    FullDate             date            NULL,
    DayNumberOfWeek      int             NULL,
    DayNameOfWeek        nvarchar(10)    NULL,
    MonthName            nvarchar(10)    NULL,
    MonthNumberOfYear    int             NULL,
    CalendarYear         smallint        NULL,
    DI_CreateDate        datetime        NULL,
    DI_ModifiedDate      datetime        NULL,
    DI_JobID             varchar(255)    NULL,
    CONSTRAINT PK_DimDate PRIMARY KEY CLUSTERED (DateSK)
)

go


IF OBJECT_ID('DimDate') IS NOT NULL
    PRINT '<<< CREATED TABLE DimDate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimDate >>>'
go

/* 
 * TABLE: DimInspection 
 */

CREATE TABLE nyc_ins.DimInspection(
    InspectionSK       int             NOT NULL,
    InspectionType     varchar(100)    NULL,
    DI_JobID           varchar(255)    NULL,
    DI_CreateDate      datetime        NULL,
    DI_ModifiedDate    datetime        NULL,
    CONSTRAINT PK_DimInspection PRIMARY KEY CLUSTERED (InspectionSK)
)

go


IF OBJECT_ID('DimInspection') IS NOT NULL
    PRINT '<<< CREATED TABLE DimInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimInspection >>>'
go

/* 
 * TABLE: DimRestaurant 
 */

CREATE TABLE nyc_ins.DimRestaurant(
    RestaurantSK                      int              NOT NULL,
    RestaurantIdentificationNumber    int              NOT NULL,
    RestaurantName                    nvarchar(255)    NULL,
    PhoneNumber                       char(12)         NULL,
    CuisineDescription                varchar(50)      NULL,
    CommunityBoardNumber              int              NULL,
    CouncilDistrictNumber             char(6)          NULL,
    CensusTractNumber                 char(10)         NULL,
    DI_JobID                          varchar(255)     NULL,
    DI_CreateDate                     datetime         NULL,
    DI_ModifiedDate                   datetime         NULL,
    CONSTRAINT PK_DimRestaurant PRIMARY KEY CLUSTERED (RestaurantSK)
)

go


IF OBJECT_ID('DimRestaurant') IS NOT NULL
    PRINT '<<< CREATED TABLE DimRestaurant >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimRestaurant >>>'
go

/* 
 * TABLE: DimViolation 
 */

CREATE TABLE nyc_ins.DimViolation(
    ViolationSK             int               NOT NULL,
    ViolationCode           char(10)          NULL,
    ViolationDescription    nvarchar(1000)    NULL,
    CriticalFlag            char(14)          NULL,
    DI_JobID                varchar(255)      NULL,
    DI_CreateDate           datetime          NULL,
    DI_ModifiedDate         datetime          NULL,
    CONSTRAINT PK_DimViolation PRIMARY KEY CLUSTERED (ViolationSK)
)

go


IF OBJECT_ID('DimViolation') IS NOT NULL
    PRINT '<<< CREATED TABLE DimViolation >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimViolation >>>'
go

/* 
 * TABLE: FactRestaurantInspection 
 */

CREATE TABLE nyc_ins.FactRestaurantInspection(
    RestaurantInspectionSK         int              NOT NULL,
    InspectionDateSK               int              NULL,
    InspectionDate                 date             NULL,
    InspectionScore                tinyint          NULL,
    GradeDateSK                    int              NULL,
    GradeDate                      date             NULL,
    ViolationSK                    int              NOT NULL,
    InspectionActionDescription    varchar(255)     NULL,
    InspectionSK                   int              NULL,
    GradeCode                      char(1)          NULL,
    GradeDescription               nvarchar(255)    NULL,
    RestaurantSK                   int              NULL,
    DI_JobID                       varchar(255)     NULL,
    DI_CreateDate                  datetime         NULL,
    DI_ModifiedDate                datetime         NULL,
    CONSTRAINT PK_FactRestaurantInspection PRIMARY KEY CLUSTERED (RestaurantInspectionSK)
)

go


IF OBJECT_ID('FactRestaurantInspection') IS NOT NULL
    PRINT '<<< CREATED TABLE FactRestaurantInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FactRestaurantInspection >>>'
go

/* 
 * INDEX: FK_DimAddress_DimRestaurant 
 */

CREATE INDEX FK_DimAddress_DimRestaurant ON nyc_ins.DimAddress(RestaurantSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('DimAddress') AND name='FK_DimAddress_DimRestaurant')
    PRINT '<<< CREATED INDEX DimAddress.FK_DimAddress_DimRestaurant >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX DimAddress.FK_DimAddress_DimRestaurant >>>'
go

/* 
 * INDEX: FK_FactRestaurantInspection_DimViolation 
 */

CREATE INDEX FK_FactRestaurantInspection_DimViolation ON nyc_ins.FactRestaurantInspection(ViolationSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('FactRestaurantInspection') AND name='FK_FactRestaurantInspection_DimViolation')
    PRINT '<<< CREATED INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimViolation >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimViolation >>>'
go

/* 
 * INDEX: FK_FactRestaurantInspection_DimDate 
 */

CREATE INDEX FK_FactRestaurantInspection_DimDate ON nyc_ins.FactRestaurantInspection(InspectionDateSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('FactRestaurantInspection') AND name='FK_FactRestaurantInspection_DimDate')
    PRINT '<<< CREATED INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimDate >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimDate >>>'
go

/* 
 * INDEX: FK_FactRestaurantInspection_DimInspection 
 */

CREATE INDEX FK_FactRestaurantInspection_DimInspection ON nyc_ins.FactRestaurantInspection(InspectionSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('FactRestaurantInspection') AND name='FK_FactRestaurantInspection_DimInspection')
    PRINT '<<< CREATED INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimInspection >>>'
go

/* 
 * INDEX: FK_FactRestaurantInspection_DimRestaurant 
 */

CREATE INDEX FK_FactRestaurantInspection_DimRestaurant ON nyc_ins.FactRestaurantInspection(RestaurantSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('FactRestaurantInspection') AND name='FK_FactRestaurantInspection_DimRestaurant')
    PRINT '<<< CREATED INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimRestaurant >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX FactRestaurantInspection.FK_FactRestaurantInspection_DimRestaurant >>>'
go

/* 
 * INDEX: Ref1130 
 */

CREATE INDEX Ref1130 ON nyc_ins.FactRestaurantInspection(GradeDateSK)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('FactRestaurantInspection') AND name='Ref1130')
    PRINT '<<< CREATED INDEX FactRestaurantInspection.Ref1130 >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX FactRestaurantInspection.Ref1130 >>>'
go

/* 
 * TABLE: DimAddress 
 */

ALTER TABLE nyc_ins.DimAddress ADD CONSTRAINT nyc_ins.FK_DimAddress_DimRestaurant 
    FOREIGN KEY (RestaurantSK)
    REFERENCES DimRestaurant(RestaurantSK)
go


/* 
 * TABLE: FactRestaurantInspection 
 */

ALTER TABLE nyc_ins.FactRestaurantInspection ADD CONSTRAINT RefDimDate30 
    FOREIGN KEY (GradeDateSK)
    REFERENCES DimDate(DateSK)
go

ALTER TABLE nyc_ins.FactRestaurantInspection ADD CONSTRAINT FK_FactRestaurantInspection_DimDate 
    FOREIGN KEY (InspectionDateSK)
    REFERENCES DimDate(DateSK)
go

ALTER TABLE nyc_ins.FactRestaurantInspection ADD CONSTRAINT FK_FactRestaurantInspection_DimInspection 
    FOREIGN KEY (InspectionSK)
    REFERENCES DimInspection(InspectionSK)
go

ALTER TABLE nyc_ins.FactRestaurantInspection ADD CONSTRAINT FK_FactRestaurantInspection_DimRestaurant 
    FOREIGN KEY (RestaurantSK)
    REFERENCES DimRestaurant(RestaurantSK)
go

ALTER TABLE nyc_ins.FactRestaurantInspection ADD CONSTRAINT FK_FactRestaurantInspection_DimViolation 
    FOREIGN KEY (ViolationSK)
    REFERENCES DimViolation(ViolationSK)
go


