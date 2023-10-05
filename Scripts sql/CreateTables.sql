/* Todas as constraints
Pessoa: cpfPKpessoa
Telefone: cpfPKtel, CPFFKtel
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
