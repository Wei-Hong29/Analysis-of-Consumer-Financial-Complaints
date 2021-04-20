# Analysis-of-Consumer-Financial-Complaints

- Done as an assignment in one of my degree's data science unit.
- Data analysed can be found here(due to Github limiting file sizes to 25MB): https://drive.google.com/file/d/1k8_RCNhjhG-UahDTMYSNmKy193AEo3cl/view?usp=sharing



### The data analysis is done in the following steps:
- **Step 0: Draw 40,000 samples from our data file(bankcomplaints.csv, which is from our google drive link above)**

- **Step a: Pre-processing**
  - Data Quality Check
  - Data Transformation and Extraction
  
- **Step b - Complaint Parameter Analysis**
  - Extract unique issues
  - Plot histogram for:
    -  most common issues with all companies
    -  issues separated by sub-products
  - Findings are noted in report, backed by statistical tests done in R code

- **Part c - Activity and Complaint Over Time Analysis**
  - Plot time series graph for all issues, 
  - Plot time series graph for each issue separatedly
  - Find top 5 companies with most complaints, and plot them using heat map




"\
"
"\
"
"\
"




### About the data that is analysed:

The Consumer Complaint Database is a collection of complaints about consumer financial products 
and services that are sent to companies for response. Complaints are published after the company 
responds, confirming a commercial relationship with the consumer, or after 15 days, whichever 
comes first. Complaints referred to other regulators, such as complaints about depository 
institutions with less than $10 billion in assets, are not published in the Consumer Complaint 
Database. The data is contained in the file bankcomplaints.csv and consists of the metadata of 
84,811 complaints over the years 2012 to 2017. 

See https://data.world/dataquest/bank-and-credit-card-complaints/workspace/project-summary?agentid=dataquest&datasetid=bank-and-credit-card-complaints for more information.

