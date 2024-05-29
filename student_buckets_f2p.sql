USE customer_engagement;

with table_period_to_consider as
(
SELECT 
    i.student_id,
    i.date_registered,
    0 as paid,
    '2022-10-31' AS last_date_to_watch
FROM
    student_info i
        LEFT JOIN
    student_purchases p USING (student_id)
WHERE
    p.student_id IS NULL

UNION

SELECT 
    i.student_id,
    i.date_registered,
    1 as paid,
    MIN(date_purchased) AS last_date_to_watch
FROM
    student_info i
        JOIN
    student_purchases p USING (student_id)
GROUP BY p.student_id
),
table_minutes_summed_1 as
(
SELECT 
    p.*,
    0 AS total_minutes_watched
FROM
    table_period_to_consider p
        LEFT JOIN
    student_learning l using(student_id)
WHERE
    l.student_id is null
    
UNION

SELECT 
    p.*,
    ROUND(SUM(l.minutes_watched), 2) AS total_minutes_watched
FROM
    table_period_to_consider p
        JOIN
    student_learning l using(student_id)
WHERE
    l.date_watched BETWEEN p.date_registered AND p.last_date_to_watch
GROUP BY l.student_id
),
table_minutes_summed_2 as
(
SELECT 
    *
FROM
    table_minutes_summed_1

UNION

SELECT 
    p.*, 0 AS total_minutes_watched
FROM
    table_period_to_consider p
        JOIN
    student_learning l USING (student_id)
WHERE
    l.date_watched NOT BETWEEN p.date_registered AND p.last_date_to_watch
        AND l.student_id NOT IN (SELECT 
            student_id
        FROM
            table_minutes_summed_1)
GROUP BY l.student_id
),
table_distribute_to_buckets as
(
SELECT 
    *,
    CASE
        WHEN
            total_minutes_watched = 0
                OR total_minutes_watched IS NULL
        THEN
            '[0]'
        WHEN
            total_minutes_watched > 0
                AND total_minutes_watched <= 5
        THEN
            '(0, 5]'
        WHEN
            total_minutes_watched > 5
                AND total_minutes_watched <= 10
        THEN
            '(5, 10]'
        WHEN
            total_minutes_watched > 10
                AND total_minutes_watched <= 15
        THEN
            '(10, 15]'
        WHEN
            total_minutes_watched > 15
                AND total_minutes_watched <= 20
        THEN
            '(15, 20]'
        WHEN
            total_minutes_watched > 20
                AND total_minutes_watched <= 25
        THEN
            '(20, 25]'
        WHEN
            total_minutes_watched > 25
                AND total_minutes_watched <= 30
        THEN
            '(25, 30]'
        WHEN
            total_minutes_watched > 30
                AND total_minutes_watched <= 40
        THEN
            '(30, 40]'
        WHEN
            total_minutes_watched > 40
                AND total_minutes_watched <= 50
        THEN
            '(40, 50]'
        WHEN
            total_minutes_watched > 50
                AND total_minutes_watched <= 60
        THEN
            '(50, 60]'
        WHEN
            total_minutes_watched > 60
                AND total_minutes_watched <= 70
        THEN
            '(60, 70]'
        WHEN
            total_minutes_watched > 70
                AND total_minutes_watched <= 80
        THEN
            '(70, 80]'
        WHEN
            total_minutes_watched > 80
                AND total_minutes_watched <= 90
        THEN
            '(80, 90]'
        WHEN
            total_minutes_watched > 90
                AND total_minutes_watched <= 100
        THEN
            '(90, 100]'
        WHEN
            total_minutes_watched > 100
                AND total_minutes_watched <= 110
        THEN
            '(100, 110]'
        WHEN
            total_minutes_watched > 110
                AND total_minutes_watched <= 120
        THEN
            '(110, 120]'
        WHEN
            total_minutes_watched > 120
                AND total_minutes_watched <= 240
        THEN
            '(120, 240]'
        WHEN
            total_minutes_watched > 240
                AND total_minutes_watched <= 480
        THEN
            '(240, 480]'
        WHEN
            total_minutes_watched > 480
                AND total_minutes_watched <= 1000
        THEN
            '(480, 1000]'
        WHEN
            total_minutes_watched > 1000
                AND total_minutes_watched <= 2000
        THEN
            '(1000, 2000]'
        WHEN
            total_minutes_watched > 2000
                AND total_minutes_watched <= 3000
        THEN
            '(2000, 3000]'
        WHEN
            total_minutes_watched > 3000
                AND total_minutes_watched <= 4000
        THEN
            '(3000, 4000]'
        WHEN
            total_minutes_watched > 4000
                AND total_minutes_watched <= 6000
        THEN
            '(4000, 6000]'
        ELSE '6000+'
    END AS buckets
FROM
    table_minutes_summed_2
)
select  
student_id,
date_registered,
paid as f2p,
total_minutes_watched,
buckets
from table_distribute_to_buckets;



select * from purchases_info where student_id = 275430;
select * from student_purchases where student_id = 263338;
select * from student_info where student_id = 258832;









