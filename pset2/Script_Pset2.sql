/* QUESTAO 01:  */

SELECT 
	numero_departamento 	      	                                            	AS departamento,
	AVG(salario)		                                                    	AS media_salarial
FROM funcionario
GROUP BY numero_departamento;

/* QUESTAO 02: */

SELECT 
	sexo 		                                                       		AS genero,
	AVG(salario) 	              	                                            	AS media_salarial
FROM funcionario
GROUP BY sexo;

/* QUESTAO 03:  */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                           AS funcionario,
	d.nome_departamento                                                             AS departamento,
	f.numero_departamento,
	t.horas
FROM funcionario f
INNER JOIN trabalha_em t ON ( t.cpf_funcionario = f.cpf)
INNER JOIN departamento d ON ( d.numero_departamento = f.numero_departamento);

/* QUESTAO 04:  */

SELECT 
 	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS nome,
 	DATE_PART('year', NOW()) - DATE_PART('year', data_nascimento)			AS idade, 
	salario 									AS salario_atual, 
CASE 
	WHEN salario < 35000 THEN salario + salario * 0.2
	WHEN salario >= 35000 THEN salario + salario * 0.15 
END 											AS salario_reajustado
FROM funcionario;

/* QUESTAO 05:  */



/* QUESTAO 06:  */

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

/* QUESTAO 07: */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS funcionario,
	f.numero_departamento 								AS departamento,
	salario
FROM funcionario f
LEFT OUTER JOIN dependente d ON (f.cpf = d.cpf_funcionario)
WHERE d.cpf_funcionario IS NULL;

/* QUESTAO 08:  */

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

/* QUESTAO 09:  */

SELECT
	p.nome_projeto 									AS nome_projeto,
	d.nome_departamento 								AS nome_departamento,
	SUM(horas) 									AS horas_trabalhadas
FROM projeto p
INNER JOIN departamento d ON ( d.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON ( t.numero_projeto = p.numero_projeto)
GROUP BY p.nome_projeto, d.nome_departamento
ORDER BY p.nome_projeto, d.nome_departamento;

/* QUESTAO 10 IGUAL A QUESTAO 1 */
/* QUESTAO 10:  */

SELECT 
	numero_departamento 								AS departamento,
	AVG(salario)									AS media_salarial
FROM funcionario
GROUP BY numero_departamento;

/* QUESTÃO 11:  */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS funcionario,
	nome_projeto,
	SUM(horas) * 50 								AS valor
FROM funcionario f
INNER JOIN projeto p ON ( p.numero_departamento = f.numero_departamento)
INNER JOIN trabalha_em t ON (t.numero_projeto = p.numero_projeto)
GROUP BY funcionario, nome_projeto
ORDER BY funcionario ASC;

/* QUESTAO 12:  */

SELECT DISTINCT
	nome_departamento,
	nome_projeto,
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS funcionario
FROM funcionario f
INNER JOIN departamento d ON ( d.numero_departamento = f.numero_departamento)
INNER JOIN projeto p ON ( p.numero_departamento = d.numero_departamento)
INNER JOIN trabalha_em t ON ( t.cpf_funcionario = f.cpf)
WHERE te.horas IS NULL;

/* QUESTAO 13:  */

SELECT
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS nome_completo,
	DATE_PART ('year', NOW()) - DATE_PART ('year', data_nascimento) 		AS idade,
	sexo 										AS genero								
FROM funcionario 	
UNION
SELECT
	CONCAT(nome_dependente,' ', ultimo_nome),
	DATE_PART ('year', NOW()) - DATE_PART ('year', d.data_nascimento),
	d.sexo 					
FROM dependente d
INNER JOIN funcionario f ON ( d.cpf_funcionario = f.cpf)
ORDER BY idade DESC;

/* QUESTAO 14:  */

SELECT
	f.numero_departamento 								AS numero,
	d.nome_departamento 								AS departamento,
	COUNT(cpf) 									AS numero_funcionarios
FROM funcionario f
INNER JOIN departamento d ON (d.numero_departamento = f.numero_departamento)
GROUP BY departamento, f.numero_departamento;

/* QUESTAO 15:  */

SELECT 
	CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) 				AS nome_completo,
	nome_departamento,
	nome_projeto
FROM funcionario f
INNER JOIN departamento d ON (d.numero_departamento = f.numero_departamento)
INNER JOIN projeto p ON (p.numero_departamento = d.numero_departamento);
