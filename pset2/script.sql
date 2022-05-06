/* QUESTÃO 01: prepare um relatorio que mostre a madia salarial dos funcionarios de cada departamento. *

SELECT 
	numero_departamento 	      	                                            AS departamento,
	AVG(salario)		                                                    AS media_salarial
FROM funcionario
GROUP BY numero_departamento;

/* QUESTÃO 02: prepare um relatorio que mostre a media salarial dos homens e das mulheres. */

SELECT 
	sexo 		                                                            AS genero,
	AVG(salario) 	              	                                            AS media_salarial
FROM funcionario
GROUP BY sexo;

/* QUESTÃO 03: prepare um relatorio que liste o nome dos departamentos e, para
cada departamento, inclua as seguintes informacoes de seus funcionarios: o nome
completo, a data de nascimento, a idade em anos completos e o salario. */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                           AS funcionario,
	d.nome_departamento                                                             AS departamento,
	f.numero_departamento,
	te.horas
FROM funcionario f
INNER JOIN trabalha_em te ON ( te.cpf_funcionario = f.cpf)
INNER JOIN departamento d ON ( d.numero_departamento = f.numero_departamento);

/* QUESTÃO 04: prepare um relatorio que mostre o nome completo dos funcionarios, 
a idade em anos completos, o salário atual e o salario com um reajuste que
obedece ao seguinte criterio: se o salario atual do funcionario e inferior a 35.000 o
reajuste deve ser de 20%, e se o salario atual do funcionario for igual ou superior a
35.000 o reajuste deve ser de 15%. */

?????????????

/* QUESTÃO 05: prepare um relatorio que liste, para cada departamento, o nome
do gerente e o nome dos funcionarios. Ordene esse relatorio por nome do departamento 
(em ordem crescente) e por salario dos funcionários (em ordem decrescente). */

??????????????

/* QUESTÃO 06: prepare um relatorio que mostre o nome completo dos funcionarios que tem dependentes, 
o departamento onde eles trabalham e, para cada funcionario, tambem liste o nome completo dos dependentes, 
a idade em anos de cada dependente e o sexo (o sexo NAO DEVE aparecer como M ou F, deve aparecer
como “Masculino” ou “Feminino”). */

SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)             		AS nome_completo_funcionario,
	numero_departamento                                                    		AS departamento,
	CONCAT(nome_dependente, ' ', ultimo_nome)                              		AS nome_completo_dependente,
	DATE_PART('year', CURRENT_DATE) - DATE_PART('year', d.data_nascimento) 		AS idade_dependente,
CASE 
	WHEN d.sexo = 'M' THEN 'Masculino'	
	WHEN d.sexo = 'F' THEN 'Feminino'
END                                                                      		AS sexo_dependente
FROM funcionario      f
INNER JOIN dependente d ON (f.cpf = d.cpf_funcionario);
