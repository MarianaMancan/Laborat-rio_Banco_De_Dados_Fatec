-- Script de criação de componentes em uma base de dados.
--
-- A Base de dados deve ser criada e acessada ANTES da execução deste Script
-- Este Script inicialmente foi gerado pelo programa pddump.
--
-- CRIE uma base de dados e acesse esta base.
-- Execute este script dentro de uma JANELA de Query Tool no aplicativo pgAdmin 4.
--
-- PostgreSQL database dump
-- Dumped from database version 13.2
-- Dumped by pg_dump version 15.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres

-- *not* creating schema, since initdb creates it
ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;
-- #########################################   AQUI COMEÇAM AS DESCRIÇÕES DE ESTRUTURAS DE OBJETOS DE DADOS (TABELAS E VISÕES)   #########################################


-- Name: agencias; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.agencias (
    cebanco character(3) NOT NULL,
    cpagencia character(6) NOT NULL,
    txnomeagencia character varying(250) NOT NULL,
    celogradouro integer,
    txcomplemento character varying(25),
    nucep character(8) DEFAULT NULL::bpchar,
    dtcadagencia date
);
ALTER TABLE public.agencias OWNER TO postgres;
COMMENT ON TABLE public.agencias IS 'Cadastro das agências bancárias onde os funcionários podem ter uma conta.';
COMMENT ON COLUMN public.agencias.cebanco IS 'Parte da cp Composta com cpagencia, ce para a tabela bancos.';
COMMENT ON COLUMN public.agencias.cpagencia IS 'Parte da cp Composta com cebanco. Pode conter letras e números.';
COMMENT ON COLUMN public.agencias.txnomeagencia IS 'Nome da Agência (sem abreviações).';
COMMENT ON COLUMN public.agencias.celogradouro IS 'ce para a tabela logradouros da cidade onde se localiza a agência bancária.';
COMMENT ON COLUMN public.agencias.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.).';
COMMENT ON COLUMN public.agencias.nucep IS 'Número do CEP (somente números)';
COMMENT ON COLUMN public.agencias.dtcadagencia IS 'Data de geração do registro.';


-- Name: agenciastels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.agenciastels (
    cpagenciatel integer NOT NULL,
    cebanco character(3) NOT NULL,
    ceagencia character(6) NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadagenciatel date
);
ALTER TABLE public.agenciastels OWNER TO postgres;
COMMENT ON TABLE public.agenciastels IS 'Registro dos telefones de cada autor de publicação.';
COMMENT ON COLUMN public.agenciastels.cpagenciatel IS 'cp da tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.agenciastels.cebanco IS 'ce (composta) para a tabela agencias.';
COMMENT ON COLUMN public.agenciastels.ceagencia IS 'ce (composta) para a tabela agencias.';
COMMENT ON COLUMN public.agenciastels.cetipotelefone IS 'ce para a tabela telefonestipos';
COMMENT ON COLUMN public.agenciastels.nutelefone IS 'Data de geração do registro.';
COMMENT ON COLUMN public.agenciastels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.agenciastels.dtcadagenciatel IS 'Data de geração do registro.';


-- Name: aplicacoesfinanceiras; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.aplicacoesfinanceiras (
    cpaplicacaofinanceira smallint NOT NULL,
    txnomeaplicacao character varying(250) NOT NULL,
    txregrasdaaplicacao text,
    vlmintaxaderetorno double precision,
    vlmaxtaxaderetorno double precision,
    dtcadaplicfinanc date
);
ALTER TABLE public.aplicacoesfinanceiras OWNER TO postgres;
COMMENT ON TABLE public.aplicacoesfinanceiras IS 'Cadastro de aplicações financeiras que podem ser feitas para as contas de funcionarios.';
COMMENT ON COLUMN public.aplicacoesfinanceiras.cpaplicacaofinanceira IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.aplicacoesfinanceiras.txnomeaplicacao IS 'Nome da aplicação financeira';
COMMENT ON COLUMN public.aplicacoesfinanceiras.txregrasdaaplicacao IS 'Descrição detalhada das regras de como fazer a aplicação financeira: saldo inicial, datas limites e formas de recuperação.';
COMMENT ON COLUMN public.aplicacoesfinanceiras.vlmintaxaderetorno IS 'Valor mínimo da Taxa de Retorno da Aplicação Financeira.';
COMMENT ON COLUMN public.aplicacoesfinanceiras.vlmaxtaxaderetorno IS 'Valor máximo da Taxa de Retorno da Aplicação Financeira.';
COMMENT ON COLUMN public.aplicacoesfinanceiras.dtcadaplicfinanc IS 'Data de geração do registro';


-- Name: areadeestudo; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.areasdeestudo (
    cpareadeestudo integer NOT NULL,
    txnomearea character varying(250) NOT NULL,
    txdescricaoarea text,
    dtcadareadeestudo date NOT NULL
);
ALTER TABLE public.areasdeestudo OWNER TO postgres;
COMMENT ON TABLE public.areasdeestudo IS 'Cadastro das áreas de estudo de interesse geral, tais como EXATAS, HUMANAS, etc., e suas subdivisões.';
COMMENT ON COLUMN public.areasdeestudo.cpareadeestudo IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.areasdeestudo.txnomearea IS 'Nome da area de estudo (ou área de conhecimento).';
COMMENT ON COLUMN public.areasdeestudo.txdescricaoarea IS 'Descrição detalhada de uma Área de Estudo (ou área de conhecimento).';
COMMENT ON COLUMN public.areasdeestudo.dtcadareadeestudo IS 'Data de geração do registro.';


-- Name: areadeestudocursos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.areasdeestudocursos (
    cpareaestcurso integer NOT NULL,
    cecurso integer NOT NULL,
    ceareadeestudo integer NOT NULL,
    dtcadareaestcurso date NOT NULL
);
ALTER TABLE public.areasdeestudocursos OWNER TO postgres;
COMMENT ON TABLE public.areasdeestudocursos IS 'Registro das áreas de estudos de cada curso. É o desmembramento de um relacionamento N:M.';
COMMENT ON COLUMN public.areasdeestudocursos.cpareaestcurso IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.areasdeestudocursos.cecurso IS 'Parte da CC (com ceareadeestudo), ce para a tabela Cursos.';
COMMENT ON COLUMN public.areasdeestudocursos.ceareadeestudo IS 'Parte da CC (com cecurso), ce para a tabela Áreas de Estudos (areadeestudos).';
COMMENT ON COLUMN public.areasdeestudocursos.dtcadareaestcurso IS 'Data de geração do registro.';


-- Name: areadeestudodisciplinas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.areasdeestudodisciplinas (
    cpareaestdisciplina integer NOT NULL,
    cedisciplina integer NOT NULL,
    ceareadeestudo integer NOT NULL,
    dtcadareaestdisc date NOT NULL
);
ALTER TABLE public.areasdeestudodisciplinas OWNER TO postgres;
COMMENT ON TABLE public.areasdeestudodisciplinas IS 'Registro das áreas de estudo de cada disciplina de curso. É o desmembramento de um relacionamento N:M.';
COMMENT ON COLUMN public.areasdeestudodisciplinas.cpareaestdisciplina IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.areasdeestudodisciplinas.cedisciplina IS 'Parte da CC (com ceareadeestudo), ce para a Tabela Disciplinas.';
COMMENT ON COLUMN public.areasdeestudodisciplinas.ceareadeestudo IS 'Parte da CC (com cedisciplina), ce para a tabela Áreas de Estudos (areadeestudos).';
COMMENT ON COLUMN public.areasdeestudodisciplinas.dtcadareaestdisc IS 'Data de geração do registro.';


-- Name: areadeestudolivros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.areasdeestudolivros (
    cpareaestlivro integer NOT NULL,
    celivro integer NOT NULL,
    ceareadeestudo integer NOT NULL,
    nugrauinfluencia numeric(3,0) DEFAULT NULL::numeric,
    dtcadareaestlivro date NOT NULL
);
ALTER TABLE public.areasdeestudolivros OWNER TO postgres;
COMMENT ON TABLE public.areasdeestudolivros IS 'Registro das áreas de estudos de cada livro. É o desmembramento de um relacionamento N:M.';
COMMENT ON COLUMN public.areasdeestudolivros.cpareaestlivro IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.areasdeestudolivros.celivro IS 'Parte da CC (com ceareadeestudo), ce para a tabela livros.';
COMMENT ON COLUMN public.areasdeestudolivros.ceareadeestudo IS 'Parte da CC (com celivro), ce para tabela Áreas de Estudos (areadeestudos).';
COMMENT ON COLUMN public.areasdeestudolivros.nugrauinfluencia IS 'Percentagem de cobertura da Área de Estudo no livro (num. inteiro)';
COMMENT ON COLUMN public.areasdeestudolivros.dtcadareaestlivro IS 'Data de geração do registro.';


-- Name: armazens; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.armazens (
    cparmazem smallint NOT NULL,
    txnomearmazem character varying(50) NOT NULL,
    txdescricaogeral character varying(500),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(50) DEFAULT NULL::character varying,
    cecliente integer NOT NULL,
    nutelefone character(12) DEFAULT NULL::bpchar,
    nucep character(8) DEFAULT NULL::bpchar,
    qtarea double precision NOT NULL,
    dtcadarmazem date NOT NULL
);
ALTER TABLE public.armazens OWNER TO postgres;
COMMENT ON TABLE public.armazens IS 'Cadastro dos Armazens dos clientes para onde as vendas registradas por um funcionario podem ser entregues.';
COMMENT ON COLUMN public.armazens.cparmazem IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.armazens.txnomearmazem IS 'Nome curto ou usual do Armazem. Como ele é identificado informalmente.';
COMMENT ON COLUMN public.armazens.txdescricaogeral IS 'Texto com descrição completa do armazém (capacidade, pé direito médio, etc.).';
COMMENT ON COLUMN public.armazens.celogradouro IS 'ce indicando o logradouro onde se localiza o armazém.';
COMMENT ON COLUMN public.armazens.txcomplemento IS 'Texto com o complemento do logradouro da agência bancária (número, andar, etc.)';
COMMENT ON COLUMN public.armazens.cecliente IS 'ce indicando o cliente que é dono ou aluga o armazém.';
COMMENT ON COLUMN public.armazens.nutelefone IS 'Número de telefone. Formato OP-DD-TTTT-RRRR, sem o ZERO no início, só numeros.';
COMMENT ON COLUMN public.armazens.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.armazens.qtarea IS 'Número inteiro indicando a área total.';
COMMENT ON COLUMN public.armazens.dtcadarmazem IS 'Data de geração do registro.';


-- Name: atividades; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.atividades (
    cpatividade integer NOT NULL,
    txnomeatividade character varying(50) NOT NULL,
    txdescricao character varying(500) NOT NULL,
    dtcadatividade date NOT NULL
);
ALTER TABLE public.atividades OWNER TO postgres;
COMMENT ON TABLE public.atividades IS 'Cadastro com as atividades profissionais desempenhadas por um funcionário.';
COMMENT ON COLUMN public.atividades.cpatividade IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.atividades.txnomeatividade IS 'Nome curto ou usual.';
COMMENT ON COLUMN public.atividades.txdescricao IS 'Descrição detalhada e completa de uma atividade profissional.';
COMMENT ON COLUMN public.atividades.dtcadatividade IS 'Data de Geração do Registro';


-- Name: atribuicoes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.atribuicoes (
    cpatribuicao integer NOT NULL,
    ceprofessor smallint NOT NULL,
    cedisciplina integer NOT NULL,
    qthorasatribuidas numeric(5,0) NOT NULL,
    dtatribuicao date NOT NULL,
    dtcadatribuicao date
);
ALTER TABLE public.atribuicoes OWNER TO postgres;
COMMENT ON TABLE public.atribuicoes IS 'Registro dos Professores de cada uma da Disciplinas. É o desmembramento do relacionamento N:M. Tem a CC composta.';
COMMENT ON COLUMN public.atribuicoes.cpatribuicao IS 'cp da tabela.';
COMMENT ON COLUMN public.atribuicoes.ceprofessor IS 'Parte da CC Composta com cedisciplina, ce indicando o código do professor.';
COMMENT ON COLUMN public.atribuicoes.cedisciplina IS 'Parte da CC Composta com ceprofessor, ce indicando o código da disciplina.';
COMMENT ON COLUMN public.atribuicoes.qthorasatribuidas IS 'Quantidade de horas de uma disciplina atribuídas ao professor para a disciplina.';
COMMENT ON COLUMN public.atribuicoes.dtatribuicao IS 'Data de atribuição da disciplina ao professor';
COMMENT ON COLUMN public.atribuicoes.dtcadatribuicao IS 'Data de geração do registro.';


-- Name: atuacoes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.atuacoes (
    cpatuacao smallint NOT NULL,
    cetarefaprojeto integer NOT NULL,
    cefuncionario integer NOT NULL,
    dtinicio date DEFAULT '2014-04-25'::date NOT NULL,
    dttermino date,
    qttempoduracao numeric(5,0) NOT NULL,
    dtcadatuacao date NOT NULL
);
ALTER TABLE public.atuacoes OWNER TO postgres;
COMMENT ON TABLE public.atuacoes IS 'Registro das atuações profissionais dos funcionários nos projetos. É um desmembramento de um N:M e tem uma CCK composta.';
COMMENT ON COLUMN public.atuacoes.cpatuacao IS 'cp da tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.atuacoes.cetarefaprojeto IS 'Parte da CC Composta com cefuncionario e dtinicio, ce para a tabela tarefasprojetos.';
COMMENT ON COLUMN public.atuacoes.cefuncionario IS 'Parte da CC Composta com cetarefaprojeto e dtinicio, ce para tabela funcionários.';
COMMENT ON COLUMN public.atuacoes.dtinicio IS 'Parte da CC Composta com cefuncionario e cetarefaprojeto, é a Data de início de atuação do Funcionário em uma tarefa de um projeto.';
COMMENT ON COLUMN public.atuacoes.dttermino IS 'Data de término de atuação do funcionário em uma tarefa de um projeto.';
COMMENT ON COLUMN public.atuacoes.qttempoduracao IS 'Quantidade de horas de participação do funcionário em uma tarefa de um projeto.';
COMMENT ON COLUMN public.atuacoes.dtcadatuacao IS 'Data de geração do registro.';


-- Name: autores; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.autores (
    cpautor integer NOT NULL,
    txnomeautor character(90) NOT NULL,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) NOT NULL,
    dtnascimento date NOT NULL,
    dtcadautor date NOT NULL
);
ALTER TABLE public.autores OWNER TO postgres;
COMMENT ON TABLE public.autores IS 'Cadastro dos autores de alguma forma de publicação de conhecimento. Na maioria dos casos são autores de livros.';
COMMENT ON COLUMN public.autores.cpautor IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.autores.txnomeautor IS 'Nome completo do autor.';
COMMENT ON COLUMN public.autores.celogradouro IS 'ce para a tabela logradouros da cidade residência do autor.';
COMMENT ON COLUMN public.autores.txcomplemento IS 'Texto com o complemento do logradouro de residência do autor (número, andar, etc.)';
COMMENT ON COLUMN public.autores.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.autores.dtnascimento IS 'Data de nascimento do autor';
COMMENT ON COLUMN public.autores.dtcadautor IS 'Data de geração do registro.';


-- Name: autorestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.autorestels (
    cpautortel integer NOT NULL,
    ceautor integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    dtcadautortel date
);
ALTER TABLE public.autorestels OWNER TO postgres;
COMMENT ON TABLE public.autorestels IS 'Registro dos telefones de cada autor de publicação.';
COMMENT ON COLUMN public.autorestels.cpautortel IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.autorestels.ceautor IS 'ce para a tabela autores';
COMMENT ON COLUMN public.autorestels.cetipotelefone IS 'ce para a tabela telefonestipos.';
COMMENT ON COLUMN public.autorestels.nutelefone IS 'Número do telefone (com operadora e DDD - somente os números)';
COMMENT ON COLUMN public.autorestels.dtcadautortel IS 'Data de geração do registro.';


-- Name: autorias; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.autorias (
    cpautoria integer NOT NULL,
    celivro integer NOT NULL,
    ceautor integer NOT NULL,
    dtcadautoria date NOT NULL
);
ALTER TABLE public.autorias OWNER TO postgres;
COMMENT ON TABLE public.autorias IS 'Registro dos autores de um livro. É o desmembramento de um relacionamento N:M. A Chave Primária é composta.';
COMMENT ON COLUMN public.autorias.cpautoria IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.autorias.celivro IS 'Parte de uma CC composta com ceautor, ce apontando para a tabela Livros.';
COMMENT ON COLUMN public.autorias.ceautor IS 'Parte de uma CC composta com celivro, ce apontando para a tabela Autores';
COMMENT ON COLUMN public.autorias.dtcadautoria IS 'Data de geração do registro';


-- Name: bairros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.bairros (
    cpbairro integer NOT NULL,
    txnomebairro character varying(120) NOT NULL,
    cecidade integer NOT NULL,
    dtcadbairro date NOT NULL
);
ALTER TABLE public.bairros OWNER TO postgres;
COMMENT ON TABLE public.bairros IS 'Cadastro dos bairros das cidades.';
COMMENT ON COLUMN public.bairros.cpbairro IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.bairros.txnomebairro IS 'Texto com o nome do bairro da cidade.';
COMMENT ON COLUMN public.bairros.cecidade IS 'ce para a tabela cidades onde se localiza o bairro.';
COMMENT ON COLUMN public.bairros.dtcadbairro IS 'Data de geração do registro.';


-- Name: bairroslogradouros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.bairroslogradouros (
    cpbairrologradouro integer NOT NULL,
    cebairro integer,
    celogradouro integer,
    dtcadbairrologradouro date
);
ALTER TABLE public.bairroslogradouros OWNER TO postgres;
-- COMENTÁRIO DE TABELA: bairroslogradouros; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.bairroslogradouros IS 'Tabela de Ligação entre bairros e logradouros.
A chave candidata é composta pelas chaves estrangeiras importadas.';
COMMENT ON COLUMN public.bairroslogradouros.cpbairrologradouro IS 'cp da tabela';
COMMENT ON COLUMN public.bairroslogradouros.cebairro IS 'ce para a tabela bairros';
COMMENT ON COLUMN public.bairroslogradouros.celogradouro IS 'ce para a tabela logradouros';
COMMENT ON COLUMN public.bairroslogradouros.dtcadbairrologradouro IS 'Data de geração do registro';


-- Name: bancos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.bancos (
    cpbanco character(3) NOT NULL,
    txnomebanco character varying(100) NOT NULL,
    dtfundacao date NOT NULL,
    aocompetencia character(1) NOT NULL,
    celogradourosede integer,
    txcomplemento character varying(50),
    nucepsede character(8),
    nucnpjbanco character(15),
    txsigla character varying(25),
    website character varying(250),
    aosituacao character(1),
    aohistorico character(1),
    qtagencias smallint,
    aocapitalaberto character(1),
    dtcadbanco date NOT NULL
);
ALTER TABLE public.bancos OWNER TO postgres;
COMMENT ON TABLE public.bancos IS 'Cadastro dos bancos do sistema financeiro onde funcionarios podem ter contas.';
COMMENT ON COLUMN public.bancos.cpbanco IS 'cp da tabela. Código do Banco na Federação Brasileira de Bancos.';
COMMENT ON COLUMN public.bancos.txnomebanco IS 'Nome completo do banco (razão social sem abreviações).';
COMMENT ON COLUMN public.bancos.dtfundacao IS 'Data de fundação do banco.';
COMMENT ON COLUMN public.bancos.aocompetencia IS '(F)ederal, (E)stadual, (I)nterestadual, (D)istrital, (P)rivado, (C)ooperativo';
COMMENT ON COLUMN public.bancos.celogradourosede IS 'ce para a tabela logradouros com o código do logradouro da sede do banco.';
COMMENT ON COLUMN public.bancos.txcomplemento IS 'Número do imóvel, localização referencial (outros imóveis próximos).';
COMMENT ON COLUMN public.bancos.nucepsede IS 'Número do CEP';
COMMENT ON COLUMN public.bancos.nucnpjbanco IS 'Número do CNPJ do Banco.';
COMMENT ON COLUMN public.bancos.txsigla IS 'Uma sigla que está associada ao banco.';
COMMENT ON COLUMN public.bancos.website IS 'Endereço do WebSite do banco (se houver).';
COMMENT ON COLUMN public.bancos.aosituacao IS 'Indica se o banco é P-Público, V-Privado, C-Cooperativo, E-Extinto, etc.';
COMMENT ON COLUMN public.bancos.aohistorico IS 'Indica se o Banco está: A-Ativo, C-Comprado, F-Fundido, L-Liquidado, etc.';
COMMENT ON COLUMN public.bancos.qtagencias IS 'Quantidade de agências do banco (estimativo).';
COMMENT ON COLUMN public.bancos.aocapitalaberto IS 'S|N – indicando se banco negocia participação com ações no mercado.';
COMMENT ON COLUMN public.bancos.dtcadbanco IS 'Data de geração do registro';


-- Name: bibliografia; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.bibliografia (
    cpbibliografia integer NOT NULL,
    cedisciplina smallint NOT NULL,
    celivro integer NOT NULL,
    aotipo character(1) NOT NULL,
    dtadocaodolivro date NOT NULL,
    dtcadbibliografia date
);
ALTER TABLE public.bibliografia OWNER TO postgres;
COMMENT ON TABLE public.bibliografia IS 'Registro dos livros da bilbiografia das disciplinas de um curso.É o desmembramento de um N:M. Tem a cp composta.';
COMMENT ON COLUMN public.bibliografia.cpbibliografia IS 'cp da Tabela. Número inteiro sequencial iniciando de 1.';
COMMENT ON COLUMN public.bibliografia.cedisciplina IS 'Parte da  (composta com celivro) e ce para a tabela disciplinas.';
COMMENT ON COLUMN public.bibliografia.celivro IS 'Parte da CC (composta com cedisciplina) e ce para tabela livros.';
COMMENT ON COLUMN public.bibliografia.aotipo IS 'Letra indicando o tipo de bibliografia (B)ásico ou (C)omplementar';
COMMENT ON COLUMN public.bibliografia.dtadocaodolivro IS 'Data que o livro passou a fazer parte da bibliografia da disciplina.';
COMMENT ON COLUMN public.bibliografia.dtcadbibliografia IS 'Data de geração do registro.';

-- Name: capacitacoes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.capacitacoes (
    cpcapacitacao smallint NOT NULL,
    cecurso smallint NOT NULL,
    cefuncionario integer NOT NULL,
    dtcapacitacao date NOT NULL,
    dtregistro date NOT NULL,
    dtcadcapacitacao date NOT NULL,
    nucertificado smallint
);
ALTER TABLE public.capacitacoes OWNER TO postgres;
COMMENT ON TABLE public.capacitacoes IS 'Registro dos cursos concluídos pelos funcionários. É o desmembramento do relacionamento N:M. Tem uma cp composta.';
COMMENT ON COLUMN public.capacitacoes.cpcapacitacao IS 'cp da tabela. Número inteiro sequencial iniciando de 1';
COMMENT ON COLUMN public.capacitacoes.cecurso IS 'Parte da cc (composta com cefuncionario) e ce para a tabela cursos.';
COMMENT ON COLUMN public.capacitacoes.cefuncionario IS 'Parte da cc (composta com cecurso) e ce para a tabela funcionário.';
COMMENT ON COLUMN public.capacitacoes.dtcapacitacao IS 'Data de capacitação do funcionário (quando terminou o curso).';
COMMENT ON COLUMN public.capacitacoes.dtregistro IS 'Data de registro do diploma do funcionário (em órgão público competente).';
COMMENT ON COLUMN public.capacitacoes.dtcadcapacitacao IS 'Data de geração do registro.';
COMMENT ON COLUMN public.capacitacoes.nucertificado IS 'Número do Certificado emitido para o curso concluído.';

-- Name: veiculos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.veiculos (
    cpveiculo smallint NOT NULL,
    ccplaca character(7),
    cetipoveiculo smallint NOT NULL,
    cemodelo smallint DEFAULT NULL::numeric,
    cefuncionario integer,
    aotipocarro character(1),
    txapelido character varying(60),
    qtcapacidade smallint NOT NULL,
    nuanofabricacao character(4) NOT NULL,
    aocategoria character(1),
    dtcadveiculo date NOT NULL
);
ALTER TABLE public.veiculos OWNER TO postgres;
COMMENT ON TABLE public.veiculos IS 'Cadastro de Veículos. É uma superentidade com herança para carros e ônibus.';
COMMENT ON COLUMN public.veiculos.cpveiculo IS 'cp da tabela.';
COMMENT ON COLUMN public.veiculos.ccplaca IS 'Chave Candidata. Placa do veículo (somente letras e números).';
COMMENT ON COLUMN public.veiculos.cetipoveiculo IS 'ce para a tabela veiculotipos (Tipos de Veículos).';
COMMENT ON COLUMN public.veiculos.cemodelo IS 'ce para a tabela veiculosmodelo (Modelos de Veículos).';
COMMENT ON COLUMN public.veiculos.cefuncionario IS 'ce para a tabela funcionarios (funcionário proprietário do carro).';
COMMENT ON COLUMN public.veiculos.aotipocarro IS 'Indica o tipo do veículo do Funcionário (P=Principal e S=Secundário).';
COMMENT ON COLUMN public.veiculos.txapelido IS 'Nome de apelido do ônibus';
COMMENT ON COLUMN public.veiculos.qtcapacidade IS 'Quantidade de acentos no veículo.';
COMMENT ON COLUMN public.veiculos.nuanofabricacao IS 'Ano de fabricação do veículo.';
COMMENT ON COLUMN public.veiculos.aocategoria IS 'C-Carro | O-Ônibus | A-Outro.';
COMMENT ON COLUMN public.veiculos.dtcadveiculo IS 'Data de Geração do Registro';

-- Name: carros; Type: VIEW; Schema: public; Owner: postgres
CREATE VIEW public.carros AS
 SELECT veiculos.cpveiculo AS cpcarro,
    veiculos.ccplaca,
    veiculos.cemodelo,
    veiculos.cefuncionario,
    veiculos.aotipocarro,
    veiculos.qtcapacidade,
    veiculos.nuanofabricacao,
    veiculos.dtcadveiculo AS dtcarro
   FROM public.veiculos
  WHERE (veiculos.aocategoria = 'C'::bpchar);
ALTER TABLE public.carros OWNER TO postgres;

-- Name: cidades; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.cidades (
    cpcidade integer NOT NULL,
    txnomecidade character varying(250) DEFAULT NULL::character varying,
    ceestadodopais character(2),
    txformaacesso text,
    qtpopulacao double precision,
    qtarea double precision,
    dtfundacao date,
    dtcadcidade date NOT NULL
);
ALTER TABLE public.cidades OWNER TO postgres;
COMMENT ON TABLE public.cidades IS 'Cadastro das cidades. A partir delas os bairros e por fim os logradouros.';
COMMENT ON COLUMN public.cidades.cpcidade IS 'cp da Tabela.';
COMMENT ON COLUMN public.cidades.txnomecidade IS 'Nome completo da cidade';
COMMENT ON COLUMN public.cidades.ceestadodopais IS 'ce para tabela estadosdopais (estados, comarcas ou condados de uma união federativa de estados).';
COMMENT ON COLUMN public.cidades.txformaacesso IS 'Descrição das formas de acesso à cidade (hidrovias, estrada, ferrovias, etc).';
COMMENT ON COLUMN public.cidades.qtpopulacao IS 'População estimada';
COMMENT ON COLUMN public.cidades.qtarea IS 'Area total municipal.';
COMMENT ON COLUMN public.cidades.dtfundacao IS 'Data de Fundação da Cidade';
COMMENT ON COLUMN public.cidades.dtcadcidade IS 'Data de Geração do Registro';

-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.clientes (
    cpcliente integer NOT NULL,
    txnomecliente character varying(250) NOT NULL,
    txrazaosocial character varying(250) DEFAULT NULL::character varying,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) NOT NULL,
    vllimitecompra double precision NOT NULL,
    aosituacao character(1),
    dtcadcliente date NOT NULL
);
ALTER TABLE ONLY public.clientes ALTER COLUMN txnomecliente SET STORAGE MAIN;
ALTER TABLE public.clientes OWNER TO postgres;
COMMENT ON TABLE public.clientes IS 'Cadastro dos Clientes de uma empresa.';
COMMENT ON COLUMN public.clientes.cpcliente IS 'cp da Tabela';
COMMENT ON COLUMN public.clientes.txnomecliente IS 'Nome usual completo (sem abreviações) do cliente.';
COMMENT ON COLUMN public.clientes.txrazaosocial IS 'Razão social completa do Cliente.';
COMMENT ON COLUMN public.clientes.celogradouro IS 'ce com o código do logradouro comercial do cliente';
COMMENT ON COLUMN public.clientes.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.clientes.nucep IS 'Número do CEP (somente números)';
COMMENT ON COLUMN public.clientes.vllimitecompra IS 'Valor limite de compra para o cliente';
COMMENT ON COLUMN public.clientes.aosituacao IS 'Atributo Operacional indicando a Situação do Cliente (A-Ativo ou B-Bloqueado).';
COMMENT ON COLUMN public.clientes.dtcadcliente IS 'Data de geração do registro';

-- Name: clientestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.clientestels (
    cpclientetel numeric(5,0) NOT NULL,
    cecliente integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    dtcadclientetel date,
    txnomecontato character varying(50)
);
ALTER TABLE public.clientestels OWNER TO postgres;
COMMENT ON TABLE public.clientestels IS 'Registros dos telefones de cada cliente.';
COMMENT ON COLUMN public.clientestels.cpclientetel IS 'cp da Tabela. Número inteiro sequencial crescente de 1 em 1. ';
COMMENT ON COLUMN public.clientestels.cecliente IS 'ce para a tabela Clientes';
COMMENT ON COLUMN public.clientestels.cetipotelefone IS 'ce para a tabela tipos_telefones';
COMMENT ON COLUMN public.clientestels.nutelefone IS 'Número do telefone (com operadora, DDD e somente os números)';
COMMENT ON COLUMN public.clientestels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.clientestels.dtcadclientetel IS 'Data de geração do registro.';

-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.consultas (
    cpconsulta integer NOT NULL,
    cefuncionario integer,
    cemedico smallint,
    dthoraconsulta timestamp without time zone NOT NULL,
    dthorarealizada timestamp without time zone,
    ceplanodesaude integer NOT NULL,
    aosituacaoconsulta character(1) NOT NULL,
    dtcadconsulta date NOT NULL
);
ALTER TABLE public.consultas OWNER TO postgres;
COMMENT ON TABLE public.consultas IS 'Registros das consultas marcadas para os funcionarios.';
COMMENT ON COLUMN public.consultas.cpconsulta IS 'cp da tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.consultas.cefuncionario IS 'ce para a Tabela funcionarios.';
COMMENT ON COLUMN public.consultas.cemedico IS 'ce para a tabela medicos.';
COMMENT ON COLUMN public.consultas.dthoraconsulta IS 'Data e hora da consulta (programada).';
COMMENT ON COLUMN public.consultas.dthorarealizada IS 'Data e hora da realização da consulta';
COMMENT ON COLUMN public.consultas.ceplanodesaude IS 'ce para a tabela planosdesaude';
COMMENT ON COLUMN public.consultas.aosituacaoconsulta IS 'Atributo Operacional indicando Agendada, Realizada ou Cancelada';
COMMENT ON COLUMN public.consultas.dtcadconsulta IS 'Data de geração do registro';

-- Name: contas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.contas (
    cebanco character(5) NOT NULL,
    ceagencia character(6) NOT NULL,
    cpnuconta character(6) NOT NULL,
    cefuncionario integer,
    dtcadconta date,
    vlsaldo double precision
);
ALTER TABLE public.contas OWNER TO postgres;
COMMENT ON TABLE public.contas IS 'Cadastro das contas bancárias dos funcionarios. A cp desta tabela é composta: cebanco,ceagencia,nuconta.';
COMMENT ON COLUMN public.contas.cebanco IS 'ce apontando para o Banco onde a cpnta existe.';
COMMENT ON COLUMN public.contas.ceagencia IS 'ce apontando para a Agencia (do Banco) onde existe a conta.';
COMMENT ON COLUMN public.contas.cpnuconta IS 'Sequencia que identifica a conta (na agencia do banco). Junto com cebanco e ceagencia forma a cp Composta.';
COMMENT ON COLUMN public.contas.cefuncionario IS 'ce apontando para o Funcionario que é o titular da conta.';
COMMENT ON COLUMN public.contas.dtcadconta IS 'Data de criação do registro.';
COMMENT ON COLUMN public.contas.vlsaldo IS 'Valor do saldo da conta atualizado a cada movimentação de valor.';

-- Name: cores; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.cores (
    cpcor integer NOT NULL,
    txnomecor character varying(250) NOT NULL,
    nupantone integer NOT NULL,
    dtcadcor date NOT NULL
);
ALTER TABLE public.cores OWNER TO postgres;
COMMENT ON TABLE public.cores IS 'Cadastro de cores pantone usados para veículos.';
COMMENT ON COLUMN public.cores.cpcor IS 'cp da Tabela.';
COMMENT ON COLUMN public.cores.txnomecor IS 'Nome completo da cor segundo a tabela Pantone';
COMMENT ON COLUMN public.cores.nupantone IS 'Número Pantone.';
COMMENT ON COLUMN public.cores.dtcadcor IS 'Data de geração do registro';

-- Name: coresveiculos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.coresveiculos (
    cecarro integer NOT NULL,
    cecor integer NOT NULL,
    dtcadcorveiculo date
);
ALTER TABLE public.coresveiculos OWNER TO postgres;
COMMENT ON TABLE public.coresveiculos IS 'Tabela de Ligação entre bairros e logradouros.
A chave primária é composta pelas chaves estrangeiras importadas.';
COMMENT ON COLUMN public.coresveiculos.cecarro IS 'ce para a tabela veiculos (visão -> carros).';
COMMENT ON COLUMN public.coresveiculos.cecor IS 'ce para a tabela cores.';
COMMENT ON COLUMN public.coresveiculos.dtcadcorveiculo IS 'Data de geração do registro.';

-- Name: cursos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.cursos (
    cpcurso integer NOT NULL,
    txnomecurso character varying(250) NOT NULL,
    ceinstituicao smallint,
    qtcargahoraria integer NOT NULL,
    dtcadcurso date NOT NULL
);
ALTER TABLE public.cursos OWNER TO postgres;
COMMENT ON TABLE public.cursos IS 'Cadastro de cursos de uma instituição.';
COMMENT ON COLUMN public.cursos.cpcurso IS 'cp da Tabela';
COMMENT ON COLUMN public.cursos.txnomecurso IS 'Nome completo (sem abreviações).';
COMMENT ON COLUMN public.cursos.ceinstituicao IS 'ce apontando para a tabela Instituições de Ensino.';
COMMENT ON COLUMN public.cursos.qtcargahoraria IS 'Quantidade de Horas na carga horária do curso.';
COMMENT ON COLUMN public.cursos.dtcadcurso IS 'Data de Geração dos Registro.';

