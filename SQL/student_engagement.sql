USE customer_engagement;

SELECT 
    student_id, date_engaged, MAX(paid) AS paid
FROM
    (SELECT 
        e.student_id,
            e.date_engaged,
            p.date_start,
            p.date_end,
            CASE
                WHEN date_start IS NULL AND date_end IS NULL THEN 0
                WHEN date_engaged BETWEEN date_start AND date_end THEN 1
                WHEN date_engaged NOT BETWEEN date_start AND date_end THEN 0
            END AS paid
    FROM
        student_engagement e
    LEFT JOIN purchases_info p USING (student_id)) a
GROUP BY student_id , date_engaged;


SELECT 
        e.student_id,
            e.date_engaged,
            p.date_start,
            p.date_end,
            CASE
                WHEN date_start IS NULL AND date_end IS NULL THEN 0
                WHEN date_engaged BETWEEN date_start AND date_end THEN 1
                WHEN date_engaged NOT BETWEEN date_start AND date_end THEN 0
            END AS paid
    FROM
        student_engagement e
    LEFT JOIN purchases_info p USING (student_id)
where student_id = 262643;

select * from student_purchases where student_id = 262643;

select * from purchases_info;