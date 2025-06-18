-- Create Stored Procedure

CREATE OR ALTER PROCEDURE bronze.load_bronze As 
BEGIN
--Add Try ... Catch 
--Ensures error handling, data integrity, and issue logging for easier debugging
-- SQL runs the TRY block, and if it fails, it runs the CATCH block to handle the error
    BEGIN TRY
        PRINT '===================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===================================================';

        PRINT'----------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT'----------------------------------------------------';


        -- TRUNCATE and LOAD 
        -- TRUNCATE: Quickly delete all rows from a table, resetting it into an empty state 

        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info

        PRINT '>> Inserting Table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/data/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        /*
        ===============================================================================
        -- Check Data quality 
        -- Every column has data on it or not 
        -- Check that the data has not shifted and is in the correct columns
        - data completeness, like whether all rows are there or not (using count() function), and check the data source, the CSV file in our case
        ===============================================================================
        */
        SELECT * FROM bronze.crm_cust_info
        SELECT COUNT(*) FROM bronze.crm_cust_info

        -- ===============================================================================


        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info

        PRINT '>> Inserting Table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM '/data/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        -- Check Data quality 
        SELECT * FROM bronze.crm_prd_info
        SELECT COUNT(*) FROM bronze.crm_prd_info
        -------------------------------------------------


        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details

        PRINT '>> Inserting Table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM '/data/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );


        -- source_erp
        PRINT'----------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT'----------------------------------------------------';

        PRINT '>> Truncating Table: bronze.erp_cust_az12'
        TRUNCATE TABLE bronze.erp_cust_az12

        PRINT '>> Inserting Table: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM '/data/source_erp/CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK  
        );

        SELECT * FROM bronze.erp_cust_az12
        SELECT COUNT(*) FROM bronze.erp_cust_az12
        --------------------------------------------------
        PRINT '>> Truncating Table: bronze.erp_loc_a101'   
        TRUNCATE TABLE bronze.erp_loc_a101

        PRINT '>> Inserting Table : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/data/source_erp/LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK  
        );

        SELECT * FROM bronze.erp_loc_a101
        SELECT COUNT(*) FROM bronze.erp_loc_a101

        --------------------------------------------------
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2' 
        TRUNCATE TABLE bronze.erp_px_cat_g1v2

        PRINT '>> Inserting Table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/data/source_erp/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK  
        );

        SELECT * FROM bronze.erp_px_cat_g1v2
        SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
    END TRY
    BEGIN CATCH
        PRINT'================================================='
        PRINT 'ERROR OCCURRED DURING LOADING BROZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT'================================================='
    END CATCH
END
