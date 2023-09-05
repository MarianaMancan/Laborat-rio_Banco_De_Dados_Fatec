-- Exemplificação de comandos SQL x AR
-- SELEÇÃO
-- Definição..: Gera uma subconjunto de linhas a partir de uma tabela com as linhas atendendo a uma condição.
-- Sintaxe AR.: <tab> [[ condição ]]
-- Exemplo.AR.: medicos [[ ]]
-- Sintaxe SQL: 
-- Exemplo SQL:
select * from medicos where ceinstituicao IS null; /* o operador de null é o 'is' ou 'is not' */
select * from medicos where ceespecialidade >= 4;  /* usando um operador simples de comparação */
select * from medicos where ceinstituicao IS null and ceespecialidade >= 4; /* usando o operador lógico AND */
-- ====================================================================================================================
-- PROJEÇÃO
-- Definição..: Gera uma tabela copiando os dados de colunas de tabela de origem
-- Sintaxe AR.: <tab> [[ nomes dos campos (separados por ',') ]]
-- Exemplo AR.: medicos [[ cpmedico, txnomemedico, nucrm ]]
-- Sintaxe SQL: select <lista de campo> from <tab>;
-- Exemplo SQL:
select cpmedico, txnomemedico, nucrm from medicos;
-- Esta tabela existe somente em tempo de execução (memória RAM), entretanto, pode seer necessário 'guardar' os dados
-- processados uma tabela. Para isso usamos o comando que 'TRANSFERE' os dados tabela. Na forma:
-- consultando os dados de med1
-- pode ser necessário, as vezes, criar uma tabela com dados temporários.
-- Em SQL, isso é possível, na forma:
create table med1 as (select cpmedico, txnomemedico, nucrm from medicos);
-- O comando dentro dos () é dito 'aninhado' por isso existe a referencia (livros) de comandos com 'aninhamento'.
select * from med1;
-- removendo o arquivo 'materializado'
drop table med1;
-- 'Materializando' em memória
create temporary table med2 as (select cpmedico, txnomemedico, nucrm from medicos);
select * from med2;
drop table med2;
-- Tanto med1 quanto med2 estão 'ocupando' espaço no computador. Portanto, é de praxe remover estas tabelas.
drop table med1, med2;
-- ====================================================================================================================
-- PRODUTO CARTESIANO
-- Definição..: Emparelhamento de cada linha de uma tabela com todas as linhas de outra tabela.
-- Sintaxe AR.: <tab1> X <tab2> -- ANSI:87
--              <tab1> <LEFT | RIGTH | INNER | FULL OUTER | CROSS >JOIN <tab2> ON <condição> -- ANSI:92
-- para o ProdCart: <tab1> CROSS JOIN <tab2>
-- Exemplo AR.: armazens X livros
-- Sintaxe SQL: select * from <tab1> CROSS JOIN <tab2>;
-- Exemplo SQL:
select * from armazens cross join livros; /* esta linha tem o comentário seguido do comando */
-- ====================================================================================================================
-- JUNÇÃO NATURAL (Fechada)
-- Definição..: Emparelhamento de cada linha de uma tabela com todas as linhas de outra tabela,
--              ATENDENDO a uma CONDIÇÃO
-- Sintaxe AR.: <tab1> [[ condição do emparelhamento ]] <tab2>
-- Exemplo AR.: clientes [[ clientes.celogradouro=logrcompleto.cplogradouro ]] logrcompleto
-- Sintaxe SQL: select * from <tab1> inner join <tab2> ON <tab1>.campo=<tab2>.campo;
-- Exemplo SQL:
select * from clientes inner join logrcompleto on clientes.celogradouro=logrcompleto.cplogradouro;
-- Explorando um pouco além do comando e analisando as sintaxes de 87 e 92
-- escrevendo uma junção entre três tabelas 
select * from autores;
select * from autorias;
select * from livros;

-- Em SQL ANSI:87
select * from autores, autorias, livros
         where autores.cpautor=autorias.ceautor and
               autorias.celivro=livros.cplivro;
-- Sobre este comando ainda podemos combinar uma operação de projeção.
select cpautor, txnomeautor, cplivro, txtituloacervo
       from autores, autorias, livros
       where autores.cpautor=autorias.ceautor and
             autorias.celivro=livros.cplivro;

