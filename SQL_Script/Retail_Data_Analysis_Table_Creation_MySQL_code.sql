CREATE DATABASE RETAILS;
USE RETAILS;

/* TABLE CREATION */

CREATE TABLE DEMOGRAPHIC_RAW (
    AGE_DESC VARCHAR(10),
    MARITAL_STATUS_CODE VARCHAR(5),
    INCOME_DESC VARCHAR(20),
    HOMEOWNER_DESC VARCHAR(25),
    HH_COMP_DESC VARCHAR(40),
    HOUSEHOLD_SIZE_DESC VARCHAR(15),
    KID_CATEGORY_DESC VARCHAR(15),
    household_key INT PRIMARY KEY
);

CREATE TABLE CAMPAIGN_DESC_RAW (
    DESCRIPTION VARCHAR(15),
    CAMPAIGN INT,
    START_DAY INT,
    END_DAY INT,
    PRIMARY KEY (DESCRIPTION, CAMPAIGN)
);
CREATE INDEX IN01 ON CAMPAIGN_DESC_RAW(DESCRIPTION);
CREATE INDEX IN02 ON CAMPAIGN_DESC_RAW(CAMPAIGN);
/*
-- Here, in the above code, we can take a composite primary key without any restriction because MySQL strictly enforces the primary key
on the columns.
-- In addition, we need to create indexes on both columns. By doing this, we can avoid errors while making foreign key connections 
with other tables.
-- A composite primary key actually has two columns, but in the other table, only one column is common among them. 
If we make this connection with a foreign key, it will throw an error.
-- Hence, in order to avoid it, we can create an index on the composite primary key columns. */

CREATE TABLE CAMPAIGN_RAW (
    DESCRIPTION VARCHAR(15),
    household_key INT,
    CAMPAIGN INT,
    FOREIGN KEY (DESCRIPTION, CAMPAIGN) REFERENCES CAMPAIGN_DESC_RAW(DESCRIPTION, CAMPAIGN),
    FOREIGN KEY (household_key) REFERENCES DEMOGRAPHIC_RAW(household_key)
);

CREATE TABLE PRODUCT_RAW (
    PRODUCT_ID INT PRIMARY KEY,
    MANUFACTURER INT,
    DEPARTMENT VARCHAR(50),
    BRAND VARCHAR(15),
    COMMODITY_DESC VARCHAR(100),
    SUB_COMMODITY_DESC VARCHAR(100),
    CURR_SIZE_OF_PRODUCT VARCHAR(20)
);

CREATE TABLE COUPON_RAW (
    COUPON_UPC INT,
    PRODUCT_ID INT,
    CAMPAIGN INT,
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT_RAW(PRODUCT_ID),
    FOREIGN KEY (CAMPAIGN) REFERENCES CAMPAIGN_DESC_RAW(CAMPAIGN)
);

CREATE TABLE COUPON_REDEMPT_RAW (
    household_key INT,
    DAY INT,
    COUPON_UPC INT,
    CAMPAIGN INT,
    FOREIGN KEY (household_key) REFERENCES DEMOGRAPHIC_RAW(household_key),
    FOREIGN KEY (CAMPAIGN) REFERENCES CAMPAIGN_DESC_RAW(CAMPAIGN)
);

CREATE TABLE TRANSACTION_RAW (
    HOUSEHOLD_KEY INT,
    BASKET_ID INT,
    DAY INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    SALES_VALUE FLOAT,
    STORE_ID INT,
    RETAIL_DISC FLOAT,
    TRANS_TIME INT,
    WEEK_NO INT,
    COUPON_DISC INT,
    COUPON_MATCH_DISC INT,
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT_RAW(PRODUCT_ID),
    FOREIGN KEY (HOUSEHOLD_KEY) REFERENCES DEMOGRAPHIC_RAW(household_key)
);


