-- SAFE VERSION: SQL Script to Delete Lists and All Related Records
-- This version allows you to review the list_ids before actual deletion
-- Based on the condition: category_id = 8 from list_category table

-- STEP 1: First run this query to see which list_ids will be affected
SELECT 'PREVIEW - Records that will be deleted:' as Info;
SELECT lc.list_id, l.list_stats_id, l.* 
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;

-- STEP 2: Check related records count in each table
SELECT 'Related records count in each table:' as Info;

SELECT 'client_favourite_lists' as table_name, COUNT(*) as record_count
FROM client_favourite_lists cfl
WHERE cfl.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'collection_lists' as table_name, COUNT(*) as record_count
FROM collection_lists cl
WHERE cl.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'discount_condition_lists' as table_name, COUNT(*) as record_count
FROM discount_condition_lists dcl
WHERE dcl.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'discount_lists' as table_name, COUNT(*) as record_count
FROM discount_lists dl
WHERE dl.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_ai_reason' as table_name, COUNT(*) as record_count
FROM list_ai_reason lar
WHERE lar.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_category_extra_information_answer' as table_name, COUNT(*) as record_count
FROM list_category_extra_information_answer lceia
WHERE lceia.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_draft' as table_name, COUNT(*) as record_count
FROM list_draft ld
WHERE ld.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_image' as table_name, COUNT(*) as record_count
FROM list_image li
WHERE li.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_personalizations' as table_name, COUNT(*) as record_count
FROM list_personalizations lp
WHERE lp.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_price_history' as table_name, COUNT(*) as record_count
FROM list_price_history lph
WHERE lph.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_read_stats' as table_name, COUNT(*) as record_count
FROM list_read_stats lrs
WHERE lrs.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_read_stats_daily' as table_name, COUNT(*) as record_count
FROM list_read_stats_daily lrsd
WHERE lrsd.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_regional_districts' as table_name, COUNT(*) as record_count
FROM list_regional_districts lrd
WHERE lrd.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_stock_movements' as table_name, COUNT(*) as record_count
FROM list_stock_movements lsm
WHERE lsm.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'lists_lang' as table_name, COUNT(*) as record_count
FROM lists_lang ll
WHERE ll.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

UNION ALL

SELECT 'list_category' as table_name, COUNT(*) as record_count
FROM list_category lc2
WHERE lc2.list_id IN (
    SELECT lc.list_id 
    FROM lists l
    INNER JOIN list_category lc ON l.id = lc.list_id
    WHERE lc.category_id = 8
)

ORDER BY record_count DESC;

-- STEP 3: After reviewing the above results, if you want to proceed with deletion,
-- uncomment and run the following deletion script:

/*
-- ACTUAL DELETION SCRIPT - UNCOMMENT TO RUN
-- WARNING: This will permanently delete data. Make sure you have a backup!

DECLARE @list_ids TABLE (list_id INT, list_stats_id INT);

-- Store the list_ids to delete
INSERT INTO @list_ids (list_id, list_stats_id)
SELECT lc.list_id, l.list_stats_id
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;

-- Start transaction
BEGIN TRANSACTION;

BEGIN TRY
    -- Delete from child tables first
    DELETE FROM client_favourite_lists WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM collection_lists WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM discount_condition_lists WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM discount_lists WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_ai_reason WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_category_extra_information_answer WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_draft WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_image WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_personalizations WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_price_history WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_read_stats WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_read_stats_daily WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_regional_districts WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_stock_movements WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM lists_lang WHERE list_id IN (SELECT list_id FROM @list_ids);
    DELETE FROM list_category WHERE list_id IN (SELECT list_id FROM @list_ids);
    
    -- Finally delete from main table
    DELETE FROM lists WHERE id IN (SELECT list_id FROM @list_ids);
    
    -- Commit if all successful
    COMMIT TRANSACTION;
    PRINT 'All records deleted successfully!';
    
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;
*/