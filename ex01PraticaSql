--1. Quais ônibus fizeram viagens em todas as rotas viárias que tiveram viagens no ano de 2012?
-- Preparando as tabelas para a divisao
--SEL : a  viagens [[dtsaidaviagem entre "2012-01-01" e "2012-12-31" ou dtchegadaviagem entre "2012-01-01" e "2012-12-31"]]
--JUN : b  a [[ a.pkviagem=passagens.fkviagem ]] passagens
--PRO : p  b [[fkrota]] – Códigos das rotas que tiveram viagens em 2010.
--PRO : pd  b [[fkrota, fkonibus]]
--PRO : f  onibus [[pkonibusfkonibus ]]
-- Dividindo
--PCT : s  p X f
--SUB : t  s - pd
--PRO : w  t [[ onibusid ]]
--SUB : r  f - w
-- Completando a solução
--JUN : z <- r [[ r.onibusid=onibus.id ]] onibus
--PRO : z [[ukplaca,txapelido, nuanofabricacao, qtcapacidade]]

--SEL : a  viagens [[dtsaidaviagem entre "2012-01-01" e "2012-12-31" ou dtchegadaviagem entre "2012-01-01" e "2012-12-31"]]
CREATE TEMPORARY TABLE A AS (select * from viagens where (dtsaidaviagem BETWEEN '2012-01-01' and '2012-12-31')
or (dtchegadaviagem BETWEEN '2012-01-01' AND '2012-12-31'))
--JUN : b  a [[ a.pkviagem=passagens.fkviagem ]] passagens
CREATE TEMPORARY TABLE B AS (select * from A inner join passagens on A.cpviagem = passagens.ceviagem)
--PRO : p  b [[fkrota]] – Códigos das rotas que tiveram viagens em 2010.
CREATE TEMPORARY TABLE P AS (SELECT CEROTA from B) 
--PRO : pd  b [[fkrota, fkonibus]]
CREATE TEMPORARY TABLE PD AS (SELECT CEONIBUS,CEROTA from B)
--PRO : f  onibus [[pkonibusfkonibus ]] 
CREATE TEMPORARY TABLE F AS (SELECT cponibus as ceonibus from onibus)
-- Dividindo
--PCT : s  p X f
CREATE TEMPORARY TABLE S AS (SELECT * FROM P CROSS JOIN F)
--SUB : t  s - pd
CREATE TEMPORARY TABLE T AS (SELECT * FROM S except  (SELECT * FROM PD))
--PRO : w  t [[ onibusid ]]
CREATE TEMPORARY TABLE W AS (SELECT CEONIBUS FROM T)
--SUB : r  f - w
CREATE TEMPORARY TABLE R AS (SELECT * FROM F except (select * from W))
-- Completando a solução
--JUN : z <- r [[ r.onibusid=onibus.id ]] onibus
CREATE TEMPORARY TABLE Z AS (SELECT * FROM R INNER JOIN ONIBUS ON R.ceonibus = ONIBUS.cponibus)
--PRO : z [[ukplaca,txapelido, nuanofabricacao, qtcapacidade]]
select ccplaca,txapelido, nuanofabricacao, qtcapacidade from Z
