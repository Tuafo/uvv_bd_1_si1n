-- Criação do esquema elmasri dentro do banco de dados uvv.

CREATE SCHEMA elmasri
    AUTHORIZATION thiago;  -- Dando autorização ao meu usuario para o esquema elmasri

-- Criação da tabela funcionario

CREATE TABLE elmasri.funcionario (
    cpf CHAR(11) NOT NULL,
    primeiro_nome VARCHAR(15) NOT NULL,
    nome_meio CHAR(1),
    ultimo_nome VARCHAR(15) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR(50),
    sexo CHAR(1),
    salario NUMERIC(10,2),
    cpf_supervisor CHAR(11),
    numero_departamento INTEGER NOT NULL,
    CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);

COMMENT ON TABLE elmasri.funcionario IS 'Tabela com informacoes dos funcionarios.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionario, PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereco do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salario do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor, FK para a própria tabela.';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Numero do departamento do funcionario.';

-- Adicionando constraints na tabela funcionario.

ALTER TABLE elmasri.funcionario ADD CONSTRAINT sex CHECK (sexo='M' OR sexo='F'); -- aceita apenas  valores M ou F para o sexo
ALTER TABLE elmasri.funcionario ADD CONSTRAINT salario_positivo CHECK (salario > -1); -- funcionario não pode ganhar um saldo negativo
ALTER TABLE elmasri.funcionario ADD CONSTRAINT num_dep CHECK (numero_departamento > 0); -- numero de departamento não pode receber um valor <=0
ALTER TABLE elmasri.funcionario ADD CONSTRAINT data CHECK (data_nascimento BETWEEN '1933-01-01' AND '2004-01-01'); -- funcionario so pode ter idade entre 89 e 18 anos

-- Criação da tabela departamento.

CREATE TABLE elmasri.departamento (
    numero_departamento INTEGER NOT NULL,
    nome_departamento VARCHAR(15) NOT NULL,
    cpf_gerente CHAR(11) NOT NULL,
    data_inicio_gerente DATE,
    CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);

COMMENT ON TABLE elmasri.departamento IS 'Tabela com informacoes do departamento.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Numero do departamento, PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento, nome unico.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento, FK tabela funcionario.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do inicio do gerente no departamento.';

-- Adicionando constraints na tabela departamento.

ALTER TABLE departamento ADD CONSTRAINT num_dep2 CHECK (numero_departamento > 0);  -- numero do departamento não vai aceitar um valor <=0
ALTER TABLE departamento ADD CONSTRAINT data_gerente CHECK (data_inicio_gerente BETWEEN '1981-06-18' AND '2023-01-01');  -- data do inicio do gerente so vai aceitar a data a parti da ultima data do ultimo gerente

CREATE UNIQUE INDEX idx_nome_departamento -- Criação da Alternate Key para a tabela departamento, mostrando que o nome de cada departamento deve ser unico
  ON elmasri.departamento
    (nome_departamento);

-- Criação da tabela localizacoes_departamento.

CREATE TABLE elmasri.localizacoes_departamento (
    numero_departamento INTEGER NOT NULL,
    local VARCHAR(15) NOT NULL,
    CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);

COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Armazena as possiveis localizacoes dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Numero do departamento. PK desta tabela, e FK da tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localizacao do departamento. Faz parte da PK desta tabela.';

-- Criação da tabela projeto.

CREATE TABLE elmasri.projeto (
    numero_projeto INTEGER NOT NULL,
    nome_projeto VARCHAR(15) NOT NULL,
    local_projeto VARCHAR(15),
    numero_departamento INTEGER NOT NULL,
    CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);

COMMENT ON TABLE elmasri.projeto IS 'Armazena as informacoes sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Numero do projeto, PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto, nome unico.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localizacao do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Numero do departamento. FK da tabela departamento.';

-- Adicionando constraints na tabela projeto. 

ALTER TABLE elmasri.projeto ADD CONSTRAINT num_proj CHECK (numero_projeto > 0); -- impede que o numero do projeto seja um valor <=0

CREATE UNIQUE INDEX idx_nome_projeto -- Criação da Alternate Key da tabela projeto, mostrando que o nome do projeto deve ser unico
    ON elmasri.projeto
      (nome_projeto);

-- Criação da tabela trabalha_em.

CREATE TABLE elmasri.trabalha_em (
    cpf_funcionario CHAR(11) NOT NULL,
    numero_projeto INTEGER NOT NULL,
    horas NUMERIC(3,1),
    CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);

COMMENT ON TABLE elmasri.trabalha_em IS 'Armazena em quais projetos cada funcionario trabalha.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionario. PK dessa tabela, e FK da tabela funcionario.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. PK dessa tabela, e  FK da tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionario neste projeto.';

-- Adicionando constraints.

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT hora_projeto CHECK (horas > -1); -- Impede que seja adicionado um valor negativo no campo hora.

-- Criação da tabela dependente.

CREATE TABLE elmasri.dependente (
    cpf_funcionario CHAR(11) NOT NULL,
    nome_dependente VARCHAR(15) NOT NULL,
    sexo CHAR(1),
    data_nascimento DATE,
    parentesco VARCHAR(15),
    CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);

