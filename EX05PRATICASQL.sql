--5. Quais são todas as rotas viárias que passam pelas cidades "São Paulo" e "Rio de Janeiro"?
--A <- cidades [[ txnomecidade="São Paulo" ou txnome="Rio de Janeiro" ]]
--B1 <- A [[ A.pkcidade = rotasviarias.fkcidadeorigem]] rotasviarias
--B2 <- A [[ A.pkcidade = rotasviarias.fkcidadedestino]] rotasviarias
--C <- B1 U B2
--C [[ pkrota, txnomerota, txdescrperiodo, fkcidadeorigem, fkcidadedestino ]]

--A <- cidades [[ txnomecidade="São Paulo" ou txnome="Rio de Janeiro" ]]
create temporary table A as (select * from cidades where txnomecidade ='Sao Paulo' or txnomecidade = 'Rio de Janeiro')
--B1 <- A [[ A.pkcidade = rotasviarias.fkcidadeorigem]] rotasviarias
create temporary table B1 as (select * from A inner join rotasviarias on A.cpcidade = rotasviarias.cecidadeorigem)
--B2 <- A [[ A.pkcidade = rotasviarias.fkcidadedestino]] rotasviarias
create temporary table B2 as (select * from A inner join rotasviarias on A.cpcidade = rotasviarias.cecidadedestino)
--C <- B1 U B2
create temporary table C as (SELECT * FROM B1 union (select * from B2))
--C [[ pkrota, txnomerota, txdescrperiodo, fkcidadeorigem, fkcidadedestino ]]
SELECT cprota, txnomerota, txdescrperiodo, cecidadeorigem, cecidadedestino FROM C
