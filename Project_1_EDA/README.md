# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Alt Text](/Images/1_1_Project1_EDA.png)

A SQL project analyzing the data engineering job market using real world posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## Executive Summary 

- **Project scope:** Built **3 analytical queries** that answer key questions about the data eangineer job market.
- **Data modeling:** Used **multi-table joibs** across fact and dimension tables to extract insights.
- **Analytics:** Applied **aggregations, filters, and sorting** to find top skills by demand, salary, and overall value.
- **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns.

If you want to review source code:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) - demand analysis with multi-table jobs
2. [`02_top_paying_skills.sql`](.02_top_paying_skills.sql) - salary analysis with aggregations
3. [`03_most_optimal_skills.sql`](./03_most_optimal_skills.sql) - combined demand/salary optimization query


## Problem and Content

![Data Warehouse](/Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_facts` - Central table containing job posting details (job titles, locations, salaries, dates, etc)
- **Dimension Tables**:
    - `company_dim` - Comapny information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table**: `skills_job_dim` - Resolves the many-toomany relationships between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary, pattern, and optimal skill combinations for data engineering roles. 


## Teck Stack

- **Query Engine:** DuckDB for fast OLAP-style analytical queries
- **Language:** SQL (ANSI-style with analytical functions)
- **Data Model:** Star Schema with fact + dimension + bridge tables
- **Development:** VS Code for SQL editing + Terminal for DuckDB CLI 
- **Version Control:** Git/GitHub for versioned SQL scripts

## Analysis Overview

### Query Structure

1. [`Top Demanded Skills`](./01_top_demanded_skills.sql) - Identify the top 10 most in-demand skills for remote data engineering positions
2. [`Top Paying Skills`](.02_top_paying_skills.sql) - Analyze the 25 highest-paying skills with salary and demand metrics
3. [`Most Optima Skill`](./03_most_optimal_skills.sql) - Calculate an optimal score using natural log of demand combined with median salary to identify the myost valuable skills to learn

### Key Insights

- Core languages: SQL and Python each appear in ~29,000 job posting, making them the most demanded skills
- Cloud platforms: AWS and AZURE are critical for modern data engineering roles
- Infrastructure & tooling: Kubernetes, Docker, and TYerraform are associated with premium salaries
- Big data tools: Apache Spark shows strong demand with competitive compensation

## SQL Skills Demonstrated

### Query Design and Optimization

- **Complex Joins**: Multi-table `INNER-JOIN` operations across `job_posting_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting and Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY `for categorical analysis by skill
- **Conditional Logic**: `CASE WHEN` statements for derived metrics 
- **Mathmatical Functions**: `LN()` for natural logarithm transformation to normalize trend metrics
- **Calculate Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggreagted results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)