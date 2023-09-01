---seleção
-- gera um subconjunto de linhas a partir de uma tabela com as linhas atendendo a uma condição
---sintaxe ar: <tab>[[condição]]
---exemplo: medico[[]]
select * from medicos where ceinstituicao is null
select * from medicos where ceinstituicao is not null
select * from medicos where ceespecialidade>=4 and ceinstituicao is null
---Projeção
--gera uma tabela copiando os dados de colunas de uma tabela de origem
---sintexe ar:<tab>[[nomes dos campos (separados por ,)]]
--exemplo:medicos[[cpmedico,txnomedico,numcrm]]
-- select <lista de campos> from <tab>
select cpmedico,txnomemedico,nucrm from medicos;

--para guardar esse dados é preciso usar o comando create table

create table med1 as (select cpmedico,txnomemedico,nucrm from medicos);
-- o comando dentro dos () é dito aninhado
select * from med1
--removendo o arquivo materializado
drop table med1
--materializando em memoria ram (apenas na sessão que está aberta)
create temporary table med1 as (select cpmedico,txnomemedico,nucrm from medicos);
select * from med1
drop table med1

create temporary table med2 as (select cpmedico,txnomemedico,nucrm from medicos);
select * from med2
drop table med2

--tanto med1 tanto med2 estã ocupando o mesmo espaço na memória,portando pode ser remover juntas
drop table med1,med2

---produto cartesiano
--Emparelhamento de cada linha de uma tabela com todas de outra
--Sintaxe ar:<tab1>x<tab2>--ANSI:87
--           <tab1><left|right|inner|full outer|cross>join <tab2> on <condição>--ansi:92
--sintaxe sql: select * from <tab1> cross join  <tab2>
--cross join faz emparelhamento
select * from armazens cross join livros
---comentarios no postgress podem ser por --- ou /**/

--JUNCAO NATURAL
--emparelhamento de cada linha de uma tabela com todas as linha de outra tabela,atendendo 
--a uma condiçao
---<tab1>[[condicao do emparelhamento]]<tab2>
--select * from <tab1> inner join <tab2>on <tab1>.campo =<tab2>.campo
select * from autores
select * from livros
select * from autorias
--- em sql:87
select * from autores,autorias,livros where autores.cpautor=autorias.ceautor and
autorias.celivro = livros.cplivro;

---em sql 92(agora usando o operado)
--junção fechada
select * from autores inner join autorias on autores.cpautor=autorias.ceautor
inner join livros on autorias.celivro = livros.cplivro;

--- em sql:87
select cpautor,txnomeautor,cplivro,txtituloacervo
from autores,autorias,livros where autores.cpautor=autorias.ceautor and
autorias.celivro = livros.cplivro;

---em sql 92(agora usando o operado)
--junção fechada
select cpautor,txnomeautor,cplivro,txtituloacervo from autores inner join autorias on autores.cpautor=autorias.ceautor
inner join livros on autorias.celivro = livros.cplivro;

