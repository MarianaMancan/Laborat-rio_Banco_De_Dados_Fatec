
--3. Quais são os nomes dos professores que ministram todas disciplinas (note que uma parte da resposta especifica o procedimento
--da divisão)?
--Preparando a divisão Projeção: P  professores[[pkprofessorfkprofessor]]
--Projeção: D  disciplinas[[pkdisciplinafkdisciplina]]
--Projeção: PD atribuições[[fkprofessor, fkdisciplina]]
--Procedimento da Divisão: A  P X D - Esta tab. Fica UC com PD (atribuições)
--B  A – PD – A é maior que Atribuições
--C  B[[fkprofessor]] - Aqui temos os prof. Que não se ligam a pelo menos uma disciplina
--E  P – C - Aqui tenho os códigos de professores que ministram TODAS as disc.
--Conclusão da Pergunta Junção..: F  E[[E.fkprofessor=Professores.pkprofessor]]Professores
--Projeção: F[[pkprofessor, txnomeprofessor]]

--Preparando a divisão Projeção: P  professores[[pkprofessorfkprofessor]]
CREATE TEMPORARY TABLE P AS (SELECT cpprofessor as ceprofessor from professores)
--Projeção: D  disciplinas[[pkdisciplinafkdisciplina]]
CREATE TEMPORARY TABLE D AS (SELECT cpdisciplina as cedisciplina from disciplinas)
--Projeção: PD atribuições[[fkprofessor, fkdisciplina]]
CREATE TEMPORARY TABLE PD AS (SELECT ceprofessor,cedisciplina from atribuicoes)
--Procedimento da Divisão: A  P X D - Esta tab. Fica UC com PD (atribuições)
CREATE TEMPORARY TABLE A AS  (SELECT * FROM P CROSS JOIN D)
--B  A – PD – A é maior que Atribuições
CREATE TEMPORARY TABLE B AS  (SELECT * FROM A EXCEPT (SELECT * FROM PD))
--C  B[[fkprofessor]] - Aqui temos os prof. Que não se ligam a pelo menos uma disciplina
CREATE TEMPORARY TABLE C AS (SELECT ceprofessor from B)
--E  P – C - Aqui tenho os códigos de professores que ministram TODAS as disc.
CREATE TEMPORARY TABLE E AS (SELECT * FROM P EXCEPT (SELECT * FROM C))
--Conclusão da Pergunta Junção..: F  E[[E.fkprofessor=Professores.pkprofessor]]Professores
CREATE TEMPORARY TABLE F AS (SELECT * FROM E INNER JOIN PROFESSORES ON E.ceprofessor = professores.cpprofessor)
--Projeção: F[[pkprofessor, txnomeprofessor]]
select ceprofessor,txnomeprofessor from F 
DROP TABLE P,D,PD,A,B,C,E,F
