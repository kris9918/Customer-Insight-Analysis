USE customer_engagement;

WITH table_overall_minutes as
(
SELECT 
    i.*,
    ROUND(SUM(l.minutes_watched), 2) AS minutes_watched,
    COUNT(DISTINCT l.student_id) AS students_watched
FROM
    course_info i
        JOIN
    student_learning l USING (course_id)
GROUP BY course_id
),
table_minutes_per_student_and_completion_rate as
(
SELECT 
    course_id,
    course_title,
    minutes_watched,
    ROUND(minutes_watched / students_watched, 2) AS minutes_per_student,
    ROUND((minutes_watched / students_watched) / course_duration,
            2) AS completion_rate
FROM
    table_overall_minutes
)
SELECT 
    *
FROM
    table_minutes_per_student_and_completion_rate;
    
    
SELECT 
    course_id,
    course_title,
    minutes_watched,
    ROUND(minutes_watched / students_watched, 2) AS minutes_per_student,
    ROUND((minutes_watched / students_watched) / course_duration,
            2) AS completion_rate
FROM
    (SELECT 
    i.*,
    ROUND(SUM(l.minutes_watched), 2) AS minutes_watched,
    COUNT(DISTINCT l.student_id) AS students_watched
FROM
    course_info i
        JOIN
    student_learning l USING (course_id)
GROUP BY course_id) a;



select * from student_learning;