COMMENT ON TABLE elmasri.dependente IS 'Armazena as informacoes dos dependentes dos funcionarios.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionario. PK dessa tabela, e FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. PK dessa tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descreve o parentesco do dependente com o funcionario.';

-- Adicionando constraints.

ALTER TABLE elmasri.dependente ADD CONSTRAINT sex_dep CHECK (sexo='M' OR sexo='F'); -- Permite que o campo sexo receba os valores M ou F apenas.
ALTER TABLE elmasri.dependente ADD CONSTRAINT data_dep CHECK (data_nascimento BETWEEN '1928-01-01' AND '2004-01-01'); -- Restringe o valor da data de nascimento entre 1928 ate 2004.

-- Criando Foreign Keys em todas as tabelas.

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Inserindo as informções na tabela funcionario

INSERT INTO funcionario VALUES
  ('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto. 35. Sao Paulo. SP', 'M', 55000, null, 1);

INSERT INTO funcionario VALUES
  ('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av Arthur de Lima. 54. Santo Andre. SP', 'F', 43000, '88866555576', 4);
INSERT INTO funcionario VALUES
  ('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa. 34. Sao Paulo. SP', 'M', 40000, '88866555576', 5);
INSERT INTO funcionario VALUES
  ('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima. 35. Curitiba. PR', 'F', 25000, '98765432168', 4);
INSERT INTO funcionario VALUES
  ('98798798733', 'Andre', 'V', 'Pereira', '1969-03-29', 'Rua Timbira 35. Sao Paulo. SP', 'M', 25000, '98765432168', 4);
INSERT INTO funcionario VALUES
  ('12345678966', 'Joao', 'B', 'Silva', '1965-01-09', 'Rua das Flores. 751. Sao Paulo. SP', 'M', 30000, '33344555587', 5);
INSERT INTO funcionario VALUES
  ('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Reboucas. 65. Piracicaba. SP', 'M', 38000, '33344555587', 5);
INSERT INTO funcionario VALUES
  ('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av Lucas Obes. 74. Sao Paulo. SP', 'F', 25000, '33344555587', 5);

-- Inserindo as informções na tabela departamento

INSERT INTO departamento VALUES
  (5, 'Pesquisa', '33344555587', '1988-05-22');
INSERT INTO departamento VALUES
  (4, 'Administracao', '98765432168', '1995-01-01');
INSERT INTO departamento VALUES
  (1, 'Matriz', '88866555576', '1981-06-19');

-- Inserindo as informações na tabela localizacoes_departamento

INSERT INTO localizacoes_departamento VALUES
  (1, 'Sao Paulo');
INSERT INTO localizacoes_departamento VALUES
  (4, 'Maua');
INSERT INTO localizacoes_departamento VALUES
  (5, 'Santo Andre');
INSERT INTO localizacoes_departamento VALUES
  (5, 'Itu');
INSERT INTO localizacoes_departamento VALUES
  (5, 'Sao Paulo');

-- Inserindo as informações na tabela projeto

INSERT INTO projeto VALUES
  (1, 'ProdutoX', 'Santo Andre', 5);
INSERT INTO projeto VALUES
  (2, 'ProdutoY', 'Itu', 5);
INSERT INTO projeto VALUES
  (3, 'ProdutoZ', 'Sao Paulo', 5);
INSERT INTO projeto VALUES
  (10, 'Informatizacao', 'Maua', 4);
INSERT INTO projeto VALUES
  (20, 'Reorganizacao', 'Sao Paulo', 1);
INSERT INTO projeto VALUES
  (30, 'Novosbeneficios', 'Maua', 4);

-- Inserindo informações na tabela dependente

INSERT INTO dependente VALUES
  ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO dependente VALUES
  ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');
INSERT INTO dependente VALUES
  ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa');
INSERT INTO dependente VALUES
  ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO dependente VALUES
  ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO dependente VALUES
  ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO dependente VALUES
  ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- Inserindo informacoes na tabela trabalha_em

INSERT INTO trabalha_em VALUES
  ('12345678966', 1, 32.5);
INSERT INTO trabalha_em VALUES
  ('12345678966', 2, 7.5);
INSERT INTO trabalha_em VALUES
  ('66688444476', 3, 40.0);
INSERT INTO trabalha_em VALUES
  ('45345345376', 1, 20.0);
INSERT INTO trabalha_em VALUES
  ('45345345376', 2, 20.0);
INSERT INTO trabalha_em VALUES
  ('33344555587', 2, 10.0);
INSERT INTO trabalha_em VALUES
  ('33344555587', 3, 10.0);
INSERT INTO trabalha_em VALUES
  ('33344555587', 10, 10.0);
INSERT INTO trabalha_em VALUES
  ('33344555587', 20, 10.0);
INSERT INTO trabalha_em VALUES
  ('99988777767', 30, 30.0);
INSERT INTO trabalha_em VALUES
  ('99988777767', 10, 10.0);
INSERT INTO trabalha_em VALUES
  ('98798798733', 10, 35.0);
INSERT INTO trabalha_em VALUES
  ('98798798733', 30, 5.0);
INSERT INTO trabalha_em VALUES
  ('98765432168', 30, 20.0);
INSERT INTO trabalha_em VALUES
  ('98765432168', 20, 15.0);
INSERT INTO trabalha_em VALUES
  ('88866555576', 20, 00.0);