-- EM SQL ANSI:92 (agora usando o operador )
select * from autores inner join autorias on autores.cpautor=autorias.ceautor
                      inner join livros on autorias.celivro=livros.cplivro;
-- Agora combinando com a projeção (apresentada acima)
select cpautor, txnomeautor, cplivro, txtituloacervo
       from autores inner join autorias on autores.cpautor=autorias.ceautor
                    inner join livros on autorias.celivro=livros.cplivro;
-- Se ainda quisermos ver os livros de um determinado autor, podemos escrever a
-- condição da seleção depois de um subcomando where, na forma:
select cpautor, txnomeautor, cplivro, txtituloacervo
       from autores inner join autorias on autores.cpautor=autorias.ceautor
                    inner join livros on autorias.celivro=livros.cplivro
	   where autores.cpautor=20;
-- ====================================================================================================================
-- ====================================================================================================================
-- Operação...: Junção Aberta pela Direita
-- Definição..: Emparelhamento de cada linha de uma tabela com todas as linhas de outra tabela, ATENDENDO a uma
--              CONDIÇÃO, porém mantendo emparelhadas TODAS as linhas da tabela à DIREITA do operador JOIN
-- Sintaxe AR.: <tab1> [[ condição do emparelhamento ][ <tab2>
-- Exemplo AR.: clientes [[ clientes.celogradouro=logrcompleto.cplogradouro ][ logrcompleto
-- Sintaxe SQL: select * from <tab1> RIGTH join <tab2> on <tab1>.campo=<tab2>.campo;
-- Exemplo SQL:
select * from clientes RIGTH join clientes.celogradouro=logrcompleto.cplogradouro;
-- ====================================================================================================================
-- Operação...: Junção Aberta pela Esquerda
-- Definição..: Emparelhamento de cada linha de uma tabela com todas as linhas de outra tabela, ATENDENDO a uma
--              CONDIÇÃO, porém mantendo emparelhadas TODAS as linhas da tabela à ESQUERDA do operador JOIN
-- Sintaxe AR.: <tab1> ][ condição do emparelhamento ]] <tab2>
-- Exemplo AR.: logrcompleto ][ logrcompleto.cplogradouro=clientes.celogradouro ]] clientes
-- Sintaxe SQL: select * from <tab1> LEFT join <tab2> on <tab1>.campo=<tab2>.campo;
-- Exemplo SQL:
select * from logrcompleto LEFT join clientes on logrcompleto.cplogradouro=clientes.celogradouro;
-- ====================================================================================================================
-- Operação...: Junção Completa (Aberta pela Esquerda e Direita)
-- Definição..: Emparelhamento de cada linha de uma tabela com todas as linhas de outra tabela, ATENDENDO a uma
--              CONDIÇÃO, porém mantendo emparelhadas TODAS as linhas da tabela à ESQUERDA do operador JOIN
-- Sintaxe AR.: <tab1> ][ condição do emparelhamento ][ <tab2>
-- Exemplo AR.: logrcompleto ][ logrcompleto.cplogradouro=clientes.celogradouro ][ clientes
-- Sintaxe SQL: select * from <tab1> FULL OUTER join <tab2> on <tab1>.campo=<tab2>.campo;
-- Exemplo SQL: 
select * from logrcompleto FULL OUTER join clientes on logrcompleto.cplogradouro=clientes.celogradouro;
-- ====================================================================================================================
-- Para ser possível realizar as operações de união, intersecção e subtração as tabelas devem União Compatíveis.
-- UC é observado quando as tabelas tem o mesmo esquema. Ou seja, tenham campos:
-- - com mesmo nome
-- - com mesmo tipo de dados
-- - com mesmo tamanho
-- - na mesma ordem da tabela.
-- Para gerarmos duas tabelas UC vamos fazer uma analise sobre os dados de medicos
-- fazendo projeção de medicos
select cpmedico, txnomemedico, nucrm, ceespecialidade from medicos order by ceespecialidade;
-- Agora podemos fazer duas seleções, em cada uma geramos uma tabela temporária.
create temporary table m1 as (select cpmedico, txnomemedico, nucrm, ceespecialidade from medicos where ceespecialidade>=3 order by ceespecialidade);
create temporary table m2 as (select cpmedico, txnomemedico, nucrm, ceespecialidade from medicos where ceespecialidade<=5 order by ceespecialidade);
-- verificando os dados em cada tabela gerada vemos que existem tuplas 'repetidas' nas duas. As duas tabelas são UC,
-- portanto podemos escrever as operações de União, Intersecção e Subtração.
-- ====================================================================================================================
-- Operação...: União
-- Definição..: Gera uma tabela com todas as tuplas das duas tabelas.
-- Sintaxe AR.: <tab1> U <tab2>
-- Sintaxe SQL: select * from <tab1> UNION (select * from <tab2>);
-- Exemplo SQL: 
select * from m1 union (select * from m2);
-- Note que no SQL ANSI:87 o UNION mostrava TODAS as tuplas (inclusive as repetidas). Para evitar de uma operação
-- apresentar tuplas repetidas, ainda na ANSI:87 apresentaram o operador DISTINCT que deve ser escrito logo
-- a seguir do comando SELECT.
-- Para facilitar a escrita do UNION, na versão ANSI:92, o comando já omite as repatidas.
-- Se for necessária ver todas as linhas é opcional usar o operador UNION ALL, na forma:
select * from m1 union (select * from m2);
-- Agora veja o resultado do processamento do comando:
select * from (select * from m1 union (select * from m2)) as t order by t.ceespecialidade;
-- Como exercício, pesquise:
-- o que é "from (select * from m1 union (select * from m2)) as t"?
-- Por que é preciso escrever este trecho do comando?
-- As respostas não são simples, pesquise.
-- ====================================================================================================================
-- Operação...: Intersecção
-- Definição..: Gera uma tabela com as tuplas COMUNS nas duas tabelas ("pega" as repetidas).
-- Sintaxe AR.: <tab1> ^ <tab2>
-- Sintaxe SQL: select * from <tab1> INTERSECT (select * from <tab2>);
-- Exemplo SQL: 
select * from m1 intersect (select * from m2);
-- Como será que fica o comando caso queiramos ordenar novamente por ceespecialidade?
-- ====================================================================================================================
-- Operação...: Subtração
-- Definição..: Gera uma tabela com as tuplas que não estão presentes em outra tabela.
-- Sintaxe AR.: <tab1> - <tab2>
-- Sintaxe SQL: select * from <tab1> EXCEPT | MINUS (select * from <tab2>);
-- Exemplo SQL: 
select * from m1 except (select * from m2);
-- ====================================================================================================================
-- ====================================================================================================================
-- Comandos de Atualização
-- Operação...: INSERÇÃO de Linhas em tabelas
-- Definição..: Permite a inclusão de linhas em tabelas.
-- Sintaxe AR.: NÃO Existe correspondência em AR para o comando de INSERÇÃO.
-- Sintaxe SQL: Existem variantes do comando em SQL. O mais simples e convencional é:
-- INSERT INTO <tab> [(Lista de campos da tabela que vai receber dados)] VALUES (Lista de Valores);
-- Exemplo SQL: 
INSERT INTO <tab> [(Lista de campos da tabela que vai receber dados)] VALUES (Lista de Valores);
-- Ao tentar executar este comando
insert into clientes (cpcliente,txnomecliente,txrazaosocial,celogradouro,txcomplemento,nucep,vllimitecompra,aosituacao,dtcadcliente)
       values (15,'Auto Posto São Bernardo','Auto Posto São Bernardo S/C Ltda.','520','1450','04114521','150000','A','2023-09-03');
-- Receberemos a mensagem:
ERROR:  Key (cpcliente)=(15) already exists.duplicate key value violates unique constraint "clientescp" 
ERROR:  duplicate key value violates unique constraint "clientescp"
SQL state: 23505
Detail: Key (cpcliente)=(15) already exists.
-- Agora podemos alterar o comando para:
insert into clientes (cpcliente,txnomecliente,txrazaosocial,celogradouro,txcomplemento,nucep,vllimitecompra,aosituacao,dtcadcliente)
       values (45,'Auto Posto São Bernardo','Auto Posto São Bernardo S/C Ltda.','520','1450','04114521','150000','A','2023-09-03');
-- Apresentamos as alternativas de comando INSERT
insert into clientes (cpcliente,txnomecliente,txrazaosocial,celogradouro,txcomplemento,nucep,vllimitecompra,aosituacao,dtcadcliente)
       values (60,'Auto Posto São Bernardo','Auto Posto São Bernardo S/C Ltda.','520','1450','04114521','150000','A','2023-09-03'),
	          (90,'Auto Posto São Bernardo','Auto Posto São Bernardo S/C Ltda.','520','1450','04114521','150000','A','2023-09-03');
-- Também é possível gerar dados através de algum comando SQL e inserir os dados gerados.
-- A tabela clientes, após os comandos de inclusão anteriormente escritoscontém: 18 linhas como pode ser visto com o comando:
select * from clientes;
Podemos gerar novos 18 outros registros com o seguinte comando:
select row_number () over (order by cpcliente) + 100 as cpcliente,
       txnomecliente,
	   txrazaosocial,
	   celogradouro,
	   txcomplemento,
	   nucep,
	   vllimitecompra,
	   aosituacao,
	   dtcadcliente
       from clientes;
-- Estude a função ROW_NUMBER(), ela pode ser usada de diferentes formas.
-- Agora veja como as linhas geradas no comando acima pode ser usado para inserir linhas na tabela clientes:
insert into clientes
            ( select row_number () over (order by cpcliente) + 100 as cpcliente, txnomecliente,txrazaosocial,celogradouro,txcomplemento,nucep,vllimitecompra,aosituacao,dtcadcliente
                     from clientes );
-- Se você percebeu que a tabela clientes ficou com linhas repetidas (com exceção dos valores da CP), fique tranquilo,
-- nos exemplos do comando de EXCLUSÃO, a seguir...
-- ====================================================================================================================
-- Operação...: EXCLUSÃO de linhas de tabelas
-- Definição..: Exclui linhas de uma tabela que atedam a uma condição.
-- Sintaxe AR.: NÃO Existe correspondência em AR para o comando de EXCLUSÃO
-- Sintaxe SQL: delete from <tab> [where <condição>];
-- Exemplo SQL: 
delete from clientes where cpcliente>=100;
-- PRESTE atenção na condição de processamento das linhas. O PostgreSQL trata cada comando de atualização escrito em
-- uma Query Tool como uma TRANSAÇÃO implicita (como se acontecesse o inicio da transação, a execução do comando e
-- a finalização da transação em um só comando). Isso acontece em outros SGBDs mais novos como o MariaDB ou o MySQL.
-- Ou seja, se o comando não estiver errado a tabela é atualizada no arquivo correspondente.
-- Então se escrevermos:
delete from clientes;
-- E executarmos este comando, TODAS as linhas de clientes serão deletadas, pois com a condição omitida todas as Linhas
-- são processadas (o comando tem o mesmo efeito de: delete from clientes where 1=1;
-- Este sub-comando 'where 1=1' tem o efeito: Em quais linhas da tabela o 1 é igual a 1? Resposta obvia: em TODAS.
-- ====================================================================================================================
-- Operação...: ALTERAÇÃO de Linhas em tabelas
-- Definição..: Altera valores em campos de linhas das tabelas
-- Sintaxe AR.: NÃO Existe correspondência em AR para o comando de ALTERAÇÃO
-- Sintaxe SQL: UPDATE <tab> SET <atribuiçao1[,atribuição2,...,atribuiçãon]> [where <condição>;
-- Exemplo SQL: 
update medicos set ceinstituicao=6 where ceinstituicao is null;
-- PRESTE atenção na condição de processamento das linhas. O PostgreSQL trata cada comando de atualização escrito em
-- uma Query Tool como uma TRANSAÇÃO implicita (como se acontecesse o inicio da transação, a execução do comando e
-- a finalização da transação em um só comando). Isso acontece em outros SGBDs mais novos como o MariaDB ou o MySQL.
-- Ou seja, se o comando não estiver errado a tabela é atualizada no arquivo correspondente.
-- Então se escrevermos:
update medicos set txnomemedico='Jesuino Alvares Penteado';
-- E executarmos este comando, TODAS as linhas de medicos serão alteradas, pois com a condição omitida todas as Linhas
-- são processadas (o comando tem o mesmo efeito de: update medicos set txnomemedico='Jesuino Alvares Penteado' where 1=1;
-- Este sub-comando 'where 1=1' tem o efeito: Em quais linhas da tabela o 1 é igual a 1? Resposta obvia: em TODAS.
-- Daí, TODAS as linhas serão alteradas tendo o nome do médico alterado para 'Jesuino Alvares Penteado'. 
