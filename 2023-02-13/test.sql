'Write the SQL statements that allow you to answer the following questions.'
'Total number of rows;'
SELECT COUNT(*) as TOTAL
FROM teste.sensor

'Check for duplicates in the table;'
SELECT name, `YEAR` as ANO, `MONTH` as MES, `DAY` as DIA, `TIME` as HORA, COUNT(*) as TOTAL
FROM teste.sensor
GROUP BY name, `YEAR`, `MONTH`, `DAY`, `TIME`
HAVING COUNT(*) > 1

'Number of distinct sensors present on the database;'
SELECT COUNT(DISTINCT name) as TOTAL
FROM teste.sensor

'Number of rows for the sensor PPL340;'
SELECT COUNT(*) as TOTAL
FROM teste.sensor
WHERE name = 'PPL340'

'The number of rows by year for the sensor PPL340;'
SELECT `YEAR` as ANO, COUNT(*) as TOTAL
FROM teste.sensor
WHERE name = 'PPL340'
GROUP BY `YEAR`

'Average number of readings by year for the sensor PPL340;'
SELECT `YEAR` as ANO, AVG(TOTAL) as MEDIA
FROM (
    SELECT `YEAR`, COUNT(*) as TOTAL
    FROM teste.sensor
    WHERE name = 'PPL340'
    GROUP BY `YEAR`
) as X
GROUP BY `YEAR`

'For PPL340, Identify the years in which the number of readings is less than the average'
WITH cte_table AS (
    SELECT `YEAR`, COUNT(*) as total
    FROM teste.sensor
    WHERE name = 'PPL340'
    GROUP BY `YEAR`
)
SELECT `YEAR`, total
FROM cte_table
WHERE total < (SELECT AVG(total) FROM cte_table)
group by `YEAR`


'The column “Diff value” must be calculated by the difference between the value (Sensor reading value) ordered by date.'
SELECT
  t1.timestamp as TIMESTAMP,
  t1.value as VALUE,
  t1.value - t2.value AS DIFF_VALUE
FROM
  teste.ex02_diff t1
  LEFT JOIN teste.ex02_diff t2
    ON t2.timestamp = t1.timestamp -1



    
'É possível melhorar, adicionando um join adicional com a coluna "month"'   
'Ficaria assim:'   
Select
	 t1.ID
	,t1.name
	,t1.TIME as Timestamp
	,t1.value
	,t2.quarter
from teste.sensor t1
left join teste.`date` t2
on t1.day = t2.day and t1.month = t2.month
where t2.year >= 2022   
    

'Dá para adicionar um índice no campo nome, bem como adicionar o mês, como na consulta anterior'
select
	 t1.ID
	,t1.name
	,t1.TIME as Timestamp
	,t1.value
	,t2.quarter
from teste.sensor t1
left join teste.`date` t2
on t1.day = t2.day and t1.month = t2.month
and t1.name = "PPL340"


'utilizando a cláusula INNER JOIN. 
Para selecionar apenas os dados que correspondem entre elas'
SELECT 
	t1.ID, t1.name
FROM 
	teste.sensor t1
INNER JOIN teste.`date` t2 
	ON  t1.month = t2.month 
	AND t1.day   = t2.day
WHERE t2.year = 2022




