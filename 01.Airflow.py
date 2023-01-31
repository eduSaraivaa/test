from airflow import DAG
from datetime import datetime
from airflow.providers.mysql.operators.mysql import MySqlOperator

with DAG('dag_executa_sql', start_date = datetime(2023-30-1),
	schedule_interval "0 0 * * *", catchup=False) as dag:

	criar_tabela_banco = MySqlOperator(
		task_id = 'criar_tabela_banco',
		mysql_conn_id = 'mysql-airflow',
		sql = 	"""
			CREATE TABLE if NOT exists transactions
			(
			  product_id	timestamp
			 ,product_name	varchar(30)
			 ,product_price Double
			 ,cliente_id 	long
			)
			"""
	)

	insere_dados_tabela = MySqlOperator(
		task_id = 'insere_dados_tabela',
		mysql_conn_id = 'mysql-airflow',
		sql = 	"""
			INSERT INTO transactions (product_id, product_name, product_price, cliente_id) 
				SELECT product_id, product_name, product_price, cliente_id FROM database_table_source
				WHERE product_id = cast(current_date()-1 as date)
			"""
	)


criar_tabela_banco >> insere_dados_tabela


