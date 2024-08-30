# Customer Engagement Analysis
[Dashboard](https://public.tableau.com/app/profile/kuanyu.lai/viz/CustomerInsightAnalysis/Overview)
## Project Overview
An in-depth analysis using SQL and Tableau on self-made subscription platform data surfaces answering key busineess questions like:

- How engaged are the subscriber inside the platform, and how can this metric be improvd?
- How long do subscriber stay engged on the platform, and how canthis period be exstended?
- what is the difference  in behavior between free and paid subscriber?
- Which are the most popular courses on the platform?

## Data Source

The main data used in this analysis is the "customer_behavior.xlsx" containing detailed information about customer behavior.

## Tools
- Excel
- Mysql
- Tableau

## Analysis exmaple

```sql
SELECT 
    certificate_id, student_id, certificate_type, date_issued, MAX(paid) AS paid
FROM
    (SELECT 
        c.certificate_id,
            c.student_id,
            c.certificate_type,
            c.date_issued,
            p.date_start,
            p.date_end,
            CASE
                WHEN date_start IS NULL AND date_end IS NULL THEN 0
                WHEN date_issued BETWEEN date_start AND date_end THEN 1
                WHEN date_issued NOT BETWEEN date_start AND date_end THEN 0
            END AS paid
    FROM
        student_certificates c
    LEFT JOIN purchases_info p USING (student_id)) a
GROUP BY certificate_id;
```
This query aims to list all certificates with their associated payment status (paid) based on whether the issuance date of the certificate falls within any purchase period. It consolidates multiple possible purchase periods into a single determination of whether the certificate was paid for.

## Tableau Dashboard
![Engagement Date](https://github.com/user-attachments/assets/fe64d805-66b7-45ea-b1ad-f53ff4d6c510)

## Insights

- From Engagemtn dashboard, we can that there is a peak in August because of the free period. And there is a stready trend going up throughout the year. 

## Limitations
We only consider customer from January 1st to October 31th. In general customer engagement befoer January would still effect the analysis.
