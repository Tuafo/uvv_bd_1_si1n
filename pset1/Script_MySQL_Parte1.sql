-- Primeiro script apenas para a criação do usuário
-- Criação do Usuário

create user thiago identified by '123';

grant all privileges on *.* TO thiago;

-- Inserir senha 123

system mysql -u thiago -p