-- Name: departamentos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.departamentos (
    cpdepto character(3) NOT NULL,
    txnomedepto character varying(36) NOT NULL,
    cefuncionariogerente integer DEFAULT NULL::numeric,
    cedeptosuperior character(3) DEFAULT NULL::bpchar,
    txlocalizacao character varying(80) DEFAULT NULL::character varying,
    qtareatotal smallint DEFAULT NULL::numeric,
    dtcriacaodepto date,
    dtcaddepartamento date NOT NULL
);
ALTER TABLE public.departamentos OWNER TO postgres;
COMMENT ON TABLE public.departamentos IS 'Cadastro dos departamentos da empresa onde os funcionarios trabalham.';
COMMENT ON COLUMN public.departamentos.cpdepto IS 'cp da Tabela. Sequencia de UMA letra e dois números, informados pelo usuário.';
COMMENT ON COLUMN public.departamentos.txnomedepto IS 'Nome usual completo (sem abreviações)';
COMMENT ON COLUMN public.departamentos.cefuncionariogerente IS 'ce para a tabela funcionarios (gerente do departamento).';
COMMENT ON COLUMN public.departamentos.cedeptosuperior IS 'ce para a tabela departamentos. Código do departamento superior na empresa.';
COMMENT ON COLUMN public.departamentos.txlocalizacao IS 'Descrição da localização do departamento (Bloco, andar, sala,etc)';
COMMENT ON COLUMN public.departamentos.qtareatotal IS 'Quantidade da área ocupada pelo departamento';
COMMENT ON COLUMN public.departamentos.dtcriacaodepto IS 'Data da criação do departamento na empresa';
COMMENT ON COLUMN public.departamentos.dtcaddepartamento IS 'Data de geração do registro.';

-- Name: departamentostels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.departamentostels (
    cpdeptotel integer NOT NULL,
    cedepto character(3) NOT NULL,
    cetelefonetipo smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcaddeptotel date
);
ALTER TABLE public.departamentostels OWNER TO postgres;
COMMENT ON TABLE public.departamentostels IS 'Registro com os telefones de cada departamento.';
COMMENT ON COLUMN public.departamentostels.cpdeptotel IS 'cp da tabela.';
COMMENT ON COLUMN public.departamentostels.cedepto IS 'ce apontando para a tabela Departamentos';
COMMENT ON COLUMN public.departamentostels.cetelefonetipo IS 'ce apontando para a tabela Tipos de Telefones.';
COMMENT ON COLUMN public.departamentostels.nutelefone IS 'Número do telefone com operadora+DDD+número sem traços ou parenteses.';
COMMENT ON COLUMN public.departamentostels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.departamentostels.dtcaddeptotel IS 'Data de geração do registro.';

-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.disciplinas (
    cpdisciplina integer NOT NULL,
    cecurso smallint NOT NULL,
    txnome character varying(250) NOT NULL,
    txementa character varying(250) DEFAULT NULL::character varying,
    qthoras smallint NOT NULL,
    dtcaddisciplina date NOT NULL,
    txcriterioavaliacao character varying(500)
);
ALTER TABLE public.disciplinas OWNER TO postgres;
COMMENT ON TABLE public.disciplinas IS 'Cadastro das disciplinas oferecidas em um curso';
COMMENT ON COLUMN public.disciplinas.cpdisciplina IS 'cp da Tabela';
COMMENT ON COLUMN public.disciplinas.cecurso IS 'ce apontando para a tabela cursos';
COMMENT ON COLUMN public.disciplinas.txnome IS 'Nome completo da Disciplina';
COMMENT ON COLUMN public.disciplinas.txementa IS 'Texto com a ementa disciplinar';
COMMENT ON COLUMN public.disciplinas.qthoras IS 'Quantidade de horas-aulas (de 60 min.) que ocupa e disciplina.';
COMMENT ON COLUMN public.disciplinas.dtcaddisciplina IS 'Data de Geração do registro.';
COMMENT ON COLUMN public.disciplinas.txcriterioavaliacao IS 'Texto com a descrição do critério de avaliação da disciplina.';

-- Name: duplicatas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.duplicatas (
    cpduplicata integer NOT NULL,
    cenfvenda integer NOT NULL,
    dtvencimento date NOT NULL,
    dtpagamento date,
    vlduplicata double precision,
    vldesconto double precision NOT NULL,
    vlliquido double precision NOT NULL,
    vlmulta double precision NOT NULL,
    dtcadduplicata date NOT NULL
);
ALTER TABLE public.duplicatas OWNER TO postgres;
COMMENT ON TABLE public.duplicatas IS 'Cadastro das Duplicatas que devem ser recebidas pelas vendas feitas em uma empresa.';
COMMENT ON COLUMN public.duplicatas.cpduplicata IS 'cp da Tabela';
COMMENT ON COLUMN public.duplicatas.cenfvenda IS 'ce apontando para a Nota Fiscal da qual se gera a Duplicata.';
COMMENT ON COLUMN public.duplicatas.dtvencimento IS 'Data de vencimento da duplicata.';
COMMENT ON COLUMN public.duplicatas.dtpagamento IS 'Data de pagamento da duplicata.';
COMMENT ON COLUMN public.duplicatas.vlduplicata IS 'Valor da Duplicata.';
COMMENT ON COLUMN public.duplicatas.vldesconto IS 'Valor de Desconto.';
COMMENT ON COLUMN public.duplicatas.vlliquido IS 'Valor Líquido da Duplicata.';
COMMENT ON COLUMN public.duplicatas.vlmulta IS 'Valor da Multa.';
COMMENT ON COLUMN public.duplicatas.dtcadduplicata IS 'Data de geração do registro.';

-- Name: editoras; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.editoras (
    cpeditora integer NOT NULL,
    txnomeeditora character(70) NOT NULL,
    txrazaosocial character varying(250) DEFAULT NULL::character varying,
    nucnpj character(16),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    aoporteeditora character(1),
    aoabrangencia character(1),
    dtfundacao date,
    dtcadeditora date NOT NULL
);
ALTER TABLE public.editoras OWNER TO postgres;
COMMENT ON TABLE public.editoras IS 'Cadastro das Editoras de Livros, Revistas e/ou periódicos.';
COMMENT ON COLUMN public.editoras.cpeditora IS 'cp da tabela.';
COMMENT ON COLUMN public.editoras.txnomeeditora IS 'Nome usual da editora (sem abreviações ).';
COMMENT ON COLUMN public.editoras.txrazaosocial IS 'Razão social completa.';
COMMENT ON COLUMN public.editoras.nucnpj IS 'Número do CNPJ da Editora (somente números).';
COMMENT ON COLUMN public.editoras.celogradouro IS 'ce apontando para a tabela Logradouros.';
COMMENT ON COLUMN public.editoras.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.).';
COMMENT ON COLUMN public.editoras.nucep IS 'Número do CEP (somente números)';
COMMENT ON COLUMN public.editoras.aoporteeditora IS 'P|M|G – Porte da editora (Pequena|Média|Grande).';
COMMENT ON COLUMN public.editoras.aoabrangencia IS 'L|E|N|I - Abrangência da editora (Local|Estadual|Nacional|Internacional)';
COMMENT ON COLUMN public.editoras.dtfundacao IS 'Data de fundação da editora.';
COMMENT ON COLUMN public.editoras.dtcadeditora IS 'Data de geração do registro';

-- Name: editorastels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.editorastels (
    cpeditoratel integer NOT NULL,
    ceeditora integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character(30),
    dtcadeditoratel date
);
ALTER TABLE public.editorastels OWNER TO postgres;
COMMENT ON TABLE public.editorastels IS 'Registros de telefones de cada editora.';
COMMENT ON COLUMN public.editorastels.cpeditoratel IS 'cp da Tabela.';
COMMENT ON COLUMN public.editorastels.ceeditora IS 'ce apontando para a Tabela Editoras.';
COMMENT ON COLUMN public.editorastels.cetipotelefone IS 'ce apontando para a tabela tipos_telefones.';
COMMENT ON COLUMN public.editorastels.nutelefone IS 'Número do telefone com operadora+DDD+número sem traços ou parenteses.';
COMMENT ON COLUMN public.editorastels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.editorastels.dtcadeditoratel IS 'Data de geração do registro.';

-- Name: empresas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.empresas (
    cpempresa integer NOT NULL,
    txnomeusual character varying(150) NOT NULL,
    txrazaosocial character varying(250) NOT NULL,
    nucnpj character(16),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    cesetoratuacao integer DEFAULT NULL::numeric,
    aoporteempresa character(1),
    dtfundacao date,
    dtcadempresa date NOT NULL
);
ALTER TABLE public.empresas OWNER TO postgres;
COMMENT ON TABLE public.empresas IS 'Cadastro de empresas onde os funcionarios trabalham ou trabalharam.';
COMMENT ON COLUMN public.empresas.cpempresa IS 'cp da Tabela.';
COMMENT ON COLUMN public.empresas.txnomeusual IS 'Nome usual completo (sem abreviações).';
COMMENT ON COLUMN public.empresas.txrazaosocial IS 'Razão social completa';
COMMENT ON COLUMN public.empresas.nucnpj IS 'Número do CNPJ da Empresa (somente números).';
COMMENT ON COLUMN public.empresas.celogradouro IS 'ce apontando para o logradouro da empresa';
COMMENT ON COLUMN public.empresas.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.empresas.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.empresas.cesetoratuacao IS 'ce apontando  o setor de atuação da empresa.';
COMMENT ON COLUMN public.empresas.aoporteempresa IS 'P|M|G – Porte da empresa (Pequena | Média | Grande).';
COMMENT ON COLUMN public.empresas.dtfundacao IS 'Data de fundação da empresa.';
COMMENT ON COLUMN public.empresas.dtcadempresa IS 'Data de geração do registro.';

-- Name: empresastels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.empresastels (
    cpempresatel integer NOT NULL,
    ceempresa integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadempresatel date
);
ALTER TABLE public.empresastels OWNER TO postgres;
COMMENT ON TABLE public.empresastels IS 'Registros dos telefones de cada empresa.';
COMMENT ON COLUMN public.empresastels.cpempresatel IS 'cp da Tabela.';
COMMENT ON COLUMN public.empresastels.ceempresa IS 'ce apontando para a tabela empresas.';
COMMENT ON COLUMN public.empresastels.cetipotelefone IS 'ce apontando para a tabela Tipos de Telefones';
COMMENT ON COLUMN public.empresastels.nutelefone IS 'Número do telefone (somente os números).';
COMMENT ON COLUMN public.empresastels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.empresastels.dtcadempresatel IS 'Data de Geração do Registro';

-- Name: especialidadesmedicas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.especialidadesmedicas (
    cpespecialidade integer NOT NULL,
    txnomeespecialidade character varying(200) NOT NULL,
    txdescricaoespecialidade text,
    dtcadespecmedica date NOT NULL
);
ALTER TABLE public.especialidadesmedicas OWNER TO postgres;
COMMENT ON TABLE public.especialidadesmedicas IS 'Cadastro das Especialidades Médicas.';
COMMENT ON COLUMN public.especialidadesmedicas.cpespecialidade IS 'cp da Tabela.';
COMMENT ON COLUMN public.especialidadesmedicas.txnomeespecialidade IS 'Nome usual completo (sem abreviações).';
COMMENT ON COLUMN public.especialidadesmedicas.txdescricaoespecialidade IS 'Descrição completa das principais atribuições da especialidade (sem abreviações).';
COMMENT ON COLUMN public.especialidadesmedicas.dtcadespecmedica IS 'Data de geração do registro.';

-- Name: estadosdauniao; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.estadosdauniao (
    cpestadouniao character(2) NOT NULL,
    txnome character varying(250) NOT NULL,
    txnomecapital character varying(250) NOT NULL,
    qtareatotal integer,
    qtcidades smallint,
    qtpopulacao integer,
	cepais character(3),
    dtcadestado date NOT NULL
);
ALTER TABLE public.estadosdauniao OWNER TO postgres;
COMMENT ON TABLE public.estadosdauniao IS 'Cadastro dos Estados da República Federativa do Brasil';
COMMENT ON COLUMN public.estadosdauniao.cpestadouniao IS 'cp da tabela. Sigla do estado da união como identificado no Brasil.';
COMMENT ON COLUMN public.estadosdauniao.txnome IS 'Nome (por extenso) do estado da união.';
COMMENT ON COLUMN public.estadosdauniao.txnomecapital IS 'Nome da Capital do Estado';
COMMENT ON COLUMN public.estadosdauniao.qtareatotal IS 'Área total (em Km2) do estado.';
COMMENT ON COLUMN public.estadosdauniao.qtcidades IS 'Quantidade de Cidades do estado.';
COMMENT ON COLUMN public.estadosdauniao.qtpopulacao IS 'Quantidade de pessoas que residem no estado';
COMMENT ON COLUMN public.estadosdauniao.dtcadestado IS 'Data de Cadastro do Estado.';

-- Name: fabricantes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.fabricantes (
    cpfabricante integer NOT NULL,
    txnome character varying(250) NOT NULL,
    txrazaosocial character varying(250) NOT NULL,
    nucnpj character(16),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    cesetoratuacao smallint,
    aoportefabricante character(1),
    dtfundacao date,
    dtcadfabricante date NOT NULL
);
ALTER TABLE public.fabricantes OWNER TO postgres;
COMMENT ON TABLE public.fabricantes IS 'Cadastro dos Fabricantes.';
COMMENT ON COLUMN public.fabricantes.cpfabricante IS 'cp da tabela.';
COMMENT ON COLUMN public.fabricantes.txnome IS 'Nome usual completo (sem abreviações).';
COMMENT ON COLUMN public.fabricantes.txrazaosocial IS 'Razão social completa.';
COMMENT ON COLUMN public.fabricantes.nucnpj IS 'Número do CNPJ do fabricante (somente números).';
COMMENT ON COLUMN public.fabricantes.celogradouro IS 'ce para a tabela logradouros (logradouro do fabricante).';
COMMENT ON COLUMN public.fabricantes.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.fabricantes.nucep IS 'Número do CEP.';
COMMENT ON COLUMN public.fabricantes.cesetoratuacao IS 'ce apontando  o setor de atuação da fabricante.';
COMMENT ON COLUMN public.fabricantes.aoportefabricante IS 'P|M|G – Porte do fabricante (Pequena | Média | Grande).';
COMMENT ON COLUMN public.fabricantes.dtfundacao IS 'Data de fundação (criação da empresa) do fabricante.';
COMMENT ON COLUMN public.fabricantes.dtcadfabricante IS 'Data de geração do registro.';

-- Name: fabricantestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.fabricantestels (
    cpfabricantetel integer NOT NULL,
    cefabricante integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadfabrictel date
);
ALTER TABLE public.fabricantestels OWNER TO postgres;
COMMENT ON TABLE public.fabricantestels IS 'Registros dos telefones dos fabricantes.';
COMMENT ON COLUMN public.fabricantestels.cpfabricantetel IS 'cp da tabela.';
COMMENT ON COLUMN public.fabricantestels.cefabricante IS 'ce para a tabela fabricantes.';
COMMENT ON COLUMN public.fabricantestels.cetipotelefone IS 'ce para a tabela telefonestipos';
COMMENT ON COLUMN public.fabricantestels.nutelefone IS 'Número do telefone com operadora e DDD (somente os números).';
COMMENT ON COLUMN public.fabricantestels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.fabricantestels.dtcadfabrictel IS 'Data de geração do registro';

-- Name: faturas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.faturas (
    cpfatura integer NOT NULL,
    cenunfcompra integer,
    dtvencimento date,
    dtpagamento date,
    vlfatura double precision NOT NULL,
    vldesconto double precision NOT NULL,
    vlliquido double precision NOT NULL,
    vlmulta double precision NOT NULL,
    dtcadfatura date NOT NULL
);
ALTER TABLE public.faturas OWNER TO postgres;
COMMENT ON TABLE public.faturas IS 'Cadastro das faturas. A partir delas os bairros e por fim os logradouros.';
COMMENT ON COLUMN public.faturas.cpfatura IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.faturas.cenunfcompra IS 'ce apontando para a Nota Fiscal da qual se gera a fatura..';
COMMENT ON COLUMN public.faturas.dtvencimento IS 'Data de vencimento da fatura.';
COMMENT ON COLUMN public.faturas.dtpagamento IS 'Data de pagamento da Fatura.';
COMMENT ON COLUMN public.faturas.vlfatura IS 'Valor da Fatura.';
COMMENT ON COLUMN public.faturas.vldesconto IS 'Valor de Desconto.';
COMMENT ON COLUMN public.faturas.vlliquido IS 'Valor Líquido da Fatura';
COMMENT ON COLUMN public.faturas.vlmulta IS 'Valor da Multa por atraso de pagamento da Fatura.';
COMMENT ON COLUMN public.faturas.dtcadfatura IS 'Data de Geração do Registro';

-- Name: feitospor; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.feitospor (
    cpfeitospor integer NOT NULL,
    ceoficina integer NOT NULL,
    ceservico integer NOT NULL,
    txdescricaocomplementar character varying(250),
    nudiasprevistos smallint,
    dtcadfeitopor date
);
ALTER TABLE public.feitospor OWNER TO postgres;
COMMENT ON TABLE public.feitospor IS 'Registros dos Serviços feitos pelas oficinas.';
COMMENT ON COLUMN public.feitospor.cpfeitospor IS 'cp da tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.feitospor.ceoficina IS 'ce para tabela oficinas (que realiza um serviço).';
COMMENT ON COLUMN public.feitospor.ceservico IS 'ce para tabela serviços (prestados por uma oficina).';
COMMENT ON COLUMN public.feitospor.txdescricaocomplementar IS 'Descrição complementar do serviço prestado (se preciso).';
COMMENT ON COLUMN public.feitospor.nudiasprevistos IS 'Prazo inicialmente previsto para o serviço.';
COMMENT ON COLUMN public.feitospor.dtcadfeitopor IS 'Data de geração do registro.';

-- Name: fornecedores; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.fornecedores (
    cpfornecedor integer NOT NULL,
    txnome character varying(250) DEFAULT NULL::character varying,
    txrazaosocial character varying(250) DEFAULT NULL::character varying,
    nucnpj character(15),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    nusedes numeric(3,0) DEFAULT NULL::numeric,
    vllimitecompra double precision NOT NULL,
    cesetoratuacao smallint,
    aoportefornecedor character(1),
    dtfundacao date,
    dtcadfornecedor date NOT NULL
);
ALTER TABLE public.fornecedores OWNER TO postgres;
COMMENT ON TABLE public.fornecedores IS 'Cadastro dos Fornecedores de uma empresa.';
COMMENT ON COLUMN public.fornecedores.cpfornecedor IS 'cp da tabela.';
COMMENT ON COLUMN public.fornecedores.txnome IS 'Nome usual completo (sem abreviações)';
COMMENT ON COLUMN public.fornecedores.txrazaosocial IS 'Razão social completa.';
COMMENT ON COLUMN public.fornecedores.celogradouro IS 'ce apontando  o logradouro do Fornecedor.';
COMMENT ON COLUMN public.fornecedores.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.fornecedores.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.fornecedores.nusedes IS 'Número de sedes que o fornecedor possui (loja central e filiais).';
COMMENT ON COLUMN public.fornecedores.vllimitecompra IS 'Valor Limite para compra com o Fornecedor.';
COMMENT ON COLUMN public.fornecedores.cesetoratuacao IS 'ce para a tabela setoresdeatuacao (setor de atuação do fornecedor).';
COMMENT ON COLUMN public.fornecedores.aoportefornecedor IS 'P|M|G – Porte do fornecedor (Pequena | Média | Grande).';
COMMENT ON COLUMN public.fornecedores.dtfundacao IS 'Data de fundação do fornecedor.';
COMMENT ON COLUMN public.fornecedores.dtcadfornecedor IS 'Data de geração do registro.';

-- Name: fornecedorestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.fornecedorestels (
    cpfornecedortel integer NOT NULL,
    cefornecedor integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadfornecedortel date
);
ALTER TABLE public.fornecedorestels OWNER TO postgres;
COMMENT ON TABLE public.fornecedorestels IS 'Registro dos Telefones dos fornecedores.';
COMMENT ON COLUMN public.fornecedorestels.cpfornecedortel IS 'cp da tabela.';
COMMENT ON COLUMN public.fornecedorestels.cefornecedor IS 'ce apontando para a tabela fornecedores.';
COMMENT ON COLUMN public.fornecedorestels.cetipotelefone IS 'ce apontando para a tabela tipos_telefones';
COMMENT ON COLUMN public.fornecedorestels.nutelefone IS 'Número do telefone (somente números).';
COMMENT ON COLUMN public.fornecedorestels.txnomecontato IS 'Nomes das pessoas que atendem como contato no telefone.';
COMMENT ON COLUMN public.fornecedorestels.dtcadfornecedortel IS 'Data de geração do registro.';

-- Name: fornecimentos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.fornecimentos (
    cpfornecimento integer NOT NULL,
    ceproduto character(12) DEFAULT (0)::numeric NOT NULL,
    cefornecedor integer NOT NULL,
    dtcadfornecimento date NOT NULL
);
ALTER TABLE public.fornecimentos OWNER TO postgres;
COMMENT ON TABLE public.fornecimentos IS 'Registro com os produtos fornecidos por cada fornecedor.';
COMMENT ON COLUMN public.fornecimentos.cpfornecimento IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.fornecimentos.ceproduto IS 'ce para a tabela produtos. Forma com cefornecedor uma cc.';
COMMENT ON COLUMN public.fornecimentos.cefornecedor IS 'ce para a tabela fornecedores. Forma com ceproduto uma cc.';
COMMENT ON COLUMN public.fornecimentos.dtcadfornecimento IS 'Data de geração do registro.';

-- Name: funcionarios; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.funcionarios (
    cpfuncionario integer NOT NULL,
    txprenomes character varying(40) NOT NULL,
    txsobrenome character varying(20) NOT NULL,
    cedepto character(3) DEFAULT NULL::bpchar,
    cefuncao integer DEFAULT NULL::numeric,
    ceniveleducacao integer DEFAULT NULL::numeric,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nuramal character(4) DEFAULT NULL::bpchar,
    dtcontratacao date,
    aosexo character(1) DEFAULT NULL::bpchar,
    dtnascimento date,
    txresenha text,
    vlsalario double precision DEFAULT NULL::numeric,
    vlbonus double precision DEFAULT NULL::numeric,
    vlcomissao double precision DEFAULT NULL::numeric,
    nucep character(8) NOT NULL,
    dtcadfuncionario date NOT NULL
);
ALTER TABLE public.funcionarios OWNER TO postgres;
COMMENT ON TABLE public.funcionarios IS 'Cadastro dos Funcionários';
COMMENT ON COLUMN public.funcionarios.cpfuncionario IS 'cp da Tabela.';
COMMENT ON COLUMN public.funcionarios.txprenomes IS 'Nomes do funcionário sem abreviações e sem o sobrenome.';
COMMENT ON COLUMN public.funcionarios.txsobrenome IS 'Sobrenome completo (sem abreviações).';
COMMENT ON COLUMN public.funcionarios.cedepto IS 'ce apontando para a tabelas Departamentos.';
COMMENT ON COLUMN public.funcionarios.cefuncao IS 'ce apontando para a tabela Funções.';
COMMENT ON COLUMN public.funcionarios.ceniveleducacao IS 'ce com o código do nível de educação (escolaridade)';
COMMENT ON COLUMN public.funcionarios.celogradouro IS 'ce com o código do Logradouro de moradia do Funcionário.';
COMMENT ON COLUMN public.funcionarios.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.funcionarios.nuramal IS 'Número do ramal telefônico do funcionario.';
COMMENT ON COLUMN public.funcionarios.dtcontratacao IS 'Data de contratação';
COMMENT ON COLUMN public.funcionarios.aosexo IS 'Atributo Operacional indicando o Sexo como Masculino e Feminino.';
COMMENT ON COLUMN public.funcionarios.dtnascimento IS 'Data de nascimento';
COMMENT ON COLUMN public.funcionarios.txresenha IS 'Texto descrevendo a personalidade e dinâmica profissional do funcionário.';
COMMENT ON COLUMN public.funcionarios.vlsalario IS 'Valor do Salário Base do Funcionário.';
COMMENT ON COLUMN public.funcionarios.vlbonus IS 'Valor do Bônus de ganho (se não houver deve ser 0-Zero).';
COMMENT ON COLUMN public.funcionarios.vlcomissao IS 'Valor da comissão (se não houver deve ser 0-Zero).';
COMMENT ON COLUMN public.funcionarios.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.funcionarios.dtcadfuncionario IS 'Data de geração do registro.';

-- Name: funcionariosplanos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.funcionariosplanos (
    cpfuncionarioplano integer NOT NULL,
    cefuncionario integer NOT NULL,
    ceplanodesaude integer NOT NULL,
    dtvinculacao date NOT NULL,
    dtdesligamento date NOT NULL,
    dtcadfuncplano date
);
ALTER TABLE public.funcionariosplanos OWNER TO postgres;
COMMENT ON TABLE public.funcionariosplanos IS 'Registro dos planos de saúde dos funcionários.';
COMMENT ON COLUMN public.funcionariosplanos.cpfuncionarioplano IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.funcionariosplanos.cefuncionario IS 'ce apontando para a tabela funcionarios.';
COMMENT ON COLUMN public.funcionariosplanos.ceplanodesaude IS 'ce apontando para a tabela ';
COMMENT ON COLUMN public.funcionariosplanos.dtvinculacao IS 'Data de vinculação do funcionário ao plano de saúde.';
COMMENT ON COLUMN public.funcionariosplanos.dtdesligamento IS 'Data de desligamento do funcionário ao plano de saúde.';
COMMENT ON COLUMN public.funcionariosplanos.dtcadfuncplano IS 'Data de geração do registro.';

-- Name: funcionariostels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.funcionariostels (
    cpfuncionariotel integer NOT NULL,
    cefuncionario integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadfunctel date
);
ALTER TABLE public.funcionariostels OWNER TO postgres;
COMMENT ON TABLE public.funcionariostels IS 'Registros dos telefones de cada funcionário.';
COMMENT ON COLUMN public.funcionariostels.cpfuncionariotel IS 'cp da Tabela.';
COMMENT ON COLUMN public.funcionariostels.cefuncionario IS 'ce apontando para a tabela funcionarios.';
COMMENT ON COLUMN public.funcionariostels.cetipotelefone IS 'ce apontando para a tabela tipos de telefones.';
COMMENT ON COLUMN public.funcionariostels.nutelefone IS 'Número do telefone (somente números).';
COMMENT ON COLUMN public.funcionariostels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.funcionariostels.dtcadfunctel IS 'Data de geração do registro.';

-- Name: funcoes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.funcoes (
    cpfuncao smallint NOT NULL,
    txnomefuncao character varying(60) NOT NULL,
    txdescricaofuncao text,
    qtanosprefuncao smallint,
    dtcadfuncao date NOT NULL
);
ALTER TABLE public.funcoes OWNER TO postgres;
COMMENT ON TABLE public.funcoes IS 'Cadastro das funções que podem ser exercidas por funcionários.';
COMMENT ON COLUMN public.funcoes.cpfuncao IS 'cp da Tabela';
COMMENT ON COLUMN public.funcoes.txnomefuncao IS 'Nome completo e sem abreviações.';
COMMENT ON COLUMN public.funcoes.txdescricaofuncao IS 'Descrição completa das principais atribuições da função do profissional (sem abreviações)';
COMMENT ON COLUMN public.funcoes.qtanosprefuncao IS 'Quantidade de anos na empresa para assumir a função.';
COMMENT ON COLUMN public.funcoes.dtcadfuncao IS 'Data de Geração do Registro.';

-- Name: grausdeescolaridade; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.grausdeescolaridade (
    cpgrauescolaridade smallint NOT NULL,
    txnomecomum character varying(30) NOT NULL,
    qtanosdeestudo smallint NOT NULL,
    dtcadgrauescolaridade date NOT NULL
);
ALTER TABLE public.grausdeescolaridade OWNER TO postgres;
COMMENT ON TABLE public.grausdeescolaridade IS 'Cadastro dos Níveis de Escolaridade (Educação).';
COMMENT ON COLUMN public.grausdeescolaridade.cpgrauescolaridade IS 'cp da Tabela';
COMMENT ON COLUMN public.grausdeescolaridade.txnomecomum IS 'Nome do nível de educação (sem abreviações).';
COMMENT ON COLUMN public.grausdeescolaridade.qtanosdeestudo IS 'Quantidade de anos de estudo para alcançar o grau de escolaridade.';
COMMENT ON COLUMN public.grausdeescolaridade.dtcadgrauescolaridade IS 'Data de Geração do Registro';

-- Name: habilitacoes; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.habilitacoes (
    cphabilitacao smallint NOT NULL,
    cecurso smallint NOT NULL,
    ceprofessor smallint NOT NULL,
    dthabilitacao date NOT NULL,
    dtcapacitacao date NOT NULL,
    dtcadhabilitacao date NOT NULL
);
ALTER TABLE public.habilitacoes OWNER TO postgres;
COMMENT ON TABLE public.habilitacoes IS 'Registro dos Cursos que cada professor tem habilitação para atuar.';
COMMENT ON COLUMN public.habilitacoes.cphabilitacao IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.habilitacoes.cecurso IS 'Parte da cp e ce indicando o código do curso.';
COMMENT ON COLUMN public.habilitacoes.ceprofessor IS 'Parte da cp e ce indicando o código do professo.';
COMMENT ON COLUMN public.habilitacoes.dthabilitacao IS 'Parte da cp é a Data de habilitação do professor para ministrar a disciplina.';
COMMENT ON COLUMN public.habilitacoes.dtcapacitacao IS 'Data quando o professor conseguiu a capacitação para ministrar a disciplina.';
COMMENT ON COLUMN public.habilitacoes.dtcadhabilitacao IS 'Data de geração do registro';

-- Name: historicoprofissional; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.historicoprofissional (
    cphistorico smallint NOT NULL,
    cefuncionario integer NOT NULL,
    ceempresa smallint DEFAULT NULL::numeric,
    ceatividade smallint NOT NULL,
    dtinicio date NOT NULL,
    dttermino date NOT NULL,
    dtcadhistprof date NOT NULL
);
ALTER TABLE public.historicoprofissional OWNER TO postgres;
COMMENT ON TABLE public.historicoprofissional IS 'Registro do histórico profissional de um funcionário.';
COMMENT ON COLUMN public.historicoprofissional.cphistorico IS 'cp da Tabela';
COMMENT ON COLUMN public.historicoprofissional.cefuncionario IS 'ce para tabela funcionários.';
COMMENT ON COLUMN public.historicoprofissional.ceempresa IS 'ce para tabela empresas.';
COMMENT ON COLUMN public.historicoprofissional.ceatividade IS 'ce para tabela atividades.';
COMMENT ON COLUMN public.historicoprofissional.dtinicio IS 'Data de inicio de atividade do funcionário na empresa (na atividade)';
COMMENT ON COLUMN public.historicoprofissional.dttermino IS 'Data de termino de atividade do funcionário na empresa (na atividade)';
COMMENT ON COLUMN public.historicoprofissional.dtcadhistprof IS 'Data de Geração do Registro';

-- Name: instituicoesdeensino; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.instituicoesdeensino (
    cpinstituicao smallint NOT NULL,
    txnomeinstituicao character varying(200) NOT NULL,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    aotipoinstituicao character(1),
    dtfundacao date,
    nucep character(8) DEFAULT NULL::bpchar,
    dtcadinstituicao date NOT NULL
);
ALTER TABLE public.instituicoesdeensino OWNER TO postgres;
COMMENT ON TABLE public.instituicoesdeensino IS 'Cadastro de Instituições de Ensino.';
COMMENT ON COLUMN public.instituicoesdeensino.cpinstituicao IS 'cp da Tabela.';
COMMENT ON COLUMN public.instituicoesdeensino.txnomeinstituicao IS 'Nome usual completo (sem abreviações)';
COMMENT ON COLUMN public.instituicoesdeensino.celogradouro IS 'ce com o código do logradouro da instituição de ensino.';
COMMENT ON COLUMN public.instituicoesdeensino.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.instituicoesdeensino.aotipoinstituicao IS 'G-pública (Gratuíta) | P-Particular.';
COMMENT ON COLUMN public.instituicoesdeensino.dtfundacao IS 'Data de fundação da instituição de ensino.';
COMMENT ON COLUMN public.instituicoesdeensino.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.instituicoesdeensino.dtcadinstituicao IS 'Data de geração do registro.';

-- Name: instituicoestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.instituicoestels (
    cpinstituicaotel smallint NOT NULL,
    ceinstituicao smallint NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadinstenstel date
);
ALTER TABLE public.instituicoestels OWNER TO postgres;
COMMENT ON TABLE public.instituicoestels IS 'Registros dos telefones das Instituições de Ensino.';
COMMENT ON COLUMN public.instituicoestels.cpinstituicaotel IS 'cp da Tabela';
COMMENT ON COLUMN public.instituicoestels.ceinstituicao IS 'ce para a tabela instituições de ensino.';
COMMENT ON COLUMN public.instituicoestels.cetipotelefone IS 'ce para a tabela tipos_telefones';
COMMENT ON COLUMN public.instituicoestels.nutelefone IS 'Número do telefone (somente números).';
COMMENT ON COLUMN public.instituicoestels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.instituicoestels.dtcadinstenstel IS 'Data de geração do registro.';

-- Name: inventarios; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.inventarios (
    cpinventario smallint NOT NULL,
    ceproduto character(12) DEFAULT (0)::numeric NOT NULL,
    cefuncionario integer DEFAULT (0)::numeric NOT NULL,
    dtinventario date NOT NULL,
    qtestoque real NOT NULL,
    txlocal character varying(250) DEFAULT NULL::character varying,
    dtcadinventario date NOT NULL
);
ALTER TABLE public.inventarios OWNER TO postgres;
COMMENT ON TABLE public.inventarios IS 'Cadastro com o levantamento de itens de estoque feitos pelos funcionários.';
COMMENT ON COLUMN public.inventarios.cpinventario IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.inventarios.ceproduto IS 'Parte da cp e ce apontando para a tabela Produtos.';
COMMENT ON COLUMN public.inventarios.cefuncionario IS 'Parte da cp e ce apontando para a tabela Funcionários.';
COMMENT ON COLUMN public.inventarios.dtinventario IS 'Parte da cp é a Data de realização do inventário de estoque.';
COMMENT ON COLUMN public.inventarios.qtestoque IS 'Quantidade contabilizada do item de produto.';
COMMENT ON COLUMN public.inventarios.txlocal IS 'Local de realização do Inventário';
COMMENT ON COLUMN public.inventarios.dtcadinventario IS 'Data de geração do registro.';

