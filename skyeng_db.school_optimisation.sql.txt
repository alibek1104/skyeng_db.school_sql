with teachers_cost as (
    select id_teacher, 
           case when language_group = 'rus' then 900 else 1500 end as class_cost
    from skyeng_db.teachers
),
class_data as (
    select user_id, class_start_datetime, class_end_datetime, id_teacher, 
           id_class, class_status, class_type
    from skyeng_db.classes
    where class_status in ('success', 'failed_by_teacher')
      and class_type != 'trial'
      and class_start_datetime >= '2016-01-01'::timestamp
      and class_start_datetime < '2017-01-01'::timestamp
)
select 
    date_trunc('month', class_start_datetime) as class_month,
    sum(class_cost) as total_classes_cost, 
    count(id_class) as classes_count,
    sum(class_cost)::float / count(id_class) as avg_cost
from class_data
join teachers_cost using(id_teacher)
group by 1
order by 1;
