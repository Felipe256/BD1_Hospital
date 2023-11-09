/* Todas as constraints
Pessoa: cpfPKpessoa
Telefone: cpfPKtel, CPFFKtel
Quarto: PKNUMquarto
Paciente: CPFPKpaciente, CPFFKpaciente, NRQUARTOFKpaciente
Enfermeiro: corenPKenfermeiro, cpfFKmedico
Medico: cpfFKmedico, crmPKmedico
Especialidade: crmFKespec
Comorbidade: cpfPKComorbidade, cpfFKComorbidade
Consulta: cpfFKConsulta, crmFKConsulta, idPKConsulta
Exame: corenFKExame, cpfFKExame, crmFKExame, idPKExame

*/
CREATE SCHEMA IF NOT EXISTS hosp
    AUTHORIZATION postgres;

SET search_path TO hosp, public;

CREATE TABLE IF NOT EXISTS Pessoa(
	nome varchar(50) NOT NULL,
	cpf varchar(11) NOT NULL,
	
	CONSTRAINT cpfPKpessoa PRIMARY KEY(cpf)
);
CREATE TABLE IF NOT EXISTS Telefone(
	telNum varchar(9) NOT NULL, /* varchar pois telefone tem 8 e celular 9*/
	cpfPessoa varchar(11)  NOT NULL,
	
	CONSTRAINT cpfPKtel PRIMARY KEY(cpfPessoa),
	CONSTRAINT CPFFKtel FOREIGN KEY(cpfPessoa) REFERENCES Pessoa(cpf) ON DELETE CASCADE ON UPDATE CASCADE	
);
CREATE TABLE IF NOT EXISTS Quarto(
	NUM_QUARTO int NOT NULL, /* OU VARCHAR?*/
	
	CONSTRAINT PKNUMquarto PRIMARY KEY(NUM_QUARTO)
);
CREATE TABLE IF NOT EXISTS Paciente(
	cpfPaciente varchar(11) NOT NULL,
	sorotipagem char(3) NOT NULL,
	NrQuarto int,
	
	CONSTRAINT CPFPKpaciente PRIMARY KEY(cpfPaciente),
	CONSTRAINT CPFFKpaciente FOREIGN KEY(cpfPaciente) REFERENCES Pessoa(cpf) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT NRQUARTOFKpaciente FOREIGN KEY(NRQuarto) REFERENCES Quarto(NUM_QUARTO) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Enfermeiro(
	cpf varchar(11) NOT NULL,
	coren varchar(19) NOT NULL,
	plantao varchar(5),
	
	CONSTRAINT corenPKenfermeiro PRIMARY KEY(coren),
	CONSTRAINT cpfFKenfermeiro FOREIGN KEY(cpf) REFERENCES Pessoa(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Medico(
	cpf varchar(11) NOT NULL,
	crm varchar(13) NOT NULL,
	plantao varchar(5),
	
	CONSTRAINT crmPKmedico PRIMARY KEY(crm),
	CONSTRAINT cpfFKmedico FOREIGN KEY(cpf) REFERENCES Pessoa(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);
	
CREATE TABLE IF NOT EXISTS Especialidade(
	crm varchar(13) NOT NULL,
	descricao varchar(20) NOT NULL,
	
	CONSTRAINT crmFKespec FOREIGN KEY(crm) REFERENCES Medico(crm) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Comorbidade(
	cpf varchar(11) NOT NULL,
	descricao varchar(100) NOT NULL,

	CONSTRAINT cpfPKComorbidade PRIMARY KEY(cpf),
	CONSTRAINT cpfFKComorbidade FOREIGN KEY(cpf) REFERENCES paciente(cpfpaciente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Consulta(
	id varchar(6) NOT NULL,
	crm varchar(13) NOT NULL,
	cpf varchar(11) NOT NULL,
	horario timestamp NOT NULL,
	status varchar(100) NOT NULL,

	CONSTRAINT idPKConsulta PRIMARY KEY(id),
	CONSTRAINT crmFKConsulta FOREIGN KEY(crm) REFERENCES Medico(crm) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cpfFKConsulta FOREIGN KEY(cpf) REFERENCES Paciente(cpfpaciente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Exame(
	id varchar(6) NOT NULL,
	crm varchar(13) NOT NULL,
	cpf varchar(11) NOT NULL,
	coren varchar(19) NOT NULL,
	horario timestamp NOT NULL,
	nome varchar(50) NOT NULL,

	CONSTRAINT idPKExame PRIMARY KEY(id),
	CONSTRAINT crmFKExame FOREIGN KEY(crm) REFERENCES Medico(crm) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cpfFKExame FOREIGN KEY(cpf) REFERENCES Paciente(cpfpaciente) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT corenFKExame FOREIGN KEY(coren) REFERENCES Enfermeiro(coren) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Resultado(
	id varchar(6) NOT NULL,
	descricao varchar(20) NOT NULL,

	CONSTRAINT idFKresul FOREIGN KEY(id) REFERENCES Exame(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS CentroCirurgico(
	numero int,

	CONSTRAINT numeroPKCentroCirurgico PRIMARY KEY(numero)
);

CREATE TABLE IF NOT EXISTS Cirurgia(
	id varchar(6) NOT NULL,
	crm varchar(13) NOT NULL,
	cpf varchar(11) NOT NULL,
	coren varchar(19) NOT NULL,
	numero int NOT NULL,
	horario timestamp NOT NULL,
	descricao varchar(100) NOT NULL,

	CONSTRAINT idPKCirurgia PRIMARY KEY(id),
	CONSTRAINT crmFKCirugia FOREIGN KEY(crm) REFERENCES Medico(crm) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cpfFKCirurgia FOREIGN KEY(cpf) REFERENCES Paciente(cpfpaciente) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT corenFKCirurgia FOREIGN KEY(coren) REFERENCES Enfermeiro(coren) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT numeroFKCirurgia FOREIGN KEY(numero) REFERENCES CentroCirurgico(numero) ON DELETE CASCADE ON UPDATE CASCADE
);