-- Name: livros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.livros (
    cplivro integer NOT NULL,
    txtituloacervo character varying(90) NOT NULL,
    nuisbn bigint,
    ceeditora integer DEFAULT NULL::numeric,
    dtpublicacao date,
    nuanopublicacao character(4) DEFAULT NULL::bpchar,
    qtpaginas smallint,
    qtexemplaresacervo smallint DEFAULT NULL::numeric,
    qtexemplaresconsulta numeric(2,0) DEFAULT NULL::numeric,
    dtcadlivro date NOT NULL
);
ALTER TABLE public.livros OWNER TO postgres;
COMMENT ON TABLE public.livros IS 'Cadastro dos Livros que podem ser usados em bibliografias de disciplinas.';
COMMENT ON COLUMN public.livros.cplivro IS 'cp da Tabela';
COMMENT ON COLUMN public.livros.txtituloacervo IS 'Texto com o título do acervo';
COMMENT ON COLUMN public.livros.nuisbn IS 'Número do ISBN (International Standard Book Number)';
COMMENT ON COLUMN public.livros.ceeditora IS 'ce com o código da editora que publicou o livro.';
COMMENT ON COLUMN public.livros.dtpublicacao IS 'Data de publicação do Livro';
COMMENT ON COLUMN public.livros.nuanopublicacao IS 'Ano de Publicação do Livro';
COMMENT ON COLUMN public.livros.qtpaginas IS 'Quantidade de páginas que tem o livro (sem contar capa e contracapa.';
COMMENT ON COLUMN public.livros.qtexemplaresacervo IS 'Quantidade total do livro no acervo, é alterada no movimento de retirada';
COMMENT ON COLUMN public.livros.qtexemplaresconsulta IS 'Quantidade mínima (em consulta) para o livro no acervo';
COMMENT ON COLUMN public.livros.dtcadlivro IS 'Data de Geração do Registro';

-- Name: logradouros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.logradouros (
    cplogradouro integer NOT NULL,
    txnomelogradouro character varying(120) NOT NULL,
    cecidade integer,
    celogradourotipo integer DEFAULT NULL::numeric,
    aotipodepiso character(1),
    dtcadlogradouro date NOT NULL
);
ALTER TABLE public.logradouros OWNER TO postgres;
COMMENT ON TABLE public.logradouros IS 'Cadastro dos logradouros.';
COMMENT ON COLUMN public.logradouros.cplogradouro IS 'cp da Tabela';
COMMENT ON COLUMN public.logradouros.txnomelogradouro IS 'Texto com o nome do logradouro com o tipo (praça, rua, etc.) indicado.';
COMMENT ON COLUMN public.logradouros.cecidade IS 'ce para a tabela de Cidades.';
COMMENT ON COLUMN public.logradouros.celogradourotipo IS 'ce para a tabela de Bairros.';
COMMENT ON COLUMN public.logradouros.dtcadlogradouro IS 'Data de geração do registro';

-- Name: logradourostipos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.logradourostipos (
    cplogradourotipo smallint NOT NULL,
    txnometipologradouro character varying(250) NOT NULL,
    dtcadtipologradouro date NOT NULL
);
ALTER TABLE public.logradourostipos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: logradourostipos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.logradourostipos IS 'Cadastro dos tipo de logradouros';
COMMENT ON COLUMN public.logradourostipos.cplogradourotipo IS 'cp da Tabela';
COMMENT ON COLUMN public.logradourostipos.txnometipologradouro IS 'Texto com o nome do TIPO logradouro com o tipo (praça, rua, etc.).';
COMMENT ON COLUMN public.logradourostipos.dtcadtipologradouro IS 'Data de geração do registro';

-- Name: logrcompleto; Type: VIEW; Schema: public; Owner: postgres
CREATE VIEW public.logrcompleto AS
 SELECT logradouros.cplogradouro,
    concat(logradourostipos.txnometipologradouro, ' ', logradouros.txnomelogradouro) AS txlogrcompleto,
    logradouros.cecidade,
    logradouros.aotipodepiso,
    logradouros.dtcadlogradouro
   FROM (public.logradouros
     JOIN public.logradourostipos ON ((logradouros.celogradourotipo = logradourostipos.cplogradourotipo)))
  ORDER BY logradouros.cplogradouro;
ALTER TABLE public.logrcompleto OWNER TO postgres;

-- Name: VIEW logrcompleto; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON VIEW public.logrcompleto IS 'Concatenação de dados das tabelas logradouros e logradourostipos';

-- Name: matriculas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.matriculas (
    cpmatricula integer NOT NULL,
    ceturma integer NOT NULL,
    cefuncionario integer NOT NULL,
    dtmatricula date NOT NULL,
    dtvalidade date NOT NULL,
    dtcadmatricula date NOT NULL
);
ALTER TABLE public.matriculas OWNER TO postgres;
COMMENT ON TABLE public.matriculas IS 'Cadastro das matrículas dos funcionários em disciplinas que foram atribuídas aos professores. Tem uma chave primária simples, sequencial.';
COMMENT ON COLUMN public.matriculas.cpmatricula IS 'cp da Tabela.';
COMMENT ON COLUMN public.matriculas.ceturma IS 'ce para a tabela turmas (que relaciona professores com disciplinas em um determinado SEMESTRE).';
COMMENT ON COLUMN public.matriculas.cefuncionario IS 'ce com o código do funcionario.';
COMMENT ON COLUMN public.matriculas.dtmatricula IS 'Data de Matrícula';
COMMENT ON COLUMN public.matriculas.dtvalidade IS 'Data de Validade da Matrícula (duração do vinculo funcionário-disciplina).';
COMMENT ON COLUMN public.matriculas.dtcadmatricula IS 'Data de geração do registro.';

-- Name: medicos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.medicos (
    cpmedico integer NOT NULL,
    txnomemedico character varying(200) NOT NULL,
    nucrm integer NOT NULL,
    ceespecialidade smallint NOT NULL,
    ceinstituicao smallint,
    celogradouromoradia integer DEFAULT NULL::numeric,
    txcomplementomoradia character varying(50) DEFAULT NULL::character varying,
    nucepmoradia character(8),
    celogradouroclinica integer DEFAULT NULL::numeric,
    txcomplementoclinica character varying(50) DEFAULT NULL::character varying,
    nucepclinica character(8),
    aosituacao character(1),
    dtcadmedico date NOT NULL
);
-- lista de campos para comando insert: 
-- (cpmedico,txnomemedico,nucrm,ceespecialidade,ceinstituicao,celogradouromoradia,txcomplementomoradia,celogradouroclinica,txcomplementoclinica,aosituacao,dtcadmedico,nucepmoradia,nucepclinica)
ALTER TABLE public.medicos OWNER TO postgres;
COMMENT ON TABLE public.medicos IS 'Cadastro de médicos.';
COMMENT ON COLUMN public.medicos.cpmedico IS 'cp da Tabela';
COMMENT ON COLUMN public.medicos.txnomemedico IS 'Nome completo e sem abreviação';
COMMENT ON COLUMN public.medicos.nucrm IS 'Número do registro do médico no Conselho Regional dos médicos.';
COMMENT ON COLUMN public.medicos.ceespecialidade IS 'ce com o código da especialidade médica';
COMMENT ON COLUMN public.medicos.ceinstituicao IS 'ce com o código da instituição de ensino onde o médico se formou.';
COMMENT ON COLUMN public.medicos.celogradouromoradia IS 'ce com o código do Logradouro de moradia do Médico';
COMMENT ON COLUMN public.medicos.txcomplementomoradia IS 'Texto com o complemento do logradouro de moradia do médico (número, andar, etc.)';
COMMENT ON COLUMN public.medicos.celogradouroclinica IS 'ce com o código do Logradouro da Clínica Principal do Médico.';
COMMENT ON COLUMN public.medicos.txcomplementoclinica IS 'Texto com o complemento do logradouro da clínica do médico (número, andar, etc.)';
COMMENT ON COLUMN public.medicos.aosituacao IS 'Atributo operacional com valor A | D (Ativo | Desligado)';
COMMENT ON COLUMN public.medicos.dtcadmedico IS 'Data de geração do registro';
COMMENT ON COLUMN public.medicos.nucepmoradia IS 'Número do CEP do Logradouro da Moradia do médico (somente números)';
COMMENT ON COLUMN public.medicos.nucepclinica IS 'Número do CEP do logradouro da clínica onde trabalhar o médico. Somente números.';

-- Name: movimentos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.movimentos (
    cpmovimento integer NOT NULL,
    celivro integer DEFAULT NULL::numeric,
    cefuncionario integer DEFAULT NULL::numeric,
    dtmovimento date,
    cetipomovimento smallint DEFAULT NULL::numeric,
    dtprevistadevolucao date,
    dtrealdevolucao date,
    dtcadmovimento date NOT NULL
);
ALTER TABLE public.movimentos OWNER TO postgres;
COMMENT ON TABLE public.movimentos IS 'Registro de movimentos de livros realizados pelos funcionários.';
COMMENT ON COLUMN public.movimentos.cpmovimento IS 'cp da Tabela.';
COMMENT ON COLUMN public.movimentos.celivro IS 'ce para a tabela livros (registrado no movimento).';
COMMENT ON COLUMN public.movimentos.cefuncionario IS 'ce para a tabela funcionarios (que faz o movimento).';
COMMENT ON COLUMN public.movimentos.dtmovimento IS 'Data de realização do movimento';
COMMENT ON COLUMN public.movimentos.cetipomovimento IS 'ce para a tabela movimentotipos.';
COMMENT ON COLUMN public.movimentos.dtprevistadevolucao IS 'Data prevista de devolução do livro';
COMMENT ON COLUMN public.movimentos.dtrealdevolucao IS 'Data real da devolução';
COMMENT ON COLUMN public.movimentos.dtcadmovimento IS 'Data de Geração do Registro.';

-- Name: movimentostipos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.movimentostipos (
    cptipomovimento smallint NOT NULL,
    txnometipomov character varying(80) NOT NULL,
    aopermiteretirada character(1) NOT NULL,
    dtcadmovimtipo date NOT NULL
);
ALTER TABLE public.movimentostipos OWNER TO postgres;
COMMENT ON TABLE public.movimentostipos IS 'Cadastro dos tipos de movimentos.';
COMMENT ON COLUMN public.movimentostipos.cptipomovimento IS 'cp da Tabela.';
COMMENT ON COLUMN public.movimentostipos.txnometipomov IS 'Nome do tipo de movimento (sem abreviações).';
COMMENT ON COLUMN public.movimentostipos.aopermiteretirada IS 'S|N para “permite” ou “não permite” retirada do exemplo do espaço da biblioteca. biblioteca.';
COMMENT ON COLUMN public.movimentostipos.dtcadmovimtipo IS 'Data de Geração do Registro';

-- Name: nfcompras; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.nfcompras (
    cpnunfcompra integer NOT NULL,
    cefornecedor integer,
    cefuncionario integer DEFAULT NULL::numeric,
    dtnfcompra date,
    vltotalnfcompra double precision,
    aosituacao character(1) DEFAULT NULL::bpchar,
    txcomentarios character varying(1000) DEFAULT NULL::character varying,
    dtcadnfcompra date NOT NULL
);
ALTER TABLE public.nfcompras OWNER TO postgres;
COMMENT ON TABLE public.nfcompras IS 'Cadastro das Notas Fiscais de Compras. É a entidade forte entre nf_compras e nf_compras_itens.';
COMMENT ON COLUMN public.nfcompras.cpnunfcompra IS 'cp da Tabela.';
COMMENT ON COLUMN public.nfcompras.cefornecedor IS 'ce com o código do fornecedor da Nota de Compra';
COMMENT ON COLUMN public.nfcompras.cefuncionario IS 'ce com o código do funcionário.';
COMMENT ON COLUMN public.nfcompras.dtnfcompra IS 'Data de realização da venda que gera a nota de venda.';
COMMENT ON COLUMN public.nfcompras.vltotalnfcompra IS 'Valor total da Nota de Compra';
COMMENT ON COLUMN public.nfcompras.aosituacao IS 'Indicador da situação da Nota como "A" (a pagar) ou "P" (paga).';
COMMENT ON COLUMN public.nfcompras.txcomentarios IS 'Comentário geral sobre a Nota de Compra';
COMMENT ON COLUMN public.nfcompras.dtcadnfcompra IS 'Data de Geração do Registro';

-- Name: nfcomprasitens; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.nfcomprasitens (
    cenunfcompra integer NOT NULL,
    ceproduto character(12) DEFAULT (0)::numeric NOT NULL,
    qtcomprada numeric(5,0) NOT NULL,
    vlunitario double precision NOT NULL
);
ALTER TABLE public.nfcomprasitens OWNER TO postgres;
COMMENT ON TABLE public.nfcomprasitens IS 'Cadastro das Notas Fiscais de Compras. É a entidade fraca entre nf_compras e nf_compras_itens.';
COMMENT ON COLUMN public.nfcomprasitens.cenunfcompra IS 'Parte da cp e ce com o código da nota fiscal de venda';
COMMENT ON COLUMN public.nfcomprasitens.ceproduto IS 'Parte da cp e ce apontando para a tabela Produtos.';
COMMENT ON COLUMN public.nfcomprasitens.qtcomprada IS 'Quantidade de produto vendida';
COMMENT ON COLUMN public.nfcomprasitens.vlunitario IS 'Valor unitário do produto na Nota de venda (pode ser ? do valor do estoque)';

-- Name: nfvendas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.nfvendas (
    cpnunfvenda integer NOT NULL,
    cecliente integer DEFAULT NULL::numeric,
    cefuncionario integer DEFAULT NULL::numeric,
    cearmazem smallint DEFAULT NULL::numeric,
    vltotalnfvenda double precision,
    dtvenda date DEFAULT '2014-04-25'::date NOT NULL,
    dtemissao date NOT NULL,
    dtcadnfvenda date NOT NULL
);
ALTER TABLE public.nfvendas OWNER TO postgres;
COMMENT ON TABLE public.nfvendas IS 'Cadastro das Notas Fiscais de Vendas. É a entidade forte entre nf_vendas e nf_vendas_itens.';
COMMENT ON COLUMN public.nfvendas.cpnunfvenda IS 'cp da Tabela.';
COMMENT ON COLUMN public.nfvendas.cecliente IS 'ce para a tabela clientes (para o qual se faz a venda).';
COMMENT ON COLUMN public.nfvendas.cefuncionario IS 'ce para a tabela funcionarios.';
COMMENT ON COLUMN public.nfvendas.cearmazem IS 'ce para a tabela armazens.';
COMMENT ON COLUMN public.nfvendas.vltotalnfvenda IS 'Valor total da nota fiscal de venda.';
COMMENT ON COLUMN public.nfvendas.dtvenda IS 'Data de realização da venda que gera a nota de venda.';
COMMENT ON COLUMN public.nfvendas.dtemissao IS 'Data de emissão da nota de venda.';
COMMENT ON COLUMN public.nfvendas.dtcadnfvenda IS 'Data de Geração do Registfro.';

-- Name: nfvendasitens; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.nfvendasitens (
    cenunfvenda integer NOT NULL,
    ceproduto character(12) DEFAULT (0)::numeric NOT NULL,
    qtvendida integer NOT NULL,
    vlunitario double precision NOT NULL
);
ALTER TABLE public.nfvendasitens OWNER TO postgres;
COMMENT ON TABLE public.nfvendasitens IS 'Cadastro das Notas Fiscais de Vendas. É a entidade fraca entre nf_vendas e nf_vendas_itens.';
COMMENT ON COLUMN public.nfvendasitens.cenunfvenda IS 'Parte da cp e ce com o código da nota fiscal de venda';
COMMENT ON COLUMN public.nfvendasitens.ceproduto IS 'Parte da cp e ce apontando para a tabela Produtos.';
COMMENT ON COLUMN public.nfvendasitens.qtvendida IS 'Quantidade de produto vendida';
COMMENT ON COLUMN public.nfvendasitens.vlunitario IS 'Valor unitário do produto na Nota de venda (pode ser ? do valor do estoque)';

-- Name: ocorrencias; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.ocorrencias (
    cpocorrencia integer NOT NULL,
    cesinistro integer NOT NULL,
    ceveiculo integer NOT NULL,
    cenumeroapolice integer NOT NULL,
    celogradouroprincipal integer NOT NULL,
    celogradourosecundario integer,
    txlogradouroocorrencia character varying(250) NOT NULL,
    dtcadocorrencia date NOT NULL
);
ALTER TABLE public.ocorrencias OWNER TO postgres;
COMMENT ON TABLE public.ocorrencias IS 'Registros da ocorrência de Sinistros nos veículos segurados de uma seguradora.';
COMMENT ON COLUMN public.ocorrencias.cpocorrencia IS 'cp da Tabela.';
COMMENT ON COLUMN public.ocorrencias.cesinistro IS 'ce indicando o código do sinistro';
COMMENT ON COLUMN public.ocorrencias.ceveiculo IS 'ce indicando o código do veículo que sofreu o sinistro';
COMMENT ON COLUMN public.ocorrencias.cenumeroapolice IS 'ce para a tabela seguros (que cobre o sinistro do veículo).';
COMMENT ON COLUMN public.ocorrencias.celogradouroprincipal IS 'ce com o código do Logradouro principal da ocorrência do sinistro.';
COMMENT ON COLUMN public.ocorrencias.celogradourosecundario IS 'ce com o código do Logradouro secundário da ocorrência do sinistro';
COMMENT ON COLUMN public.ocorrencias.txlogradouroocorrencia IS 'Texto descrevendo os logradouros e localidade da ocorrência do sinistro.';
COMMENT ON COLUMN public.ocorrencias.dtcadocorrencia IS 'Data de geração do registro';

-- Name: oficinas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.oficinas (
    cpoficina integer NOT NULL,
    txrazaosocial character varying(100) NOT NULL,
    nucnpj character(14),
    txapelido character varying(30),
    celogradouro integer,
    dtfundacao date,
    dtcadoficina date
);
ALTER TABLE public.oficinas OWNER TO postgres;
COMMENT ON TABLE public.oficinas IS 'Cadastro das Oficinas que prestam serviços para reparos em veículos.';
COMMENT ON COLUMN public.oficinas.cpoficina IS 'cp da Tabela';
COMMENT ON COLUMN public.oficinas.txrazaosocial IS 'Razão Social completa da Oficina segundo o cadastro do CNPJ';
COMMENT ON COLUMN public.oficinas.nucnpj IS 'Número do CNPJ (Cadastro Nacional de Pessoas Jurídicas)';
COMMENT ON COLUMN public.oficinas.txapelido IS 'Nome de apelido da Oficina';
COMMENT ON COLUMN public.oficinas.celogradouro IS 'ce com o código do Logradouro da Oficina.';
COMMENT ON COLUMN public.oficinas.dtfundacao IS 'Data de fundação ou criação da oficina.';
COMMENT ON COLUMN public.oficinas.dtcadoficina IS 'Data de geração do registro';

-- Name: oficinastels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.oficinastels (
    cpoficinatel integer NOT NULL,
    ceoficina integer NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadoficinatel date
);
ALTER TABLE public.oficinastels OWNER TO postgres;
COMMENT ON TABLE public.oficinastels IS 'Registro dos Telefones das oficinas.';
COMMENT ON COLUMN public.oficinastels.cpoficinatel IS 'cp da tabela.';
COMMENT ON COLUMN public.oficinastels.ceoficina IS 'ce apontando para a tabela oficinas.';
COMMENT ON COLUMN public.oficinastels.cetipotelefone IS 'ce apontando para a tabela telefonestipos';
COMMENT ON COLUMN public.oficinastels.nutelefone IS 'Número do telefone (somente números).';
COMMENT ON COLUMN public.oficinastels.txnomecontato IS 'Nomes das pessoas que atendem como contato no telefone.';
COMMENT ON COLUMN public.oficinastels.dtcadoficinatel IS 'Data de geração do registro.';

-- Name: onibus; Type: VIEW; Schema: public; Owner: postgres
CREATE VIEW public.onibus WITH (security_barrier='false') AS
 SELECT veiculos.cpveiculo AS cponibus,
    veiculos.ccplaca,
    veiculos.cemodelo,
    veiculos.txapelido,
    veiculos.qtcapacidade,
    veiculos.nuanofabricacao,
    veiculos.dtcadveiculo AS dtcadonibus
   FROM public.veiculos
  WHERE (veiculos.aocategoria = 'O'::bpchar);
ALTER TABLE public.onibus OWNER TO postgres;

-- Name: paises; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.paises (
    cppais character(3) NOT NULL,
    txnomepais character varying(200) NOT NULL,
    txnomecapital character varying(200) DEFAULT NULL::numeric,
    vlarea double precision,
    dtcadpais date
);
ALTER TABLE public.paises OWNER TO postgres;
COMMENT ON TABLE public.paises IS 'Paises existentes no mundo (ONU).';
COMMENT ON COLUMN public.paises.cppais IS 'cp da tabela.';
COMMENT ON COLUMN public.paises.txnomepais IS 'Nome completo do país (registrado na ONU).';
COMMENT ON COLUMN public.paises.txnomecapital IS 'Nome da cidade capital do país';
COMMENT ON COLUMN public.paises.vlarea IS 'Área do país em Kilometro quadrado.';
COMMENT ON COLUMN public.paises.dtcadpais IS 'Data de geração do registro.';

-- Name: palavraschaves; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.palavraschaves (
    cppalavra integer NOT NULL,
    txnomepalavra character varying(30) NOT NULL,
    dtcadpalavrachave date NOT NULL
);
ALTER TABLE public.palavraschaves OWNER TO postgres;
-- COMENTÁRIO DE TABELA: palavraschaves; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.palavraschaves IS 'Cadastro das palavras-chaves para pesquisa por palavras de exemplares de um acervo de uma biblioteca.';
COMMENT ON COLUMN public.palavraschaves.cppalavra IS 'cp da Tabela.';
COMMENT ON COLUMN public.palavraschaves.txnomepalavra IS 'Palavra-chave de pesquisa complete e se abreviações';
COMMENT ON COLUMN public.palavraschaves.dtcadpalavrachave IS 'Data de Geração do Registro';

-- Name: palavraslivros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.palavraslivros (
    cepalavra integer NOT NULL,
    celivro integer NOT NULL,
    dtcadpalchavelivro date NOT NULL
);
ALTER TABLE public.palavraslivros OWNER TO postgres;
-- COMENTÁRIO DE TABELA: palavraslivros; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.palavraslivros IS 'Registro das palavras-chaves de cada exemplar de um acervo.';
COMMENT ON COLUMN public.palavraslivros.cepalavra IS 'Parte da cp e ce com o código da Palavra-Chave de Pesquisa';
COMMENT ON COLUMN public.palavraslivros.celivro IS 'Parte da cp e ce com o código do livro';
COMMENT ON COLUMN public.palavraslivros.dtcadpalchavelivro IS 'Data de geração do registro';

-- Name: passagens; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.passagens (
    cppassagem integer NOT NULL,
    ceviagem integer NOT NULL,
    ceonibus smallint NOT NULL,
    nupoltrona integer NOT NULL,
    cefuncionario integer DEFAULT NULL::numeric,
    dtcadpassagem date
);
ALTER TABLE public.passagens OWNER TO postgres;
-- COMENTÁRIO DE TABELA: passagens; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.passagens IS 'Cadastro das passagens vendidas para funcionários em cada ônibus para cada viagem.';
COMMENT ON COLUMN public.passagens.cppassagem IS 'cp da tabela.';
COMMENT ON COLUMN public.passagens.ceviagem IS 'ce com o código da viagem para o qual se vende a passagem';
COMMENT ON COLUMN public.passagens.ceonibus IS 'ce com o código do ônibus para o qual se vende a passagem';
COMMENT ON COLUMN public.passagens.nupoltrona IS 'Indica o número da poltrona do ônibus que é alocada na venda da passagem';
COMMENT ON COLUMN public.passagens.cefuncionario IS 'ce com o código do funcionário que compra a passagem.';
COMMENT ON COLUMN public.passagens.dtcadpassagem IS 'Data de geração do registro';

-- Name: planosdesaude; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.planosdesaude (
    cpplanodesaude integer NOT NULL,
    txnomeplano character varying(200) NOT NULL,
    txrazaosocial character varying(250) DEFAULT NULL::character varying,
    nucnpj character(15),
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    dtcadplanosaude date NOT NULL
);
ALTER TABLE public.planosdesaude OWNER TO postgres;
-- COMENTÁRIO DE TABELA: planosdesaude; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.planosdesaude IS 'Cadastro dos planos de saúde.';
COMMENT ON COLUMN public.planosdesaude.cpplanodesaude IS 'cp da Tabela';
COMMENT ON COLUMN public.planosdesaude.txnomeplano IS 'Nome completo e usual para o plano de saúde';
COMMENT ON COLUMN public.planosdesaude.txrazaosocial IS 'Razão social completa.';
COMMENT ON COLUMN public.planosdesaude.celogradouro IS 'ce com o código do logradouro do escritório do Plano de Saúde.';
COMMENT ON COLUMN public.planosdesaude.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.planosdesaude.nucep IS 'Número do CEP';
COMMENT ON COLUMN public.planosdesaude.dtcadplanosaude IS 'Data de Geração do Registro';

-- Name: planostels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.planostels (
    cpplanostel smallint NOT NULL,
    ceplanodesaude smallint NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadplanotel date
);
ALTER TABLE public.planostels OWNER TO postgres;
-- COMENTÁRIO DE TABELA: planostels; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.planostels IS 'Registro dos telefones de cada Plano de Saúde.';
COMMENT ON COLUMN public.planostels.cpplanostel IS 'cp da Tabela';
COMMENT ON COLUMN public.planostels.ceplanodesaude IS 'ce para a tabela planos de saúde';
COMMENT ON COLUMN public.planostels.cetipotelefone IS 'ce para a tabela tipos_telefones';
COMMENT ON COLUMN public.planostels.nutelefone IS 'Número do telefone (somente os números)';
COMMENT ON COLUMN public.planostels.txnomecontato IS 'Nome de uma pessoa que atende como contato no telefone.';
COMMENT ON COLUMN public.planostels.dtcadplanotel IS 'Data de geração do registro';

-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.produtos (
    cpproduto character(12) NOT NULL,
    txnome character varying(128) DEFAULT NULL::character varying,
    vlpreco numeric(12,2) DEFAULT NULL::numeric,
    vlprecopromocao numeric(12,2) DEFAULT NULL::numeric,
    vlprecominimo numeric(12,2),
    qtestoque numeric(7,2),
    qtdiaspromocao smallint DEFAULT NULL::numeric,
    txdescricaocompleta character varying(2000) DEFAULT NULL::character varying,
    dtcadproduto date NOT NULL
);
ALTER TABLE public.produtos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: produtos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.produtos IS 'Cadastro dos produtos que são feitos e vendidos pela empresa onde o funcionário trabalha.';
COMMENT ON COLUMN public.produtos.cpproduto IS 'cp da Tabela';
COMMENT ON COLUMN public.produtos.txnome IS 'Nome completo e usual';
COMMENT ON COLUMN public.produtos.vlpreco IS 'Valor do preço';
COMMENT ON COLUMN public.produtos.vlprecopromocao IS 'Valor do preço de venda para promoção (com desconto máximo)';
COMMENT ON COLUMN public.produtos.vlprecominimo IS 'Valor do preço mínimo (contabilizando os custos de produção)';
COMMENT ON COLUMN public.produtos.qtestoque IS 'Quantidade do produto em estoque (até 99999.99)';
COMMENT ON COLUMN public.produtos.qtdiaspromocao IS 'Quant. De dias para execução de uma promoção do produto';
COMMENT ON COLUMN public.produtos.txdescricaocompleta IS 'Texto com a descrição complete do produto.';
COMMENT ON COLUMN public.produtos.dtcadproduto IS 'Data de geração do registro';

-- Name: professores; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.professores (
    cpprofessor smallint NOT NULL,
    txnomeprofessor character varying(250) NOT NULL,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    dtnascimento date,
    dtcadprofessor date
);
ALTER TABLE public.professores OWNER TO postgres;
-- COMENTÁRIO DE TABELA: professores; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.professores IS 'Professores de uma Instituição de ensino';
COMMENT ON COLUMN public.professores.cpprofessor IS 'cp da tabela.';
COMMENT ON COLUMN public.professores.txnomeprofessor IS 'Nome completo e sem abreviações';
COMMENT ON COLUMN public.professores.celogradouro IS 'ce com o código do Logradouro de residência do Professor.';
COMMENT ON COLUMN public.professores.txcomplemento IS 'Texto com o complemento do logradouro comercial do cliente (número, andar, etc.)';
COMMENT ON COLUMN public.professores.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.professores.dtnascimento IS 'Data de Nascimento';
COMMENT ON COLUMN public.professores.dtcadprofessor IS 'Data de geração do registro';

-- Name: professorestels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.professorestels (
    cpprofessortel integer NOT NULL,
    ceprofessor smallint NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    dtcadprofessortel date
);
ALTER TABLE public.professorestels OWNER TO postgres;
-- COMENTÁRIO DE TABELA: professorestels; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.professorestels IS 'Registro dos telefones de cada professor.';
COMMENT ON COLUMN public.professorestels.cpprofessortel IS 'cp da tabela.';
COMMENT ON COLUMN public.professorestels.ceprofessor IS 'ce para a tabela professores';
COMMENT ON COLUMN public.professorestels.cetipotelefone IS 'ce para a tabela tipos_telefones';
COMMENT ON COLUMN public.professorestels.nutelefone IS 'Número do telefone (somente os números)';
COMMENT ON COLUMN public.professorestels.dtcadprofessortel IS 'DAta de geração do registro';

-- Name: projetos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.projetos (
    cpprojeto character(6) NOT NULL,
    txnomeprojeto character varying(90) DEFAULT ''::character varying NOT NULL,
    cedepto character(3) DEFAULT NULL::bpchar,
    cefuncionarioresponsavel smallint DEFAULT NULL::numeric,
    vlestimado numeric(13,2),
    dtinicio date,
    dttermino date,
    ceprojetosuperior character(6) DEFAULT NULL::bpchar,
    dtcadprojeto date NOT NULL
);
ALTER TABLE public.projetos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: projetos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.projetos IS 'Cadastro dos projetos que são desenvolvidos pelos funcionários de uma empresa.';
COMMENT ON COLUMN public.projetos.cpprojeto IS 'cp da tabela.';
COMMENT ON COLUMN public.projetos.txnomeprojeto IS 'Nome completo e sem abreviações.';
COMMENT ON COLUMN public.projetos.cedepto IS 'ce com o código do departamento que lidera ou coordena o projeto';
COMMENT ON COLUMN public.projetos.cefuncionarioresponsavel IS 'ce com o código do funcionário responsável pelo projeto';
COMMENT ON COLUMN public.projetos.vlestimado IS 'Valor estimado do projeto.';
COMMENT ON COLUMN public.projetos.dtinicio IS 'Data de inicio do projeto (após conclusão de estudos de viabilidade).';
COMMENT ON COLUMN public.projetos.dttermino IS 'Data de término do projeto (após a declaração de aceite dos interessados).';
COMMENT ON COLUMN public.projetos.ceprojetosuperior IS 'ce com o código de projeto superior (havendo subordinação).';
COMMENT ON COLUMN public.projetos.dtcadprojeto IS 'Data de geração do registro.';

-- Name: rotasviarias; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.rotasviarias (
    cprota numeric(6,0) NOT NULL,
    txnomerota character varying(60) NOT NULL,
    txdescrperiodo character varying(250) NOT NULL,
    cecidadeorigem smallint DEFAULT NULL::numeric,
    cecidadedestino smallint DEFAULT NULL::numeric,
    dtcadrotaviaria date NOT NULL
);
ALTER TABLE public.rotasviarias OWNER TO postgres;
-- COMENTÁRIO DE TABELA: rotasviarias; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.rotasviarias IS 'Cadastro das rotas viárias de viagens entre cidades.';
COMMENT ON COLUMN public.rotasviarias.cprota IS 'cp da Tabela.';
COMMENT ON COLUMN public.rotasviarias.txnomerota IS 'Nome completo e sem abreviações.';
COMMENT ON COLUMN public.rotasviarias.txdescrperiodo IS 'Texto com a descrição do período de ocorrência de viagens na rota viária';
COMMENT ON COLUMN public.rotasviarias.cecidadeorigem IS 'ce com o código da cidade de origem da rota viária';
COMMENT ON COLUMN public.rotasviarias.cecidadedestino IS 'ce com o código da cidade de destino da rota viária';
COMMENT ON COLUMN public.rotasviarias.dtcadrotaviaria IS 'Data de geração do registro';

-- Name: roteiros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.roteiros (
    cproteiro integer NOT NULL,
    cerota numeric(6,0) NOT NULL,
    cecidade smallint NOT NULL,
    nuordem character(3),
    dtcadroteiro date
);
ALTER TABLE public.roteiros OWNER TO postgres;
-- COMENTÁRIO DE TABELA: roteiros; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.roteiros IS 'Cadastro dos roteiros de cada Rota Viária. É a lista de cidades por onde um ônibus passa em uma rota.';
COMMENT ON COLUMN public.roteiros.cproteiro IS 'cp da Tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.roteiros.cerota IS 'ce apontando para a tabela rotas_viarias e parte da cp composta da Tabela.';
COMMENT ON COLUMN public.roteiros.cecidade IS 'ce apontando para a tabela cidades e parte da cp composta da Tabela.';
COMMENT ON COLUMN public.roteiros.nuordem IS 'Número indicando a ordem das cidades dentro de uma rota viária.';
COMMENT ON COLUMN public.roteiros.dtcadroteiro IS 'Data de geração do registro';

-- Name: seguradoras; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.seguradoras (
    cpseguradora smallint NOT NULL,
    txnomeseguradora character varying(250) NOT NULL,
    celogradouro integer DEFAULT NULL::numeric,
    txcomplemento character varying(25) DEFAULT NULL::character varying,
    nucep character(8) DEFAULT NULL::bpchar,
    dtcadseguradora date NOT NULL
);
ALTER TABLE public.seguradoras OWNER TO postgres;
-- COMENTÁRIO DE TABELA: seguradoras; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.seguradoras IS 'Cadastro das Seguradoras de valores.';
COMMENT ON COLUMN public.seguradoras.cpseguradora IS 'cp da tabela.';
COMMENT ON COLUMN public.seguradoras.txnomeseguradora IS 'Nome completo e sem abreviações.';
COMMENT ON COLUMN public.seguradoras.celogradouro IS 'ce apontando o logradouro onde é a sede da seguradora.';
COMMENT ON COLUMN public.seguradoras.txcomplemento IS 'Texto com o complemento do logradouro da seguradora (número, andar, etc.)';
COMMENT ON COLUMN public.seguradoras.nucep IS 'Número do CEP (somente números).';
COMMENT ON COLUMN public.seguradoras.dtcadseguradora IS 'Data de geração do registro.';

-- Name: seguradorastels; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.seguradorastels (
    cpseguradoratel smallint NOT NULL,
    ceseguradora smallint NOT NULL,
    cetipotelefone smallint DEFAULT NULL::numeric,
    nutelefone character(15) NOT NULL,
    txnomecontato character varying(30),
    dtcadseguradoratel date
);
ALTER TABLE public.seguradorastels OWNER TO postgres;
-- COMENTÁRIO DE TABELA: seguradorastels; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.seguradorastels IS 'Cadastro dos telefones de cada Seguradora.';
COMMENT ON COLUMN public.seguradorastels.cpseguradoratel IS 'cp da tabela.';
COMMENT ON COLUMN public.seguradorastels.ceseguradora IS 'ce apontando para a tabela Seguradoras.';
COMMENT ON COLUMN public.seguradorastels.cetipotelefone IS 'ce apontando para a tabela Tipos de Telefones.';
COMMENT ON COLUMN public.seguradorastels.nutelefone IS 'Número do telefone (somente os números)';
COMMENT ON COLUMN public.seguradorastels.dtcadseguradoratel IS 'Data de geração do registro';

