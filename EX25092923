-- Uma Universidade ten várias Faculdades agregadas. A Bibiliteca de uma Faculdade tem seu
-- acervo formado pelas indicações da Reitoria da Universidade. Nem sempre a Reitoria
-- acompanha as mudanças de indicações de bibliografias das disciplinas de todas as
-- Faculdades agregadas. Isso faz com o acervo das bibliotecas passe a ficar com livros sem
-- referencias em bibliografias ads disciplinas. Recentemente, montaram um Banco de Dados
-- com dados sobre os acervos de TODAS as bibliotecas de Todas as Faculdades, bem como os
-- cadastros de TODAS as bibliografias de TODAS as disciplinas.
-- Agora é possível responder a seguinte pergunta:
-- Quais são os códigos de livros e título de todos os livros que constam e que não constam em
-- bibliografias das disciplinas? Devem ser exibidos os nomes das disciplinas quando constar
-- o livro em sua bibliografia e quando o livro não constar em bibliografia de nenhuma disciplinas
-- no nome da disciplina do livro deve aparecer "NÃO CONSTA". 
-- Elabore sua resposta com base nas estruturas das tabelas:
-- livros e bibliografias e disciplinas da base de dados do PRATICASQL.
-- Escreva as operações de AR que devem ser feitas e traduza as operações para os
-- correspondentes comandos SQL.
-- Resposta:
-- O modelo em questão apresenta relacionamentos [livros](1,N:0,N)[disciplinas], sendo que este
-- relacionamento é nomeado bibliografia. Sendo assim temos:
-- [livros](1,1:0,N)[bibliografias](1,N:1,1)[disciplinas], portanto podem existir livros SEM
-- referência em nenhuma bibliografia (de disciplinas). Isso indica que, para termos uma lista de
-- TODOS os livros deveremos fazer uma junção aberta para o lado de livros.


--junção (FECHADA): A<-disciplinas-d[[d.cpdisciplina = b b.cedplicina]]bibliografia-b
--junção aberta direita : B <- A[[A.celivro = l.cplivro]] livros
--Projeção: B[[cplivro,txtituloarcervo,
--           SE cpdisciplina no é nuulo ENTAO txnome
--                                       SENAO "Não consta"]]

--EM SQL,TEREMOS:
CREATE TEMPORARY TABLE A AS (SELECT * FROM disciplinas as d INNER JOIN bibliografia as b
							 on d.cpdisciplina = b.cedisciplina);

CREATE TEMPORARY TABLE B AS (SELECT * FROM A RIGHT JOIN livros as l on A.celivro = l.cplivro);

select cplivro,txtituloacervo,
CASE WHEN cpdisciplina IS NOT NULL THEN txnomedisciplina 
ELSE 'Não consta'
END
from B

drop table A,B;

--AGORA VAMOS COMBINAR ESSES COMANDOS
SELECT   cplivro,txtituloacervo,
CASE WHEN cpdisciplina IS NOT NULL THEN txnomedisciplina 
ELSE 'Não consta'
END
FROM disciplinas as d INNER JOIN bibliografia as b
					  on d.cpdisciplina = b.cedisciplina
					 RIGHT JOIN livros as l on b.celivro = l.cplivro
