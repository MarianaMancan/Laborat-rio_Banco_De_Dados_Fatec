--4. Qual é a média da quantidade de disciplinas atribuídas aos professores para cada área de estudo? O que pode representar esta
--média (interprete o resultado), exiba a média com duas casas decimais.
--W  atribuicoes [[fkprofessoridprof, fkdisciplina iddisc]]
--S  W [[W.iddisc = disciplinas.pkdisciplina][disciplinas
--T  S [[idprof,pkdisciplinaiddisc]]
--K  T [[T.iddisc= aed.fkdisciplina]] areaestudodisciplinas  aed
--M  K [[media(idprof)QtdMedProf, fkareaestudo]] {agrupar por fkareaestudo} {ordernar por fkareaestudo}
--L  M[[M.fkareaestudo=areaestudo.pkareaestudo]]areaestudo
--L[[txnomearea,ARREDONDAR(QtdMedProf,2)]]

--W  atribuicoes [[fkprofessoridprof, fkdisciplina iddisc]]
create temporary table W as( select ceprofessor as idprof,cedisciplina as iddisc from atribuicoes)
--S  W [[W.iddisc = disciplinas.pkdisciplina][disciplinas
create temporary table S as (SELECT * FROM W RIGHT JOIN DISCIPLINAS ON W.iddisc = DISCIPLINAS.cpdisciplina)
--T  S [[idprof,pkdisciplinaiddisc]]
create temporary table T as (select idprof,cpdisciplina as iddisc from S)
--K  T [[T.iddisc= aed.fkdisciplina]] areaestudodisciplinas  aed
create temporary table K as (select * from T inner join areasdeestudodisciplinas as aed on T.iddisc = aed.cedisciplina)
--M  K [[media(idprof)QtdMedProf, fkareaestudo]] {agrupar por fkareaestudo} {ordernar por fkareaestudo}
create temporary table M as (select avg(idprof) as QtdMedProf,ceareadeestudo from K group by ceareadeestudo order by ceareadeestudo )
--L  M[[M.fkareaestudo=areaestudo.pkareaestudo]]areaestudo
create temporary table L as (select * from M inner join areasdeestudo on M.ceareadeestudo = areasdeestudo.cpareadeestudo)
--L[[txnomearea,ARREDONDAR(QtdMedProf,2)]]
select txnomeareadeestudo,round(QtdMedProf,2) from L
DROP TABLE W,S,T,K,M,L
