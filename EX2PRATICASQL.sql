--2. Quais os nomes dos professores e os nomes das respectivas disciplinas atribuídas aos professores que ministram disciplinas da
--Área de Estudo "EXATAS"?
--SEL : a  areadeestudo[[txnomearea="EXATAS"]]
--JUN : b  a[[a. pkareaestudo = k.fkareaestudo]] areaestudodisciplinas K
--JUN : c  b[[b.fkdisciplina= disciplinas.pkdisciplina]]disciplinas
--PRO : c1  c[[pkdisciplina, txnometxnomedisciplina]]
--JUN : d  c1[[C.pkdisciplina = atribuicoes.fkdisciplina]]atribuicoes
--PRO : d1  d[[fkprofessor, txnomedisciplina]]
--JUN : e  d1[[D.fkprofessor=professores.fkprofessor]]professores
--PRO : r  e[[professores.txnomeprofessor,disciplinas.txnome]]

--SEL : a  areadeestudo[[txnomearea="EXATAS"]]
CREATE TEMPORARY TABLE A AS(SELECT * FROM AREASDEESTUDO WHERE txnomeareadeestudo = 'Exatas')
--JUN : b  a[[a. pkareaestudo = k.fkareaestudo]] areaestudodisciplinas K
CREATE TEMPORARY TABLE B AS(SELECT * FROM A INNER JOIN areasdeestudodisciplinas as K on A.cpareadeestudo = K.ceareadeestudo)
--JUN : c  b[[b.fkdisciplina= disciplinas.pkdisciplina]]disciplinas
CREATE TEMPORARY TABLE C AS (SELECT * FROM  B INNER JOIN DISCIPLINAS ON B.cedisciplina = disciplinas.cpdisciplina)
--PRO : c1  c[[pkdisciplina, txnometxnomedisciplina]]
CREATE TEMPORARY TABLE C1 AS(select cpdisciplina,txnome as txnomedisciplina from C)
--JUN : d  c1[[C.pkdisciplina = atribuicoes.fkdisciplina]]atribuicoes
CREATE TEMPORARY TABLE D AS (select * from C1 inner join atribuicoes on C1.cpdisciplina = atribuicoes.cedisciplina)
--PRO : d1  d[[fkprofessor, txnomedisciplina]]
CREATE TEMPORARY TABLE D1 AS (SELECT ceprofessor,txnomedisciplina from D)
--JUN : e  d1[[D.fkprofessor=professores.fkprofessor]]professores
CREATE TEMPORARY TABLE E AS(SELECT * FROM D1 INNER JOIN PROFESSORES ON D1.ceprofessor=professores.cpprofessor )
--PRO : r  e[[professores.txnomeprofessor,disciplinas.txnome]]
CREATE TEMPORARY TABLE R AS (SELECT txnomeprofessor,txnomedisciplina from E)
SELECT * FROM R
DROP TABLE A,B,C,C1,D,C1,E,R
