BEGIN;

-- Remove o registro pelo email
DELETE FROM accounts 
WHERE email ='justin@bieber.com';

-- Insere uma nova conta e obtém o ID da conta recém-inserida
WITH new_account AS (
    INSERT INTO accounts (name, email, cpf)
    VALUES ('Justin Bieber', 'justin@bieber.com', '03796320040')
    RETURNING id
)

--Insere um registro na tabela memberships com o ID da conta
INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
SELECT id, 1,'4242', 99.99, true
FROM new_account;

COMMIT; -- confirma a transação 