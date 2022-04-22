DROP DATABASE IF EXISTS uvv; -- Comando para apagar qualquer banco de dados, caso exista, com o mesmo nome que será criado a seguir.
DROP USER IF EXISTS thiago;   -- Comando para apagar qualquer usuário, caso exista, com o mesmo nome que será criado a seguir.

CREATE USER thiago WITH  -- Criando o user
  LOGIN -- Dando dirteito ao login
  CREATEROLE -- Dando direito a criar roles
  REPLICATION -- Dando direito a transferir dados entre bancos de dados
  NOSUPERUSER -- Não é um superusuário
  CREATEDB -- Dando direito a criar bancos de dados
  ENCRYPTED PASSWORD '123';

-- Criando o banco de dados uvv

CREATE DATABASE uvv 
WITH OWNER = thiago
TEMPLATE = template0 
ENCODING = 'UTF8' 
LC_COLLATE = 'pt_BR.UTF-8' 
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

-- Colocando o path do meu usuario para o esquema elmasri.

ALTER USER thiago
SET SEARCH_PATH TO elmasri, "$user", public;

-- SENHA: 123
\c uvv thiago;
