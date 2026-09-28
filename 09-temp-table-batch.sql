-- Temporary Table Batch Processing
-- This script demonstrates batch processing using temporary tables

CREATE TEMPORARY TABLE temp_batch_data (
    batch_id INT PRIMARY KEY,
    process_date TIMESTAMP,
    status VARCHAR(50),
    record_count INT
);

INSERT INTO temp_batch_data (batch_id, process_date, status, record_count)
VALUES 
    (1, CURRENT_TIMESTAMP, 'PENDING', 0),
    (2, CURRENT_TIMESTAMP, 'PENDING', 0),
    (3, CURRENT_TIMESTAMP, 'PENDING', 0);

-- Process batches
UPDATE temp_batch_data
SET status = 'PROCESSING'
WHERE status = 'PENDING';

-- Simulate batch completion
UPDATE temp_batch_data
SET status = 'COMPLETED',
    record_count = batch_id * 100
WHERE status = 'PROCESSING';

SELECT * FROM temp_batch_data;

DROP TEMPORARY TABLE temp_batch_data;