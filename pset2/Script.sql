/* QUESTAO 01: prepare um relatorio que mostre a madia salarial dos funcionarios de cada departamento. */

SELECT 
	numero_departamento 	      	                                            	AS departamento,
	AVG(salario)		                                                    	AS media_salarial
FROM funcionario
GROUP BY numero_departamento;

/* QUESTAO 02: prepare um relatorio que mostre a media salarial dos homens e das mulheres. */

SELECT 
	sexo 		                                                       		AS genero,
	AVG(salario) 	              	                                            	AS media_salarial
FROM funcionario
GROUP BY sexo;

/* QUESTAO 03: prepare um relatorio que liste o nome dos departamentos e, para
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

/* QUESTAO 04: prepare um relatorio que mostre o nome completo dos funcionarios, 
a idade em anos completos, o salario atual e o salario com um reajuste que
obedece ao seguinte criterio: se o salario atual do funcionario e inferior a 35.000 o
reajuste deve ser de 20%, e se o salario atual do funcionario for igual ou superior a
35.000 o reajuste deve ser de 15%. */

SELECT 
 	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS nome,
 	DATE_PART('year', NOW()) - DATE_PART('year', data_nascimento)			AS idade, 
	salario 									AS salario_atual, 
CASE 
	WHEN salario < 35000 THEN salario + salario * 0.2
	WHEN salario >= 35000 THEN salario + salario * 0.15 
END 											AS salario_reajustado
FROM funcionario;

/* QUESTAO 05: prepare um relatorio que liste, para cada departamento, o nome
do gerente e o nome dos funcionarios. Ordene esse relatorio por nome do departamento 
(em ordem crescente) e por salario dos funcionarios (em ordem decrescente). */

??????????????

/* QUESTAO 06: prepare um relatorio que mostre o nome completo dos funcionarios que tem dependentes, 
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

/* QUESTAO 07: prepare um relatorio que mostre, para cada funcionario que NAO
TEM dependente, seu nome completo, departamento e salario. */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS funcionario,
	f.numero_departamento 								AS departamento,
	salario
FROM funcionario f
LEFT OUTER JOIN dependente d ON (f.cpf = d.cpf_funcionario)
WHERE d.cpf_funcionario IS NULL;

/* QUESTAO 08: prepare um relatorio que mostre, para cada departamento, 
os projetos desse departamentoe o nome completo dos funcionarios que estao alocados
em cada projeto. Alem disso inclua o numero de horas trabalhadas por cada funcionario, em cada projeto. */

SELECT DISTINCT
	f.numero_departamento 								AS departamento, 
	p.nome_projeto,
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS funcionario,
	SUM(horas)									AS horas_trabalhadas
FROM funcionario f
INNER JOIN trabalha_em te ON (f.cpf = te.cpf_funcionario)
INNER JOIN projeto p ON ( f.numero_departamento = p.numero_departamento)
GROUP BY f.numero_departamento, p.nome_projeto, funcionario
ORDER BY p.funcionario, funcionario;

/* QUESTAO 09: prepare um relatorio que mostre a soma total das horas de cada
projeto em cada departamento. Obs.: o relatorio deve exibir o nome do departamento, 
o nome do projeto e a soma total das horas. */

SELECT
	p.nome_projeto 									AS nome_projeto,
	d.nome_departamento 								AS nome_departamento,
	SUM(horas) 									AS horas_trabalhadas
FROM projeto p
INNER JOIN departamento d ON ( d.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em te ON ( te.numero_projeto = p.numero_projeto)
GROUP BY p.nome_projeto, d.nome_departamento
ORDER BY p.nome_projeto, d.nome_departamento;

/* QUESTAO 10 IGUAL A QUESTAO 1 */
/* QUESTAO 10: prepare um relatorio que mostre a media salarial dos funcionarios
de cada departamento. */

SELECT 
	numero_departamento 								AS departamento,
	AVG(salario)									AS media_salarial
FROM funcionario
GROUP BY numero_departamento;


