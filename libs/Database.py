import psycopg2

import os
from dotenv import load_dotenv

load_dotenv()


#Para usar a conexão com string pelo psycopg2 precisamos usar dbname ao inves de database

db_conn = f"""
    host='{os.getenv('DB_HOST')}'
    dbname='{os.getenv('DB_NAME')}'
    user='{os.getenv('DB_USER')}'
    password='{os.getenv('DB_PASS')}'
    """

def execute(query):
    conn = psycopg2.connect(db_conn)

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()

    
def insert_membership(data):

    account = data["account"]
    plan = data["plan"]
    credit_card = data["credit_card"]["card_number"][-4]

    query  = f"""
    BEGIN;
    DELETE FROM accounts 
    WHERE email ='{account["email"]}';
    WITH new_account AS (
        INSERT INTO accounts (name, email, cpf)
        VALUES ('{data["account"]["name"]}', '{account["email"]}', '{account["cpf"]}')
        RETURNING id
    )
    INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
    SELECT id, {plan["id"]},'{credit_card}', {plan["price"]}, true
    FROM new_account;
    COMMIT; 
    """
    execute(query)

def insert_account(account):
    query = f"""
    INSERT INTO accounts (name,email,cpf) 
    VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}');
    """
    execute(query)


def delete_account_by_email(email):
    query = f"DELETE FROM accounts WHERE email = '{email}';"
    execute(query)