-- Name: seguros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.seguros (
    cpnumeroapolice integer NOT NULL,
    ceveiculo integer NOT NULL,
    ceseguradora smallint NOT NULL,
    dtcontratacao date NOT NULL,
    dtlimitecobertura date NOT NULL,
    vlcobertura double precision NOT NULL,
    dtcadseguro date NOT NULL
);
ALTER TABLE public.seguros OWNER TO postgres;
-- COMENTÁRIO DE TABELA: seguros; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.seguros IS 'Cadastro dos Seguros assumidos para cada Seguradora.';
COMMENT ON COLUMN public.seguros.cpnumeroapolice IS 'cp da Tabela (assumindo que as seguradoras tenham um cadastro único de apólices de seguros)';
COMMENT ON COLUMN public.seguros.ceveiculo IS 'ce com o código do veículo (pode ser carro ou ônibus).';
COMMENT ON COLUMN public.seguros.ceseguradora IS 'ce apontando para a tabela Seguradoras.';
COMMENT ON COLUMN public.seguros.dtcontratacao IS 'Data de contratação do Seguro na Seguradora.';
COMMENT ON COLUMN public.seguros.dtlimitecobertura IS 'Data limite da cobertura do seguro.';
COMMENT ON COLUMN public.seguros.vlcobertura IS 'Valor da cobertura da apólice de seguro.';
COMMENT ON COLUMN public.seguros.dtcadseguro IS 'Data de geração do registro.';

-- Name: servicos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.servicos (
    cpservico integer NOT NULL,
    txnomecurto character varying(90),
    txdescricao character varying(250),
    vlestimado numeric(8,2),
    dtcadservico date
);
ALTER TABLE public.servicos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: servicos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.servicos IS 'Cadastro dos serviços oferecidos pelas oficinas que cobrem os sinistros das seguradoras.';
COMMENT ON COLUMN public.servicos.cpservico IS 'cp da tabela.';
COMMENT ON COLUMN public.servicos.txnomecurto IS 'Nome simples do serviço com palavras sem abreviações.';
COMMENT ON COLUMN public.servicos.txdescricao IS 'Descrição do que é feito no serviço. Palavras sem abreviações.';
COMMENT ON COLUMN public.servicos.vlestimado IS 'Valor aproximado do serviço.';
COMMENT ON COLUMN public.servicos.dtcadservico IS 'Data de geração do registro';
-- COMENTÁRIO DE TABELA: servicosfeitospor; Type: COMMENT; Schema: public; Owner: postgres
CREATE TABLE public.servicosfeitospor (
    cpservicofeitopor integer NOT NULL,
    ceoficina integer NOT NULL,
    ceservico integer NOT NULL,
    txdescricaocomplementar character varying(250) NULL,
    nudiasprevistos smallint NULL,
    dtcadfeitopor date NULL
);
ALTER TABLE public.servicosfeitospor OWNER TO postgres;
COMMENT ON TABLE public.servicosfeitospor IS 'Registros dos Serviços feitos pelas Oficinas.';
COMMENT ON COLUMN public.servicosfeitospor.cpservicofeitopor IS 'cp da tabela. Número inteiro sequencial crescente de 5 em 5.';
COMMENT ON COLUMN public.servicosfeitospor.ceoficina IS 'ce para tabela oficinas (que realiza um serviço).';
COMMENT ON COLUMN public.servicosfeitospor.ceservico IS 'ce para tabela serviços (prestados por uma oficina).';
COMMENT ON COLUMN public.servicosfeitospor.txdescricaocomplementar IS 'Descrição complementar do serviço prestado (se preciso).';
COMMENT ON COLUMN public.servicosfeitospor.nudiasprevistos IS 'Prazo inicialmente previsto para o serviço.';
COMMENT ON COLUMN public.servicosfeitospor.dtcadfeitopor IS 'Data de geração do registro.';

-- Name: setoresdeatuacao; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.setoresdeatuacao (
    cpsetoratuacao smallint NOT NULL,
    txnomesetordeatuacao character varying(90) NOT NULL,
    txdescricaosetordeatuacao character varying(250) NOT NULL,
    dtcadsetordeatuacao date NOT NULL
);
ALTER TABLE public.setoresdeatuacao OWNER TO postgres;
-- COMENTÁRIO DE TABELA: setoresdeatuacao; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.setoresdeatuacao IS 'Cadastro dos setores de atuação das empresas onde funcionários já trabalharam.';
COMMENT ON COLUMN public.setoresdeatuacao.cpsetoratuacao IS 'cp da Tabela.';
COMMENT ON COLUMN public.setoresdeatuacao.txnomesetordeatuacao IS 'Nome completo e sem abreviações';
COMMENT ON COLUMN public.setoresdeatuacao.txdescricaosetordeatuacao IS 'Texto descrevendo o que se desenvolve no setor de atuação.';
COMMENT ON COLUMN public.setoresdeatuacao.dtcadsetordeatuacao IS 'Data de geração do registro.';

-- Name: sinistros; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.sinistros (
    cpsinistro integer NOT NULL,
    txnomesinistro character varying(90) NOT NULL,
    txdescricaosinistro character varying(250) NOT NULL,
    dtcadsinistro date NOT NULL
);
ALTER TABLE public.sinistros OWNER TO postgres;
-- COMENTÁRIO DE TABELA: sinistros; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.sinistros IS 'Cadastro dos Sinistros (acidentes) que podem ocorrer nos veículos segurados de uma seguradora.';
COMMENT ON COLUMN public.sinistros.cpsinistro IS 'cp da Tabela.';
COMMENT ON COLUMN public.sinistros.txnomesinistro IS 'Denominação formal do sinistro.';
COMMENT ON COLUMN public.sinistros.txdescricaosinistro IS 'Descrição completa do sinistro (usando termos jurídicos).';
COMMENT ON COLUMN public.sinistros.dtcadsinistro IS 'Data de geração do registro.';

-- Name: tarefas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.tarefas (
    cptarefa smallint NOT NULL,
    txnometarefa character(40) NOT NULL,
    txdescricaotarefa character varying(250) NOT NULL,
    qthoraspadrao smallint DEFAULT NULL::numeric,
    dtcadtarefa date
);
ALTER TABLE public.tarefas OWNER TO postgres;
-- COMENTÁRIO DE TABELA: tarefas; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.tarefas IS 'Cadastro das tarefas que podem ser desenvolvidas pelos funcionários em projetos.';
COMMENT ON COLUMN public.tarefas.cptarefa IS 'cp da Tabela';
COMMENT ON COLUMN public.tarefas.txnometarefa IS 'Nome curto da ação de projeto (sem abreviações).';
COMMENT ON COLUMN public.tarefas.txdescricaotarefa IS 'Descrição completa de uma ação que é usada em projetos.';
COMMENT ON COLUMN public.tarefas.qthoraspadrao IS 'Quantidade de Horas padrão para a ação em qualquer projeto.';
COMMENT ON COLUMN public.tarefas.dtcadtarefa IS 'Data de geração do registro';

-- Name: tarefasprojetos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.tarefasprojetos (
    cptarefaprojeto integer NOT NULL,
    ceprojeto character(6) NOT NULL,
    cetarefa smallint NOT NULL,
    qthorasenvolvidas integer NOT NULL,
    nuordem smallint DEFAULT NULL::numeric,
    dtcadtarefaprojeto date
);
ALTER TABLE public.tarefasprojetos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: tarefasprojetos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.tarefasprojetos IS 'Registro das tarefas que são necessárisa em cada projeto.';
COMMENT ON COLUMN public.tarefasprojetos.cptarefaprojeto IS 'cp da tabela.';
COMMENT ON COLUMN public.tarefasprojetos.ceprojeto IS 'ce indicando o código do projeto que tem a tarefa.';
COMMENT ON COLUMN public.tarefasprojetos.cetarefa IS 'ce indicando o código da tarefa do projeto';
COMMENT ON COLUMN public.tarefasprojetos.qthorasenvolvidas IS 'Quantidade de horas comprometidas da tarefa no projeto';
COMMENT ON COLUMN public.tarefasprojetos.nuordem IS 'Número de ordem da tarefa dentro do projeto.';
COMMENT ON COLUMN public.tarefasprojetos.dtcadtarefaprojeto IS 'Data de geração do registro.';

-- Name: telefonestipos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.telefonestipos (
    cptipotelefone smallint NOT NULL,
    txdescricaotptelefone character varying(250) NOT NULL,
    dtcadtipotelefone date NOT NULL
);
ALTER TABLE public.telefonestipos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: telefonestipos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.telefonestipos IS 'Cadastro dos tipos de telefones (fixo, celular, empresarial, etc.).';
COMMENT ON COLUMN public.telefonestipos.cptipotelefone IS 'cp da Tabela';
COMMENT ON COLUMN public.telefonestipos.txdescricaotptelefone IS 'Texto descrevendo o tipo de telefone (sem abreviações).';
COMMENT ON COLUMN public.telefonestipos.dtcadtipotelefone IS 'Data da geração do registro';

-- Name: turmas; Type: COMMENT; Schema: public; Owner: postgres
CREATE TABLE public.turmas (
    cpturma smallint NOT NULL,
    nuanosemestre character(5),
    ceatribuicao smallint,
    dtcadturma date NULL
);
ALTER TABLE public.turmas OWNER TO postgres;
COMMENT ON TABLE public.turmas IS 'Registros dos Serviços feitos pelas Oficinas.';
COMMENT ON COLUMN public.turmas.cpturma IS 'cp da tabela. Número inteiro sequencial crescente de 1 em 1.';
COMMENT ON COLUMN public.turmas.nuanosemestre IS 'Ano e Semestre quando a turma existe.';
COMMENT ON COLUMN public.turmas.ceatribuicao IS 'ce para a tabela atribuicoes.';
COMMENT ON COLUMN public.turmas.dtcadturma IS 'Data de geração do registro.';

-- Name: veiculosmarcas; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.veiculosmarcas (
    cpmarca integer NOT NULL,
    txnomemarca character varying(90) NOT NULL,
    cefabricante smallint NOT NULL,
    dtcadmarcaveiculo date NOT NULL
);
ALTER TABLE public.veiculosmarcas OWNER TO postgres;
-- COMENTÁRIO DE TABELA: veiculosmarcas; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.veiculosmarcas IS 'Cadastro das marcas de veículos desenvolvidos por fabricantes.';
COMMENT ON COLUMN public.veiculosmarcas.cpmarca IS 'cp da Tabela';
COMMENT ON COLUMN public.veiculosmarcas.txnomemarca IS 'Nome completo e sem abreviações';
COMMENT ON COLUMN public.veiculosmarcas.cefabricante IS 'ce com o código do fabricante da marca.';
COMMENT ON COLUMN public.veiculosmarcas.dtcadmarcaveiculo IS 'Data de Geração do Registro.';

-- Name: veiculosmodelos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.veiculosmodelos (
    cpmodelo integer NOT NULL,
    cemarca integer NOT NULL,
    txdescricaomodelo character varying(250) NOT NULL,
    aotipocombustivel character(1) NOT NULL,
    dtcadmodeloveiculo date NOT NULL
);
ALTER TABLE public.veiculosmodelos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: veiculosmodelos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.veiculosmodelos IS 'Cadastro de modelos de veículos';
COMMENT ON COLUMN public.veiculosmodelos.cpmodelo IS 'cp da Tabela';
COMMENT ON COLUMN public.veiculosmodelos.cemarca IS 'ce com o código da marca de veiculos feitos por fabricantes.';
COMMENT ON COLUMN public.veiculosmodelos.txdescricaomodelo IS 'Texto com a descrição do modelo';
COMMENT ON COLUMN public.veiculosmodelos.aotipocombustivel IS 'Atributo Operacional: tipo de combustível Álcool, Gasolina, Diesel, GáS ou Flex';
COMMENT ON COLUMN public.veiculosmodelos.dtcadmodeloveiculo IS 'Data de Geração doRegistro';

-- Name: veiculostipos; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.veiculostipos (
    cptipoveiculo smallint NOT NULL,
    txdescricaotpveiculo character varying(250) NOT NULL,
    dtcadtipoveiculo date NOT NULL
);
ALTER TABLE public.veiculostipos OWNER TO postgres;
-- COMENTÁRIO DE TABELA: veiculostipos; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.veiculostipos IS 'Cadastro dos Tipos de Veículos';
COMMENT ON COLUMN public.veiculostipos.cptipoveiculo IS 'cp da tabela.';
COMMENT ON COLUMN public.veiculostipos.txdescricaotpveiculo IS 'Texto descrevendo o tipo de veiculo (rodoviário, náutico, aéreo, etc)';
COMMENT ON COLUMN public.veiculostipos.dtcadtipoveiculo IS 'Data de geração do registro';

-- Name: viagens; Type: TABLE; Schema: public; Owner: postgres
CREATE TABLE public.viagens (
    cpviagem integer NOT NULL,
    cerota integer DEFAULT NULL::numeric,
    dtsaidaviagem date NOT NULL,
    hrsaida time without time zone NOT NULL,
    dtchegadaviagem date NOT NULL,
    hrchegadaprev time without time zone,
    dtcadviagem date
);
ALTER TABLE public.viagens OWNER TO postgres;
-- COMENTÁRIO DE TABELA: viagens; Type: COMMENT; Schema: public; Owner: postgres
COMMENT ON TABLE public.viagens IS 'Cadastro de viagens feitas pelos ônibus';
COMMENT ON COLUMN public.viagens.cpviagem IS 'cp da tabela.';
COMMENT ON COLUMN public.viagens.cerota IS 'ce com o código da rota viária da viagem.';
COMMENT ON COLUMN public.viagens.dtsaidaviagem IS 'Data de realização da viagem';
COMMENT ON COLUMN public.viagens.hrsaida IS 'Hora de saída da viagem.';
COMMENT ON COLUMN public.viagens.dtchegadaviagem IS 'Data prevista de chegada da viagem';
COMMENT ON COLUMN public.viagens.hrchegadaprev IS 'Hora de saída da viagem.';
COMMENT ON COLUMN public.viagens.dtcadviagem IS 'Data de geração do registro';

