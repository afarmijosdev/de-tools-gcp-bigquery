-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://afarmijostech_dezoomcamp_hw3_2025/yellow_tripdata_2024-*.parquet']
);

CREATE OR REPLACE TABLE `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned` AS
SELECT * FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.external_yellow_tripdata`;

-- QUESTION-1
-- Check yellow trip data
SELECT count(*) FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.external_yellow_tripdata`  limit 10;

SELECT count(*) FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`;


-- Check yellow trip data
SELECT * FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.external_yellow_tripdata`  limit 10;




-- QUESTION-2
-- Scanning 0 of data
SELECT DISTINCT(PULocationID)
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.external_yellow_tripdata`;

-- Scanning ~155.12 MB of DATA
SELECT DISTINCT(PULocationID)
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`;

-- QUESTION-3

--155.12 MB
SELECT PULocationID
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`;

--310.24 MB
SELECT PULocationID,DOLocationID
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`;

-- QUESTION-4
SELECT count(*) FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned` where fare_amount=0 ;


select tpep_dropoff_datetime,count(*)
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`
group by tpep_dropoff_datetime;

-- QUESTION-5
-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`;

-- QUESTION-6
--310.25 MB
SELECT distinct(VendorID)
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_non_partitioned`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';

--26.84MB
SELECT distinct(VendorID)
FROM `project-83b7a5b9-3948-4d0a-ab3.rides_dataset.yellow_tripdata_partitioned_clustered`
WHERE DATE(tpep_dropoff_datetime) BETWEEN '2024-03-01' AND '2024-03-15';




