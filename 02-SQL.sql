
spark.sql("
--Total number of rows;
select count(*) as total_de_linhas from sensors;
").show()

spark.sql("
--Number of distinct sensors present on the database;
select count(distinct(`name`)) as total_distinct from sensors;
").show()

spark.sql("
--Number of rows for the sensor PPL340;
select count(`name`) as total_distinct from sensors where `name` = 'PPL340';
").show()

spark.sql("
--The number of rows by year for the sensor PPL340;
select year as ano, count(name) as total from sensors where `name` = 'PPL340' group by year;
").show()

spark.sql("
--Average number of readings by year for the sensor PPL340;
select year as ano, avg(value) as avg_readings from sensors where `name` = 'PPL340'group by year;
").show()

spark.sql("
--For PPL340, Identify the years in which the number of readings is less than the average;
select year as ano, avg(value) as avg_reading FROM sensors
WHERE value < (select avg(value) from sensors where `name` = 'PPL340')
and `name` = 'PPL340'
group by year;
").show()