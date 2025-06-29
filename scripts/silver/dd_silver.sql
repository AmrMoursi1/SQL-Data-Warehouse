/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
===============================================================================
*/

-- Table 1: CUST_INFO
-- Columns --> cst_id	cst_key	cst_firstname	cst_lastname	cst_marital_status	cst_gndr	cst_create_date
-- Create tables from the CRM Source Folder

-- Drop the table if it exists
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;

-- Create table
CREATE TABLE silver.crm_cust_info(

    cst_id              INT, 
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50), 
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE,
    dwh_create_data DATETIME2 DEFAULT GETDATE()
);
---------------------------------------------------------------------
-- Table 2: PRD_INFO
-- Columns --> prd_id	prd_key	prd_nm	prd_cost	prd_line	prd_start_dt	prd_end_dt

-- Drop the table if it exists
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info; 
    
-- Create table
CREATE TABLE silver.crm_prd_info(

    prd_id          INT, 
    prd_key         NVARCHAR(50),
    prd_nm          NVARCHAR(50),
    prd_cost        INT, 
    prd_line        NVARCHAR(50),
    prd_start_dt    DATETIME,
    prd_end_dt      DATETIME,
    dwh_create_data DATETIME2 DEFAULT GETDATE()
);
---------------------------------------------------------------------
-- Table 3: SALES_DETAILS
-- Columns --> sls_ord_num	sls_prd_key	sls_cust_id	sls_order_dt	sls_ship_dt	sls_due_dt	sls_sales	sls_quantity	sls_price

-- Drop the table if it exists
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details; 
    
-- Create table 
CREATE TABLE silver.crm_sales_details(

    sls_ord_num     NVARCHAR(50), 
    sls_prd_key     NVARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    INT, 
    sls_ship_dt     INT,
    sls_due_dt      INT,
    csls_sales      INT,
    sls_quantity    INT,
    sls_price       INT,
    dwh_create_data DATETIME2 DEFAULT GETDATE()
);
--=====================================================================
-- Create tables from ERP FOLDER

-- Columns --> from table CUST_AZ12 : CID	BDATE	GEN

-- Drop the table if it exists
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12; 
    
-- Create table 
 CREATE TABLE silver.erp_cust_az12(
    cid     NVARCHAR(50),
    bdate   DATE,
    gen     NVARCHAR(50),
    dwh_create_data DATETIME2 DEFAULT GETDATE()
 );
---------------------------------------------------------------------

 -- Columns --> from table loc_a101 : CID	CNTRY

 -- Drop the table if it exists
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101; 
    
-- Create table
 CREATE TABLE silver.erp_loc_a101(
    cid     NVARCHAR(50),
    cntry   NVARCHAR(50),
    dwh_create_data DATETIME2 DEFAULT GETDATE()
 );
---------------------------------------------------------------------

 -- Columns --> from table PX_CAT_G1V2 : ID	CAT	SUBCAT	MAINTENANCE
 -- Drop the table if it exists
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2; 
    
-- Create table

 CREATE TABLE silver.erp_px_cat_g1v2(
    id          NVARCHAR(50),
    cat         NVARCHAR(50),
    subcat      NVARCHAR(50),
    maintenace  NVARCHAR(50),
    dwh_create_data DATETIME2 DEFAULT GETDATE()
 );

