-- =====================================================
-- Preview script to see what data will be deleted
-- Run this BEFORE running the actual deletion script
-- =====================================================

-- Get the list_ids that will be deleted
SELECT DISTINCT lc.list_id, l.list_stats_id, l.* 
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;

PRINT '=== PREVIEW OF RECORDS TO BE DELETED ===';

-- Store list_ids in a temporary table for the preview
IF OBJECT_ID('tempdb..#ListsToDelete') IS NOT NULL
    DROP TABLE #ListsToDelete;

SELECT DISTINCT lc.list_id, l.list_stats_id
INTO #ListsToDelete
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;

PRINT 'Lists to be deleted: ' + CAST((SELECT COUNT(*) FROM #ListsToDelete) AS VARCHAR(10));

-- Preview records in each related table
PRINT '--- client_favourite_lists ---';
SELECT COUNT(*) as record_count FROM client_favourite_lists cfl
INNER JOIN #ListsToDelete ltd ON cfl.list_id = ltd.list_id;

PRINT '--- collection_lists ---';
SELECT COUNT(*) as record_count FROM collection_lists cl
INNER JOIN #ListsToDelete ltd ON cl.list_id = ltd.list_id;

PRINT '--- discount_condition_lists ---';
SELECT COUNT(*) as record_count FROM discount_condition_lists dcl
INNER JOIN #ListsToDelete ltd ON dcl.list_id = ltd.list_id;

PRINT '--- discount_lists ---';
SELECT COUNT(*) as record_count FROM discount_lists dl
INNER JOIN #ListsToDelete ltd ON dl.list_id = ltd.list_id;

PRINT '--- list_ai_reason ---';
SELECT COUNT(*) as record_count FROM list_ai_reason lar
INNER JOIN #ListsToDelete ltd ON lar.list_id = ltd.list_id;

PRINT '--- list_category_extra_information_answer ---';
SELECT COUNT(*) as record_count FROM list_category_extra_information_answer lcea
INNER JOIN #ListsToDelete ltd ON lcea.list_id = ltd.list_id;

PRINT '--- list_draft ---';
SELECT COUNT(*) as record_count FROM list_draft ld
INNER JOIN #ListsToDelete ltd ON ld.list_id = ltd.list_id;

PRINT '--- list_image ---';
SELECT COUNT(*) as record_count FROM list_image li
INNER JOIN #ListsToDelete ltd ON li.list_id = ltd.list_id;

PRINT '--- list_personalizations ---';
SELECT COUNT(*) as record_count FROM list_personalizations lp
INNER JOIN #ListsToDelete ltd ON lp.list_id = ltd.list_id;

PRINT '--- list_price_history ---';
SELECT COUNT(*) as record_count FROM list_price_history lph
INNER JOIN #ListsToDelete ltd ON lph.list_id = ltd.list_id;

PRINT '--- list_read_stats ---';
SELECT COUNT(*) as record_count FROM list_read_stats lrs
INNER JOIN #ListsToDelete ltd ON lrs.list_id = ltd.list_id;

PRINT '--- list_read_stats_daily ---';
SELECT COUNT(*) as record_count FROM list_read_stats_daily lrsd
INNER JOIN #ListsToDelete ltd ON lrsd.list_id = ltd.list_id;

PRINT '--- list_regional_districts ---';
SELECT COUNT(*) as record_count FROM list_regional_districts lrd
INNER JOIN #ListsToDelete ltd ON lrd.list_id = ltd.list_id;

PRINT '--- list_stock_movements ---';
SELECT COUNT(*) as record_count FROM list_stock_movements lsm
INNER JOIN #ListsToDelete ltd ON lsm.list_id = ltd.list_id;

PRINT '--- lists_lang ---';
SELECT COUNT(*) as record_count FROM lists_lang ll
INNER JOIN #ListsToDelete ltd ON ll.list_id = ltd.list_id;

PRINT '--- list_category ---';
SELECT COUNT(*) as record_count FROM list_category lc
INNER JOIN #ListsToDelete ltd ON lc.list_id = ltd.list_id;

PRINT '--- lists (main table) ---';
SELECT COUNT(*) as record_count FROM lists l
INNER JOIN #ListsToDelete ltd ON l.id = ltd.list_id;

-- Clean up
DROP TABLE #ListsToDelete;

PRINT '=== END PREVIEW ===';
PRINT 'If the counts look correct, run the delete_lists_and_related_records.sql script';