/*
Question: What are the most optimial skills for data engineers - balancing both demand and salary?
    - Create a ranknig column that combines demand count and median salary to identify the most valuable skills
    - Focusing only on remote Data Engineer positions with specified annual salaries
    - Why ?
        - this approach highlights skills that balance market demand and financial reward. It weights core skilsl appriopriately, rather than letting rate, outlier skills distort the results
*/

SELECT 
    sd.skills,
    ROUND(median(jpf.salary_year_avg),0) as median_salary,
    COUNT(jpf.*) as demand_count,
    ROUND(LN(COUNT(jpf.*)),1) as LN_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1000000 ,2) as optimal_score
FROM 
    job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY sd.skills
HAVING COUNT(jpf.*)  > 100 
ORDER BY optimal_score DESC
LIMIT 25;


/*
Here's a breakdwon of the most optimal skills for DE, based on high demandand high salaries.

Scoring criteria: used median_salary * natuarl log of demand count = optimal score
    - Why natural log?
        - demand count will be heavily skewed w.o using LN

Top Skills by Optimal Score:
    - Terraform leads teh list with $184k median salary and 193 postings, resulting in a highest overall optimal score of 0.97
    - Python and SQL dominate demand (over 1100 postings each), with strong median salaries fo $135K and 130K
    - AWS (783, postings $137k median), spark (503 postings, $140k median), airflow (386 postings, 150k median)
    - Kafka offers high compenstation ($145k) and solid demand (292 postings)
    - Tools suck as snowflake, azure, databricks each have 250-475 postings and median salaries between $128k-$137k

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ LN_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.97 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ aws        │      137320.0 │          783 │             6.7 │          0.91 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.89 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.82 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.0 │          247 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ git        │      140000.0 │          208 │             5.3 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.71 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ docker     │      135000.0 │          144 │             5.0 │          0.67 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows                                                           5 columns
*/