-- Aqui termina o segmento do script que cria os objetos de dados (tables e views).
-- ######################################################################################################################################################################
-- Aqui começa o segmento do script que insere linhas nas tabelas.
-- Data for Name: agencias; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.agencias
            VALUES ('001', '6632X ', 'Nove de Julho', 10, '452', '01478529', '2010-10-05'),
                   ('001', '6633X ', 'Antonio Mori', 10, '745', '14521521', '2010-10-05'),
                   ('001', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('002', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('003', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('004', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('007', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('021', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('023', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('025', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('033', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('037', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('041', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('046', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('047', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('070', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('075', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('077', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('082', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('102', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('104', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('107', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('121', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('184', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('208', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('212', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('218', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('224', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('237', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('260', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('263', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('265', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('318', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('320', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('341', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('389', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('422', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('473', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('479', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('505', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('604', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('611', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('612', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('623', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('637', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('643', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('653', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('654', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('655', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('707', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('719', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('721', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('735', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('738', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('741', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('745', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('746', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('748', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('756', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15'),
                   ('M09', '0001X ', 'Matriz', 620, '14564 - Bloco 1', '04452160', '2020-09-15');
-- Data for Name: agenciastels; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: aplicacaodascontas; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: aplicacoesfinanceiras; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.aplicacoesfinanceiras
            VALUES (5, 'RDB', 'Investimento de 5000 (mínimo) por um período de 30 dias (mínimo).', 3.5, 5.5, '2016-10-18'),
                   (10, 'Poupança', 'Investimento de 500 (mínimo) com liquidez diária a partir de 30 dias do depósito inicial.', 1, 1.5, '2016-10-18');
-- Data for Name: areasdeestudo; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.areasdeestudo
            VALUES (25, 'Gestão e Administração', '', '2010-12-16'),
                   (30, 'Tecnologias da Informação e Comunicação', '', '2010-12-16'),
                   (35, 'Astronomia', 'agrupa os estudos de fisica astronomica, geoestatistica quantica aplicada', '2010-10-10'),
                   (5, 'Exatas', 'Agrupa as áreas de matemática, física, quimica e engenharias', '2001-01-01'),
                   (10, 'Humanas', '', '2001-01-01'),
                   (15, 'Biomédicas', '', '2001-01-01'),
                   (20, 'Ciências Ambientais', '', '2001-01-01');
-- Data for Name: areasdeestudocursos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.areasdeestudocursos
            VALUES (20, 4, 30, '2001-05-10'),
                   (15, 3, 35, '2001-05-10'),
                   (5, 1, 15, '2001-06-10'),
                   (10, 3, 20, '2001-05-10'),
                   (12, 1, 35, '2010-10-10');
-- Data for Name: areasdeestudodisciplinas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.areasdeestudodisciplinas
            VALUES (20, 1, 25, '2011-05-10'),
                   (25, 1, 35, '2005-05-05');
INSERT INTO public.areasdeestudodisciplinas
            VALUES (5, 1, 5, '1980-01-01'),
                   (30, 2, 5, '1980-01-01'),
                   (40, 3, 10, '1980-01-01'),
                   (10, 1, 10, '1980-01-01'),
                   (35, 2, 10, '2010-10-10'),
                   (15, 1, 20, '2004-02-04');
-- Data for Name: areasdeestudolivros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.areasdeestudolivros
            VALUES (10, 20, 25, 1, '2010-10-10'),
                   (15, 70, 25, 2, '2010-10-10'),
                   (5, 20, 5, 10, '2010-10-10');
-- Data for Name: armazens; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.armazens
            VALUES (2, 'Sao Sebastiao', '', 470, ' 1492', 10, '            ', '        ', 50000, '1980-01-01'),
                   (5, 'Dois Irmaos', '', 470, ' 234', 10, '            ', '        ', 15000, '1980-01-01'),
                   (15, 'Big Warehouse Bahia', 'Galpão Único com pé direito de 15Metros', 240, '456', 55, '123         ', '12313212', 35000, '2010-10-10'),
                   (3, 'Rio de Janeiro - 01', 'Galpão Único com pé direito de 15Metros - Lojas Americanas', 470, ' 234', 10, '2174857485  ', '12345678', 20000, '1980-01-01'),
                   (1, 'Americanas V', 'Galpão Único com pé direito de 15Metros - Lojas Americanas', 100, 'Km 30', 10, '1145124512  ', '12345678', 150000, '2015-12-07');
-- Data for Name: atividades; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.atividades
            VALUES (25, 'Implementação de programas', 'Programação, testes, implantação e treinamento dos usuários', '2010-10-10'),
                   (5, 'Estudos de Viabilidade', 'Analisa as condições de exequibilidade de projetos', '2011-06-11'),
                   (10, 'Levantamentos de Requisitos', 'Determina as características centrais do Sistema', '2011-06-11'),
                   (15, 'Modelagem do sistema', 'Definição de modelos de dados e processos', '2010-10-10'),
                   (20, 'Especificação técnica de Dados e processos', 'Definição do Modelo Físico. Determinação dos Modelos de Dados e Processos', '2010-10-10'),
                   (30, 'Construção dos Bancos de Dados', 'Implantação do SGBD e construção dos BDs.', '2010-10-10');
-- Data for Name: atribuicoes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.atribuicoes
            VALUES (1, 1, 1, 10, '1980-01-01', NULL),
                   (2, 1, 2, 12, '1980-01-01', NULL),
                   (3, 1, 3, 8, '1980-01-01', NULL),
                   (4, 1, 4, 20, '1980-01-01', NULL),
                   (5, 2, 1, 15, '1980-01-01', NULL),
                   (6, 2, 2, 10, '1980-01-01', NULL),
                   (7, 2, 3, 5, '1980-01-01', NULL),
                   (8, 2, 4, 10, '1980-01-01', NULL),
                   (9, 3, 5, 0, '1980-01-01', NULL),
                   (10, 3, 6, 0, '1980-01-01', NULL),
                   (11, 3, 7, 0, '1980-01-01', NULL),
                   (12, 3, 8, 0, '1980-01-01', NULL),
                   (13, 4, 5, 0, '1980-01-01', NULL),
                   (14, 4, 6, 0, '1980-01-01', NULL),
                   (15, 4, 7, 0, '1980-01-01', NULL),
                   (16, 4, 8, 0, '1980-01-01', NULL),
                   (17, 5, 5, 0, '1980-01-01', NULL),
                   (18, 5, 6, 0, '1980-01-01', NULL),
                   (19, 5, 7, 0, '1980-01-01', NULL),
                   (20, 5, 8, 0, '1980-01-01', NULL),
                   (21, 6, 9, 0, '1980-01-01', NULL),
                   (22, 6, 10, 0, '1980-01-01', NULL),
                   (23, 7, 9, 0, '1980-01-01', NULL),
                   (24, 7, 10, 0, '1980-01-01', NULL),
                   (25, 7, 17, 0, '1980-01-01', NULL),
                   (26, 7, 18, 0, '1980-01-01', NULL),
                   (27, 7, 19, 0, '1980-01-01', NULL),
                   (28, 7, 20, 0, '1980-01-01', NULL),
                   (29, 7, 21, 0, '1980-01-01', NULL),
                   (30, 7, 22, 0, '1980-01-01', NULL),
                   (31, 8, 11, 0, '1980-01-01', NULL),
                   (32, 8, 12, 0, '1980-01-01', NULL),
                   (33, 9, 11, 0, '1980-01-01', NULL),
                   (34, 9, 12, 0, '1980-01-01', NULL),
                   (35, 10, 11, 0, '1980-01-01', NULL),
                   (36, 11, 13, 0, '1980-01-01', NULL),
                   (37, 11, 14, 0, '1980-01-01', NULL),
                   (38, 12, 13, 0, '1980-01-01', NULL),
                   (39, 12, 14, 0, '1980-01-01', NULL),
                   (40, 13, 13, 0, '1980-01-01', NULL),
                   (41, 13, 14, 0, '1980-01-01', NULL),
                   (42, 14, 13, 0, '1980-01-01', NULL),
                   (43, 14, 14, 0, '1980-01-01', NULL),
                   (44, 15, 15, 0, '1980-01-01', NULL),
                   (45, 15, 16, 0, '1980-01-01', NULL),
                   (46, 16, 15, 0, '1980-01-01', NULL),
                   (47, 16, 16, 0, '1980-01-01', NULL),
                   (48, 17, 15, 0, '1980-01-01', NULL),
                   (49, 17, 16, 0, '1980-01-01', NULL),
                   (50, 18, 15, 0, '1980-01-01', NULL),
                   (51, 18, 16, 0, '1980-01-01', NULL),
                   (52, 19, 17, 0, '1980-01-01', NULL),
                   (53, 19, 18, 0, '1980-01-01', NULL),
                   (54, 20, 17, 0, '1980-01-01', NULL),
                   (55, 20, 18, 0, '1980-01-01', NULL),
                   (56, 21, 17, 0, '1980-01-01', NULL),
                   (57, 22, 19, 0, '1980-01-01', NULL),
                   (58, 22, 20, 0, '1980-01-01', NULL),
                   (59, 23, 19, 10, '1980-01-01', NULL),
                   (60, 23, 20, 10, '1980-01-01', NULL),
                   (61, 24, 19, 20, '1980-01-01', NULL),
                   (62, 24, 20, 20, '1980-01-01', NULL),
                   (63, 25, 19, 10, '1980-01-01', NULL),
                   (64, 25, 20, 15, '1980-01-01', NULL),
                   (65, 27, 21, 10, '1980-01-01', NULL),
                   (66, 27, 22, 20, '1980-01-01', NULL),
                   (67, 28, 21, 10, '1980-01-01', NULL),
                   (68, 28, 22, 15, '1980-01-01', NULL),
                   (69, 29, 1, 6, '2013-11-25', NULL),
                   (70, 29, 2, 6, '2013-11-25', NULL),
                   (71, 29, 3, 6, '2013-11-25', NULL),
                   (72, 29, 4, 6, '2013-11-25', NULL),
                   (73, 29, 5, 6, '2013-11-25', NULL),
                   (74, 29, 6, 6, '2013-11-25', NULL),
                   (75, 29, 7, 6, '2013-11-25', NULL),
                   (76, 29, 8, 6, '2013-11-25', NULL),
                   (77, 29, 9, 6, '2013-11-25', NULL),
                   (78, 29, 10, 6, '2013-11-25', NULL),
                   (79, 29, 11, 6, '2013-11-25', NULL),
                   (80, 29, 12, 6, '2013-11-25', NULL),
                   (81, 29, 13, 6, '2013-11-25', NULL),
                   (82, 29, 14, 6, '2013-11-25', NULL),
                   (83, 29, 15, 6, '2013-11-25', NULL),
                   (84, 29, 16, 6, '2013-11-25', NULL),
                   (85, 29, 17, 6, '2013-11-25', NULL),
                   (86, 29, 18, 6, '2013-11-25', NULL),
                   (87, 29, 19, 6, '2013-11-25', NULL),
                   (88, 29, 20, 6, '2013-11-25', NULL),
                   (89, 29, 21, 6, '2013-11-25', NULL),
                   (90, 29, 22, 6, '2013-11-25', NULL);
-- Data for Name: atuacoes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.atuacoes VALUES (1, 1, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (2, 2, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (3, 3, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (4, 4, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (5, 5, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (6, 6, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (7, 7, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (8, 8, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (9, 9, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (10, 10, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (11, 11, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (12, 12, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (13, 13, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (14, 14, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (15, 15, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (16, 16, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (17, 17, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (18, 18, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (19, 19, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (20, 20, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (21, 21, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (22, 22, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (23, 23, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (24, 24, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (25, 25, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (26, 26, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (27, 27, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (28, 28, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (29, 29, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (30, 30, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (31, 31, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (32, 32, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (33, 33, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (34, 34, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (35, 35, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (36, 36, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (37, 37, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (38, 38, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (39, 39, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (40, 40, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (41, 41, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (42, 42, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (43, 43, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (44, 44, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (45, 45, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (46, 46, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (47, 47, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (48, 48, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (49, 49, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (50, 50, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (51, 51, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (52, 52, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (53, 53, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (54, 54, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (55, 55, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (56, 56, 10, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (57, 8, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (58, 9, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (59, 10, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (60, 11, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (61, 12, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (62, 13, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (63, 14, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (64, 15, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (65, 16, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (66, 17, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (67, 18, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (68, 19, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (69, 20, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (70, 21, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (71, 22, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (72, 23, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (73, 24, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (74, 25, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (75, 26, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (76, 27, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (77, 28, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (78, 29, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (79, 30, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (80, 31, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (81, 32, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (82, 33, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (83, 34, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (84, 35, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (85, 36, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (86, 37, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (87, 38, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (88, 39, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (89, 40, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (90, 41, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (91, 42, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (92, 43, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (93, 44, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (94, 45, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (95, 46, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (96, 47, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (97, 48, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (98, 49, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (99, 50, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (100, 51, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (101, 52, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (102, 53, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (103, 54, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (104, 55, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (105, 56, 20, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (106, 1, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (107, 2, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (108, 3, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (109, 4, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (110, 5, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (111, 6, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (112, 7, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (113, 8, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (114, 9, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (115, 10, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (116, 11, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (117, 19, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (118, 20, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (119, 21, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (120, 22, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (121, 23, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (122, 24, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (123, 25, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (124, 26, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (125, 27, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (126, 28, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (127, 29, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (128, 30, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (129, 31, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (130, 32, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (131, 33, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (132, 34, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (133, 35, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (134, 36, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (135, 37, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (136, 38, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (137, 39, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (138, 40, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (139, 41, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (140, 42, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (141, 43, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (142, 44, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (143, 45, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (144, 46, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (145, 47, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (146, 48, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (147, 49, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (148, 50, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (149, 51, 30, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (150, 35, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (151, 36, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (152, 37, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (153, 38, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (154, 39, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (155, 40, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (156, 41, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (157, 42, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (158, 43, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (159, 44, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (160, 45, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (161, 46, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (162, 47, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (163, 48, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (164, 49, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (165, 50, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (166, 51, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (167, 52, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (168, 53, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (169, 54, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (170, 55, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (171, 56, 40, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (172, 1, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (173, 2, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (174, 3, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (175, 4, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (176, 5, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (177, 6, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (178, 7, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (179, 8, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (180, 9, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (181, 10, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (182, 11, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (183, 12, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (184, 13, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (185, 14, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (186, 15, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (187, 16, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (188, 17, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (189, 18, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (190, 19, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (191, 20, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (192, 21, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (193, 22, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (194, 23, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (195, 24, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (196, 25, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (197, 26, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (198, 27, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (199, 28, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (200, 29, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (201, 30, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (202, 31, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (203, 32, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (204, 33, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (205, 34, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (206, 35, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (207, 36, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (208, 37, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (209, 38, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (210, 39, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (211, 40, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (212, 41, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (213, 42, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (214, 43, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (215, 44, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (216, 45, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (217, 46, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (218, 47, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (219, 48, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (220, 49, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (221, 50, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (222, 51, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (223, 52, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (224, 53, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (225, 54, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (226, 55, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (227, 56, 50, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (228, 9, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (229, 10, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (230, 11, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (231, 12, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (232, 13, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (233, 14, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (234, 15, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (235, 16, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (236, 17, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (237, 18, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (238, 19, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (239, 20, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (240, 21, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (241, 22, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (242, 23, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (243, 24, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (244, 25, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (245, 26, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (246, 27, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (247, 28, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (248, 29, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (249, 30, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (250, 31, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (251, 32, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (252, 33, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (253, 34, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (254, 35, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (255, 36, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (256, 37, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (257, 38, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (258, 39, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (259, 40, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (260, 41, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (261, 42, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (262, 43, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (263, 44, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (264, 45, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (265, 46, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (266, 47, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (267, 48, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (268, 49, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (269, 50, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (270, 51, 70, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (271, 8, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (272, 9, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (273, 10, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (274, 11, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (275, 12, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (276, 13, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (277, 14, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (278, 15, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (279, 16, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (280, 17, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (281, 18, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (282, 19, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (283, 20, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (284, 21, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (285, 22, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (286, 23, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (287, 24, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (288, 25, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (289, 33, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (290, 34, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (291, 35, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (292, 36, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (293, 37, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (294, 38, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (295, 39, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (296, 40, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (297, 41, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (298, 42, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (299, 43, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (300, 44, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (301, 45, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (302, 46, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (303, 47, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (304, 48, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (305, 49, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (306, 50, 80, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (307, 43, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (308, 44, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (309, 45, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (310, 46, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (311, 47, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (312, 48, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (313, 49, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (314, 50, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (315, 51, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (316, 52, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (317, 53, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (318, 54, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (319, 55, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (320, 56, 90, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (321, 1, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (322, 2, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (323, 3, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (324, 4, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (325, 5, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (326, 6, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (327, 7, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (328, 8, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (329, 9, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (330, 10, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (331, 11, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (332, 12, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (333, 13, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (334, 14, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (335, 15, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (336, 16, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (337, 17, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (338, 18, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (339, 19, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (340, 20, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (341, 21, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (342, 22, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (343, 23, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (344, 24, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (345, 25, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (346, 26, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (347, 27, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (348, 28, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (349, 29, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (350, 30, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (351, 31, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (352, 32, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (353, 33, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (354, 34, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (355, 35, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (356, 36, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (357, 37, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (358, 38, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (359, 39, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (360, 40, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (361, 41, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (362, 42, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (363, 43, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (364, 44, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (365, 45, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (366, 46, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (367, 47, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (368, 48, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (369, 49, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (370, 50, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (371, 51, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (372, 52, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (373, 53, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (374, 54, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (375, 55, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (376, 56, 100, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (377, 37, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (378, 38, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (379, 39, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (380, 40, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (381, 41, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (382, 42, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (383, 43, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (384, 44, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (385, 45, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (386, 46, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (387, 47, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (388, 48, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (389, 49, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (390, 50, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (391, 51, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (392, 52, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (393, 53, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (394, 54, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (395, 55, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (396, 56, 110, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (397, 1, 120, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (398, 2, 120, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (399, 3, 120, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (400, 4, 120, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (401, 12, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (402, 13, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (403, 14, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (404, 15, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (405, 16, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (406, 17, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (407, 18, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (408, 19, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (409, 20, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (410, 21, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (411, 22, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (412, 23, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (413, 24, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (414, 25, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (415, 26, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (416, 27, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (417, 28, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (418, 29, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (419, 30, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (420, 31, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (421, 32, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (422, 33, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (423, 34, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (424, 35, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (425, 36, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (426, 37, 130, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (427, 41, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (428, 42, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (429, 43, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (430, 44, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (431, 45, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (432, 46, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (433, 47, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (434, 48, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (435, 49, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (436, 50, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (437, 51, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (438, 52, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (439, 53, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (440, 54, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (441, 55, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (442, 56, 150, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (443, 9, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (444, 10, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (445, 11, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (446, 12, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (447, 13, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (448, 14, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (449, 15, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (450, 16, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (451, 17, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (452, 18, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (453, 19, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (454, 20, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (455, 21, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (456, 22, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (457, 23, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (458, 24, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (459, 25, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (460, 26, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (461, 27, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (462, 28, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (463, 29, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (464, 30, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (465, 31, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (466, 32, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (467, 33, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (468, 34, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (469, 39, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (470, 40, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (471, 41, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (472, 42, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (473, 43, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (474, 44, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (475, 45, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (476, 46, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (477, 47, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (478, 48, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (479, 49, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (480, 51, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (481, 52, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (482, 53, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (483, 54, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (484, 55, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (485, 56, 170, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (486, 1, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (487, 2, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (488, 3, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (489, 4, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (490, 5, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (491, 6, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (492, 7, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (493, 8, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (494, 9, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (495, 10, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (496, 11, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (497, 12, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (498, 13, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (499, 14, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (500, 29, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (501, 30, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (502, 31, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (503, 32, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (504, 33, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (505, 34, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (506, 35, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (507, 36, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (508, 37, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (509, 38, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (510, 39, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (511, 40, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (512, 41, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (513, 42, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (514, 43, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (515, 44, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (516, 45, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (517, 46, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (518, 47, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (519, 48, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (520, 49, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (521, 50, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (522, 51, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (523, 52, 190, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (524, 9, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (525, 10, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (526, 11, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (527, 12, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (528, 13, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (529, 14, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (530, 15, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (531, 16, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (532, 17, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (533, 18, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (534, 19, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (535, 20, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (536, 21, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (537, 22, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (538, 23, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (539, 24, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (540, 25, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (541, 26, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (542, 27, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (543, 28, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (544, 29, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (545, 30, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (546, 31, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (547, 32, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (548, 33, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (549, 38, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (550, 39, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (551, 40, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (552, 41, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (553, 42, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (554, 43, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (555, 44, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (556, 45, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (557, 46, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (558, 47, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (559, 48, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (560, 49, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (561, 50, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (562, 51, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (563, 52, 200, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (564, 38, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (565, 39, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (566, 40, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (567, 41, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (568, 42, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (569, 43, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (570, 44, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (571, 45, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (572, 46, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (573, 47, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (574, 48, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (575, 49, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (576, 50, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (577, 51, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (578, 52, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (579, 53, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (580, 54, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (581, 55, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (582, 56, 210, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (583, 1, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (584, 9, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (585, 10, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (586, 11, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (587, 12, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (588, 13, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (589, 14, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (590, 15, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (591, 16, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (592, 17, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (593, 18, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (594, 19, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (595, 20, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (596, 21, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (597, 37, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (598, 38, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (599, 39, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (600, 40, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (601, 41, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (602, 42, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (603, 43, 220, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (604, 9, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (605, 10, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (606, 11, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (607, 12, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (608, 13, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (609, 14, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (610, 15, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (611, 16, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (612, 17, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (613, 18, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (614, 19, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (615, 20, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (616, 21, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (617, 22, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (618, 23, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (619, 24, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (620, 45, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (621, 46, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (622, 47, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (623, 48, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (624, 49, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (625, 50, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (626, 51, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (627, 52, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (628, 53, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (629, 54, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (630, 55, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (631, 56, 230, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (632, 1, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (633, 2, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (634, 3, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (635, 4, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (636, 24, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (637, 25, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (638, 26, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (639, 27, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (640, 28, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (641, 29, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (642, 30, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (643, 31, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (644, 32, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (645, 33, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (646, 34, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (647, 35, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (648, 36, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (649, 37, 240, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (650, 1, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (651, 2, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (652, 3, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (653, 4, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (654, 5, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (655, 6, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (656, 7, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (657, 8, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (658, 9, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (659, 10, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (660, 11, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (661, 12, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (662, 13, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (663, 14, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (664, 15, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (665, 37, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (666, 38, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (667, 39, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (668, 40, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (669, 41, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (670, 42, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (671, 43, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (672, 44, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (673, 45, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (674, 46, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (675, 47, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (676, 48, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (677, 49, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (678, 50, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (679, 51, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (680, 52, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (681, 53, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (682, 54, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (683, 55, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (684, 56, 250, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (685, 1, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (686, 2, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (687, 24, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (688, 25, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (689, 26, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (690, 27, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (691, 28, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (692, 29, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (693, 30, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (694, 31, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (695, 32, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (696, 33, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (697, 34, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (698, 35, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (699, 36, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (700, 37, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (701, 38, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (702, 39, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (703, 40, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (704, 41, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (705, 42, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (706, 43, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (707, 44, 260, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (708, 11, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (709, 12, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (710, 13, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (711, 14, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (712, 15, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (713, 16, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (714, 17, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (715, 18, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (716, 19, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (717, 20, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (718, 21, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (719, 22, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (720, 23, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (721, 24, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (722, 25, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (723, 26, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (724, 27, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (725, 28, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (726, 52, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (727, 53, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (728, 54, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (729, 55, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (730, 56, 270, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (731, 1, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (732, 2, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (733, 3, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (734, 4, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (735, 5, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (736, 6, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (737, 7, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (738, 34, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (739, 35, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (740, 36, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (741, 37, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (742, 38, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (743, 39, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (744, 40, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (745, 41, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (746, 42, 280, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (747, 12, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (748, 13, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (749, 14, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (750, 15, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (751, 16, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (752, 17, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (753, 18, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (754, 19, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (755, 20, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (756, 21, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (757, 22, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (758, 23, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (759, 24, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (760, 25, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (761, 26, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (762, 27, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (763, 28, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (764, 29, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (765, 30, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (766, 31, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (767, 32, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (768, 33, 290, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (769, 1, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (770, 2, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (771, 3, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (772, 4, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (773, 5, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (774, 6, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (775, 7, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (776, 8, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (777, 9, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (778, 10, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (779, 11, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (780, 12, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (781, 13, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (782, 14, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (783, 15, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (784, 16, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (785, 17, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (786, 18, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (787, 19, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (788, 20, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (789, 21, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (790, 22, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (791, 23, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (792, 24, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (793, 25, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (794, 26, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (795, 27, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (796, 28, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (797, 29, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (798, 30, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (799, 31, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (800, 32, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (801, 33, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (802, 34, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (803, 35, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (804, 36, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (805, 37, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (806, 38, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (807, 39, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (808, 40, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (809, 41, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (810, 42, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (811, 43, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (812, 44, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (813, 45, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (814, 46, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (815, 47, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (816, 48, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (817, 49, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (818, 50, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (819, 51, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (820, 52, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (821, 53, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (822, 54, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (823, 55, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (824, 56, 300, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (825, 1, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (826, 2, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (827, 19, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (828, 20, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (829, 21, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (830, 22, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (831, 23, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (832, 24, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (833, 25, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (834, 26, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (835, 27, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (836, 28, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (837, 29, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (838, 30, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (839, 31, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (840, 32, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (841, 33, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (842, 34, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (843, 35, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (844, 36, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (845, 37, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (846, 38, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (847, 54, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (848, 55, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (849, 56, 310, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (850, 1, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (851, 2, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (852, 3, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (853, 4, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (854, 5, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (855, 6, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (856, 7, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (857, 8, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (858, 9, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (859, 10, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (860, 11, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (861, 12, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (862, 13, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (863, 14, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (864, 15, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (865, 16, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (866, 35, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (867, 36, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (868, 37, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (869, 38, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (870, 39, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (871, 40, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (872, 41, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (873, 42, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (874, 43, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (875, 44, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (876, 45, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (877, 46, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (878, 47, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (879, 48, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (880, 49, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (881, 50, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (882, 51, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (883, 52, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (884, 53, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (885, 54, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (886, 55, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (887, 56, 320, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (888, 1, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (889, 2, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (890, 3, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (891, 4, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (892, 22, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (893, 23, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (894, 24, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (895, 25, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (896, 26, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (897, 27, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (898, 28, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (899, 29, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (900, 30, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (901, 31, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (902, 32, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (903, 33, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (904, 34, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (905, 35, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (906, 36, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (907, 37, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (908, 38, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (909, 39, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (910, 40, 330, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (911, 8, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (912, 9, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (913, 10, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (914, 11, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (915, 12, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (916, 13, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (917, 14, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (918, 15, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (919, 16, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (920, 17, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (921, 18, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (922, 19, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (923, 20, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (924, 21, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (925, 22, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (926, 23, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (927, 24, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (928, 25, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (929, 26, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (930, 27, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (931, 28, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (932, 29, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (933, 30, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (934, 31, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (935, 32, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (936, 33, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (937, 34, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (938, 35, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (939, 36, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (940, 37, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (941, 38, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (942, 39, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (943, 40, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (944, 41, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (945, 42, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (946, 43, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (947, 44, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (948, 45, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (949, 46, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (950, 47, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (951, 48, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (952, 49, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (953, 50, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (954, 51, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (955, 52, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (956, 53, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (957, 54, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (958, 55, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (959, 56, 340, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (960, 1, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (961, 2, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (962, 22, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (963, 23, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (964, 24, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (965, 25, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (966, 26, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (967, 27, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (968, 28, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (969, 29, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (970, 30, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (971, 31, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (972, 32, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (973, 33, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (974, 34, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (975, 35, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (976, 36, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (977, 37, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (978, 38, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (979, 39, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (980, 40, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (981, 41, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (982, 42, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (983, 43, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (984, 44, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (985, 45, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (986, 46, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (987, 47, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (988, 48, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (989, 49, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (990, 50, 350, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (991, 15, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (992, 16, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (993, 17, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (994, 18, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (995, 19, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (996, 20, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (997, 21, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (998, 22, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (999, 23, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1000, 24, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1001, 25, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1002, 26, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1003, 27, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1004, 28, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1005, 29, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1006, 30, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1007, 31, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1008, 32, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1009, 33, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1010, 34, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1011, 35, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1012, 36, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1013, 55, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1014, 56, 360, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1015, 1, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1016, 2, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1017, 3, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1018, 4, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1019, 5, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1020, 6, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1021, 7, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1022, 8, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1023, 9, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1024, 10, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1025, 11, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1026, 12, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1027, 13, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1028, 14, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1029, 15, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1030, 16, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1031, 41, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1032, 42, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1033, 43, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1034, 44, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1035, 45, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1036, 46, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1037, 47, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1038, 48, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1039, 49, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1040, 50, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1041, 51, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1042, 52, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1043, 53, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1044, 54, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1045, 55, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1046, 56, 370, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1047, 1, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1048, 2, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1049, 3, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1050, 4, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1051, 5, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1052, 6, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1053, 7, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1054, 8, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1055, 9, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1056, 10, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1057, 11, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1058, 12, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1059, 13, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1060, 34, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1061, 35, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1062, 36, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1063, 37, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1064, 38, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1065, 39, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1066, 40, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1067, 41, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1068, 42, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1069, 43, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1070, 44, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1071, 45, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1072, 46, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1073, 47, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1074, 48, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1075, 49, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1076, 50, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1077, 51, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1078, 52, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1079, 53, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1080, 54, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1081, 55, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1082, 56, 380, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1083, 1, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1084, 2, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1085, 3, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1086, 4, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1087, 5, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1088, 6, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1089, 7, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1090, 8, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1091, 9, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1092, 10, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1093, 11, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1094, 12, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1095, 13, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1096, 14, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1097, 15, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1098, 16, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1099, 17, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1100, 18, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1101, 19, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1102, 20, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1103, 21, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1104, 22, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1105, 23, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1106, 24, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1107, 25, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1108, 26, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1109, 27, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1110, 28, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1111, 29, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1112, 30, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1113, 31, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1114, 32, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1115, 33, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1116, 34, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1117, 35, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1118, 36, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1119, 37, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1120, 38, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1121, 39, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1122, 40, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1123, 41, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1124, 42, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1125, 43, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1126, 44, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1127, 45, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1128, 46, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1129, 47, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1130, 48, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1131, 49, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1132, 50, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1133, 51, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1134, 52, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1135, 53, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1136, 54, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1137, 55, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1138, 56, 390, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1139, 17, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1140, 18, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1141, 19, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1142, 20, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1143, 21, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1144, 22, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1145, 23, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1146, 24, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1147, 25, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1148, 26, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1149, 27, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1150, 28, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1151, 29, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1152, 30, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1153, 53, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1154, 54, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1155, 55, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1156, 56, 400, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1157, 1, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1158, 2, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1159, 3, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1160, 4, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1161, 5, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1162, 6, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1163, 7, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1164, 8, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1165, 9, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1166, 10, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1167, 11, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1168, 12, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1169, 13, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1170, 14, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1171, 15, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1172, 16, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1173, 17, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1174, 18, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1175, 19, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1176, 42, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1177, 43, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1178, 44, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1179, 45, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1180, 46, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1181, 47, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1182, 48, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1183, 49, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1184, 50, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1185, 51, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1186, 52, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1187, 53, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1188, 54, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1189, 55, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1190, 56, 410, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1191, 1, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1192, 2, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1193, 3, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1194, 4, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1195, 5, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1196, 6, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1197, 7, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1198, 8, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1199, 9, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1200, 10, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1201, 11, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1202, 33, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1203, 34, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1204, 35, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1205, 36, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1206, 37, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1207, 38, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1208, 39, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1209, 40, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1210, 41, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1211, 42, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1212, 43, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1213, 44, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1214, 45, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1215, 46, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1216, 47, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1217, 48, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1218, 49, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1219, 50, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1220, 51, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1221, 52, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1222, 53, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1223, 54, 420, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1224, 15, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1225, 16, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1226, 17, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1227, 18, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1228, 19, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1229, 20, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1230, 21, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1231, 22, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1232, 23, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1233, 24, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1234, 25, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1235, 26, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1236, 27, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1237, 28, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1238, 29, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1239, 30, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1240, 31, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1241, 32, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1242, 33, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1243, 34, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1244, 35, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1245, 36, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1246, 37, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1247, 38, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1248, 39, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1249, 40, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1250, 41, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1251, 42, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1252, 43, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1253, 44, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1254, 45, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1255, 46, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1256, 47, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1257, 48, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1258, 49, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1259, 50, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1260, 51, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1261, 52, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1262, 53, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1263, 54, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1264, 55, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1265, 56, 430, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1266, 1, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1267, 2, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1268, 3, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1269, 4, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1270, 5, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1271, 6, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1272, 7, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1273, 8, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1274, 9, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1275, 10, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1276, 11, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1277, 12, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1278, 13, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1279, 14, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1280, 15, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1281, 16, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1282, 17, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1283, 18, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1284, 19, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1285, 20, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1286, 21, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1287, 22, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1288, 23, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1289, 24, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1290, 25, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1291, 26, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1292, 27, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1293, 28, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1294, 29, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1295, 30, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1296, 31, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1297, 32, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1298, 33, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1299, 34, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1300, 35, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1301, 36, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1302, 37, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1303, 38, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1304, 39, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1305, 40, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1306, 41, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1307, 42, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1308, 43, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1309, 44, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1310, 45, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1311, 46, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1312, 47, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1313, 48, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1314, 49, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1315, 50, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1316, 51, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1317, 52, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1318, 53, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1319, 54, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1320, 55, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1321, 56, 440, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1322, 49, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1323, 50, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1324, 51, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1325, 52, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1326, 53, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1327, 54, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1328, 55, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1329, 56, 460, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1330, 1, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1331, 2, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1332, 3, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1333, 4, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1334, 5, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1335, 6, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1336, 7, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1337, 8, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1338, 9, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1339, 10, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1340, 11, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1341, 12, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1342, 13, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1343, 14, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1344, 15, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1345, 16, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1346, 17, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1347, 18, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1348, 19, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1349, 20, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1350, 21, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1351, 22, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1352, 23, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1353, 24, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1354, 25, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1355, 26, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1356, 27, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1357, 28, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1358, 29, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1359, 30, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1360, 31, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1361, 32, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1362, 33, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1363, 34, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1364, 35, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1365, 36, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1366, 37, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1367, 38, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1368, 39, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1369, 40, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1370, 41, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1371, 42, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1372, 43, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1373, 44, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1374, 45, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1375, 46, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1376, 47, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1377, 48, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1378, 49, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1379, 50, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1380, 51, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1381, 52, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1382, 53, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1383, 54, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1384, 55, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05'),
                   (1385, 56, 470, '2017-10-05', '2017-10-30', 100, '2017-11-05');
-- Data for Name: autores; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.autores
            VALUES (10, 'Maurício Alencar Vieira', 600, ' 985', '12345678', '1980-01-01', '2013-03-20'),
                   (20, 'Luis Tolstoi Villas Correa', 460, ' 1254', '15452145', '1980-01-01', '2010-10-10'),
                   (40, 'José Bolseiro', 20, '45', '19906160', '1984-05-20', '2010-10-10'),
                   (50, 'Franscico Buarque Severino Santos', 20, '45', '04512412', '1951-05-20', '1995-02-20'),
                   (70, 'César Camargo Mariano', 40, '15', '41524152', '1955-08-09', '1995-05-05'),
                   (80, 'Vinicius de Morais', 490, '2324', '04512451', '1935-05-10', '1985-10-10'),
                   (130, 'Cecilia Meireles Fonseca Lins', 590, ' Km 289', '02342345', '1980-01-01', '2009-10-10');
-- Data for Name: autorestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.autorestels
            VALUES (5, 10, 5, '1433522653     ', '2016-10-18'),
                   (10, 10, 10, '14985641452    ', '2016-10-18');
-- Data for Name: autorias; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.autorias
            VALUES (5, 10, 10, '2011-10-10'),
                   (10, 10, 20, '2010-10-10'),
                   (15, 93, 10, '2019-09-21');
-- Data for Name: bairros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.bairros
            VALUES (1, 'Centro', 10, '2014-03-29'),
                   (2, 'Centro', 5, '2014-03-29'),
                   (3, 'Centro', 20, '2014-03-29'),
                   (4, 'Bela Vista', 5, '2014-03-29'),
                   (5, 'Bexiga', 5, '2014-03-29'),
                   (6, 'Liberdade', 5, '2014-03-29'),
                   (7, 'Vila Musa', 35, '2014-03-29'),
                   (8, 'Vila Matilde', 5, '2014-03-29'),
                   (9, 'Vila Esperança', 5, '2014-03-29'),
                   (11, 'Centro', 40, '2020-09-07'),
                   (12, 'Centro', 15, '2020-09-07'),
                   (13, 'Centro', 25, '2020-09-07'),
                   (14, 'Centro', 30, '2020-09-07'),
                   (10, 'Centro', 35, '2020-09-07');
-- Data for Name: bairroslogradouros; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: bancos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.bancos (cpbanco,txnomebanco,dtfundacao,aocompetencia,celogradourosede,txcomplemento,nucepsede,dtcadbanco,nucnpjbanco,txsigla,website,aosituacao,aohistorico,qtagencias,aocapitalaberto)
            VALUES ('001', 'Banco do Brasil', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('002', 'Banco Central do Brasil', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('003', 'Banco da Amazônia', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('004', 'Banco do Nordeste do Brasil', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('007', 'Banco Nacional de Desenvolvimento Econômico e Social', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('021', 'Banco do Estado do Espírito Santo', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('023', 'Banco de Desenvolvimento de Minas Gerais', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('025', 'Banco Alfa', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('033', 'Banco Santander', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('037', 'Banco do Estado do Pará', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('041', 'Banco do Estado do Rio Grande do Sul', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('046', 'Banco Regional de Desenvolvimento do Extremo Sul', '1940-05-02', 'I', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('047', 'Banco do Estado de Sergipe', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('070', 'Banco de Brasília', '1940-05-02', 'E', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('075', 'Banco ABN Amro S.A.', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('077', 'Banco Inter', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('082', 'Banco Topázio', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('102', 'XP Investimentos Corretora de Câmbio Títulos e Valores Mobiliários S.A', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('104', 'Caixa Econômica Federal', '1940-05-02', 'F', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('107', 'Banco BBM', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('121', 'Agibank', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('184', 'Banco Itaú BBA', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('208', 'Banco BTG Pactual', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('212', 'Banco Original', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('218', 'Banco Bonsucesso', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('224', 'Banco Fibra', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('237', 'Bradesco', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('260', 'Nu Pagamentos S.A', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('263', 'Banco Cacique', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('265', 'Banco Fator', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('318', 'Banco BMG', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('320', 'Banco Industrial e Comercial', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('341', 'Itaú Unibanco', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('389', 'Banco Mercantil do Brasil', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('422', 'Banco Safra', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('473', 'Banco Caixa Geral', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('479', 'Banco ItaúBank', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('505', 'Banco Credit Suisse', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('604', 'Banco Industrial do Brasil', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('611', 'Banco Paulista', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('612', 'Banco Guanabara', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('623', 'Banco Pan', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('637', 'Banco Sofisa', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('643', 'Banco Pine', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('653', 'Banco Indusval', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('654', 'Banco Renner', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('655', 'Banco Votorantim', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('707', 'Góis Monteiro & Co', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('719', 'Banco Banif', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('721', 'Banco Credibel', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('735', 'Banco Neon', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('738', 'Banco Morada', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('741', 'Banco Ribeirão Preto', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('745', 'Banco Citibank', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('746', 'Banco Modal', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('748', 'Banco Cooperativo Sicredi - BANSICREDI', '1940-05-02', 'C', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('756', 'Banco Cooperativo do Brasil - BANCOOB', '1940-05-02', 'C', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
                   ('M09', 'Banco Itaucred Financiamentos', '1940-05-02', 'P', 10, '', '12345678', '2018-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- Data for Name: bibliografia; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.bibliografia
            VALUES (5, 1, 50, 'B', '1980-01-01', '2016-08-01'),
                   (10, 4, 40, 'C', '2011-06-02', '2016-08-01'),
                   (15, 11, 20, 'B', '2011-10-26', '2016-04-05'),
                   (20, 11, 30, 'B', '2011-05-20', '2011-06-10'),
                   (25, 11, 70, 'B', '2011-10-26', '2011-10-26'),
                   (30, 11, 90, 'C', '2010-10-10', '2010-10-10'),
                   (35, 12, 60, 'C', '2011-10-26', '2016-05-02'),
                   (40, 13, 20, 'B', '2015-10-23', '2015-10-23'),
                   (45, 13, 40, 'C', '2015-10-23', '2015-10-23'),
                   (50, 14, 60, 'B', '2010-10-10', '2010-10-10');
-- Data for Name: capacitacoes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.capacitacoes
            VALUES (5, 1, 10, '2016-10-01', '20016-10-01', '2016-10-18', NULL),
                   (10, 3, 20, '2016-10-01', '2016-10-10', '2016-10-18', NULL);
-- Data for Name: cidades; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.cidades
       VALUES (5, 'Sao Paulo', 'SP', 'aeroporto, rodovia, ferrovia e hidrovia', 12000000, 780, '1980-10-10', '2019-01-21'),
                   (10, 'Osasco', 'SP', 'rodovia e ferrovia', 1000000, 0, '1980-10-10', '2019-01-21'),
                   (15, 'Barueri', 'SP', 'rodovia e ferrovia', 1000000, 0, '1980-10-10', '2019-01-21'),
                   (20, 'Sao Bernardo', 'SP', 'rodovia e ferrovia', 800000, 0, '1980-10-10', '2019-01-21'),
                   (25, 'Sao Caetano', 'SP', 'rodovia e ferrovia', 750000, 0, '1980-10-10', '2019-01-21'),
                   (30, 'Diadema', 'SP', 'rodovia e ferrovia', 900000, 0, '1980-10-10', '2019-01-21'),
                   (35, 'Guarulhos', 'SP', 'aeroporto, rodovia e ferrovia', 2200000, 0, '1980-10-10', '2019-01-21'),
                   (40, 'Ourinhos', 'SP', 'rodovia e ferrovia', 105000, 280, '2008-10-10', '1918-12-13');
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.clientes
            VALUES (5, 'Mecânica Marreco', 'Vendas e Trocas de Moveis Dragão Imperial S/C Ltda.', 290, '8560', '04514512', 20000, 'B', '2015-11-05'),
                   (10, 'Tratoria do Sargento', 'Ristoranti Il Tratoria do Sargento', 600, ' 985', '        ', 25000, 'B', '2007-02-02'),
                   (25, 'Tratoria do Pirata', 'Ristoranti tre fratelli S.A.', 470, ' 1492', '12345678', 30000, 'A', '2007-01-20'),
                   (30, 'Mc Donalds', 'Rest Com S/A ', 610, ' 6500', '        ', 100000, 'B', '2008-01-20'),
                   (35, 'La Traviatta Ripante', 'Rest Com S/A ', 380, ' 125 - 15And Ap 156', '        ', 100000, 'B', '2008-01-20'),
                   (40, 'Bistro Ratatui', 'sdf sdgf', 520, ' 1245', '        ', 3456, 'A', '2011-10-22'),
                   (50, 'Restaurante Latitude Zero', 'Restaurante e Lanches Latitude Zero S/C Ltda.', 260, '8560', '04514512', 5000, 'A', '2015-10-28'),
                   (20, 'Tratoria do General', 'Restaurante da Tratoria do General S/C Ltda.', 310, ' 1254', '12345678', 12000, 'A', '2011-06-01'),
                   (15, 'Restaurante Bom Vivan', 'Restaurante "O Bom Vivan" S/C Ltda.', 550, ' 567', '12345678', 7000, 'A', '2009-12-10'),
                   (65, 'Mecânica Marreco', 'Cooperativa de mecânicos Marreco e Associados S/C Ltda.', 20, '451', '19845745', 10000, 'A', '2015-11-05'),
                   (70, 'Tarecapis', 'Mecânica de Automóveis Tarecapis S/C Ltda.', 300, '4500', '04512142', 6000, 'A', '2016-10-10'),
                   (75, 'Sterling Software', 'Sterling Software S/C Ltda.', 180, '2456', '04156145', 25000, 'A', '2016-11-01'),
                   (80, 'Vingadores', 'Associação dos vingadores de vovós desamparadas S/C Ltda.', 290, '1234', '23523453', 2000, 'A', '2016-11-10'),
                   (55, 'Autoposto São Luiz', 'Companhia de Abastecimento Autoposto São Luiz S/C Ltda.', 350, '4512', '45781245', 20000, 'A', '2015-10-28'),
                   (85, 'EdUEL', 'Editora da Universidade Estadual de Londrina S/C Ltda.', 490, '2650', '45121452', 25000, 'A', '2017-03-06');
-- Data for Name: clientestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.clientestels
            VALUES (1, 25, 5, '1232323434     ', NULL, NULL),
                   (6, 25, 5, '114528562      ', NULL, NULL),
                   (2, 25, 15, '1141524152     ', NULL, NULL),
                   (3, 25, 15, '1144141412     ', NULL, NULL),
                   (4, 25, 15, '114528562      ', NULL, NULL),
                   (5, 40, 15, '114528562      ', NULL, NULL);
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.consultas
            VALUES (2, 20, 1, '2013-03-20 08:20:00', NULL, 2, 'A', '2013-03-10'),
                   (3, 30, 1, '2013-03-20 09:20:00', NULL, 2, 'A', '2013-03-10'),
                   (4, 40, 1, '2013-03-21 07:00:00', NULL, 2, 'A', '2013-03-10'),
                   (5, 70, 1, '2013-03-21 07:20:00', NULL, 2, 'A', '2013-03-10'),
                   (6, 80, 1, '2013-03-21 07:40:00', NULL, 2, 'A', '2013-03-10'),
                   (7, 90, 1, '2016-03-21 08:00:00', NULL, 2, 'A', '2016-03-10'),
                   (8, 100, 1, '2016-03-21 10:00:00', NULL, 2, 'A', '2016-03-10'),
                   (9, 110, 1, '2016-03-21 10:20:00', NULL, 2, 'A', '2016-03-10'),
                   (10, 120, 1, '2016-03-21 10:40:00', NULL, 2, 'A', '2016-03-10'),
                   (11, 130, 1, '2016-03-21 11:00:00', NULL, 2, 'A', '2016-03-10'),
                   (12, 150, 1, '2016-03-21 08:20:00', NULL, 2, 'A', '2016-03-10'),
                   (13, 160, 1, '2016-03-21 08:40:00', NULL, 2, 'A', '2016-03-10');
-- Data for Name: contas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.contas
            VALUES ('001  ', '6632X ', '153052', 10, '2016-10-18', NULL),
                   ('001  ', '6632X ', '153060', 10, '2016-10-18', NULL),
                   ('001  ', '6633X ', '109520', 20, '2016-10-18', NULL),
                   ('001  ', '6633X ', '145241', 20, '2016-10-18', NULL),
                   ('001  ', '6632X ', '451254', 30, '2016-10-18', NULL),
                   ('001  ', '6632X ', '124527', 30, '2016-10-18', NULL);
-- Data for Name: cores; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.cores
            VALUES (1, 'abobora', 234, '2012-03-26'),
                   (2, 'Verde', 23452, '2012-03-26'),
                   (3, 'Vermelho', 1452, '2010-10-10'),
                   (4, 'Branco', 14785, '2010-10-10'),
                   (5, 'Abobora', 451256, '2010-10-10'),
                   (6, 'Amarelo', 451256, '2010-10-10'),
                   (7, 'Azul', 415636, '2010-10-10'),
                   (8, 'roxo', 234, '2012-03-26'),
                   (9, 'verde limão', 234, '2012-03-26'),
                   (10, 'DASDFASD', 12313, '2010-10-15'),
                   (15, 'ashdfahsdf', 23123, '2013-09-18');
-- Data for Name: coresveiculos; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: cursos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.cursos
            VALUES (1, 'Conhecimentos de química fundamental na arte culinária.', 1, 50, '2013-03-12'),
                   (3, 'conceitos fundamentais de astronomia', 2, 80, '2010-10-10'),
                   (4, 'Administrando Sistemas de Informação com o PostgreSQL', 4, 120, '1996-01-01'),
                   (5, 'Como Desenvolver um Software com Gambiarra', 3, 60, '2010-10-10'),
                   (6, 'Avaliação de Mercados emergentes de hipermidias', 4, 60, '2010-10-10'),
                   (7, 'Fundamentos de Engenharia de Software', 3, 80, '2010-05-10');
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.departamentos
            VALUES ('A02', 'Desenvolvimento de Rotinas de Biblio', 150, 'A01', 'Polo de Desenvolvimento de TI', 450, '2010-10-10', '2010-10-10'),
                   ('A01', 'Desenvolvimento de Software', 160, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('A11', 'Desenvolvimento de Lixo reciclável', 170, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('B01', 'Desenvolvimento de processos gerenci', 180, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('C01', 'Pesquisa de Mercado para tendências ', 190, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('D01', 'Pesquisa em Biociências', 200, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('D11', 'Oceanografia aplicada em des. de sof', 210, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('D91', 'Pesquisa e desenvolvimento de soluçõ', 220, 'B01', 'centro', 1500, '2016-03-10', '2016-03-10'),
                   ('E01', 'Des. de ambientes de escritórios sus', 230, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('E11', 'Des. de processos de construção civi', 240, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('E21', 'Pesquisa de ferramentas de arquitetu', 260, 'A01', 'Av. Luis Carlos Berrini, 2340', 8000, '2010-10-10', '2010-10-10'),
                   ('F22', 'Des. de Sists Computacionais', 250, 'A01', 'Av. Circular, 3200', 2500, '2010-10-15', '2011-05-20'),
                   ('Z97', 'Desenvolvimento de polos de energia', 290, 'Z97', 'Av. Copernico, 23-456', 7500, '2010-10-10', '2010-10-10'),
                   ('Z98', 'Desenvolvimento de Usinas Solares.', 120, 'Z97', 'Campus da Universidade de Ourinhos - SP', 900, '2010-10-10', '2010-10-10'),
                   ('Z99', 'Desenvolvimento de Usinas eólicas', 100, 'Z97', 'Centro Empresarial de Fortaleza - CE', 150, '2010-10-10', '2010-10-10');
-- Data for Name: departamentostels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.departamentostels
            VALUES (2, 'F22', 15, '1145874567     ', NULL, '2022-05-05'),
                   (4, 'A01', 15, '1425412145     ', NULL, '2022-05-15'),
                   (5, 'A01', 15, '14 33256214    ', NULL, '2022-05-15'),
                   (3, 'F22', 20, '11452145241    ', NULL, '2022-05-20');
-- Data for Name: disciplinas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.disciplinas
            VALUES (1, 1, 'CALCULO I', '', 0, '1980-01-01', NULL),
                   (2, 1, 'CALCULO II', '', 0, '1980-01-01', NULL),
                   (3, 1, 'CALCULO IV', '', 0, '1980-01-01', NULL),
                   (4, 1, 'CALCULO III', '', 0, '1980-01-01', NULL),
                   (5, 1, 'FISICA I', 'Desenvolvimento dos conceitos fundamentais da Física: Força, ação e reação, inércia, campos de força', 100, '2010-10-10', NULL),
                   (6, 1, 'FISICA II', '', 0, '1980-01-01', NULL),
                   (7, 1, 'FISICA III', '', 0, '1980-01-01', NULL),
                   (8, 3, 'FISICA IV', 'asdfasf', 100, '2012-10-05', NULL),
                   (9, 1, 'PORTUGUES I', '', 0, '1980-01-01', NULL),
                   (10, 1, 'PORTUGUES II', '', 0, '1980-01-01', NULL),
                   (11, 1, 'ALGORITMOS DE PROGRAMACAO I', '', 0, '1980-01-01', NULL),
                   (12, 1, 'ALGORITMOS DE PROGRAMACAO II', '', 0, '1980-01-01', NULL),
                   (13, 1, 'LINGUAGEM DE PROGRAMACAO I', '', 0, '1980-01-01', NULL),
                   (14, 1, 'LINGUAGEM DE PROGRAMACAO II', '', 0, '1980-01-01', NULL),
                   (15, 1, 'LINGUAGEM DE PROGRAMACAO III', '', 0, '1980-01-01', NULL),
                   (16, 1, 'LINGUAGEM DE PROGRAMACAO IV', '', 0, '1980-01-01', NULL),
                   (17, 1, 'CALCULO NUMERICO', '', 0, '1980-01-01', NULL),
                   (18, 1, 'APLICACOES DE CALCULO NUMERICO I', '', 0, '1980-01-01', NULL),
                   (19, 1, 'ETICA NA TECNOLOGIA DA INFORMA', '', 0, '1980-01-01', NULL),
                   (20, 1, 'TECNICAS DE APRESENTA', '', 0, '1980-01-01', NULL),
                   (21, 1, 'Avaliação de Qualidade em Fábrica de Software', 'Apresenta métricas e métodos de avaliação de Qualidade de So', 120, '2010-10-10', NULL),
                   (22, 1, 'ENGENHARIA DE SOFTWARE I', '', 0, '1980-01-01', NULL),
                   (27, 7, 'Antropologia moderna', 'Estudos dos comportamentos humanos no contexto dos séculos 20 e 21.', 120, '2010-10-10', NULL);
-- Data for Name: duplicatas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.duplicatas
            VALUES (10, 13, '2016-01-10', NULL, 50, 5, 45, 5, '2015-12-10'),
                   (15, 13, '2016-02-10', NULL, 50, 5, 45, 5, '2015-12-10'),
                   (5, 8, '2015-10-10', NULL, 50, 0, 50, 10, '2015-10-10'),
                   (20, 8, '2016-01-10', NULL, 50, 5, 45, 10, '2015-12-10');
-- Data for Name: editoras; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.editoras
            VALUES (1, 'Abril       ', 'Abril Editora S/C Ltda.', NULL, 450, ' 1234', '12345678', NULL, NULL, NULL, '2010-10-10'),
                   (2, 'McGraw-Books', 'Editora McGraw-Books S.A.', NULL, 290, ' 234', '1245124 ', NULL, NULL, NULL, '2005-05-20'),
                   (3, 'Nova        ', 'Nova Editora S.A.', NULL, 330, ' 1450', '1452142 ', NULL, NULL, NULL, '2006-04-20'),
                   (4, 'FDT Editores', 'FDT - Editores Associados S/C Ltda.', NULL, 460, ' 1254', '98765432', NULL, NULL, NULL, '2010-10-10'),
                   (5, 'Ericas      ', 'Editora e produtora Erica S/C Ltda.', NULL, 430, ' 234', '14512412', NULL, NULL, NULL, '2010-10-10');
-- Data for Name: editorastels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.editorastels
            VALUES (5, 1, 10, '5511856985221', 'Luiz Gama', '2019-02-20'),
                   (6, 1, 10, '5511451524643', 'Antonio Lima', '2019-02-10'),
                   (1, 4, 15, '5543451245152', 'Marsilla', '2018-12-10'),
                   (2, 4, 15, '5543895623566', 'Edivaldo', '2019-03-15'),
                   (3, 4, 15, '5543562345576', 'Guimarães', '2019-03-15'),
                   (7, 2, 15, '5511451552144', 'Carlos Molina', '2019-02-04'),
                   (8, 2, 15, '5511748451254', 'Marilice', '2019-02-04');
-- Data for Name: empresas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.empresas
            VALUES (2, 'Lorenzetti', 'Fabrica de Produtos Elétricos Lorenzetti S/C Ltda.', '4567646546546   ', 420, ' 234', '11452145', 1, 'P', '1986-05-20', '2010-10-10'),
                   (3, 'Supermack', 'Equipamentos Frigoríficos  Supermack S/C Ltda.', '34564643456     ', 560, ' 234', '11451245', 1, 'G', '1996-04-20', '2012-10-10'),
                   (4, 'TecMon', 'Tecnica de Montagens e Ajustes de Equip. Domiciliares S/C Ltda', '3456354675467856', 440, ' 456', '41452145', 1, 'G', '1966-06-20', '2010-10-10'),
                   (1, 'FAME', 'Fabrica Americana de Materiais Elétricos S.A.', '45674567456     ', 530, ' 1456', '11452145', 2, 'M', '2005-08-10', '2011-06-10');
-- Data for Name: empresastels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.empresastels
            VALUES (5, 1, 15, '1145265236     ', 'José', '2016-05-02'),
                   (6, 1, 20, '154221512150221', 'Nabucodonosor', '2016-05-02'),
                   (7, 1, 20, '4152241251121  ', 'Ana', '2016-05-20');
-- Data for Name: especialidadesmedicas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.especialidadesmedicas
            VALUES (1, 'Clínica Geral', '', '2010-10-05'),
                   (2, 'Pediatria', '', '2010-10-05'),
                   (3, 'Geriatria', '', '2010-10-05'),
                   (4, 'Cardiolgia', '', '2010-10-05'),
                   (5, 'Ortopedia', '', '2010-10-05'),
                   (6, 'Gastroenterologia', '', '2010-10-05'),
                   (7, 'Infectologista', '', '2010-12-10'),
                   (8, 'Oncolologista', '', '2010-12-10');
-- Data for Name: estadosdauniao; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.estadosdauniao
            VALUES ('AC', 'Acre',             'Rio Branco', NULL, 100, NULL, 'BRA', '2018-09-30'),
                   ('AL', 'Alagoas',          'Maceio',     NULL, 150, NULL, 'BRA', '2018-09-30'),
                   ('AM', 'Amazonas',         'Manaus',     NULL, 250, NULL, 'BRA', '2018-09-30'),
                   ('BA', 'Bahia',            'Salvador',   NULL, 400, NULL, 'BRA', '2018-09-30'),
                   ('ES', 'Espírito Santo',   'Vitória',    NULL, 150, NULL, 'BRA', '2018-09-30'),
                   ('DF', 'Distrito Federal', 'Brasilia',   NULL, 10,  NULL, 'BRA', '2018-09-30'),
                   ('SP', 'São Paulo',        'São Paulo',  NULL, 500, NULL, 'BRA', '2018-09-30');
-- Data for Name: fabricantes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.fabricantes
            VALUES (1, 'Volkswagen', 'Fábrica de Veículos Brasileiros VolksWagen S.A.', NULL, 100, ' 34000', '14512413', NULL, NULL, NULL, '2001-05-20'),
                   (2, 'FIAT', 'Fabrica Italiana de Automóveis S.A', NULL, 90, ' 3450', '12987456', NULL, NULL, NULL, '2001-05-20'),
                   (3, 'GM', 'Montador de Veículos General Motors Cia. Ltda.', NULL, 100, ' Km 50', '0232345 ', NULL, NULL, NULL, '1962-10-10'),
                   (4, 'Autolatina', 'Fabrica de veículos automotivos Autolatina S.A.', NULL, 460, '4500', '0451245 ', NULL, NULL, NULL, '2010-10-10'),
                   (5, 'Nissan', 'Fábrica de automóveis Nissan do Brasil S.A.', NULL, 170, '1452', '12345678', NULL, NULL, NULL, '2010-10-10');
-- Data for Name: fabricantestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.fabricantestels
            VALUES (5, 1, 10, '1178754745     ', 'Hermann', '2019-05-10'),
                   (4, 2, 10, '1144566776     ', 'Ennio', '2019-04-20'),
                   (1, 2, 20, '1144566776     ', 'Ennio', '2019-04-20'),
                   (2, 2, 20, '1144566776     ', 'Ennio', '2019-04-21'),
                   (3, 2, 20, '1144566776     ', 'Ennio', '2019-05-10'),
                   (6, 3, 10, '1197654678     ', 'Smith', '2019-09-01'),
                   (7, 4, 10, '1147574845     ', 'Joselva', '2019-09-01'),
                   (8, 5, 10, '1174851245     ', 'Jose Kualker', '2019-09-01');
-- Data for Name: faturas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.faturas
            VALUES (5, 1, '2016-11-10', NULL, 2105, 0, 2255, 150, '2016-11-12'),
                   (10, 1, '2016-12-10', NULL, 850, 0, 850, 0, '2016-10-10'),
                   (15, 2, '2016-11-10', NULL, 2500, 0, 2500, 0, '2016-11-10'),
                   (20, 3, '2016-11-10', NULL, 2500, 0, 2500, 0, '2016-11-10'),
                   (25, 3, '2015-12-10', NULL, 650, 0, 650, 0, '2016-11-10'),
                   (30, 1, '2010-10-10', NULL, 500, 80, 420, 120, '2010-10-05');
-- Data for Name: feitospor; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: fornecedores; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.fornecedores
            VALUES (1, 'Fazenda Rio Branco', 'Latic', NULL, 370, ' Km 350', '12345678', 1, 100000, NULL, NULL, NULL, '2008-01-20'),
                   (2, 'Leite Mont Blanc', 'Laticinio Mont Blanc S/C Ltda.', NULL, 590, ' Km 289', '12345678', 2, 120000, NULL, NULL, NULL, '2010-10-10'),
                   (5, 'Hamburgueria Girafa', 'Restaurante Franco-Italiano Girafa S/C Ltda.', NULL, 70, ' 4345', '12345678', 2, 5000, NULL, NULL, NULL, '1998-10-10'),
                   (10, 'Fazenda Rio Claro', 'Fazenda de produtos laticionios Rio Claro S/C Ltda.', NULL, 240, 'Km 35', '74512845', 2, 50000, NULL, NULL, NULL, '2010-10-10');
-- Data for Name: fornecedorestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.fornecedorestels
            VALUES (1, 1, 10, '1174185296     ', NULL, '2019-09-02'),
                   (2, 2, 10, '5474185296     ', NULL, '2019-09-02'),
                   (3, 5, 10, '1196385274     ', NULL, '2019-09-02'),
                   (4, 10, 10, '3145124512     ', NULL, '2019-09-02'),
                   (5, 1, 15, '43985264521    ', NULL, '2019-09-02');
-- Data for Name: fornecimentos; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.funcionarios
            VALUES (40, 'MAUDE', 'SETRIGHT', 'E11', 10, 99, 470, ' 234', '3332', '1994-09-12', 'F', '1961-04-21', '', 35900, 300, 1272, '        ', '1980-01-01'),
                   (60, 'IRVING', 'STERN', 'D11', 4, 16, 380, ' 125 - 15And Ap 156', '6423', '2003-09-14', 'M', '1975-07-07', '', 72250, 500, 2580, '        ', '1980-01-01'),
                   (100, 'THEODORE', 'SPENSER', 'E21', 6, 14, 600, ' 985', '0972', '2000-06-19', 'M', '1980-12-18', '', 86150, 500, 2092, '        ', '1980-01-01'),
                   (110, 'VINCENZO', 'LUCCHESSI', 'A01', 7, 19, 570, ' 25 - Vila Siqueira', '3490', '1988-05-16', 'M', '1959-11-05', '', 66500, 900, 3720, '        ', '1980-01-01'),
                   (160, 'ELIZABETH', 'PIANKA', 'D11', 6, 17, 550, ' 567', '3782', '2006-10-11', 'F', '1980-04-12', '', 62250, 400, 1780, '        ', '1980-01-01'),
                   (170, 'MASATOSHI', 'YOSHIMURA', 'D11', 7, 16, 540, ' 234', '2890', '1999-09-15', 'M', '1981-01-05', '', 44680, 500, 1974, '        ', '1980-01-01'),
                   (180, 'MARILYN', 'SCOUTTEN', 'D11', 7, 17, 450, ' 1234', '1682', '2003-07-07', 'F', '1979-02-21', '', 51340, 500, 1707, '        ', '1980-01-01'),
                   (210, 'WILLIAM', 'JONES', 'D11', 10, 17, 460, ' 1254', '0942', '1998-04-11', 'M', '2003-02-23', '', 68270, 400, 1462, '        ', '1980-01-01'),
                   (220, 'JENNIFER', 'LUTZ', 'D11', 10, 18, 430, ' 234', '0672', '1998-08-29', 'F', '1978-03-19', '', 49840, 600, 2387, '        ', '1980-01-01'),
                   (230, 'JAMES', 'JEFFERSON', 'A11', 7, 16, 530, ' 1456', '2094', '1996-11-21', 'M', '1980-05-30', '', 42180, 400, 1774, '        ', '1980-01-01'),
                   (240, 'SALVATORE', 'MARINO', 'D01', 10, 17, 420, ' 234', '3780', '2004-12-05', 'M', '2002-03-31', '', 48760, 600, 2301, '        ', '1980-01-01'),
                   (250, 'DANIEL', 'SMITH', 'D01', 9, 15, 560, ' 234', '0961', '1999-10-30', 'M', '1969-11-12', '', 49180, 400, 1534, '        ', '1980-01-01'),
                   (260, 'SYBIL', 'JOHNSON', 'D01', 9, 16, 440, ' 456', '8953', '2005-09-11', 'F', '1976-10-05', '', 47250, 300, 1380, '        ', '1980-01-01'),
                   (270, 'MARIA', 'PEREZ', 'D01', 10, 15, 100, ' 34000', '9001', '2006-09-30', 'F', '2003-05-26', '', 37380, 500, 2190, '        ', '1980-01-01'),
                   (280, 'ETHEL', 'SCHNEidER', 'E11', 10, 17, 490, ' 452', '8997', '1997-03-24', 'F', '1980-01-01', 'Um teste de troca', 36250, 500, 2100, '12345678', '2010-10-10'),
                   (330, 'DIAN', 'HEMMINGER', 'A01', 8, 18, 470, ' 1492', '3978', '1995-01-01', 'F', '1973-08-14', '', 46500, 1000, 4220, '        ', '1980-01-01'),
                   (340, 'GREG', 'ORLANDO', 'A01', 7, 14, 470, ' 234', '2167', '2002-05-05', 'M', '1972-10-18', '', 39250, 600, 2340, '        ', '1980-01-01'),
                   (350, 'KIM', 'NATZ', 'C01', 8, 18, 470, ' 234', '1793', '2006-12-15', 'F', '1976-01-19', '', 68420, 600, 2274, '        ', '1980-01-01'),
                   (360, 'KIYOSHI', 'YAMAMOTO', 'D11', 7, 16, 470, ' 234', '2890', '2005-09-15', 'M', '1981-01-05', '', 64680, 500, 1974, '        ', '1980-01-01'),
                   (370, 'REBA', 'JOHN', 'D11', 8, 18, 610, ' 6500', '0672', '2005-08-29', 'F', '1978-03-19', '', 69840, 600, 2387, '        ', '1980-01-01'),
                   (380, 'ROBERT', 'MONTEVERDE', 'D01', 8, 17, 610, ' 6500', '3780', '2004-12-05', 'M', '1984-03-31', '', 37760, 600, 2301, '        ', '1980-01-01'),
                   (390, 'EILEEN', 'SCHWARTZ', 'E11', 9, 17, 360, ' 1400', '8997', '1997-03-24', 'F', '1966-03-28', '', 46250, 500, 2100, '        ', '1980-01-01'),
                   (400, 'MICHELLE', 'SPRINGER', 'E11', 9, 99, 520, ' 1245', '3332', '1994-09-12', 'F', '1961-04-21', '', 35900, 300, 1272, '        ', '1980-01-01'),
                   (410, 'HELENA', 'WONG', 'E21', 9, 14, 600, ' 985', '2103', '2006-02-23', 'F', '1971-07-18', '', 35370, 500, 2030, '        ', '1980-01-01'),
                   (420, 'ROY', 'ALONZO', 'E21', 10, 16, 590, ' 35 - Camp', '5698', '1997-07-05', 'M', '1956-05-17', '', 31840, 500, 1907, '        ', '1980-01-01'),
                   (430, 'JOSE', 'BUENO', 'D01', 9, 14, 570, ' 25 - Vila Siqueira', '2145', '1980-01-01', 'M', '1980-01-01', '', 1250, 100, 500, '        ', '1980-01-01'),
                   (440, 'Teste', 'Silva', 'A01', 12, 14, 570, ' 25 - Vila Siqueira', '3232', '2010-05-10', 'M', '1985-10-20', '', 1600, 200, 200, '        ', '1980-01-01'),
                   (450, 'Louis', 'Armstrong', 'A01', 1, 18, 590, ' 35 - Camp', '452 ', '2002-10-20', 'M', '1958-05-15', 'Músico', 2500, 500, 400, '1452151 ', '2002-10-20'),
                   (460, 'Ella', 'Frintgerald', 'B01', 1, 18, 600, ' 985', '452 ', '2002-10-20', 'F', '1958-05-14', 'Cantora', 2500, 500, 400, '14511254', '2002-10-05'),
                   (470, 'Leonidas', 'Spartacus', 'D11', 5, 20, 600, ' 985', '666 ', '1901-10-10', 'M', '1960-05-05', 'Forte pacas', 12000, 1000, 500, '0451245 ', '1902-10-10'),
                   (310, 'WING WONG', 'LEE', 'E21', 8, 14, 600, ' 985', '2103', '2006-02-23', 'M', '1971-07-18', '', 45370, 500, 2030, '        ', '1980-01-01'),
                   (20, 'MICHAEL', 'THOMPSON', 'B01', 3, 18, 470, ' 1492', '3476', '2003-10-10', 'M', '1978-02-02', '', 94250, 800, 3300, '        ', '1980-01-01'),
                   (30, 'SALLY', 'KWAN', 'C01', 2, 20, 470, ' 234', '4738', '2005-04-05', 'F', '1971-05-11', '', 98250, 800, 3060, '        ', '1980-01-01'),
                   (320, 'JASON MORISON', 'GOUNOT', 'E21', 9, 16, 590, ' 35 - Camp', '5698', '1977-05-05', 'M', '1956-05-17', '', 43840, 500, 1907, '        ', '1980-01-01'),
                   (10, 'CHRISTINE MARIE', 'HAAS', 'A01', 1, 18, 350, ' 1243', '3978', '1995-01-01', 'F', '1963-08-24', '', 152750, 1000, 4220, '        ', '1980-01-01'),
                   (290, 'JOHN CARPENTER', 'PARKER', 'E11', 10, 99, 350, ' 1243', '4502', '2006-05-30', 'M', '1985-07-09', '', 35340, 300, 1227, '        ', '1980-01-01'),
                   (300, 'PHILIP MORIS', 'SMITH', 'E11', 10, 14, 550, ' 567', '2095', '2002-06-19', 'M', '1976-10-27', '', 37750, 400, 1420, '        ', '1980-01-01'),
                   (120, 'SEAN PEAN', 'O CONNELL', 'A01', 8, 14, 590, ' 35 - Camp', '2167', '1993-12-05', 'M', '1972-10-18', '', 49250, 600, 2340, '        ', '1980-01-01'),
                   (130, 'DOLORES MARIA', 'QUINTANA', 'C01', 7, 16, 580, ' 345', '4578', '2001-07-28', 'F', '1955-09-15', '', 73800, 500, 1904, '        ', '1980-01-01'),
                   (150, 'BRUCE TAYLOR', 'ADAMSON', 'A01', 7, 16, 490, ' 452', '4510', '2002-02-12', 'M', '1977-05-17', NULL, 55280, 500, 2022, '12312312', '2010-10-10'),
                   (190, 'JAMES PAUL', 'WALKER', 'D11', 9, 16, 290, ' 234', '2986', '2004-07-26', 'M', '1982-06-25', '', 50450, 400, 1636, '        ', '1980-01-01'),
                   (200, 'DAVID CHARLES', 'BROWN', 'D11', 9, 16, 330, ' 1450', '4501', '2002-03-03', 'M', '1971-05-29', '', 57740, 600, 2217, '        ', '1980-01-01'),
                   (50, 'JOHN SILVESTER', 'GEYER', 'E01', 5, 16, 610, ' 6500', '6789', '1979-08-17', 'M', '1955-09-15', '', 80175, 800, 3214, '        ', '1980-01-01'),
                   (70, 'EVA MARIA', 'PULASKI', 'D01', 10, 16, 360, ' 1400', '7831', '2005-09-30', 'F', '2003-05-26', '', 96170, 700, 2893, '        ', '1980-01-01'),
                   (80, 'RAMLAL ABDUL', 'MEHTA', 'E21', 10, 16, 520, ' 1245', '9990', '1995-07-07', 'M', '1962-08-11', '', 39950, 400, 1596, '        ', '1980-01-01'),
                   (90, 'EILEEN B''ORGN', 'HENDERSON', 'E11', 10, 16, 390, ' 150', '5498', '2000-08-15', 'F', '1971-05-15', '', 89750, 600, 2380, '        ', '1980-01-01'),
                   (480, 'HELENA', 'WONG', 'E21', 9, 14, 600, ' 985', '2103', '2006-02-23', 'F', '1971-07-18', '', 35370, 500, 2030, '        ', '1980-01-01');
-- Data for Name: funcionariosplanos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.funcionariosplanos
            VALUES (5, 10, 1, '2016-12-07', '2016-12-07', '2016-12-07'),
                   (10, 20, 1, '2016-12-07', '2016-12-07', '2016-12-07'),
                   (15, 10, 2, '2016-12-07', '2016-12-07', '2016-12-07'),
                   (20, 10, 4, '2016-12-07', '2016-12-07', '2016-12-07');
-- Data for Name: funcionariostels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.funcionariostels
            VALUES (4, 20, 5, '2345345        ', 'José', '2017-05-20'),
                   (2, 10, 10, '2342345        ', 'Ana', '2018-04-10'),
                   (3, 10, 15, '23453245       ', 'Rui', '2018-05-10'),
                   (1, 10, 20, '1231313        ', 'Abel', '2018-06-25');
-- Data for Name: funcoes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.funcoes
            VALUES (1, 'Presidente', '', 15, '1980-01-01'),
                   (2, 'Diretor Comercial', '', 5, '1980-01-01'),
                   (3, 'Diretor Administrativo', '', 5, '1980-01-01'),
                   (4, 'Diretor Produ', '', 5, '1980-01-01'),
                   (5, 'Gerente De Vendas', '', 1, '1980-01-01'),
                   (6, 'Gerente de Compras', '', 1, '1980-01-01'),
                   (7, 'Gerente de contas', '', 1, '1980-01-01'),
                   (8, 'Gerente de Recursos Humanos', '', 1, '1980-01-01'),
                   (9, 'Gerente de Rela', '', 1, '1980-01-01'),
                   (10, 'Gerente de Opera', '', 1, '1980-01-01'),
                   (11, 'Professor', '', 2, '1980-01-01'),
                   (12, 'Auxiliar Administrativo', '', 1, '1980-01-01');
-- Data for Name: grausdeescolaridade; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.grausdeescolaridade
            VALUES (14, 'Ensino fundamental I', 4, '1980-01-01'),
                   (15, 'Ensino Fundamental II', 4, '1980-01-01'),
                   (16, 'Jardim I', 1, '1980-01-01'),
                   (17, 'Jardim II', 2, '1980-01-01'),
                   (18, 'Ensino Medio', 3, '1980-01-01'),
                   (19, 'Superior', 5, '1980-01-01'),
                   (20, 'Pos-Graduacao (Mestrado)', 3, '1980-01-01'),
                   (99, 'Pos-Graduacao (Doutorado)', 5, '1980-01-01'),
                   (30, 'Pos-Graduacao (MBA)', 1, '1980-01-01'),
                   (31, 'Mestrado', 3, '2011-12-10');
-- Data for Name: habilitacoes; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.habilitacoes
            VALUES (10, 3, 2, '2010-05-05', '2010-05-05', '2010-05-10'),
                   (15, 3, 2, '2010-10-10', '2010-10-10', '2010-10-10'),
                   (20, 3, 2, '2012-10-10', '2012-10-10', '2012-10-15'),
                   (30, 3, 4, '2010-05-05', '2010-05-05', '2010-05-10'),
                   (35, 3, 4, '2012-10-10', '2012-10-10', '2012-10-15'),
                   (40, 3, 6, '2012-10-10', '2012-10-10', '2012-10-15'),
                   (45, 3, 21, '2012-10-10', '2012-10-10', '2012-10-15'),
                   (55, 3, 24, '2012-10-10', '2012-10-10', '2012-10-15'),
                   (60, 4, 2, '2010-10-10', '2010-10-10', '2010-10-10'),
                   (70, 5, 1, '2012-10-10', '2012-10-10', '2012-10-15');
-- Data for Name: historicoprofissional; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.historicoprofissional
            VALUES (4, 90, 1, 25, '2002-06-26', '2004-07-30', '2012-10-01'),
                   (11, 150, 1, 5, '2007-05-10', '2007-09-10', '2007-05-10'),
                   (1, 10, NULL, 15, '2001-01-20', '2002-06-25', '2010-10-01'),
                   (3, 60, 1, 20, '2001-01-20', '2002-06-25', '2012-08-12'),
                   (5, 70, 1, 30, '2012-10-10', '2013-11-10', '2013-06-19'),
                   (6, 150, 1, 30, '2010-10-10', '2011-10-10', '2013-06-21');
-- Data for Name: instituicoesdeensino; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.instituicoesdeensino
            VALUES (1, 'Faculdade de Belas Artes', 60, ' 1500', 'P', '1958-05-10', '12767890', '2001-01-10'),
                   (2, 'Faculdade de Arqitetura de Urbanismo de S', 120, ' 500', 'G', '1952-05-10', '        ', '2001-01-10'),
                   (3, 'Escola Politecnica da USP', 10, ' 564 - sob a escada', 'G', '1892-01-10', '14514251', '2001-10-10'),
                   (4, 'Escola de 1 e 2 Grau Amadeu Amaral', 500, ' 1200', 'G', '1918-06-20', '14215125', '1996-01-01'),
                   (5, 'Escola Superior de Propaganda e Marketing', 470, ' 3456', 'P', '1950-01-10', '15642854', '2010-10-10');
-- Data for Name: instituicoestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.instituicoestels
            VALUES (1, 5, 15, '1433526523     ', NULL, '2016-08-28'),
                   (2, 5, 20, '1545124512     ', NULL, '2016-08-28'),
                   (3, 5, 20, '1124512542     ', NULL, '2016-08-28'),
                   (4, 3, 20, '1425252541     ', NULL, '2016-08-28'),
                   (5, 3, 20, '1145215213     ', NULL, '2016-08-28'),
                   (7, 3, 20, '545454         ', NULL, '2016-08-28');
-- Data for Name: inventarios; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: livros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.livros
            VALUES (10, 'Preparando pratos com Lagostas', NULL, 1, '2010-10-12', '2010', NULL, 20, 2, '2011-08-01'),
                   (20, 'Cálculo Diferencial e Integral', NULL, 1, '2010-10-12', '2010', NULL, 40, 10, '2011-08-01'),
                   (30, 'exercicios de matematica', NULL, 3, '2008-10-10', '2008', NULL, 50, 10, '2011-08-01'),
                   (50, 'Física Quantica', NULL, 3, '2008-10-10', '2008', NULL, 60, 20, '2011-08-01'),
                   (60, 'Introdução a Bancos de Dados', NULL, 1, '2008-10-10', '2008', NULL, 80, 20, '2011-08-01'),
                   (70, 'Cálculo Diferencial e Integral', NULL, 2, '2010-10-12', '2010', NULL, 120, 20, '2011-08-01'),
                   (80, 'Projetos de Grandes Estruturas', NULL, 3, '2010-10-10', '2010', NULL, 150, 25, '2011-08-01'),
                   (90, 'Cálculo Estrutural I', NULL, 1, '2010-10-12', '2010', NULL, 200, 50, '2011-08-01'),
                   (40, 'O Alfabeto dos Numeros', NULL, 1, '2008-10-10', '2008', NULL, 20, 5, '2011-08-01'),
                   (92, 'A Menina que roubava Livros', NULL, 1, '2007-04-10', '2007', NULL, 75, 10, '2007-05-10'),
                   (93, 'O fim da eternidade', NULL, 1, '2019-09-10', '2019', 456, 35, 15, '2019-09-30');
-- Data for Name: logradouros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.logradouros
            VALUES (10, 'dos alfineiros', 5, 33, NULL, '1996-01-01'),
                   (40, 'Luiz Antonio', 5, 33, NULL, '2000-05-29'),
                   (70, 'Brigadeiro Luis Antonio', 10, 33, NULL, '2001-01-10'),
                   (100, 'Anchieta', 5, 32, NULL, '2001-05-20'),
                   (240, 'das Trombetas', 5, 2, NULL, '2005-03-12'),
                   (90, 'Troncoso', 5, 33, NULL, '2001-05-20'),
                   (110, 'Miguel Faria Lima', 10, 33, NULL, '2001-08-21'),
                   (130, 'das Laranjeiras', 20, 33, NULL, '2002-01-21'),
                   (140, 'Direita', 10, 33, NULL, '2002-05-13'),
                   (150, 'Roberto Simonsen', 20, 33, NULL, '2002-05-16'),
                   (160, 'dos Alfineiros', 5, 33, NULL, '2002-05-28'),
                   (190, 'Sta Maria da Conceição', 5, 33, NULL, '2003-05-27'),
                   (200, 'Tavares de Miranda', 10, 33, NULL, '2004-02-10'),
                   (210, 'MMDC', 10, 33, NULL, '2004-02-14'),
                   (230, 'Circular', 5, 33, NULL, '2005-02-16'),
                   (250, 'Celso Garcia', 20, 33, NULL, '2005-03-25'),
                   (270, 'Brigadeiro Faria Lima', 5, 33, NULL, '2005-05-14'),
                   (280, 'Troncoso Perez', 20, 33, NULL, '2005-05-20'),
                   (20, 'Horácio Soares', 10, 4, NULL, '1998-10-10'),
                   (50, 'Ricardo Berrini', 5, 4, NULL, '2000-06-14'),
                   (60, 'Universitária', 5, 4, NULL, '2001-01-10'),
                   (120, 'Politécnica', 10, 4, NULL, '2001-10-10'),
                   (180, 'João Cabral de Mello Netto', 5, 4, NULL, '2003-04-23'),
                   (220, 'Celso Garcia', 20, 4, NULL, '2005-01-10'),
                   (260, 'dos Autonomistas', 20, 4, NULL, '2005-05-12'),
                   (290, 'dos Timbiras', 10, 4, NULL, '2005-05-20'),
                   (300, 'Campos Elíseos', 10, 4, NULL, '2005-05-28'),
                   (310, 'Filadélfia', 5, 4, NULL, '2005-09-18'),
                   (320, 'Maranhão', 5, 4, NULL, '2005-12-13'),
                   (170, 'Quintino Bocaiuva', 5, 33, NULL, '2002-10-21'),
                   (80, 'Doze de Outubro', 5, 33, NULL, '2001-05-16'),
                   (490, 'Arthur Thomas', 5, 4, NULL, '2010-10-10'),
                   (610, 'Vital Brasil', 10, 4, NULL, '2014-03-14'),
                   (620, 'das Nações Unidas', 5, 4, NULL, '2013-10-10'),
                   (570, 'Anhaguera', 10, 32, NULL, '2012-10-10'),
                   (590, 'Castelo Branco', 10, 32, NULL, '2014-01-20'),
                   (350, 'Pamplona', 5, 2, NULL, '2007-01-20'),
                   (380, 'Pérola Bygton', 5, 28, NULL, '2009-10-10'),
                   (370, 'Ibitirama', 5, 13, NULL, '2008-01-20'),
                   (510, 'Quintino Bocaiuva', 5, 33, NULL, '2010-10-10'),
                   (520, 'Pamplona', 10, 33, NULL, '2011-06-01'),
                   (530, 'Bresser', 10, 33, NULL, '2011-06-10'),
                   (540, 'Cristóvão Bueno', 20, 33, NULL, '2011-10-22'),
                   (550, 'Gaspar Bueno de Almeida', 5, 33, NULL, '2011-10-24'),
                   (560, 'Paraisópolis', 10, 33, NULL, '2012-10-10'),
                   (580, 'Alvarenga Peixoto', 5, 33, NULL, '2013-03-20'),
                   (600, 'Pelotas', 10, 33, NULL, '2014-03-10'),
                   (330, 'Liberdade', 10, 4, NULL, '2006-04-20'),
                   (450, 'Rubens de Almeida Falcão', 10, 4, NULL, '2010-10-10'),
                   (460, 'Rio Branco', 35, 4, NULL, '2010-10-10'),
                   (470, 'Ruben Berta', 5, 4, NULL, '2010-10-10'),
                   (340, 'Almeida Lima Gutemberg', 10, 33, NULL, '2006-05-13'),
                   (360, 'Augusta', 10, 33, NULL, '2007-02-02'),
                   (390, 'Paulo Sá', 10, 33, NULL, '2009-12-10'),
                   (400, 'Altino Arantes', 5, 33, NULL, '2010-02-12'),
                   (410, 'Rui Barbosa', 5, 33, NULL, '2010-02-12'),
                   (420, 'dos Alfineiros', 10, 33, NULL, '2010-10-10'),
                   (430, 'São Joaquim', 20, 33, NULL, '2010-10-10'),
                   (440, 'Alba', 5, 33, NULL, '2010-10-10'),
                   (480, 'dos Maias', 10, 33, NULL, '2010-10-10'),
                   (500, 'Bela Cintra', 10, 33, NULL, '2010-10-10');
-- Data for Name: logradourostipos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.logradourostipos
            VALUES (1, 'Aeroporto', '2018-10-25'),
                   (2, 'Alameda', '2018-10-25'),
                   (3, 'Área', '2018-10-25'),
                   (4, 'Avenida', '2018-10-25'),
                   (5, 'Campo', '2018-10-25'),
                   (6, 'Chácara', '2018-10-25'),
                   (7, 'Colônia', '2018-10-25'),
                   (8, 'Condomínio', '2018-10-25'),
                   (9, 'Conjunto', '2018-10-25'),
                   (10, 'Distrito', '2018-10-25'),
                   (11, 'Esplanada', '2018-10-25'),
                   (12, 'Estação', '2018-10-25'),
                   (13, 'Estrada', '2018-10-25'),
                   (14, 'Favela', '2018-10-25'),
                   (15, 'Fazenda', '2018-10-25'),
                   (16, 'Feira', '2018-10-25'),
                   (17, 'Jardim', '2018-10-25'),
                   (18, 'Ladeira', '2018-10-25'),
                   (19, 'Lago', '2018-10-25'),
                   (20, 'Lagoa', '2018-10-25'),
                   (21, 'Largo', '2018-10-25'),
                   (22, 'Loteamento', '2018-10-25'),
                   (23, 'Morro', '2018-10-25'),
                   (24, 'Núcleo', '2018-10-25'),
                   (25, 'Parque', '2018-10-25'),
                   (26, 'Passarela', '2018-10-25'),
                   (27, 'Pátio', '2018-10-25'),
                   (28, 'Praça', '2018-10-25'),
                   (29, 'Quadra', '2018-10-25'),
                   (30, 'Recanto', '2018-10-25'),
                   (31, 'Residencial', '2018-10-25'),
                   (32, 'Rodovia', '2018-10-25'),
                   (33, 'Rua', '2018-10-25'),
                   (34, 'Setor', '2018-10-25'),
                   (35, 'Sítio', '2018-10-25'),
                   (36, 'Travessa', '2018-10-25'),
                   (37, 'Trecho', '2018-10-25'),
                   (38, 'Trevo', '2018-10-25'),
                   (39, 'Vale', '2018-10-25'),
                   (40, 'Vereda', '2018-10-25'),
                   (41, 'Via', '2018-10-25'),
                   (42, 'Viaduto', '2018-10-25'),
                   (43, 'Viela', '2018-10-25'),
                   (44, 'Vila', '2018-10-25');
-- Data for Name: matriculas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.matriculas
            VALUES (2, 1, 20, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (3, 1, 30, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (4, 1, 40, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (5, 2, 10, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (6, 2, 20, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (7, 2, 30, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (8, 2, 40, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (9, 3, 10, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (10, 3, 20, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (11, 3, 30, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (12, 3, 40, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (13, 4, 10, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (14, 4, 20, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (15, 4, 30, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (16, 4, 40, '2014-08-01', '2015-06-30', '2015-07-05'),
                   (21, 5, 230, '2012-10-10', '2013-10-10', '2012-10-05'),
                   (1, 1, 70, '2014-08-01', '2015-06-30', '2015-07-05');
-- Data for Name: medicos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.medicos
            VALUES (1, 'Sebastião Quirino dos Santos', 1234, 5, 1, 350, '1450 - ap45', '12345678', 350, '1460 - 25ºAndar Cj 2547', '14258963', 'A', '2010-10-05'),
                   (2, 'Franco da Rocha', 1233, 1, 1, 470, '', '87654321', 350, '', '41852963', 'D', '2010-10-05'),
                   (3, 'Rogerio Albuquerque de Oliveira', 1235678, 2, NULL, 240, '', '85274163', 350, '', '85241963', 'A', '1986-05-10'),
                   (4, 'Marina Emanuela Carolina Bizeo', 123452, 4, NULL, 240, '450', '74163852', 620, '540', '89456324', 'A', '2010-10-10'),
                   (5, 'teste 4 de Inclusão', 1234567684, 8, 3, 300, '1852 - Ap. 254', '12654789', 260, '786 - 3ºAndar conjunto 39', '45745645', 'A', '2020-10-25'),
                   (6, 'Geraldo Luiz Albuquerque Ramos', 7765765, 1, 4, 610, '', '63741258', 300, '', '98654253', 'D', '2010-10-10'),
                   (7, 'João Luiz Constantino Araújo', 123123, 2, 2, 470, '', '36258147', 470, '', '85236941', 'D', '2010-10-10'),
                   (8, 'Alberto Clementino dos Santos', 332222, 3, 2, 20, '500', '65487123', 470, '456', '12345698', 'A', '2001-10-05'),
                   (9, 'teste 2 de inclusão - ALTERANDO', 12676892, 8, 3, 300, '1852 - Ap. 254', '12654789', 260, '786 - 3ºAndar conjunto 39', '45745645', 'A', '2020-10-25'),
                   (10, 'teste 4 de exclusão - ALTERANDO', 1276892, 8, 3, 300, '1852 - Ap. 254', '12654789', 260, '786 - 3ºAndar conjunto 39', '45745645', 'A', '2020-10-25'),
                   (11, 'Sebastião Quirino da Costa Santos', 12345, 5, 1, 350, '1450 - ap45', '12345678', 350, '1460 - 25ºAndar Cj 2547', '14258963', 'A', '2010-10-05'),
                   (12, 'Franco da Rocha', 12336, 1, 1, 470, '', '87654321', 350, '', '41852963', 'D', '2010-10-05'),
                   (13, 'Rogerio Albuquerque de Oliveira', 125678, 2, NULL, 240, '', '85274163', 350, '', '85241963', 'A', '1986-05-10'),
                   (14, 'Elisabeth Juliana Camargo', 1233452, 4, NULL, 240, '450', '74163852', 620, '540', '89456324', 'A', '2010-10-10'),
                   (15, 'teste 1 de inclusão', 12345684, 8, 3, 300, '1852 - Ap. 254', '12654789', 260, '786 - 3ºAndar conjunto 39', '45745645', 'A', '2020-10-25'),
                   (16, 'Geraldo Luiz Albuquerque Ramos', 17765765, 1, 4, 610, '', '63741258', 300, '', '98654253', 'D', '2010-10-10'),
                   (17, 'Natalia Felícia Queiroz', 12318723, 2, 2, 470, '', '36258147', 470, '', '85236941', 'D', '2010-10-10'),
                   (18, 'Alberto Clementino dos Santos', 34532222, 3, 2, 20, '500', '65487123', 470, '456', '12345698', 'A', '2001-10-05');
-- Data for Name: medicostels; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: movimentos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.movimentos
            VALUES (1, 10, 50, '2010-10-10', 10, '2010-10-10', '2010-10-10', '2010-10-15'),
                   (2, 40, 80, '2011-08-25', 10, '2011-08-25', '2011-08-25', '2011-08-25'),
                   (3, 40, 70, '2011-08-31', 20, '2011-08-31', '2011-08-31', '2011-08-31'),
                   (4, 40, 200, '2011-08-31', 30, '2011-08-31', '2011-08-31', '2011-08-31'),
                   (5, 10, 50, '2010-10-11', 30, '2010-10-11', '2010-10-11', '2010-10-15'),
                   (7, 10, 50, '2010-10-10', 20, '2010-10-10', '2010-10-10', '2010-10-15'),
                   (6, 20, 150, '2010-10-10', 20, '2010-10-15', '2010-10-14', '2010-10-10');
-- Data for Name: movimentostipos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.movimentostipos
            VALUES (10, 'Entrada em Tombamento', 'A', '2011-08-20'),
                   (20, 'Saida de Tombamento', 'A', '2011-08-20'),
                   (30, 'Disponibilização em Acervo', 'A', '2011-08-20'),
                   (40, 'Retirada da Acervo', 'S', '2011-08-20'),
                   (50, 'Devolução de Retirada do Acervo', 'E', '2011-08-20'),
                   (60, 'Consulta do Acervo', 'S', '2011-08-20'),
                   (70, 'Devolução de Consulta do Acervo', 'E', '2014-05-26'),
                   (80, 'Empréstimo entre Bibliotecas', 'S', '2014-03-29'),
                   (90, 'Devolução de Empréstimo entre Bibliotecas', 'E', '2014-03-29'),
                   (100, 'Retirada para Manutenção da Peça do Acervo', 'A', '2014-03-29'),
                   (110, 'Devolução de Manutenção de Peça do Acervo', 'A', '2014-03-29');
-- Data for Name: nfcompras; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.nfcompras
            VALUES (2, 2, 10, '2016-10-10', 2500, 'A', 'Bons profutos na última compra', '2016-10-10'),
                   (1, 5, 10, '2016-10-10', 3105, 'A', 'Fornecedor com bom histórico de compra', '2016-10-10'),
                   (3, 1, 20, '2016-10-10', 3150, 'A', 'Ótimo gado de Corte', '2016-10-10');
-- Data for Name: nfcomprasitens; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.nfcomprasitens
            VALUES (1, '001001001001', 10, 38),
                   (1, '001001001002', 25, 45),
                   (1, '001001001003', 40, 40),
                   (2, '001003001001', 50, 40),
                   (2, '001002001004', 10, 50),
                   (3, '001001001001', 20, 45),
                   (3, '001001001003', 50, 45);
-- Data for Name: nfvendas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.nfvendas
            VALUES (41, 5, 50, 1, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (42, 30, 50, 3, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (43, 25, 50, 2, 53, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (44, 25, 50, 1, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (45, 30, 60, 2, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (46, 10, 60, 3, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (47, 30, 50, 1, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (48, 35, 200, 2, 65.5, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (49, 20, 90, 3, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (50, 10, 50, 2, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (51, 10, 60, 1, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (53, 5, 200, 3, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (54, 25, 50, 1, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (55, 30, 50, 2, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (56, 30, 60, 1, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (57, 5, 200, 2, 56, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (58, 35, 150, 3, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (59, 35, 200, 3, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (60, 35, 190, 3, 90, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (61, 40, 190, 1, 44, '2012-05-02', '2012-05-02', '2012-05-02'),
                   (62, 35, 190, 1, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (63, 40, 170, 2, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (64, 35, 200, 3, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (65, 5, 170, 1, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (66, 10, 170, 2, 58.5, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (67, 15, 180, 2, 56, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (68, 10, 170, 3, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (69, 10, 150, 1, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (70, 10, 190, 2, 90, '2012-05-03', '2012-05-03', '2012-05-03'),
                   (101, 40, 470, 2, 37, '2012-05-09', '2012-05-09', '2012-05-09'),
                   (102, 10, 460, 3, 77.5, '2012-05-09', '2012-05-09', '2012-05-09'),
                   (103, 10, 200, 1, 77.5, '2012-05-10', '2012-05-10', '2012-05-10'),
                   (104, 10, 470, 2, 46, '2012-05-10', '2012-05-10', '2012-05-10'),
                   (105, 5, 460, 2, 37, '2012-05-10', '2012-05-10', '2012-05-10'),
                   (106, 35, 460, 3, 65.5, '2012-05-10', '2012-05-10', '2012-05-10'),
                   (107, 40, 450, 1, 58.5, '2012-05-11', '2012-05-11', '2012-05-11'),
                   (108, 40, 370, 2, 90, '2012-05-11', '2012-05-11', '2012-05-11'),
                   (109, 40, 200, 3, 77.5, '2012-05-11', '2012-05-11', '2012-05-11'),
                   (110, 40, 350, 1, 90, '2012-05-11', '2012-05-11', '2012-05-11'),
                   (111, 10, 360, 3, 90, '2012-05-11', '2012-05-11', '2012-05-11'),
                   (112, 35, 200, 2, 65.5, '2012-05-12', '2012-05-12', '2012-05-12'),
                   (113, 40, 450, 2, 65.5, '2012-05-12', '2012-05-12', '2012-05-12'),
                   (114, 40, 450, 1, 68.5, '2012-05-12', '2012-05-12', '2012-05-12'),
                   (115, 30, 450, 1, 58.5, '2012-05-13', '2012-05-13', '2012-05-13'),
                   (116, 10, 440, 1, 77.5, '2012-05-13', '2012-05-13', '2012-05-13'),
                   (117, 10, 200, 1, 90, '2012-05-13', '2012-05-13', '2012-05-13'),
                   (118, 15, 370, 3, 56, '2012-05-14', '2012-05-14', '2012-05-14'),
                   (119, 35, 200, 2, 90, '2012-05-14', '2012-05-14', '2012-05-14'),
                   (120, 15, 200, 1, 56, '2012-05-14', '2012-05-14', '2012-05-14'),
                   (121, 20, 370, 2, 58.5, '2012-05-14', '2012-05-14', '2012-05-14'),
                   (122, 10, 200, 3, 77.5, '2012-05-15', '2012-05-15', '2012-05-15'),
                   (123, 20, 200, 1, 56, '2012-05-15', '2012-05-15', '2012-05-15'),
                   (124, 30, 350, 2, 58.5, '2012-05-15', '2012-05-15', '2012-05-15'),
                   (125, 15, 360, 3, 77.5, '2012-05-15', '2012-05-15', '2012-05-15'),
                   (126, 10, 460, 2, 34, '2012-05-15', '2012-05-15', '2012-05-15'),
                   (127, 5, 200, 1, 90, '2012-05-16', '2012-05-16', '2012-05-16'),
                   (129, 10, 450, 3, 90, '2012-05-16', '2012-05-16', '2012-05-16'),
                   (130, 10, 370, 1, 90, '2012-05-16', '2012-05-16', '2012-05-16'),
                   (131, 10, 200, 2, 90, '2012-05-16', '2012-05-16', '2012-05-16'),
                   (132, 30, 360, 1, 34, '2012-05-16', '2012-05-16', '2012-05-16'),
                   (133, 10, 200, 2, 90, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (134, 20, 190, 3, 56, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (135, 25, 200, 3, 90, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (136, 35, 350, 3, 56, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (137, 40, 460, 1, 90, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (138, 5, 200, 1, 56, '2012-05-17', '2012-05-17', '2012-05-17'),
                   (139, 20, 440, 2, 90, '2012-05-18', '2012-05-18', '2012-05-18'),
                   (140, 5, 350, 3, 68.5, '2012-05-18', '2012-05-18', '2012-05-18'),
                   (141, 15, 340, 1, 68.5, '2012-05-18', '2012-05-18', '2012-05-18'),
                   (142, 10, 180, 2, 58.5, '2012-05-19', '2012-05-19', '2012-05-19'),
                   (143, 5, 120, 2, 58.5, '2012-05-19', '2012-05-19', '2012-05-19'),
                   (145, 10, 200, 1, 65.5, '2012-05-20', '2012-05-20', '2012-05-20'),
                   (146, 35, 350, 2, 90, '2012-05-20', '2012-05-20', '2012-05-20'),
                   (147, 35, 450, 3, 90, '2012-05-20', '2012-05-20', '2012-05-20'),
                   (149, 35, 170, 3, 90, '2012-05-22', '2012-05-22', '2012-05-22'),
                   (150, 30, 460, 2, 56, '2012-05-22', '2012-05-22', '2012-05-22'),
                   (151, 30, 360, 2, 90, '2012-05-22', '2012-05-22', '2012-05-22'),
                   (152, 30, 150, 3, 132, '2010-10-10', '2010-10-10', '2010-10-10'),
                   (1, 35, 170, 1, 55.5, '2012-04-24', '2012-04-24', '2012-04-24'),
                   (2, 35, 160, 1, 68.5, '2012-04-24', '2012-04-24', '2012-04-24'),
                   (3, 10, 150, 1, 90, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (4, 5, 110, 3, 68.5, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (5, 20, 200, 2, 65.5, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (6, 40, 200, 1, 65.5, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (7, 5, 150, 2, 34, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (8, 10, 160, 3, 90, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (9, 10, 200, 1, 90, '2012-04-25', '2012-04-25', '2012-04-25'),
                   (10, 25, 200, 2, 90, '2012-04-27', '2012-04-27', '2012-04-27'),
                   (11, 10, 50, 3, 90, '2012-04-27', '2012-04-27', '2012-04-27'),
                   (12, 10, 50, 2, 58.5, '2012-04-27', '2012-04-27', '2012-04-27'),
                   (13, 40, 200, 1, 90, '2012-04-28', '2012-04-28', '2012-04-28'),
                   (15, 5, 50, 3, 90, '2012-04-28', '2012-04-28', '2012-04-28'),
                   (16, 5, 200, 1, 58.5, '2012-04-28', '2012-04-28', '2012-04-28'),
                   (17, 40, 200, 2, 90, '2012-04-28', '2012-04-28', '2012-04-28'),
                   (18, 10, 100, 1, 90, '2012-04-28', '2012-04-28', '2012-04-28'),
                   (19, 10, 100, 2, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (20, 10, 100, 3, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (21, 10, 100, 3, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (22, 10, 100, 3, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (23, 10, 90, 1, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (24, 10, 100, 1, 90, '2012-04-29', '2012-04-29', '2012-04-29'),
                   (25, 5, 100, 2, 68.5, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (26, 25, 100, 3, 68.5, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (27, 25, 100, 1, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (28, 20, 100, 2, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (29, 5, 100, 2, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (30, 15, 100, 3, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (31, 25, 50, 1, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (32, 5, 200, 2, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (33, 10, 200, 3, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (34, 10, 50, 1, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (35, 15, 50, 3, 77.5, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (36, 10, 200, 2, 77.5, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (37, 10, 50, 2, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (38, 10, 50, 1, 90, '2012-04-30', '2012-04-30', '2012-04-30'),
                   (39, 10, 200, 1, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (40, 10, 200, 1, 90, '2012-05-01', '2012-05-01', '2012-05-01'),
                   (71, 15, 180, 3, 58.5, '2012-05-04', '2012-05-04', '2012-05-04'),
                   (72, 10, 180, 1, 77.5, '2012-05-04', '2012-05-04', '2012-05-04'),
                   (73, 10, 200, 3, 90, '2012-05-04', '2012-05-04', '2012-05-04'),
                   (74, 25, 180, 2, 90, '2012-05-04', '2012-05-04', '2012-05-04'),
                   (75, 30, 130, 2, 90, '2012-05-04', '2012-05-04', '2012-05-04'),
                   (76, 15, 180, 1, 90, '2012-05-05', '2012-05-05', '2012-05-05'),
                   (77, 10, 360, 1, 56, '2012-05-05', '2012-05-05', '2012-05-05'),
                   (78, 40, 50, 1, 90, '2012-05-05', '2012-05-05', '2012-05-05'),
                   (79, 15, 200, 1, 90, '2012-05-05', '2012-05-05', '2012-05-05'),
                   (80, 35, 160, 3, 90, '2012-05-06', '2012-05-06', '2012-05-06'),
                   (81, 15, 160, 2, 65.5, '2012-05-06', '2012-05-06', '2012-05-06'),
                   (82, 20, 200, 1, 68.5, '2012-05-06', '2012-05-06', '2012-05-06'),
                   (83, 25, 120, 2, 68.5, '2012-05-06', '2012-05-06', '2012-05-06'),
                   (84, 30, 110, 3, 90, '2012-05-06', '2012-05-06', '2012-05-06'),
                   (85, 25, 190, 1, 90, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (86, 35, 90, 2, 68.5, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (87, 5, 60, 3, 58.5, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (88, 40, 200, 2, 58.5, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (89, 10, 360, 1, 90, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (91, 40, 200, 3, 90, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (92, 15, 200, 1, 90, '2012-05-07', '2012-05-07', '2012-05-07'),
                   (93, 20, 200, 2, 90, '2012-05-08', '2012-05-08', '2012-05-08'),
                   (94, 20, 180, 1, 34, '2012-05-08', '2012-05-08', '2012-05-08'),
                   (95, 15, 360, 2, 90, '2012-05-08', '2012-05-08', '2012-05-08'),
                   (96, 10, 200, 3, 44, '2012-05-08', '2012-05-08', '2012-05-08'),
                   (97, 30, 200, 3, 68.5, '2012-05-08', '2012-05-08', '2012-05-08'),
                   (98, 20, 200, 3, 68.5, '2012-05-09', '2012-05-09', '2012-05-09'),
                   (99, 15, 440, 1, 68.5, '2012-05-09', '2012-05-09', '2012-05-09'),
                   (100, 40, 360, 1, 68.5, '2012-05-09', '2012-05-09', '2012-05-09');
-- Data for Name: nfvendasitens; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.nfvendasitens
            VALUES (1, '001001001001', 10, 1.25),
                   (1, '001001001002', 20, 2.15),
                   (2, '001001001001', 10, 1.25),
                   (2, '001001001003', 10, 2.45),
                   (2, '001001001005', 10, 3.15),
                   (3, '001001001001', 10, 1.25),
                   (3, '001001001002', 10, 2.15),
                   (3, '001001001003', 10, 2.45),
                   (3, '001001001005', 10, 3.15),
                   (4, '001001001001', 10, 1.25),
                   (4, '001001001003', 10, 2.45),
                   (4, '001001001005', 10, 3.15),
                   (5, '001001001001', 10, 1.25),
                   (5, '001001001002', 10, 2.15),
                   (5, '001001001005', 10, 3.15),
                   (6, '001001001001', 10, 1.25),
                   (6, '001001001002', 10, 2.15),
                   (6, '001001001005', 10, 3.15),
                   (7, '001001001001', 10, 1.25),
                   (7, '001001001002', 10, 2.15),
                   (8, '001001001001', 10, 1.25),
                   (8, '001001001002', 10, 2.15),
                   (8, '001001001003', 10, 2.45),
                   (8, '001001001005', 10, 3.15),
                   (9, '001001001001', 10, 1.25),
                   (9, '001001001002', 10, 2.15),
                   (9, '001001001003', 10, 2.45),
                   (9, '001001001005', 10, 3.15),
                   (10, '001001001001', 10, 1.25),
                   (10, '001001001002', 10, 2.15),
                   (10, '001001001003', 10, 2.45),
                   (10, '001001001005', 10, 3.15),
                   (11, '001001001001', 10, 1.25),
                   (11, '001001001002', 10, 2.15),
                   (11, '001001001003', 10, 2.45),
                   (11, '001001001005', 10, 3.15),
                   (12, '001001001001', 10, 1.25),
                   (12, '001001001002', 10, 2.15),
                   (12, '001001001003', 10, 2.45),
                   (13, '001001001001', 10, 1.25),
                   (13, '001001001002', 10, 2.15),
                   (13, '001001001003', 10, 2.45),
                   (13, '001001001005', 10, 3.15),
                   (15, '001001001001', 10, 1.25),
                   (15, '001001001002', 10, 2.15),
                   (15, '001001001003', 10, 2.45),
                   (15, '001001001005', 10, 3.15),
                   (16, '001001001001', 10, 1.25),
                   (16, '001001001002', 10, 2.15),
                   (16, '001001001003', 10, 2.45),
                   (17, '001001001001', 10, 1.25),
                   (17, '001001001002', 10, 2.15),
                   (17, '001001001003', 10, 2.45),
                   (17, '001001001005', 10, 3.15),
                   (18, '001001001001', 10, 1.25),
                   (18, '001001001002', 10, 2.15),
                   (18, '001001001003', 10, 2.45),
                   (18, '001001001005', 10, 3.15),
                   (19, '001001001001', 10, 1.25),
                   (19, '001001001002', 10, 2.15),
                   (19, '001001001003', 10, 2.45),
                   (19, '001001001005', 10, 3.15),
                   (20, '001001001001', 10, 1.25),
                   (20, '001001001002', 10, 2.15),
                   (20, '001001001003', 10, 2.45),
                   (20, '001001001005', 10, 3.15),
                   (21, '001001001001', 10, 1.25),
                   (21, '001001001002', 10, 2.15),
                   (21, '001001001003', 10, 2.45),
                   (21, '001001001005', 10, 3.15),
                   (22, '001001001001', 10, 1.25),
                   (22, '001001001002', 10, 2.15),
                   (22, '001001001003', 10, 2.45),
                   (22, '001001001005', 10, 3.15),
                   (23, '001001001001', 10, 1.25),
                   (23, '001001001002', 10, 2.15),
                   (23, '001001001003', 10, 2.45),
                   (23, '001001001005', 10, 3.15),
                   (24, '001001001001', 10, 1.25),
                   (24, '001001001002', 10, 2.15),
                   (24, '001001001003', 10, 2.45),
                   (24, '001001001005', 10, 3.15),
                   (25, '001001001001', 10, 1.25),
                   (25, '001001001003', 10, 2.45),
                   (25, '001001001005', 10, 3.15),
                   (26, '001001001001', 10, 1.25),
                   (26, '001001001003', 10, 2.45),
                   (26, '001001001005', 10, 3.15),
                   (27, '001001001001', 10, 1.25),
                   (27, '001001001002', 10, 2.15),
                   (27, '001001001003', 10, 2.45),
                   (27, '001001001005', 10, 3.15),
                   (28, '001001001001', 10, 1.25),
                   (28, '001001001002', 10, 2.15),
                   (28, '001001001003', 10, 2.45),
                   (28, '001001001005', 10, 3.15),
                   (29, '001001001001', 10, 1.25),
                   (29, '001001001002', 10, 2.15),
                   (29, '001001001003', 10, 2.45),
                   (29, '001001001005', 10, 3.15),
                   (30, '001001001001', 10, 1.25),
                   (30, '001001001002', 10, 2.15),
                   (30, '001001001003', 10, 2.45),
                   (30, '001001001005', 10, 3.15),
                   (31, '001001001001', 10, 1.25),
                   (31, '001001001002', 10, 2.15),
                   (31, '001001001003', 10, 2.45),
                   (31, '001001001005', 10, 3.15),
                   (32, '001001001001', 10, 1.25),
                   (32, '001001001002', 10, 2.15),
                   (32, '001001001003', 10, 2.45),
                   (32, '001001001005', 10, 3.15),
                   (33, '001001001001', 10, 1.25),
                   (33, '001001001002', 10, 2.15),
                   (33, '001001001003', 10, 2.45),
                   (33, '001001001005', 10, 3.15),
                   (34, '001001001001', 10, 1.25),
                   (34, '001001001002', 10, 2.15),
                   (34, '001001001003', 10, 2.45),
                   (34, '001001001005', 10, 3.15),
                   (35, '001001001002', 10, 2.15),
                   (35, '001001001003', 10, 2.45),
                   (35, '001001001005', 10, 3.15),
                   (36, '001001001002', 10, 2.15),
                   (36, '001001001003', 10, 2.45),
                   (36, '001001001005', 10, 3.15),
                   (37, '001001001001', 10, 1.25),
                   (37, '001001001002', 10, 2.15),
                   (37, '001001001003', 10, 2.45),
                   (37, '001001001005', 10, 3.15),
                   (38, '001001001001', 10, 1.25),
                   (38, '001001001002', 10, 2.15),
                   (38, '001001001003', 10, 2.45),
                   (38, '001001001005', 10, 3.15),
                   (39, '001001001001', 10, 1.25),
                   (39, '001001001002', 10, 2.15),
                   (39, '001001001003', 10, 2.45),
                   (39, '001001001005', 10, 3.15),
                   (40, '001001001001', 10, 1.25),
                   (40, '001001001002', 10, 2.15),
                   (40, '001001001003', 10, 2.45),
                   (40, '001001001005', 10, 3.15),
                   (41, '001001001001', 10, 1.25),
                   (41, '001001001002', 10, 2.15),
                   (41, '001001001003', 10, 2.45),
                   (41, '001001001005', 10, 3.15),
                   (42, '001001001001', 10, 1.25),
                   (42, '001001001002', 10, 2.15),
                   (42, '001001001003', 10, 2.45),
                   (42, '001001001005', 10, 3.15),
                   (43, '001001001002', 10, 2.15),
                   (43, '001001001005', 10, 3.15),
                   (44, '001001001001', 10, 1.25),
                   (44, '001001001002', 10, 2.15),
                   (44, '001001001003', 10, 2.45),
                   (44, '001001001005', 10, 3.15),
                   (45, '001001001001', 10, 1.25),
                   (45, '001001001002', 10, 2.15),
                   (45, '001001001003', 10, 2.45),
                   (45, '001001001005', 10, 3.15),
                   (46, '001001001001', 10, 1.25),
                   (46, '001001001002', 10, 2.15),
                   (46, '001001001003', 10, 2.45),
                   (46, '001001001005', 10, 3.15),
                   (47, '001001001001', 10, 1.25),
                   (47, '001001001002', 10, 2.15),
                   (47, '001001001003', 10, 2.45),
                   (47, '001001001005', 10, 3.15),
                   (48, '001001001001', 10, 1.25),
                   (48, '001001001002', 10, 2.15),
                   (48, '001001001005', 10, 3.15),
                   (49, '001001001001', 10, 1.25),
                   (49, '001001001002', 10, 2.15),
                   (49, '001001001003', 10, 2.45),
                   (49, '001001001005', 10, 3.15),
                   (50, '001001001001', 10, 1.25),
                   (50, '001001001002', 10, 2.15),
                   (50, '001001001003', 10, 2.45),
                   (50, '001001001005', 10, 3.15),
                   (51, '001001001001', 10, 1.25),
                   (51, '001001001002', 10, 2.15),
                   (51, '001001001003', 10, 2.45),
                   (51, '001001001005', 10, 3.15),
                   (53, '001001001001', 10, 1.25),
                   (53, '001001001002', 10, 2.15),
                   (53, '001001001003', 10, 2.45),
                   (53, '001001001005', 10, 3.15),
                   (54, '001001001001', 10, 1.25),
                   (54, '001001001002', 10, 2.15),
                   (54, '001001001003', 10, 2.45),
                   (54, '001001001005', 10, 3.15),
                   (55, '001001001001', 10, 1.25),
                   (55, '001001001002', 10, 2.15),
                   (55, '001001001003', 10, 2.45),
                   (55, '001001001005', 10, 3.15),
                   (56, '001001001001', 10, 1.25),
                   (56, '001001001002', 10, 2.15),
                   (56, '001001001003', 10, 2.45),
                   (56, '001001001005', 10, 3.15),
                   (57, '001001001003', 10, 2.45),
                   (57, '001001001005', 10, 3.15),
                   (58, '001001001001', 10, 1.25),
                   (58, '001001001002', 10, 2.15),
                   (58, '001001001003', 10, 2.45),
                   (58, '001001001005', 10, 3.15),
                   (59, '001001001001', 10, 1.25),
                   (59, '001001001002', 10, 2.15),
                   (59, '001001001003', 10, 2.45),
                   (59, '001001001005', 10, 3.15),
                   (60, '001001001001', 10, 1.25),
                   (60, '001001001002', 10, 2.15),
                   (60, '001001001003', 10, 2.45),
                   (60, '001001001005', 10, 3.15),
                   (61, '001001001001', 10, 1.25),
                   (61, '001001001005', 10, 3.15),
                   (62, '001001001001', 10, 1.25),
                   (62, '001001001002', 10, 2.15),
                   (62, '001001001003', 10, 2.45),
                   (62, '001001001005', 10, 3.15),
                   (63, '001001001001', 10, 1.25),
                   (63, '001001001002', 10, 2.15),
                   (63, '001001001003', 10, 2.45),
                   (63, '001001001005', 10, 3.15),
                   (64, '001001001001', 10, 1.25),
                   (64, '001001001002', 10, 2.15),
                   (64, '001001001003', 10, 2.45),
                   (64, '001001001005', 10, 3.15),
                   (65, '001001001001', 10, 1.25),
                   (65, '001001001002', 10, 2.15),
                   (65, '001001001003', 10, 2.45),
                   (65, '001001001005', 10, 3.15),
                   (66, '001001001001', 10, 1.25),
                   (66, '001001001002', 10, 2.15),
                   (66, '001001001003', 10, 2.45),
                   (67, '001001001003', 10, 2.45),
                   (67, '001001001005', 10, 3.15),
                   (68, '001001001001', 10, 1.25),
                   (68, '001001001002', 10, 2.15),
                   (68, '001001001003', 10, 2.45),
                   (68, '001001001005', 10, 3.15),
                   (69, '001001001001', 10, 1.25),
                   (69, '001001001002', 10, 2.15),
                   (69, '001001001003', 10, 2.45),
                   (69, '001001001005', 10, 3.15),
                   (70, '001001001001', 10, 1.25),
                   (70, '001001001002', 10, 2.15),
                   (70, '001001001003', 10, 2.45),
                   (70, '001001001005', 10, 3.15),
                   (71, '001001001001', 10, 1.25),
                   (71, '001001001002', 10, 2.15),
                   (71, '001001001003', 10, 2.45),
                   (72, '001001001002', 10, 2.15),
                   (72, '001001001003', 10, 2.45),
                   (72, '001001001005', 10, 3.15),
                   (73, '001001001001', 10, 1.25),
                   (73, '001001001002', 10, 2.15),
                   (73, '001001001003', 10, 2.45),
                   (73, '001001001005', 10, 3.15),
                   (74, '001001001001', 10, 1.25),
                   (74, '001001001002', 10, 2.15),
                   (74, '001001001003', 10, 2.45),
                   (74, '001001001005', 10, 3.15),
                   (75, '001001001001', 10, 1.25),
                   (75, '001001001002', 10, 2.15),
                   (75, '001001001003', 10, 2.45),
                   (75, '001001001005', 10, 3.15),
                   (76, '001001001001', 10, 1.25),
                   (76, '001001001002', 10, 2.15),
                   (76, '001001001003', 10, 2.45),
                   (76, '001001001005', 10, 3.15),
                   (77, '001001001003', 10, 2.45),
                   (77, '001001001005', 10, 3.15),
                   (78, '001001001001', 10, 1.25),
                   (78, '001001001002', 10, 2.15),
                   (78, '001001001003', 10, 2.45),
                   (78, '001001001005', 10, 3.15),
                   (79, '001001001001', 10, 1.25),
                   (79, '001001001002', 10, 2.15),
                   (79, '001001001003', 10, 2.45),
                   (79, '001001001005', 10, 3.15),
                   (80, '001001001001', 10, 1.25),
                   (80, '001001001002', 10, 2.15),
                   (80, '001001001003', 10, 2.45),
                   (80, '001001001005', 10, 3.15),
                   (81, '001001001001', 10, 1.25),
                   (81, '001001001002', 10, 2.15),
                   (81, '001001001005', 10, 3.15),
                   (82, '001001001001', 10, 1.25),
                   (82, '001001001003', 10, 2.45),
                   (82, '001001001005', 10, 3.15),
                   (83, '001001001001', 10, 1.25),
                   (83, '001001001003', 10, 2.45),
                   (83, '001001001005', 10, 3.15),
                   (84, '001001001001', 10, 1.25),
                   (84, '001001001002', 10, 2.15),
                   (84, '001001001003', 10, 2.45),
                   (84, '001001001005', 10, 3.15),
                   (85, '001001001001', 10, 1.25),
                   (85, '001001001002', 10, 2.15),
                   (85, '001001001003', 10, 2.45),
                   (85, '001001001005', 10, 3.15),
                   (86, '001001001001', 10, 1.25),
                   (86, '001001001003', 10, 2.45),
                   (86, '001001001005', 10, 3.15),
                   (87, '001001001001', 10, 1.25),
                   (87, '001001001002', 10, 2.15),
                   (87, '001001001003', 10, 2.45),
                   (88, '001001001001', 10, 1.25),
                   (88, '001001001002', 10, 2.15),
                   (88, '001001001003', 10, 2.45),
                   (89, '001001001001', 10, 1.25),
                   (89, '001001001002', 10, 2.15),
                   (89, '001001001003', 10, 2.45),
                   (89, '001001001005', 10, 3.15),
                   (91, '001001001001', 10, 1.25),
                   (91, '001001001002', 10, 2.15),
                   (91, '001001001003', 10, 2.45),
                   (91, '001001001005', 10, 3.15),
                   (92, '001001001001', 10, 1.25),
                   (92, '001001001002', 10, 2.15),
                   (92, '001001001003', 10, 2.45),
                   (92, '001001001005', 10, 3.15),
                   (93, '001001001001', 10, 1.25),
                   (93, '001001001002', 10, 2.15),
                   (93, '001001001003', 10, 2.45),
                   (93, '001001001005', 10, 3.15),
                   (94, '001001001001', 10, 1.25),
                   (94, '001001001002', 10, 2.15),
                   (95, '001001001001', 10, 1.25),
                   (95, '001001001002', 10, 2.15),
                   (95, '001001001003', 10, 2.45),
                   (95, '001001001005', 10, 3.15),
                   (96, '001001001001', 10, 1.25),
                   (96, '001001001005', 10, 3.15),
                   (97, '001001001001', 10, 1.25),
                   (97, '001001001003', 10, 2.45),
                   (97, '001001001005', 10, 3.15),
                   (98, '001001001001', 10, 1.25),
                   (98, '001001001003', 10, 2.45),
                   (98, '001001001005', 10, 3.15),
                   (99, '001001001001', 10, 1.25),
                   (99, '001001001003', 10, 2.45),
                   (99, '001001001005', 10, 3.15),
                   (100, '001001001001', 10, 1.25),
                   (100, '001001001003', 10, 2.45),
                   (100, '001001001005', 10, 3.15),
                   (101, '001001001001', 10, 1.25),
                   (101, '001001001003', 10, 2.45),
                   (102, '001001001002', 10, 2.15),
                   (102, '001001001003', 10, 2.45),
                   (102, '001001001005', 10, 3.15),
                   (103, '001001001002', 10, 2.15),
                   (103, '001001001003', 10, 2.45),
                   (103, '001001001005', 10, 3.15),
                   (104, '001001001002', 10, 2.15),
                   (104, '001001001003', 10, 2.45),
                   (105, '001001001001', 10, 1.25),
                   (105, '001001001003', 10, 2.45),
                   (106, '001001001001', 10, 1.25),
                   (106, '001001001002', 10, 2.15),
                   (106, '001001001005', 10, 3.15),
                   (107, '001001001001', 10, 1.25),
                   (107, '001001001002', 10, 2.15),
                   (107, '001001001003', 10, 2.45),
                   (108, '001001001001', 10, 1.25),
                   (108, '001001001002', 10, 2.15),
                   (108, '001001001003', 10, 2.45),
                   (108, '001001001005', 10, 3.15),
                   (109, '001001001002', 10, 2.15),
                   (109, '001001001003', 10, 2.45),
                   (109, '001001001005', 10, 3.15),
                   (110, '001001001001', 10, 1.25),
                   (110, '001001001002', 10, 2.15),
                   (110, '001001001003', 10, 2.45),
                   (110, '001001001005', 10, 3.15),
                   (111, '001001001001', 10, 1.25),
                   (111, '001001001002', 10, 2.15),
                   (111, '001001001003', 10, 2.45),
                   (111, '001001001005', 10, 3.15),
                   (112, '001001001001', 10, 1.25),
                   (112, '001001001002', 10, 2.15),
                   (112, '001001001005', 10, 3.15),
                   (113, '001001001001', 10, 1.25),
                   (113, '001001001002', 10, 2.15),
                   (113, '001001001005', 10, 3.15),
                   (114, '001001001001', 10, 1.25),
                   (114, '001001001003', 10, 2.45),
                   (114, '001001001005', 10, 3.15),
                   (115, '001001001001', 10, 1.25),
                   (115, '001001001002', 10, 2.15),
                   (115, '001001001003', 10, 2.45),
                   (116, '001001001002', 10, 2.15),
                   (116, '001001001003', 10, 2.45),
                   (116, '001001001005', 10, 3.15),
                   (117, '001001001001', 10, 1.25),
                   (117, '001001001002', 10, 2.15),
                   (117, '001001001003', 10, 2.45),
                   (117, '001001001005', 10, 3.15),
                   (118, '001001001003', 10, 2.45),
                   (118, '001001001005', 10, 3.15),
                   (119, '001001001001', 10, 1.25),
                   (119, '001001001002', 10, 2.15),
                   (119, '001001001003', 10, 2.45),
                   (119, '001001001005', 10, 3.15),
                   (120, '001001001003', 10, 2.45),
                   (120, '001001001005', 10, 3.15),
                   (121, '001001001001', 10, 1.25),
                   (121, '001001001002', 10, 2.15),
                   (121, '001001001003', 10, 2.45),
                   (122, '001001001002', 10, 2.15),
                   (122, '001001001003', 10, 2.45),
                   (122, '001001001005', 10, 3.15),
                   (123, '001001001003', 10, 2.45),
                   (123, '001001001005', 10, 3.15),
                   (124, '001001001001', 10, 1.25),
                   (124, '001001001002', 10, 2.15),
                   (124, '001001001003', 10, 2.45),
                   (125, '001001001002', 10, 2.15),
                   (125, '001001001003', 10, 2.45),
                   (125, '001001001005', 10, 3.15),
                   (126, '001001001001', 10, 1.25),
                   (126, '001001001002', 10, 2.15),
                   (127, '001001001001', 10, 1.25),
                   (127, '001001001002', 10, 2.15),
                   (127, '001001001003', 10, 2.45),
                   (127, '001001001005', 10, 3.15),
                   (129, '001001001001', 10, 1.25),
                   (129, '001001001002', 10, 2.15),
                   (129, '001001001003', 10, 2.45),
                   (129, '001001001005', 10, 3.15),
                   (130, '001001001001', 10, 1.25),
                   (130, '001001001002', 10, 2.15),
                   (130, '001001001003', 10, 2.45),
                   (130, '001001001005', 10, 3.15),
                   (131, '001001001001', 10, 1.25),
                   (131, '001001001002', 10, 2.15),
                   (131, '001001001003', 10, 2.45),
                   (131, '001001001005', 10, 3.15),
                   (132, '001001001001', 10, 1.25),
                   (132, '001001001002', 10, 2.15),
                   (133, '001001001001', 10, 1.25),
                   (133, '001001001002', 10, 2.15),
                   (133, '001001001003', 10, 2.45),
                   (133, '001001001005', 10, 3.15),
                   (134, '001001001003', 10, 2.45),
                   (134, '001001001005', 10, 3.15),
                   (135, '001001001001', 10, 1.25),
                   (135, '001001001002', 10, 2.15),
                   (135, '001001001003', 10, 2.45),
                   (135, '001001001005', 10, 3.15),
                   (136, '001001001003', 10, 2.45),
                   (136, '001001001005', 10, 3.15),
                   (137, '001001001001', 10, 1.25),
                   (137, '001001001002', 10, 2.15),
                   (137, '001001001003', 10, 2.45),
                   (137, '001001001005', 10, 3.15),
                   (138, '001001001003', 10, 2.45),
                   (138, '001001001005', 10, 3.15),
                   (139, '001001001001', 10, 1.25),
                   (139, '001001001002', 10, 2.15),
                   (139, '001001001003', 10, 2.45),
                   (139, '001001001005', 10, 3.15),
                   (140, '001001001001', 10, 1.25),
                   (140, '001001001003', 10, 2.45),
                   (140, '001001001005', 10, 3.15),
                   (141, '001001001001', 10, 1.25),
                   (141, '001001001003', 10, 2.45),
                   (141, '001001001005', 10, 3.15),
                   (142, '001001001001', 10, 1.25),
                   (142, '001001001002', 10, 2.15),
                   (142, '001001001003', 10, 2.45),
                   (143, '001001001001', 10, 1.25),
                   (143, '001001001002', 10, 2.15),
                   (143, '001001001003', 10, 2.45),
                   (145, '001001001001', 10, 1.25),
                   (145, '001001001002', 10, 2.15),
                   (145, '001001001005', 10, 3.15),
                   (146, '001001001001', 10, 1.25),
                   (146, '001001001002', 10, 2.15),
                   (146, '001001001003', 10, 2.45),
                   (146, '001001001005', 10, 3.15),
                   (147, '001001001001', 10, 1.25),
                   (147, '001001001002', 10, 2.15),
                   (147, '001001001003', 10, 2.45),
                   (147, '001001001005', 10, 3.15),
                   (149, '001001001001', 10, 1.25),
                   (149, '001001001002', 10, 2.15),
                   (149, '001001001003', 10, 2.45),
                   (149, '001001001005', 10, 3.15),
                   (150, '001001001003', 10, 2.45),
                   (150, '001001001005', 10, 3.15),
                   (151, '001001001001', 10, 1.25),
                   (151, '001001001002', 10, 2.15),
                   (151, '001001001003', 10, 2.45),
                   (151, '001001001005', 10, 3.15),
                   (152, '001001001003', 20, 2.45),
                   (152, '001001001005', 20, 3.15),
                   (152, '001002001004', 10, 2);
-- Data for Name: ocorrencias; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.ocorrencias
            VALUES (5, 1, 5, 145241, 120, 130, 'Colisão lateral dos veículos trafegando pela Av. Politécnica e logo a seguir colindo com um muro e um poste no cruzamento da R. das Laranjeiras.', '2010-10-10'),
                   (6, 3, 8, 145241, 170, 300, 'Roubo com uso de arma de fogo por volta das 23h00', '2010-10-10');
-- Data for Name: oficinas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.oficinas
            VALUES (1, 'Oficina Mecânica de Reparos Gerais Luiz Porto S/C Ltda.', '01245241521   ', 'Luizinho', 520, NULL, '2010-10-10'),
                   (2, 'Oficina de Reparos Gerais "Marreco" S/C Ltda.', '123123        ', 'Marreco', 240, NULL, '2015-10-10');
-- Data for Name: oficinastels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.oficinastels
            VALUES (1, 1, 10, '1174185296     ', NULL, '2019-09-02'),
                   (2, 2, 10, '5474185296     ', NULL, '2019-09-02'),
                   (3, 2, 10, '1196385274     ', NULL, '2019-09-02'),
                   (4, 1, 10, '3145124512     ', NULL, '2019-09-02'),
                   (5, 2, 15, '43985264521    ', NULL, '2019-09-02');
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.paises
       VALUES ('BRA','Brasil','Brasilia',8512798,'2020-02-10'),
	          ('ITA','Itália','',1512798,'2020-02-10');
-- Data for Name: palavraschaves; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.palavraschaves
            VALUES (1, 'Amor', '2010-12-13'),
                   (2, 'Carinho', '2010-12-13'),
                   (3, 'Amizade', '2010-12-13'),
                   (4, 'Convivencia', '2010-12-13'),
                   (7, 'Solidariedade', '2010-12-10'),
                   (5, 'Compreensão', '2010-12-10'),
                   (6, 'Confiança', '2010-12-10'),
                   (8, 'Lógica', '2016-12-07'),
                   (9, 'Matemática', '2016-12-07'),
                   (10, 'Física', '2016-12-07'),
                   (11, 'Cálculo Diferencial', '2016-12-07');
-- Data for Name: palavraslivros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.palavraslivros
            VALUES (1, 92, '2016-12-07');
INSERT INTO public.palavraslivros
            VALUES (2, 92, '2016-12-07'),
                   (11, 90, '2016-12-07'),
                   (9, 90, '2016-12-07'),
                   (9, 40, '2016-12-07'),
                   (10, 50, '2016-12-07');
-- Data for Name: passagens; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: pedcompras; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: pedcomprasitens; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: pedvendas; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: pedvendasitens; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: planosdesaude; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.planosdesaude
            VALUES (1, 'Unimed', 'zvfzxfasdfsdfasdf', NULL, 350, ' 1243', '2354235 ', '2010-10-27'),
                   (2, 'SulAmericana', 'Trocando os valores', NULL, 470, ' 1492', '14524515', '2010-10-27'),
                   (4, 'MedialSaude', NULL, NULL, 470, ' 1492', NULL, '2010-10-27'),
                   (5, 'teter', 'sadfsdf', NULL, 470, ' 234', '12313123', '2010-10-10');
-- Data for Name: planosmedicos; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: planostels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.planostels
            VALUES (5, 2, 5, '12341234       ', NULL, '2016-06-10'),
                   (8, 4, 5, '141514541242   ', NULL, '2016-07-05'),
                   (2, 4, 10, '1452451255     ', NULL, '2016-05-20'),
                   (3, 4, 15, '5642151651     ', NULL, '2016-06-20'),
                   (1, 4, 20, '1421254412     ', NULL, '2016-05-20'),
                   (4, 2, 20, '12341234       ', NULL, '2016-05-25'),
                   (7, 1, 20, '2134523453     ', NULL, '2016-07-08');
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.produtos
            VALUES ('001003001002', 'Trocando de Valor na Descricao Curta', 123.00, 120.00, 120.00, 0.00, 15, 'Trocando de Valor na Descricao completa', '2010-10-10'),
                   ('001001001001', 'metafluocoreto de potássio', 40.00, 35.00, 26.00, 0.00, 0, 'o metafluocoreto ', '1980-01-01'),
                   ('001001001002', 'sulfito de sódio', 45.00, 20.00, 10.00, 0.00, 0, 'asdfasdfadsf', '2010-10-10'),
                   ('001001001003', 'enxofre', 42.00, 12.00, 23.00, 0.00, 0, 'laskfjsdf', '1980-01-01'),
                   ('001001001005', 'Permanganato de Silício', 35.00, 1450.00, 1400.00, 0.00, 0, NULL, '2011-01-20'),
                   ('001002001004', 'amianto de sódio', 40.00, 22.00, 20.00, 0.00, 0, 'asdfsadf', '1980-01-01'),
                   ('001002003001', 'Acido Sulfúrico', 15.00, 1100.00, 950.00, 0.00, 0, 'Este ', '1980-01-01'),
                   ('001003001001', 'Resfriador de Sódio', 40.00, 1450.00, 1100.00, 0.00, 0, NULL, '2010-10-20');
-- Data for Name: professores; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.professores
            VALUES (1, 'ANA MARIA VERDIM', 470, ' 3456', '3436567 ', '1960-12-19', '2005-05-11'),
                   (2, 'ABEL DA SILVA', 110, ' 234', '1233536 ', '1964-07-11', '2001-08-21'),
                   (3, 'ABRAO ABUJANRA', 240, ' 451', '1342545 ', '1975-06-12', '2005-03-12'),
                   (4, 'CARLOS TAKESHI UENDO', 340, ' 475', '1865456 ', '1984-07-19', '2006-05-13'),
                   (5, 'DAVid GUTEMBERG', 260, ' 4521', '5680567 ', '1966-06-16', '2005-05-12'),
                   (6, 'FRANCISCO ROMEU DA CRUZ', 140, ' 75 23And, Cj 23', '5670479 ', '1974-12-05', '2002-05-13'),
                   (7, 'GERALDO BANDEIRAS PONTES', 170, ' 234', '4656589 ', '1987-09-06', '2002-10-21'),
                   (8, 'HEITOR DE TROIA', 120, ' 7458', '5656745 ', '1964-10-08', '2003-02-21'),
                   (9, 'HERCULES OLIMPIANO', 130, ' 345', '7643587 ', '1976-07-29', '2002-01-21'),
                   (10, 'IRINEU EVANGELISTA DE SOUZA', 270, ' 456', '4669908 ', '1984-11-28', '2005-05-14'),
                   (11, 'JOAO HEULALIO DE BUENO VIDIGAL', 360, ' 2569', '4794477 ', '1967-08-24', '2005-05-27'),
                   (12, 'JAIME DE ABREU POMPEU DE LIMA', 150, ' 75', '6298666 ', '1975-12-19', '2002-05-16'),
                   (13, 'JOSE RAMOS DE ALMEIDA', 160, ' 54', '7489455 ', '1988-07-29', '2002-05-28'),
                   (14, 'LEONIDAS DE PERCEPOLIS', 80, ' 345', '8405674 ', '1964-10-11', '2001-05-16'),
                   (15, 'LEOPOLDO DE COUTO E SILVA', 250, ' 3879', '8486453 ', '1976-10-10', '2005-03-25'),
                   (16, 'MARIA MAURA CORREIA ALVES LIMA', 310, ' 25', '8504467 ', '1984-12-21', '2005-09-18'),
                   (17, 'MARCIA DE ALBUQUERQUE LIMA', NULL, ' 25415', '8674645 ', '1966-09-21', '2000-05-25'),
                   (18, 'MARIO QUINTANA DRUMOND DE ANDRADE', 50, ' 345', '7605555 ', '1974-06-30', '2000-06-14'),
                   (19, 'NAIR DE MELLO CUNHA', 180, ' 4521', '6407626 ', '1987-05-30', '2003-04-23'),
                   (20, 'NEIRE GONCALVES DE ALBUQUERQUE LINS', 230, ' 345', '5567715 ', '1965-11-29', '2005-02-16'),
                   (21, 'OLIVIA CRUZ DO NASCIMENTO', 300, ' 657', '5456600 ', '1977-11-13', '2005-05-28'),
                   (22, 'ODUVALDO VIANNA', 460, ' 456', '5235683 ', '1966-09-24', '2004-05-15'),
                   (23, 'PASCOAL DE LIMA ROSA CRUZ', 190, ' 190', '5329444 ', '1987-10-25', '2003-05-27'),
                   (24, 'RENATO CORTE REAL', 210, ' 3456', '5444753 ', '1965-05-06', '2004-02-14'),
                   (25, 'SEBASTIAO MELLO DA SILVA CRUZ', 280, ' 867', '6534756 ', '1987-12-07', '2005-05-20'),
                   (26, 'TADEU BUARQUE DE HOLANDA', 320, ' 2145', '5644642 ', '1965-07-19', '2005-12-13'),
                   (27, 'ULISSES ODEBRECHT', 40, ' 2767', '5744548 ', '1987-11-17', '2000-05-29'),
                   (28, 'VINICIUS HUMBRTO PINHEIRO DA SILVA', 220, ' 4512', '5844426 ', '1965-11-05', '2005-01-10'),
                   (29, 'VERA ADRIANA HUANG AZEVEDO', 200, ' 745', '15122222', '1970-02-10', '2010-10-10'),
                   (35, 'EURIPEDES SOARES DE ALMEIDA', 170, '450', '12345678', '1957-05-10', '1975-10-10');
-- Data for Name: professorestels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.professorestels
            VALUES (4, 1, 5, '99999777       ', NULL),
                   (3, 7, 20, '88887777       ', NULL);
-- Data for Name: projetos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.projetos
            VALUES ('AD3100', 'ADMIN SERVICES       ', 'A01', 10, 6.50, '2002-01-01', '2003-02-01', 'AD3100', '1980-01-01'),
                   ('AD3110', 'GENERAL ADMIN SYSTEMS', 'A01', 20, 6.00, '2002-01-01', '2003-02-01', 'AD3100', '1980-01-01'),
                   ('AD3112', 'PERSONNEL PROGRAMMING', 'B01', 20, 1.00, '2002-01-01', '2003-02-01', 'AD3110', '1980-01-01'),
                   ('AD3113', 'ACCOUNT PROGRAMMING  ', 'B01', 20, 2.00, '2002-01-01', '2003-02-01', 'AD3110', '1980-01-01'),
                   ('IF1000', 'QUERY SERVICES       ', 'B01', 30, 2.00, '2002-01-01', '2003-02-01', 'IF1000', '1980-01-01'),
                   ('IF2000', 'USER EDUCATION       ', 'C01', 30, 1.00, '2002-01-01', '2003-02-01', 'IF2000', '1980-01-01'),
                   ('MA2100', 'WELD LINE AUTOMATION ', 'C01', 20, 12.00, '2002-01-01', '2003-02-01', 'MA2100', '1980-01-01'),
                   ('MA2110', 'W L PROGRAMMING      ', 'D01', 10, 9.00, '2002-01-01', '2003-02-01', 'MA2100', '1980-01-01'),
                   ('MA2111', 'W L PROGRAM DESIGN   ', 'D01', 40, 2.00, '2002-01-01', '1982-12-01', 'MA2110', '1980-01-01'),
                   ('MA2112', 'W L ROBOT DESIGN     ', 'D91', 50, 3.00, '2002-01-01', '1982-12-01', 'MA2110', '1980-01-01'),
                   ('MA2113', 'W L PROD CONT PROGS  ', 'D91', 40, 3.00, '2002-02-15', '1982-12-01', 'MA2110', '1980-01-01'),
                   ('OP2000', 'GEN SYSTEMS SERVICES ', 'E01', 50, 999.99, '2002-01-01', '2003-02-01', 'OP2000', '1980-01-01'),
                   ('OP2010', 'SYSTEMS SUPPORT      ', 'E01', 50, 4.00, '2002-01-01', '2003-02-01', 'OP2000', '1980-01-01'),
                   ('OP2011', 'SCP SYSTEMS SUPPORT  ', 'E11', 30, 1.00, '2002-01-01', '2003-02-01', 'OP2010', '1980-01-01'),
                   ('OP2012', 'APPLICATIONS SUPPORT ', 'E11', 10, 1.00, '2002-01-01', '2003-02-01', 'OP2010', '1980-01-01'),
                   ('OP2013', 'DB/DC SUPPORT        ', 'E21', 40, 1.00, '2002-01-01', '2003-02-01', 'OP2010', '1980-01-01'),
                   ('123457', 'alterando', 'Z97', 200, 280000.00, '2010-10-10', '2010-10-10', 'AD3112', '2010-10-10'),
                   ('AD2323', 'BIG DATA/SSP', 'E21', 40, 850.00, '2016-03-01', '2017-02-28', 'OP2010', '2016-02-10'),
                   ('Z90   ', 'teste', 'B01', 160, 45000.00, '2011-10-10', '2010-10-10', 'AD3100', '2010-10-10');
-- Data for Name: rotasviarias; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.rotasviarias
            VALUES (1, 'Rota 1', 'passa em Chavantes, Ipaussu, Sta Cruz do Rio Pardo e vai pela Castelo Brancos', 40, 5, '2010-10-10'),
                   (2, 'Rota 2', 'passa em Chavantes, Ipaussu, Sta Cruz do Rio Pardo e vai pela Raposo Tavares até Avaré depois pela Castelo Branco', 40, 5, '2010-10-10'),
                   (3, 'Rota 3', 'Passa por Cambará, Andirá, Bandeirantes, Cornélio Procópio, Ibaití pela BR153 (Transbrasiliana)', 40, 35, '2010-10-10'),
                   (4, 'Rota 66', 'asdasdsa as asd sd ffads', 40, 5, '2012-10-10'),
                   (8, 'Rota 88', 'Rod. Castelo Branco (até Avaré), Rod. Ildebrando Castanho (até a Rod. Raposo Tavares), Rod', 5, 40, '2013-12-11');
-- Data for Name: roteiros; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: seguradoras; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.seguradoras
            VALUES (1, 'Transamerica', 200, ' 745', '        ', '2004-02-10'),
                   (5, 'Porto Seguro', 510, ' 450', '123132  ', '2010-10-10'),
                   (6, 'Altavista Seguros', 160, '224', '12345678', '2010-10-10'),
                   (2, 'Bradesco Seguros', 200, '1452', NULL, '2016-03-28'),
                   (11, 'Seguros Lunares S/C Ltda.', 260, '1452', '04512456', '2016-11-11'),
                   (3, 'Mapfre Seguros', 400, ' 2345', '14512412', '2010-02-12');
-- Data for Name: seguradorastels; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.seguradorastels
            VALUES (1, 2, 20, '1452112212     ', NULL, NULL),
                   (2, 2, 20, '14421151       ', NULL, NULL),
                   (3, 3, 20, '1452155122     ', NULL, NULL),
                   (4, 3, 20, '1122323231     ', NULL, NULL);
-- Data for Name: seguros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.seguros
            VALUES (145241, 5, 1, '2010-10-10', '2011-10-10', 15000, '2010-10-10'),
                   (145246, 3, 2, '2010-10-10', '2011-10-10', 15000, '2010-10-07'),
                   (145251, 7, 11, '2000-05-05', '2001-05-05', 25000, '2000-05-02');
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.servicos
            VALUES (5, 'Funilaria', 'serviços de ajuste da lataria de veículos', 300.00, '2010-10-10'),
                   (10, 'Pintura', 'Pintura simples de veículos', 350.00, '2010-10-10'),
                   (15, 'Mecânica de suspensão', 'Substituição ou ajustes do conjunto de suspensão', 500.00, '2010-10-10'),
                   (20, 'Mecânica do Motor', 'Sustituição ou ajustes de partes do motor', 600.00, '2010-10-10');
-- Data for Name: servicosprestados; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: setoresdeatuacao; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.setoresdeatuacao
            VALUES (1, 'Industria', 'Manufaturados', '2011-06-10'),
                   (2, 'Comercio', 'Lojas de vendas em Atacado', '2011-06-10');
-- Data for Name: sinistros; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.sinistros
            VALUES (1, 'colisão com um ou mais veículos em via publica', 'colisão em via publica envolvendo um ou mais veículos além do segurado', '2013-03-20'),
                   (2, 'Colisão com um ou mais veículos em via privada', 'colisão em via privada (pátios de estacionamento, rampa de garagem, acesso à sítios ou chacaras), envolvendo um ou mais veículos além do segurado', '2013-03-20'),
                   (3, 'Roubo simples', 'Veículo foi roubado sem a presença do proprietário em via pública', '2013-03-20'),
                   (4, 'Roubo privado', 'Veículo roubado de dentro de casa ou estacionamento particular sem a presença do proprietário', '2013-03-20');
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.tarefas
            VALUES (10, 'Gerenciar                               ', 'Gerenciar/Advertir', 80, '2011-10-05'),
                   (20, 'Orçar                                   ', 'Estimar orçamentos de Projetos', 80, '2011-10-05'),
                   (30, 'Definir                                 ', 'Definir Especifica', 80, '2011-10-05'),
                   (40, 'Liderar                                 ', 'Liderar times de programação', 80, '2011-10-05'),
                   (50, 'Especificar                             ', 'Documentador de Especifica', 80, '2011-10-05'),
                   (60, 'An.Neg                                  ', 'Descritor das regras de neg', 80, '2011-10-05'),
                   (70, 'Codificar                               ', 'Codificar linhas de programas', 80, '2011-10-05'),
                   (80, 'Testar Progrszd                         ', 'Teste de programas conclu', 80, '2011-10-05'),
                   (90, 'AdmPesqSist                             ', 'Administrar o Sistema de Pesquisa (Prospec', 80, '2011-10-05'),
                   (100, 'Ensinar                                 ', 'Dar aulas de TI', 80, '2011-10-05'),
                   (110, 'Montar Cursos                           ', 'Desenvolver material de Cursos', 80, '2011-10-05'),
                   (120, 'Suporte Pessoal                         ', 'Surporte de Pessoal', 80, '2011-10-05'),
                   (130, 'Operar                                  ', 'Operar sistemas de informa', 80, '2011-10-05'),
                   (140, 'Manutenir                               ', 'Fazer a manuten', 80, '2011-10-05'),
                   (150, 'AdmSistInfor                            ', 'Administrar Sistemas de Informa', 80, '2011-10-05'),
                   (160, 'AdmDataBase                             ', 'Administrar Bases de Dados', 80, '2011-10-05'),
                   (170, 'Adm Com. Dados                          ', 'Administrar a rede de Dados', 80, '2011-10-05'),
                   (180, 'troca                                   ', 'troca', 80, '2011-10-05'),
                   (190, 'Treinar                                 ', 'Treinamento de Usuários', 80, '2011-10-05'),
                   (200, 'Portar Dados                            ', 'Efetuar porte de dados existentes em sistemas', 80, '2011-10-05'),
                   (210, 'Desenvolvimento                         ', 'Desenvolvimento', 80, '2011-10-05'),
                   (230, 'aDSas                                   ', 'ASDasd', 234, '2010-10-10');
-- Data for Name: tarefasprojetos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.tarefasprojetos
            VALUES (1, 'AD2323', 10, 200, 1, '2010-10-10'),
                   (2, 'AD2323', 20, 200, 2, '2010-10-10'),
                   (3, 'AD3100', 10, 200, 1, '2010-10-10'),
                   (4, 'AD3100', 20, 200, 2, '2010-10-10'),
                   (5, 'AD3100', 30, 200, 3, '2010-10-10'),
                   (6, 'AD3100', 40, 200, 4, '2010-10-10'),
                   (7, 'AD3100', 50, 200, 5, '2010-10-10'),
                   (8, 'AD3100', 60, 200, 6, '2010-10-10'),
                   (9, 'AD3100', 70, 200, 7, '2010-10-10'),
                   (10, 'AD3100', 80, 200, 8, '2010-10-10'),
                   (11, 'AD3100', 140, 200, 9, '2010-10-10'),
                   (12, 'AD3100', 100, 200, 10, '2010-10-10'),
                   (13, 'AD3100', 110, 200, 11, '2010-10-10'),
                   (14, 'AD3100', 120, 200, 12, '2010-10-10'),
                   (15, 'AD3100', 130, 200, 13, '2010-10-10'),
                   (16, 'AD3100', 140, 200, 14, '2010-10-10'),
                   (17, 'AD3100', 150, 200, 15, '2010-10-10'),
                   (18, 'AD3100', 160, 200, 16, '2010-10-10'),
                   (19, 'AD3100', 170, 200, 17, '2010-10-10'),
                   (20, 'AD3110', 10, 200, 1, '2010-10-10'),
                   (21, 'AD3110', 20, 200, 2, '2010-10-10'),
                   (22, 'AD3112', 10, 200, 1, '2010-10-10'),
                   (23, 'AD3112', 20, 200, 2, '2010-10-10'),
                   (24, 'AD3112', 60, 200, 6, '2010-10-10'),
                   (25, 'AD3112', 70, 200, 7, '2010-10-10'),
                   (26, 'AD3112', 80, 200, 8, '2010-10-10'),
                   (27, 'AD3113', 10, 200, 1, '2010-10-10'),
                   (28, 'AD3113', 20, 200, 2, '2010-10-10'),
                   (29, 'AD3113', 60, 200, 6, '2010-10-10'),
                   (30, 'AD3113', 70, 200, 7, '2010-10-10'),
                   (31, 'AD3113', 80, 200, 8, '2010-10-10'),
                   (32, 'IF1000', 10, 200, 1, '2010-10-10'),
                   (33, 'IF1000', 20, 200, 2, '2010-10-10'),
                   (34, 'IF1000', 30, 200, 3, '2010-10-10'),
                   (35, 'IF1000', 40, 200, 4, '2010-10-10'),
                   (36, 'IF1000', 50, 200, 5, '2010-10-10'),
                   (37, 'IF1000', 60, 200, 6, '2010-10-10'),
                   (38, 'IF1000', 70, 200, 7, '2010-10-10'),
                   (39, 'IF1000', 80, 200, 8, '2010-10-10'),
                   (40, 'IF1000', 90, 200, 9, '2010-10-10'),
                   (41, 'IF1000', 100, 200, 10, '2010-10-10'),
                   (42, 'IF1000', 110, 200, 11, '2010-10-10'),
                   (43, 'IF1000', 120, 200, 12, '2010-10-10'),
                   (44, 'IF1000', 130, 200, 13, '2010-10-10'),
                   (45, 'IF1000', 140, 200, 14, '2010-10-10'),
                   (46, 'IF1000', 150, 200, 15, '2010-10-10'),
                   (47, 'IF1000', 160, 200, 16, '2010-10-10'),
                   (48, 'IF1000', 170, 200, 17, '2010-10-10'),
                   (49, 'IF2000', 10, 200, 1, '2010-10-10'),
                   (50, 'IF2000', 20, 200, 2, '2010-10-10'),
                   (51, 'IF2000', 100, 200, 10, '2010-10-10'),
                   (52, 'IF2000', 110, 200, 11, '2010-10-10'),
                   (53, 'MA2100', 10, 200, 1, '2010-10-10'),
                   (54, 'MA2100', 20, 200, 2, '2010-10-10'),
                   (55, 'MA2100', 30, 200, 3, '2010-10-10'),
                   (56, 'MA2100', 40, 200, 4, '2010-10-10'),
                   (57, 'MA2100', 50, 200, 5, '2010-10-10'),
                   (58, 'MA2100', 60, 200, 6, '2010-10-10'),
                   (59, 'MA2100', 70, 200, 7, '2010-10-10'),
                   (60, 'MA2100', 80, 200, 8, '2010-10-10'),
                   (61, 'MA2100', 90, 200, 9, '2010-10-10'),
                   (62, 'MA2100', 100, 200, 10, '2010-10-10'),
                   (63, 'MA2100', 110, 200, 11, '2010-10-10'),
                   (64, 'MA2100', 120, 200, 12, '2010-10-10'),
                   (65, 'MA2100', 130, 200, 13, '2010-10-10'),
                   (66, 'MA2100', 140, 200, 14, '2010-10-10'),
                   (67, 'MA2100', 150, 200, 15, '2010-10-10'),
                   (68, 'MA2100', 160, 200, 16, '2010-10-10'),
                   (69, 'MA2100', 170, 200, 17, '2010-10-10'),
                   (70, 'MA2110', 10, 200, 1, '2010-10-10'),
                   (71, 'MA2110', 20, 200, 2, '2010-10-10'),
                   (72, 'MA2110', 30, 200, 3, '2010-10-10'),
                   (73, 'MA2110', 40, 200, 4, '2010-10-10'),
                   (74, 'MA2110', 50, 200, 5, '2010-10-10'),
                   (75, 'MA2110', 60, 200, 6, '2010-10-10'),
                   (76, 'MA2110', 70, 200, 7, '2010-10-10'),
                   (77, 'MA2110', 80, 200, 8, '2010-10-10'),
                   (78, 'MA2110', 90, 200, 9, '2010-10-10'),
                   (79, 'MA2110', 100, 200, 10, '2010-10-10'),
                   (80, 'MA2110', 110, 200, 11, '2010-10-10'),
                   (81, 'MA2110', 120, 200, 12, '2010-10-10'),
                   (82, 'MA2110', 130, 200, 13, '2010-10-10'),
                   (83, 'MA2110', 140, 200, 14, '2010-10-10'),
                   (84, 'MA2110', 150, 200, 15, '2010-10-10'),
                   (85, 'MA2110', 160, 200, 16, '2010-10-10'),
                   (86, 'MA2110', 170, 200, 17, '2010-10-10'),
                   (87, 'MA2111', 10, 200, 1, '2010-10-10'),
                   (88, 'MA2111', 20, 200, 2, '2010-10-10'),
                   (89, 'MA2111', 40, 200, 4, '2010-10-10'),
                   (90, 'MA2111', 50, 200, 5, '2010-10-10'),
                   (91, 'MA2111', 60, 200, 6, '2010-10-10'),
                   (92, 'MA2112', 10, 200, 1, '2010-10-10'),
                   (93, 'MA2112', 20, 200, 2, '2010-10-10'),
                   (94, 'MA2112', 30, 200, 3, '2010-10-10'),
                   (95, 'MA2112', 40, 200, 4, '2010-10-10'),
                   (96, 'MA2112', 50, 200, 5, '2010-10-10'),
                   (97, 'MA2112', 60, 200, 6, '2010-10-10'),
                   (98, 'MA2112', 70, 200, 7, '2010-10-10'),
                   (99, 'MA2112', 80, 200, 8, '2010-10-10'),
                   (100, 'MA2112', 90, 200, 9, '2010-10-10'),
                   (101, 'MA2112', 100, 200, 10, '2010-10-10'),
                   (102, 'MA2112', 110, 200, 11, '2010-10-10'),
                   (103, 'MA2112', 120, 200, 12, '2010-10-10'),
                   (104, 'MA2112', 130, 200, 13, '2010-10-10'),
                   (105, 'MA2112', 140, 200, 14, '2010-10-10'),
                   (106, 'MA2112', 150, 200, 15, '2010-10-10'),
                   (107, 'MA2112', 160, 200, 16, '2010-10-10'),
                   (108, 'MA2112', 170, 200, 17, '2010-10-10'),
                   (109, 'MA2113', 10, 200, 1, '2010-10-10'),
                   (110, 'MA2113', 20, 200, 2, '2010-10-10'),
                   (111, 'MA2113', 60, 200, 6, '2010-10-10'),
                   (112, 'MA2113', 70, 200, 7, '2010-10-10'),
                   (114, 'OP2000', 10, 200, 1, '2010-10-10'),
                   (115, 'OP2000', 20, 200, 2, '2010-10-10'),
                   (116, 'OP2010', 10, 200, 1, '2010-10-10'),
                   (117, 'OP2010', 20, 200, 2, '2010-10-10'),
                   (118, 'OP2011', 10, 200, 1, '2010-10-10'),
                   (119, 'OP2011', 20, 200, 2, '2010-10-10'),
                   (120, 'OP2012', 10, 120, 1, '2010-10-10'),
                   (121, 'OP2012', 20, 100, 2, '2010-10-10'),
                   (122, 'OP2013', 10, 120, 1, '2010-10-10'),
                   (123, 'OP2013', 20, 90, 2, '2010-10-10'),
                   (124, 'MA2110', 40, 200, 1, '2010-10-10');
-- Data for Name: telefonestipos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.telefonestipos
            VALUES (5, 'Fixo - Residencial', '2011-10-25'),
                   (10, 'Celular Particular', '2011-10-25'),
                   (15, 'Fixo - Comercial', '2011-10-25'),
                   (20, 'Celular Empresa', '2011-10-25');
-- Data for Name: titulacoes; Type: TABLE DATA; Schema: public; Owner: postgres
-- Data for Name: veiculos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.veiculos
            VALUES (1, 'ABC1593', 1, 1, 40, 'P', NULL, 5, '2015', 'C', '2018-02-20'),
                   (2, 'BBC1593', 2, 1, 50, 'P', NULL, 5, '2010', 'C', '2017-02-20'),
                   (3, 'CBC1593', 1, 1, 60, 'P', NULL, 5, '1999', 'C', '2018-02-20'),
                   (4, 'DBC1593', 2, 1, 90, 'P', NULL, 5, '2012', 'C', '2016-02-20'),
                   (5, 'EBC2604', 1, 1, 110, 'P', NULL, 4, '2015', 'C', '2016-02-20'),
                   (6, 'FBC1593', 2, 1, 90, 'P', NULL, 5, '2013', 'C', '2016-02-20'),
                   (7, 'ABC3715', 1, 1, 120, 'P', NULL, 5, '2015', 'C', '2015-04-20'),
                   (8, 'ABC4826', 2, 1, 110, 'P', NULL, 5, '2016', 'C', '2015-05-04'),
                   (9, 'ABD4826', 2, 1, NULL, NULL, 'Orion', 45, '2016', 'O', '2015-05-04'),
                   (10, 'AYH4826', 2, 1, NULL, NULL, 'Morpheus', 45, '2016', 'O', '2015-05-04'),
                   (11, 'AUJ4826', 2, 1, NULL, NULL, 'Centauro', 45, '2016', 'O', '2015-05-04'),
                   (12, 'AJO4826', 2, 1, NULL, NULL, 'Vega', 45, '2016', 'O', '2015-05-04');
-- Data for Name: veiculosmarcas; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.veiculosmarcas
            VALUES (2, 'Toruga', 1, '2010-05-10'),
                   (3, 'Elba', 2, '2005-10-10'),
                   (4, 'Bravo', 2, '2015-01-10'),
                   (5, 'Uno Mille', 2, '2001-01-10'),
                   (6, 'teste', 2, '2011-05-10'),
                   (1, 'Jetta', 1, '2016-03-26');
-- Data for Name: veiculosmodelos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.veiculosmodelos
            VALUES (2, 1, 'Santana 2.0', 'A', '2002-02-02'),
                   (3, 6, 'voyage 1.6', 'Z', '2002-02-02'),
                   (4, 1, 'Golf 2.0', 'Z', '2002-02-02'),
                   (9, 3, 'Elba WeekEnd 1.8 turbo', 'G', '2010-10-10'),
                   (1, 4, 'Bravo Cellera 2.2', 'G', '2002-05-20'),
                   (14, 4, 'Bravo Pallas 2.2', 'F', '2010-10-10');
-- Data for Name: veiculostipos; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.veiculostipos
            VALUES (1, 'Automóvel', '2013-01-20'),
                   (2, 'Embarcação Fluvial', '2013-01-20'),
                   (3, 'Embarcação Marítima', '2013-01-20'),
                   (4, 'Avião Comercial para até 20 passageiros', '2013-01-20');
-- Data for Name: viagens; Type: TABLE DATA; Schema: public; Owner: postgres
INSERT INTO public.viagens
            VALUES (1, 1, '2012-06-23', '00:00:00', '2012-06-23', NULL, NULL),
                   (2, 1, '2012-06-24', '00:00:00', '2012-06-23', NULL, NULL),
                   (3, 1, '2012-06-25', '00:00:00', '2012-06-23', NULL, NULL),
                   (4, 1, '2012-06-26', '00:00:00', '2012-06-23', NULL, NULL),
                   (5, 2, '2012-06-23', '16:50:00', '2012-06-23', NULL, NULL),
                   (6, 2, '2012-06-24', '00:00:00', '2012-06-23', NULL, NULL),
                   (7, 1, '2012-06-30', '23:59:00', '2012-06-23', NULL, NULL),
                   (8, 2, '2012-06-30', '23:59:00', '2012-06-23', NULL, NULL);

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
-- PostgreSQL database dump complete
