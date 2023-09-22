---quais sao os nomes completos data de contratação,datanascimento dos funcionarios
--participaram  de todos os projetos que foram ativados em junho de 2015?

select * from projetos;

-- Seleção.: A <- projetos [[ MES(dtcadpjeto)=6 e ANO(dtcadprojeto)=2015 ]]
-- Junção..: B <- A [[ A.cpprojeto=tp.ceprojeto ]] tarefasprojetos -> tp
-- Junção..: D <- B [[ B.cptarefaprojeto=at.cetarefaprojeto ]] atuacoes -> at
-- Junção..: E <- D [[ D.cefuncionario=f.cpfuncionario ]] funcionarios -> f
-- Projeção: E [[txprenomes, txsobrenome, dtcontratacao, dtnascimento]]

-- ANTES de processar esta pergunta, percebe-se que a tabela projetos não contém linhas que atendam à seleção inicial.
-- ENTÃO, para ajustar os dados (e ter uma resposta 'visível' temos que alterar os dados, com o comando:
update projetos set dtcadprojeto='2015-06-15' where dtcadprojeto='1980-01-01';

-- Seleção.: A <- projetos [[ MES(dtcadpjeto)=6 e ANO(dtcadprojeto)=2015 ]]
create temporary table A as (select * from projetos where dtcadprojeto between '2015-06-01' and '2015-06-30');
-- Junção..: B <- A [[ A.cpprojeto=tp.ceprojeto ]] tarefasprojetos -> tp
create temporary table B as(select * from A inner join tarefasprojetos as tp on A.cpprojeto=tp.ceprojeto);
-- projecao: C<- B [[cptarefaprojeto]]
create temporary table C as (select cptarefaprojeto from B)
-- Junção..: D <- C [[ C.cptarefaprojeto=at.cetarefaprojeto ]] atuacoes -> at
create temporary table D as(select * from  C inner join atuacoes as at on C.cptarefaprojeto=at.cetarefaprojeto);
--Junção..: E <- D [[ D.cefuncionario=f.cpfuncionario ]] funcionarios -> f
create temporary table E as (select * from D inner join funcionarios as f on D.cefuncionario=f.cpfuncionario)
--Projeção: E [[txprenomes, txsobrenome, dtcontratacao, dtnascimento]]
select txprenomes, txsobrenome, dtcontratacao, dtnascimento from E;

drop table a,b,c,d,e;
