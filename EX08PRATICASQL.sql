2. Quais foram os nomes das tarefas que foram executadas em projetos que são dos departamentos onde o departamento superior é o
departamento "A01"?

--seleção: A<- departamentos[[cpdepto >= 'A11']]
create temporary table A as (select * from departamentos where cpdepto > 'A11')
--junção: B<- A[[A.cpdepto=projetos.cedepto]]projetos
create temporary table B as (select * from A inner join projetos on A.cpdepto=projetos.cedepto)
--junção: C<-B[[B.cpprojetos=tp.ceprojeto]]tarefasproetos ->tp
create temporary table C as (select * from B inner join tarefasprojetos as tp on B.cpprojeto=tp.ceprojeto)
--junção:D<-C[[C.cetarefa = tarefas.cptarefa]]tarefas
create temporary table D as (select * from C inner join tarefas on C.cetarefa = tarefas.cptarefa)
--projeção:D[[txnometarefa]] (DISTINCT)
select distinct txnometarefa from D

drop table A,B,C,D
