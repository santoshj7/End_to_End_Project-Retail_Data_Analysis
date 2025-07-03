
# End-to-End Project - Retail Data Analysis

This comprehensive retail data analysis project covers end-to-end processes, including **data cleaning**, **cloud platform integration and automation**, **data transformation**, **data analysis**, and **data visualization** using a variety of analytical tools. The dataset has over **2 million** records spread across 7 different tables, providing a robust foundation for insightful analysis and decision-making.


## Introduction:

This dataset captures household-level transaction data spanning two years, sourced from a panel of 2,500 frequent shoppers at a major retailer. It provides a comprehensive view of all purchases made by each household—not limited to specific categories—offering a holistic perspective on shopping behavior.

In addition to purchase data, the dataset includes, Demographic information for each household and Direct marketing contact history, enabling analysis of promotional effectiveness and engagement.

This rich combination of transactional, demographic, and marketing interaction data makes it ideal for customer segmentation, behavioral analytics, and targeted campaign strategy development.

The dataset consists of the following tables:

- **hh_demographic**: This table likely contains demographic information about households, provides a comprehensive view of the demographic characteristics of each household.

- **campaign_desc**: This table likely contains descriptions or details of marketing campaigns.
- **campaign_table**: This table provides information about the different marketing campaign Types that have been conducted.
- **coupon**: This table likely contains information about coupons or discounts offered to customers, provides information about the available coupons on different Product.
- **coupon_redempt**: This table likely contains data about coupon redemptions and helps to track and analyze the usage and effectiveness of coupons.
- **product**: This table likely contains information about different products, provides details about the available products.
- **transaction_data**: This table likely contains data related to customer transactions. It helps to track and analyze customer purchases, including the products bought, quantities, prices, and transaction details.

## Datasets:

The dataset has over 2 million records spread across 7 different tables. 
- [Raw data](https://github.com/santoshj7/End_to_End_Project-Retail_Data_Analysis/tree/main/Raw_Datasets) and [Cleaned data](https://github.com/santoshj7/End_to_End_Project-Retail_Data_Analysis/tree/main/Cleaned_Datasets)

## Analytical Tools:
For this project, I used the following tools and technologies: 

- **AWS S3**: Used as the cloud storage layer for ingesting and storing raw data files securely.
- **Snowflake**: Loads data from AWS S3 into a raw data warehouse for scalable access. Then Stores cleaned and transformed data from Python for downstream analysis. 
- **Python**: Performs data cleaning, transformation, and EDA, connected directly to Snowflake.
- **Power BI**: Connects to the cleaned Snowflake layer to build dynamic dashboards and forecasts.
- **MySQL Workbench**: Used to design and visualize the ER diagram for understanding data relationships.
## End-to-End Data Flow and Automation Process:

- **Data Modeling**: Designed a comprehensive [Entity Relationship (ER) model](https://github.com/santoshj7/End_to_End_Project-Retail_Data_Analysis/tree/main/Entity_Relationship_(ER)_Diagram) using **MySQL Workbench**, effectively mapping relationships across all key tables for robust data understanding.
- **Data Ingestion**: Integrated **AWS S3** with **Snowflake** using IAM roles, policies, and external stages. Employed **Snowpipes** for real-time, automated ingestion of raw data into Snowflake’s staging tables.
- **Data Processing (ETL)**: Used **Python** (via notebooks) for **data cleaning**, **transformation**, and **exploratory data analysis (EDA)**. Raw data was fetched from Snowflake, [processed in Python](https://github.com/santoshj7/End_to_End_Project-Retail_Data_Analysis/tree/main/Data_Cleaning_%26_Transformation_using_Python), and then **loaded back into Snowflake** as cleaned datasets.
- **Data Modeling in Snowflake**: Created custom analytical tables using **SQL scripts**, tailored to support advanced reporting needs.
- **Visualization**: Connected Snowflake’s cleaned data layer to **Power BI** to develop **interactive dashboards and forecasts**, covering sales, customer behavior, campaign performance, and more.

**Automation & Scheduling**:

- Snowpipe ingests new files from AWS S3 in real-time, triggering the data pipeline.
- Notebook jobs can be scheduled to run Python scripts for cleaning and EDA post-ingestion. Jobs monitor for new files in Snowflake and trigger transformation pipelines automatically.
- Snowflake Stored Procedures were created to load clean and transformed data into custom tables automatically.
- Tasks in Snowflake were used to schedule these procedures in a specific order, so each step runs only after the previous one finishes.
- Different time intervals were set for each task to avoid overlapping and make sure all processes run smoothly.
- Power BI is connected to those final tables, and a Scheduled Refresh is set to update the reports automatically after Snowflake finishes its tasks.
- A small buffer time was added between Snowflake and Power BI refresh to make sure fresh data is available.

**End Result**:
- Whenever new data lands in AWS S3, Snowpipe triggers ingestion → Python transformation → Snowflake procedures transform data → custom tables update → Power BI reflects fresh insights automatically.
- This completely automated pipeline ensures that stakeholders always have access to the most up-to-date analytics without manual intervention.
## Demo:

The final report includes key analytical sections such as: Demographic Profile, Product Performance, Campaign Engagement, Coupon Performance, Transaction Overview, and Forecast Insights. Each section is equipped with dynamic filters that allow users to explore and compare insights across different dimensions. The report provides in-depth analysis supported by actionable recommendations.
- [Click here](https://project.novypro.com/aej1TT) to access an **Interactive Power BI Report** showcasing project's results and visualizations.
## Screenshots

![Report Page 1-4](https://github.com/santoshj7/End_to_End_Project-Retail_Data_Analysis/blob/main/Final_Report/Images/1-4.png)

## Feedback

If you have any feedback, please reach out to me at jsantosh7296@gmail.com

