# New York City Food Inspections

<br>

<p align="center">
 <img src="./img/nyc-logo.jpg" title="NYC Open Data logo" alt = "NYC Open Data logo" />
</p>

## Problem Definition

In this dataset sourced from NYC Open Data portal, we need to design and implement a data engineering solution that can integrate, transform, and load this data into a centralized data warehouse, enabling the data analysts and scientists to easily access and analyze it. The solution must be scalable, resilient, and secure, able to handle increasing data volumes and diverse data types while ensuring data integrity and compliance with data protection regulations. The ultimate goal of this data engineering solution is to enable our organization to make data-driven decisions, improve customer engagement, and drive business growth.

## Learning

This project has a strong emphasis on applied learning. I got to analyze restaurants inspections happening in NYC, using information from the NYC Open Data portal to build a data engineering pipeline involving data extraction, data cleansing, transformation, exploratory analysis, data visualization, and data flow orchestration of event data on the cloud.

## Data Source

**DOHMH New York City Restaurant Inspection Results** - The dataset contains every sustained or not yet adjudicated violation citation from every full or special program inspection conducted up to three years prior to the most recent inspection for restaurants and college cafeterias in an active status. This dataset and the information on the Health Department’s Restaurant Grading website come from the same data source. The Health Department’s Restaurant Grading website is here:
http://www1.nyc.gov/site/doh/services/restaurant-grades.page

The dataset for this project is acquired from NYC Open Data Portal:
https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j

## Data Description

This dataset consists of below metadata information:
|              Metadata                |   Value  |
|:------------------------------------:|:--------:|
|               Rows                   |    240K  |
|             Columns                  |     27   |
|          Update Frequency            |   Daily  |
|             File Format              |    csv   |


## Tools 

Below tools have been utilized for the various segments involving Data Profiling, Modeling, Integration and BI Reporting and Visualizations:

<p align="center">  
    <br>
	<a href="#">
        <img height=100 src="img/erstudio.png" alt="ER/Studio" title="ER/Studio" hspace=80> 
  </a>	
 	<a href="#">
        <img height=100 src="img/alteryx.png" alt="Alteryx" title="Alteryx" hspace=80> 
  </a>
    <br>
</p>
<br>
<p align="center">  
    <br>
	<a href="#">
        <img height=100 src="img/mssqlserver-modified.png" alt="Microsoft SQL Server" title="Microsoft SQL Server" hspace=80> 
  </a>	
 	<a href="#">
        <img height=100 src="img/powerbi.png" alt="Power BI" title="Power BI" hspace=80> 
  </a>
  	<a href="#">
        <img height=100 src="img/tableau.png" alt="Tableau" title="Tableau" hspace=80> 
  </a>
    <br>
</p>

## Data Modeling

This project leverages the capability of ER/Studio Data Architect to design, visualize, and manage data models and metadata for the database. ER/Studio allowed to create conceptual, logical, and physical data models and map the relationships and dependencies between them.

<p align="center">  
  <br>
	<a href="#">
        <img src="img/stage_model.png"> 
  </a>		
    <br>
	Figure 1 : New York City Food Inspection Stage Data Model
</p>
<br>

<p align="center">  
  <br>
	<a href="#">
        <img src="img/dim_model.jpg"> 
  </a>		
    <br>
	Figure 2 : New York City Food Inspection Dimensional Data Model
</p>

## Data Integration / ETL Pipeline

In this project, data is analysed, profiled, transformed and loaded into Microsoft SQL server by Alteryx. Data is collected in the form of flat files (csv/tsv) and is moved to landing zones (Stage) in SQL Server.

The ETL process involved 2 layer of data landing, transformation and loading.
- **Landing or Staging Data Layer**: The data is extracted form source and staged into the SQL Server database. Here the main focus is to land the data from source without minimal transformation (as-is data load). Also, ETL Audit fields such as DI_FILENAME, DI_WORKFLOWNAME, DI_CREATEDATE etc. were added to identify newly loaded or updated records by using audit columns.

	|              Schema                  |             Table  	   |
	|:------------------------------------:|:-------------------------:|
	|               NYC_INS                |    STG_NYC_FOOD_ESTD_INS  |
<p align="center">  
  <br>
	<a href="#">
        <img src="img/stage_load.jpg"> 
  </a>		
    <br>
	Figure 3 : New York City Food Inspection Staging Workflow
</p>
<br>
	
- **Dimensional Data Layer**: Data is loaded to multi-fact dimensional data warehouse after performing extraction from Stage and transformation with defined rules and performed data quality checks post data load. I also addded DI attributes (audit columns) to each dimension and fact for record audit and maintenance.

	|              Schema                  |             Table  	   |
	|:------------------------------------:|:-------------------------:|
	|               NYC_INS                |    Dim_NYC_Addresses  |
	|               NYC_INS                |    Dim_NYC_Borough  |
	|               NYC_INS                |    Dim_NYC_Critical_Flag  |
	|               NYC_INS                |    Dim_NYC_Cuisine  |
	|               NYC_INS                |    Dim_NYC_Inspection_Actions  |
	|               NYC_INS                |    Dim_NYC_Inspection_Grades  |
	|               NYC_INS                |    Dim_NYC_Inspection_Type  |
	|               NYC_INS                |    Dim_NYC_Food_Places
	|               NYC_INS                |    Dim_NYC_Violation_Codes  |
	|               NYC_INS                |    FCT_NYC_Food_Inspections  |
	|               NYC_INS                |    FCT_NYC_FoodInspection_Violations  |
<br>
<p align="center">  
  <br>
	<a href="#">
        <img src="img/dim_load.jpg">
  </a>		
    <br>
	Figure 4 : New York City Food Inspection Dimensional Workflow (Dimension Container)
</p>
<br>
<p align="center">  
  <br>
	<a href="#">
        <img src="img/fact_load.jpg">
  </a>		
    <br>
	Figure 5 : New York City Food Inspection Dimensional Workflow (Fact Container) 
</p>
<br>

## BI Reporting

BI reporting—preparing, analyzing, and portraying business metrics is fundamental to every business. The goal of BI reporting is to provide data insights to support decision making. This project leverages the potential of Power BI and Tableau to derive key business insights by identifying key measurements such as Satisfaction level and apply dimensions such as Inspection date, Restaurant and Violation Code information. The BI reports and dashboards developed as part of this project serves the purpose of identifying the violations in health norms and regulations at restaurants and cafeterias in New York City. Some of the snapshots of the dashboards are attached below:

<p align="center">  
  <br>
	<a href="#">
        <img src="img/bi-1.jpg">
  </a>		
    <br>
	Figure 6 : Executive Summary Dashboard
</p>
<br>
<p align="center">  
  <br>
	<a href="#">
        <img src="img/bi-2.jpg">
  </a>		
    <br>
	Figure 7 : Inspection Results over Time
</p>
<br>
<p align="center">  
  <br>
	<a href="#">
        <img src="img/bi-3.jpg">
  </a>		
    <br>
	Figure 8 : Critical Violations Distribution by Neighborhood
</p>
<br>
<p align="center">  
  <br>
	<a href="#">
        <img src="img/bi-4.jpg">
  </a>		
    <br>
	Figure 9 : Inspection Results by Geography (Tableau Maps)
</p>
<br>
