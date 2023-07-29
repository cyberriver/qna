-- Создание пользователя
CREATE USER myuser;
ALTER USER myuser WITH ENCRYPTED PASSWORD 'mypassword';
ALTER USER myuser WITH SUPERUSER;

-- Добавьте задержку в 5 секунд
SELECT pg_sleep(5);

