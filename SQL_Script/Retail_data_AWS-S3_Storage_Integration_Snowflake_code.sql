
/* AWS S3 STORAGE INTEGRATION */

-- Create all the necessary roles and policies in AWS before performing storage integration.

-- Now, create the S3 Storage Integration in Snowflake and map the S3 user (Role) to it.

CREATE OR REPLACE STORAGE INTEGRATION S3_RETAILDATA_RAW_INT
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::211125340148:role/retailrole'  -- Enter Role ARN
STORAGE_ALLOWED_LOCATIONS = ('s3://retaildata.raw/');  -- Enter S3 bucket name with path

DESC INTEGRATION S3_RETAILDATA_RAW_INT;

-- Now, update the Trust Relationship Policy in the AWS IAM role's Trust Relationship section with the 'STORAGE_AWS_IAM_USER_ARN' obtained from the DESC INTEGRATION command in the previous step.

-- Create a file format in Snowflake, which will be required during the 'Stage' creation process.
-- You can directly run the file format command in the worksheet to create a file format, or alternatively, you can create it by opening the RETAILS database details in a new tab.

-- Now, create an external (S3) stage that references the storage integration created previously.

CREATE OR REPLACE STAGE RETAIL_STAGE
URL ='s3://retaildata.raw'    -- S3 bucket name
FILE_FORMAT = RETAIL_CSV     -- File Format name we created previously
STORAGE_INTEGRATION = S3_RETAILDATA_RAW_INT;

-- Upon successful creation of the stage, list the stage. 
-- When we list a stage, we view its directory to see all uploaded files in S3 bucket, verifying successful creation and contents.

LIST @RETAIL_STAGE;

SHOW STAGES;

-- Now, create an auto-ingest pipe, i.e., Snowpipe, which recognizes CSV files ingested from the external stage and copies the data into the existing table in Snowflake.
-- Ensure that the number of Snowpipes created matches the number of folders (tables) in the S3 bucket. This guarantees that each pipe is attached to its respective folder in the bucket.
-- The AUTO_INGEST = TRUE parameter specifies to read event notifications sent from an S3 bucket to an SQS queue when new data is ready to load.

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_CAMPAIGN_DESC 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.CAMPAIGN_DESC_RAW -- Respective table path in Snowflake
FROM '@RETAIL_STAGE/CAMPAIGN_DESC/' -- Stage name & S3 bucket subfolder name
FILE_FORMAT = RETAIL_CSV; -- File Format name

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_CAMPAIGN 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.CAMPAIGN_RAW 
FROM '@RETAIL_STAGE/CAMPAIGN/' 
FILE_FORMAT = RETAIL_CSV; 

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_COUPON_REDEMPT 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.COUPON_REDEMPT_RAW 
FROM '@RETAIL_STAGE/COUPON_REDEMPT/' 
FILE_FORMAT = RETAIL_CSV; 

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_COUPON 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.COUPON_RAW 
FROM '@RETAIL_STAGE/COUPON/' 
FILE_FORMAT = RETAIL_CSV; 

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_DEMOGRAPHIC 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.DEMOGRAPHIC_RAW 
FROM '@RETAIL_STAGE/DEMOGRAPHIC/' 
FILE_FORMAT = RETAIL_CSV; 

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_PRODUCT 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.PRODUCT_RAW 
FROM '@RETAIL_STAGE/PRODUCT/' 
FILE_FORMAT = RETAIL_CSV;

CREATE OR REPLACE PIPE RETAIL_SNOWPIPE_TRANSACTION 
AUTO_INGEST = TRUE AS
COPY INTO RETAILS.PUBLIC.TRANSACTION_RAW 
FROM '@RETAIL_STAGE/TRANSACTION/' 
FILE_FORMAT = RETAIL_CSV;

SHOW PIPES;

-- After creating Snowpipe, obtain the ‘Notification Channel’ value by running the command ‘SHOW PIPES’. 
-- Now, create an Event Notification in S3 bucket using 'Notification Channel arn' which is available in the above Snowpipes, to read event notifications sent from an S3 bucket to an SQS queue when new data is ready to load.

-- By using the code below, we can check if any new data is updated in our S3 bucket. It is not mandatory to refresh the pipe every time; it is only for the user's purpose to ensure that all the pipe connections are successful and data is flowing from the S3 bucket to the Snowflake table.

ALTER PIPE RETAIL_SNOWPIPE_CAMPAIGN_DESC REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_CAMPAIGN REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_COUPON_REDEMPT REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_COUPON REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_DEMOGRAPHIC REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_PRODUCT REFRESH;
ALTER PIPE RETAIL_SNOWPIPE_TRANSACTION REFRESH;

-- We can see that all the data from the S3 bucket has been successfully copied into the respective Snowflake tables.

SELECT * FROM CAMPAIGN_DESC_RAW;
SELECT * FROM CAMPAIGN_RAW;
SELECT * FROM COUPON_RAW;
SELECT * FROM COUPON_REDEMPT_RAW;
SELECT * FROM DEMOGRAPHIC_RAW;
SELECT * FROM PRODUCT_RAW;
SELECT * FROM TRANSACTION_RAW;
SELECT COUNT(*) FROM TRANSACTION_RAW; -- 450416  (count of rows before updating new records)
-- 1162359 after loading new data
