-- Create Stored Procedure
--EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze As 
BEGIN  

-- Track ETL Duration 
-- Helps to identify bottlenecks, optimize performance, monitor trends, and detect issues
    DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME ;

    
--Add Try ... Catch 
--Ensures error handling, data integrity, and issue logging for easier debugging
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '===================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===================================================';

        PRINT'----------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT'----------------------------------------------------';


        -- TRUNCATE and LOAD 
        -- TRUNCATE: Quickly delete all rows from a table, resetting it into an empty state 
        
        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        -- Calculate loading time using DATEDIFF(): to calculate the difference between two dates or the interval, returns days, months, or years
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds' 
    
        PRINT'>> -----------------------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info
        PRINT '>> Inserting Table: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM '/data/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK 
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds'
        PRINT'>> -----------------------------';


        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds'
        PRINT'>> -----------------------------';


        -- source_erp
        PRINT'----------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT'----------------------------------------------------';

        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds'
        PRINT'>> -----------------------------';


        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101'   
        TRUNCATE TABLE bronze.erp_loc_a101

        PRINT '>> Inserting Table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/data/source_erp/LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK  
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds'
        PRINT'>> -----------------------------';


        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time ,@end_time) AS NVARCHAR) + 'seconds'
        PRINT'>> -----------------------------';

        SET @batch_end_time = GETDATE();
        PRINT '============================================='
        PRINT ' Loading Bronze Layer is Completed';
        PRINT '>> Whole Bach Load Duration:' + CAST(DATEDIFF(second, @batch_start_time ,@batch_end_time) AS NVARCHAR) + 'seconds'
        PRINT '============================================='

    END TRY
    --SQL runs the TRY block, and if it fails, it runs the CATCH block to handle the error
    BEGIN CATCH
        PRINT'================================================='
        PRINT 'ERROR OCCURRED DURING LOADING BROZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT'================================================='
    END CATCH
END
