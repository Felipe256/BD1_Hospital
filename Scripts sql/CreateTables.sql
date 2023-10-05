/* Todas as constraints
Pessoa: cpfPKpessoa
Telefone: cpfPKtel, CPFFKtel
Quarto: PKNUMquarto
Paciente: CPFPKpaciente, CPFFKpaciente, NRQUARTOFKpaciente
*/
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
	NUM_QUARTO int NOT NULL /* OU VARCHAR?*/
	
	CONSTRAINT PKNUMquarto PRIMARY KEY(NUM_QUARTO)
);
CREATE TABLE IF NOT EXISTS Paciente(
	cpfPaciente varchar(11) NOT NULL,
	sorotipagem char(2) NOT NULL,
	NrQuarto int,
	
	CONSTRAINT CPFPKpaciente PRIMARY KEY(cpfPaciente),
	CONSTRAINT CPFFKpaciente FOREIGN KEY(cpfPaciente) REFERENCES Pessoa(cpf) ON DELETE CASCADE ON UPDATE CASCADE
	CONSTRAINT NRQUARTOFKpaciente FOREIGN KEY(NRQuarto) REFERENCES Quarto(NUM_QUARTO) ON DELETE SET NULL ON UPDATE CASCADE
);
