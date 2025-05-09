

-- **Планирование нагрузки**


-- select id_teacher
--         , count(id_class) as class_count
-- from skyeng_db.classes
-- where class_status in ('success', 'failed_by_student')
--     and class_type != 'trial'
--     and date_part('year', class_start_datetime) = '2016'
-- group by id_teacher
-- order by class_count desc
-- limit 1

WITH monthly_classes AS (
    SELECT id_teacher, 
           date_trunc('month', class_start_datetime) AS class_month, 
           COUNT(id_class) AS class_count
    FROM skyeng_db.classes
    WHERE class_status IN ('success', 'failed_by_student')
        AND class_type != 'trial'
        AND date_part('year', class_start_datetime) = 2016
    GROUP BY id_teacher, class_month
)
SELECT class_count, COUNT(DISTINCT id_teacher) AS teacher_count
FROM monthly_classes
GROUP BY class_count
ORDER BY class_count
