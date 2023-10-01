
--Desenvolva um gatilho que implemente o valor de um campo PK em uma tabela atribuindo o valor incrementando de 5 unidades em relação ao máximo valor de PK da tabela.
--Se a tabela estiver vazia o primeiro valor deve ser atribuído com o valor 5
select * from editoras;
select MAX(cpeditora), min(cpeditora), count(*),avg(cpeditora) from editoras;
select * from pedvendas limit 3;
select * from information_schema."columns";
select MAX(editoras.cp) from pedvendas limit 3;
--Determine o nome do gatilho
--declarar a variavel
--mreg <-- pesquisar o ultimo valor da cp gravado 
declare
   mreg SMALLINT;
   Inicio:
   mreg<- pesquisar o ultimo valor da cp gravado;
   SE(mreg é nulo)
   	ENTÃO
		NEW.CPPVENDA <-5;
	SENÃO
		NEW.CPPVENDA <-mreg + 5;
   FIM SE;
   retorna NEW;
FIM BLOCO;

--construindo a trigger function in plpgsql  procedural language of PostGresSql
DECLARE
     mreg SMALLINT;
BEGIN
	select MAX(cppvenda) int mreg from pedvendas;
	if(mreg is null)
	the
		NEW.cppvenda := 5;
	else
		NEW.cppvenda := mreg +5;
	end if;
	return new;
end
	

 
