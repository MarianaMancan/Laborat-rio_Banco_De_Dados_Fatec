--6. Quais são os nomes de funcionários que passaram por consultas de todas as especialidades médicas nos últimos 180 dias
--a  consultas [[ dthoraconsulta >= hoje-180 ]]
--b  a [[ a.fkmedico = medicos.pkmedico ]] medicos
--PD b [[ fkfuncionario, fkespecialidade ]]
--P  funcionarios [[ pkfuncionariofkfuncionario ]]
--D  especmedicas [[ pkespecialidadefkespecialidade ]]
--S  P X D
--T  S - PD
--W  T [[ fkfuncionario ]]
--R  P – W
--V  R[[R.fkfuncionario=f.pkfuncionario ]] funcionáriosf
--V[[txprenomes,txsobrenome]]

--a  consultas [[ dthoraconsulta >= hoje-180 ]]
CREATE TEMPORARY TABLE a as (select * from consultas where dthoraconsulta >= (CURRENT_DATE - 180))
--b  a [[ a.fkmedico = medicos.pkmedico ]] medicos
CREATE TEMPORARY TABLE b AS (select * from a inner join medicos on a.cemedico = medicos.cpmedico)
--PD b [[ fkfuncionario, fkespecialidade ]]
CREATE TEMPORARY TABLE PD AS (select cefuncionario,ceespecialidade from b)
--P  funcionarios [[ pkfuncionariofkfuncionario ]]
CREATE TEMPORARY TABLE P AS (select cpfuncionario as cefuncionario from funcionarios)
--D  especmedicas [[ pkespecialidadefkespecialidade ]]
CREATE TEMPORARY TABLE D AS (select cpespecmedica as ceespecialidade from especialidadesmedicas)
--S  P X D
CREATE TEMPORARY TABLE S AS (select * from P cross join D)
--T  S - PD
CREATE TEMPORARY TABLE T AS (select * from S EXCEPT (SELECT * FROM PD))
--W  T [[ fkfuncionario ]]
CREATE TEMPORARY TABLE W AS (select cefuncionario from T)
--R  P – W
CREATE TEMPORARY TABLE R AS (select * from P EXCEPT (SELECT * FROM W))
--V  R[[R.fkfuncionario=f.pkfuncionario ]] funcionáriosf
CREATE TEMPORARY TABLE V AS (select * from R inner join funcionarios as f on R.cefuncionario = f.cpfuncionario)
--V[[txprenomes,txsobrenome]]
select txprenomes,txsobrenome from V
DROP TABLE a,b,PD,P,D,S,T,W,R,V
