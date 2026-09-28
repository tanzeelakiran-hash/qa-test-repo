-- Multi-Query Import Script
-- Multiple queries for data import and transformation

-- Query 1: Create staging table
CREATE TABLE IF NOT EXISTS staging_import (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source_id VARCHAR(50),
    data_field1 VARCHAR(100),
    data_field2 VARCHAR(100),
    import_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Query 2: Truncate staging before import
TRUNCATE TABLE staging_import;

-- Query 3: Import data
INSERT INTO staging_import (source_id, data_field1, data_field2)
VALUES 
    ('SRC001', 'Test Data 1', 'Value 1'),
    ('SRC002', 'Test Data 2', 'Value 2'),
    ('SRC003', 'Test Data 3', 'Value 3'),
    ('SRC004', 'Test Data 4', 'Value 4'),
    ('SRC005', 'Test Data 5', 'Value 5');

-- Query 4: Validate import
SELECT 
    COUNT(*) as total_records,
    MIN(import_timestamp) as first_import,
    MAX(import_timestamp) as last_import
FROM staging_import;

-- Query 5: Transform and load to main table
INSERT INTO main_table (source_id, field1, field2, processed_date)
SELECT 
    source_id,
    UPPER(data_field1) as field1,
    LOWER(data_field2) as field2,
    CURRENT_TIMESTAMP
FROM staging_import
WHERE source_id NOT IN (SELECT source_id FROM main_table);

-- Query 6: Cleanup
DROP TABLE staging_import;