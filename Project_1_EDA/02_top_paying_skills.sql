/*
Question: What are the highest-paying skills for data engineers?
- calculate median salary for each skill required in data engineering positions
- Focus on reomst postiions with specified salaries
- Include skill freq to identify both salary and demand
- Why
    - Helps identify which skill commands the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities
    - The median is used instead of average to reduce impact of outlier salaries
*/

SELECT 
    sd.skills,
    ROUND(median(jpf.salary_year_avg),0) as median_salary,
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home = True
GROUP BY sd.skills
HAVING COUNT(jpf.*)  > 100
ORDER BY median_salary DESC
LIMIT 25;


/*
Here is a break down of the highest-paying skills for Data Engineers:

Key Insights:
- Rush remains the top-paying skills at $210k median salary, though demand is still relatively limited (232 postings)
- Terraform and Goland have both a median salary of $180k, with strong demand (Terraform: 3,248 postings; Goland: 912 postings)
- Other notable skills with both high pay and moderate-to-high frequency include:
    - Spring: $175.5k median salary (364 postings)
    - Neo4j: $170k median salary (277 postings)
    - gdpr: $169.6k median salary (582 postings)
    - GraphQL: $167.5k median salary (445 postings)
    - Kubernetes: $150.5k median salary (4202 postings)
    - Airflow: $150 median salary (9996 postings)
- Most skills on the list are no longer extreme statistical outlieres writh just a handful of postings

Takeaway: While the very top-paying skill (Rust) still has less demand than major cloud and data tools,


┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ terraform  │      184000.0 │         3248 │
│ golang     │      184000.0 │          912 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ django     │      155000.0 │          265 │
│ bitbucket  │      155000.0 │          478 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ ruby       │      150000.0 │          736 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
---------------------------------------------
*/