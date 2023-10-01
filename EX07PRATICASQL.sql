--1. Quais foram os funcionários (cite: primeiro nome e sobrenome) que participaram nos projetos feitos pelo departamento onde o
--gerente é o funcionário "HEATHER"?

--seleção:A <- funcionarios[[txprenomeS = 'HEATHER']]
create temporary table A as (select * from funcionarios where txprenomeS = 'HEATHER')
--seleção:A1 <- departamentos[[cpdepto,cefuncionariogerente]]
create temporary table A1 as (select cpdepto,cefuncionariogerente from departamentos)
--junção: B <- A[[A.cpfuncionario = dept.cpdepto]]departamentos -> dept
create temporary table B as (select * from A inner join A1 on A.cpfuncionario = A1.cefuncionariogerente)
--Seleção: C <- projetos[[cpprojeto,cedepto->iddepto]]
create temporary table C as (select cpprojeto,cedepto as iddepto from projetos)
--junção:D<- B[[B.cpdepto = C.cedepto]]C
create temporary table D as (select * from B inner join C on B.cpdepto = C.iddepto)
--seleção:E<-D[cpfuncionario <-idfuncinario]
create temporary table E as (select cpfuncionario as idfuncionario from D)
--junção:F<-E[[E.IDfuncionario = func.cpfuncionario]]funcionarios as func
create temporary table F as (select * from E INNER JOIN FUNCIONARIOS AS func on E.IDfuncionario = func.cpfuncionario )
--projeção: F[[txprenomes,txsobrenome]]
select txprenomes,txsobrenome from F
