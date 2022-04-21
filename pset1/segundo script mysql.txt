-- Criando o Banco de Dados
create database uvv;
use uvv;

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(30) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(30) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(100),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. PK da tabela.';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(30) COMMENT '1º nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(30) COMMENT 'sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'data de nascimento do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(100) COMMENT 'endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'salário do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor. FK para a própria tabela.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'número do departamento do funcionário.';


CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'número do departamento. É a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'nome do departamento. Deve ser único.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do depart. FK para a tabela funcionários.';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(30) NOT NULL,
                local_projeto VARCHAR(20),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'número do projeto. É a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(30) COMMENT 'nome do projeto. Deve ser único.';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(20) COMMENT 'localização do projeto.';
ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'número do departamento. FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(20) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Nº do depart. PK desta tabela e FK tabela departamento.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(20) COMMENT 'localização do departamento. Faz parte da PK desta tabela.';


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(30) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(30),
                PRIMARY KEY (cpf_funcionario, nome_dependente));

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do func. PK desta tabela é uma FK tabela funcionário.';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(30) COMMENT 'nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(30) COMMENT 'descrição do parentesco do dependente com o funcionário.';


CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto));

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do func. PK desta tabela FK  tabela funcionário.';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'nº do projeto. PK desta tabela. FK tabela projeto.';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'horas trabalhadas pelo funcionário neste projeto.';

-- Criar FK funcionario_trabalha_em_fk

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK funcionario_dependente_fk

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK funcionario_funcionario_fk

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK funcionario_departamento_fk

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK departamento_localizacoes_departamento_fk

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK departamento_projeto_fk

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criar FK projeto_trabalha_em_fk

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Alterando o NO / NOT NULL, o Architect gerou alguns problemas

alter table departamento modify nome_departamento varchar(15) NOT NULL;
alter table departamento modify cpf_gerente char(11) NOT NULL;

alter table projeto modify nome_projeto varchar(30) NOT NULL;
alter table projeto modify numero_departamento int NOT NULL;

alter table funcionario modify primeiro_nome varchar(30) NOT NULL;
alter table funcionario modify ultimo_nome varchar(30) NOT NULL;
alter table funcionario modify numero_departamento int NOT NULL;

-- Adicionando constraint de gênero

alter table funcionario add check (sexo in ('M','F'));

-- Adicionando constraint de gênero

alter table dependente add check (sexo in ('M','F'));

-- Adicionando constraint da idade

alter table funcionario add check (data_nascimento between '1930-01-01' and '1995-12-31');

-- Adicionando constraint da idade

alter table dependente add check (data_nascimento between '1930-01-01' and '2022-01-01');

-- Adicionando os valores na tabela 'funcionario'

insert into funcionario values (
'88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', '55000.00', NULL, 1);

insert into funcionario values (
'33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', '40000.00', '88866555576', 5);

insert into funcionario values (
'98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av.Arthur de Lima, 54, Santo André, Sp', 'F', '43000.00', '88866555576', 4);

insert into funcionario values (
'12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', '30000.00', '33344555587', 5);

insert into funcionario
 values (
'66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38000.00', '33344555587', 5);

insert into funcionario values (
'45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', '25000.00', '33344555587', 5);

insert into funcionario values (
'99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', '25000.00', '98765432168', 4);

insert into funcionario values (
'98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', '25000.00', '98765432168', 4);

-- Adicionando os valores na tabela 'departamento'

insert into departamento values(
5, 'Pesquisa', '33344555587', '1988-05-22');

insert into departamento values(
4, 'Administração', '98765432168', '1995-01-01');

insert into departamento values(
1, 'Matriz', '88866555576', '1981-06-19');

-- Adicionando os valores na tabela 'localizacoes_departamento'

insert into localizacoes_departamento values (
1, 'São Paulo');

insert into localizacoes_departamento values (
4, 'Mauá');

insert into localizacoes_departamento values (
5, 'Santo André');

insert into localizacoes_departamento values (
5, 'Itu');

insert into localizacoes_departamento values (
5, 'São Paulo');

-- Adicionando os valores na tabela 'projeto'

insert into projeto values (
1, 'ProdutoX', 'Santo André', 5);

insert into projeto values (
2, 'ProdutoY', 'Itu', 5);

insert into projeto values (
3, 'ProdutoZ', 'São Paulo', 5);

insert into projeto values (
10, 'Informatização', 'Mauá', 4);

insert into projeto values (
20, 'Reorganização', 'São Paulo', 1);

insert into projeto values (
30, 'Novosbenefícios', 'Mauá', 4);

-- Adicionando os valores na tabela 'dependente'

insert into dependente values (
'33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');

insert into dependente values (
'33344555587', 'Tiago', 'M', '1983-10-25', 'filho');

insert into dependente values (
'33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa');

insert into dependente values (
'98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');

insert into dependente values (
'12345678966', 'Michael', 'M', '1988-01-04', 'Filho');

insert into dependente values (
'12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');

insert into dependente values (
'12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- Adicionando os valores na tabela trabalha_em

insert into trabalha_em values (
     '12345678966', 1, '32.5');

insert into trabalha_em values (
     '12345678966', 2, '7.5');

insert into trabalha_em values (
     '66688444476', 3, '40.0');

insert into trabalha_em values (
     '45345345376', 1, '20.0');

insert into trabalha_em values (
     '45345345376', 2, '20.0');

insert into trabalha_em values (
     '33344555587', 2, '10.0');

insert into trabalha_em values (
     '33344555587', 3, '10.0');

insert into trabalha_em values (
     '33344555587', 10, '10.0');

insert into trabalha_em values (
     '33344555587', 20, '10.0');

insert into trabalha_em values (
     '99988777767', 30, '30.0');

insert into trabalha_em values (
     '99988777767', 10, '10.0');

insert into trabalha_em values (
     '98798798733', 10, '35.0');

insert into trabalha_em values (
     '98798798733', 30, '5.0');

insert into trabalha_em values (
     '98765432168', 30, '20.0');

insert into trabalha_em values (
     '98765432168', 20, '15.0');

insert into trabalha_em values (
     '88866555576', 20, null);


desc departamento;
desc dependente;
desc funcionario;
desc localizacoes_departamento;
desc projeto;
desc trabalha_em;
