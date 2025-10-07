-- =====================================================
-- Script to delete lists and all related records
-- Based on the query: SELECT lc.list_id, l.list_stats_id
-- FROM lists l
-- INNER JOIN list_category lc ON l.id = lc.list_id
-- WHERE lc.category_id = 8
-- =====================================================

-- Start transaction for data consistency
BEGIN TRANSACTION;

BEGIN TRY
    -- Step 1: Get the list_ids that need to be deleted
    -- Store them in a temporary table for reference
    IF OBJECT_ID('tempdb..#ListsToDelete') IS NOT NULL
        DROP TABLE #ListsToDelete;
    
    SELECT DISTINCT lc.list_id, l.list_stats_id
    INTO #ListsToDelete
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8;
    
    PRINT 'Found ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' lists to delete';
    
    -- Step 2: Delete from child tables first (to avoid foreign key violations)
    -- Delete in order from most dependent to least dependent
    
    -- Delete from client_favourite_lists
    DELETE cfl 
    FROM client_favourite_lists cfl
    INNER JOIN #ListsToDelete ltd ON cfl.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from client_favourite_lists';
    
    -- Delete from collection_lists
    DELETE cl 
    FROM collection_lists cl
    INNER JOIN #ListsToDelete ltd ON cl.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from collection_lists';
    
    -- Delete from discount_condition_lists
    DELETE dcl 
    FROM discount_condition_lists dcl
    INNER JOIN #ListsToDelete ltd ON dcl.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from discount_condition_lists';
    
    -- Delete from discount_lists
    DELETE dl 
    FROM discount_lists dl
    INNER JOIN #ListsToDelete ltd ON dl.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from discount_lists';
    
    -- Delete from list_ai_reason
    DELETE lar 
    FROM list_ai_reason lar
    INNER JOIN #ListsToDelete ltd ON lar.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_ai_reason';
    
    -- Delete from list_category_extra_information_answer
    DELETE lcea 
    FROM list_category_extra_information_answer lcea
    INNER JOIN #ListsToDelete ltd ON lcea.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_category_extra_information_answer';
    
    -- Delete from list_draft
    DELETE ld 
    FROM list_draft ld
    INNER JOIN #ListsToDelete ltd ON ld.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_draft';
    
    -- Delete from list_image
    DELETE li 
    FROM list_image li
    INNER JOIN #ListsToDelete ltd ON li.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_image';
    
    -- Delete from list_personalizations
    DELETE lp 
    FROM list_personalizations lp
    INNER JOIN #ListsToDelete ltd ON lp.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_personalizations';
    
    -- Delete from list_price_history
    DELETE lph 
    FROM list_price_history lph
    INNER JOIN #ListsToDelete ltd ON lph.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_price_history';
    
    -- Delete from list_read_stats
    DELETE lrs 
    FROM list_read_stats lrs
    INNER JOIN #ListsToDelete ltd ON lrs.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_read_stats';
    
    -- Delete from list_read_stats_daily
    DELETE lrsd 
    FROM list_read_stats_daily lrsd
    INNER JOIN #ListsToDelete ltd ON lrsd.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_read_stats_daily';
    
    -- Delete from list_regional_districts
    DELETE lrd 
    FROM list_regional_districts lrd
    INNER JOIN #ListsToDelete ltd ON lrd.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_regional_districts';
    
    -- Delete from list_stock_movements
    DELETE lsm 
    FROM list_stock_movements lsm
    INNER JOIN #ListsToDelete ltd ON lsm.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_stock_movements';
    
    -- Delete from lists_lang
    DELETE ll 
    FROM lists_lang ll
    INNER JOIN #ListsToDelete ltd ON ll.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from lists_lang';
    
    -- Delete from list_category (this is where our original condition was)
    DELETE lc 
    FROM list_category lc
    INNER JOIN #ListsToDelete ltd ON lc.list_id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from list_category';
    
    -- Step 3: Finally delete from the main lists table
    DELETE l 
    FROM lists l
    INNER JOIN #ListsToDelete ltd ON l.id = ltd.list_id;
    PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records from lists table';
    
    -- Clean up temporary table
    DROP TABLE #ListsToDelete;
    
    -- Commit the transaction if everything succeeded
    COMMIT TRANSACTION;
    PRINT 'All deletions completed successfully. Transaction committed.';
    
END TRY
BEGIN CATCH
    -- Rollback transaction in case of any error
    ROLLBACK TRANSACTION;
    
    -- Display error information
    PRINT 'Error occurred during deletion process. Transaction rolled back.';
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(10));
    
    -- Clean up temporary table if it exists
    IF OBJECT_ID('tempdb..#ListsToDelete') IS NOT NULL
        DROP TABLE #ListsToDelete;
        
    -- Re-raise the error
    THROW;
END CATCH;