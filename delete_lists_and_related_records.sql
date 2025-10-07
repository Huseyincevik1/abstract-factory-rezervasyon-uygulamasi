-- SQL Script to Delete Lists and All Related Records
-- This script deletes list records and all related foreign key references
-- Based on the condition: category_id = 8 from list_category table

-- First, let's create a temporary table to store the list_ids we want to delete
-- This ensures consistency throughout the deletion process
IF OBJECT_ID('tempdb..#lists_to_delete') IS NOT NULL
    DROP TABLE #lists_to_delete;

CREATE TABLE #lists_to_delete (
    list_id INT PRIMARY KEY,
    list_stats_id INT
);

-- Insert the list_ids that need to be deleted based on your original query
INSERT INTO #lists_to_delete (list_id, list_stats_id)
SELECT lc.list_id, l.list_stats_id
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;

-- Display the records that will be deleted for verification
SELECT 'Records to be deleted:' as Info;
SELECT * FROM #lists_to_delete;

-- Start transaction to ensure data integrity
BEGIN TRANSACTION;

BEGIN TRY
    -- Delete records from child tables first (foreign key references)
    -- Order is important to avoid foreign key constraint violations
    
    -- 1. Delete from client_favourite_lists
    DELETE cfl 
    FROM client_favourite_lists cfl
    INNER JOIN #lists_to_delete ltd ON cfl.list_id = ltd.list_id;
    
    PRINT 'Deleted from client_favourite_lists: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 2. Delete from collection_lists
    DELETE cl 
    FROM collection_lists cl
    INNER JOIN #lists_to_delete ltd ON cl.list_id = ltd.list_id;
    
    PRINT 'Deleted from collection_lists: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 3. Delete from discount_condition_lists
    DELETE dcl 
    FROM discount_condition_lists dcl
    INNER JOIN #lists_to_delete ltd ON dcl.list_id = ltd.list_id;
    
    PRINT 'Deleted from discount_condition_lists: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 4. Delete from discount_lists
    DELETE dl 
    FROM discount_lists dl
    INNER JOIN #lists_to_delete ltd ON dl.list_id = ltd.list_id;
    
    PRINT 'Deleted from discount_lists: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 5. Delete from list_ai_reason
    DELETE lar 
    FROM list_ai_reason lar
    INNER JOIN #lists_to_delete ltd ON lar.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_ai_reason: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 6. Delete from list_category_extra_information_answer
    DELETE lceia 
    FROM list_category_extra_information_answer lceia
    INNER JOIN #lists_to_delete ltd ON lceia.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_category_extra_information_answer: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 7. Delete from list_draft
    DELETE ld 
    FROM list_draft ld
    INNER JOIN #lists_to_delete ltd ON ld.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_draft: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 8. Delete from list_image
    DELETE li 
    FROM list_image li
    INNER JOIN #lists_to_delete ltd ON li.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_image: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 9. Delete from list_personalizations
    DELETE lp 
    FROM list_personalizations lp
    INNER JOIN #lists_to_delete ltd ON lp.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_personalizations: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 10. Delete from list_price_history
    DELETE lph 
    FROM list_price_history lph
    INNER JOIN #lists_to_delete ltd ON lph.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_price_history: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 11. Delete from list_read_stats
    DELETE lrs 
    FROM list_read_stats lrs
    INNER JOIN #lists_to_delete ltd ON lrs.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_read_stats: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 12. Delete from list_read_stats_daily
    DELETE lrsd 
    FROM list_read_stats_daily lrsd
    INNER JOIN #lists_to_delete ltd ON lrsd.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_read_stats_daily: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 13. Delete from list_regional_districts
    DELETE lrd 
    FROM list_regional_districts lrd
    INNER JOIN #lists_to_delete ltd ON lrd.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_regional_districts: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 14. Delete from list_stock_movements
    DELETE lsm 
    FROM list_stock_movements lsm
    INNER JOIN #lists_to_delete ltd ON lsm.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_stock_movements: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 15. Delete from lists_lang
    DELETE ll 
    FROM lists_lang ll
    INNER JOIN #lists_to_delete ltd ON ll.list_id = ltd.list_id;
    
    PRINT 'Deleted from lists_lang: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 16. Delete from list_category (this should be done before deleting from lists)
    DELETE lc 
    FROM list_category lc
    INNER JOIN #lists_to_delete ltd ON lc.list_id = ltd.list_id;
    
    PRINT 'Deleted from list_category: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- 17. Finally, delete from the main lists table
    DELETE l 
    FROM lists l
    INNER JOIN #lists_to_delete ltd ON l.id = ltd.list_id;
    
    PRINT 'Deleted from lists: ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' records';
    
    -- Commit the transaction if everything succeeded
    COMMIT TRANSACTION;
    PRINT 'All deletions completed successfully!';
    
END TRY
BEGIN CATCH
    -- Rollback the transaction if any error occurred
    ROLLBACK TRANSACTION;
    
    -- Display error information
    PRINT 'Error occurred during deletion process:';
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'All changes have been rolled back.';
    
END CATCH;

-- Clean up temporary table
IF OBJECT_ID('tempdb..#lists_to_delete') IS NOT NULL
    DROP TABLE #lists_to_delete;

-- Optional: Display final verification query
-- Uncomment the following lines if you want to verify the deletion
/*
SELECT 'Verification - These list_ids should no longer exist:' as Info;
SELECT lc.list_id, l.list_stats_id
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;
*/