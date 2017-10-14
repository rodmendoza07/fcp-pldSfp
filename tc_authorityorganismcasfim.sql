USE LEAP
GO

CREATE TABLE tc_authorityorganismcasfim(
	aocasfim_id INT NOT NULL IDENTITY(1,1)
	, aocasfim_key VARCHAR(10) NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_key DEFAULT ('')
	, aocasfim_name VARCHAR(250) NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_name DEFAULT ('')
	, aocasfim_acronym VARCHAR(15) NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_acronym DEFAULT ('')
	, aocasfim_status INT NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_status DEFAULT(1)
	, aocasfim_regdate DATETIME NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_regdate DEFAULT (GETDATE())
	, aocasfim_moddate DATETIME NOT NULL CONSTRAINT c_tc_authorityorganismcasfim_aocasfim_moddate DEFAULT ('')
)

INSERT INTO tc_authorityorganismcasfim (
	aocasfim_key
	, aocasfim_name
	, aocasfim_acronym
) VALUES
	('01-001','Secretaría de Hacienda y Crédito Público', 'SHCP')
	, ('01-002','Comisión Nacional Bancaria y de Valores', 'CNBV')
	, ('01-003','Comisión Nacional de Seguros y Finanzas', 'CNSF')
	, ('01-004','Comisión Nacional de Sistemas de Ahorro para el Retiro', 'CONSAR')
	, ('01-005','Comisión Nacional para la Protección y Defensa de los Usuarios de Servicios Financieros', 'CONDUSEF')
	, ('01-006','Instituto para la Protección al Ahorro Bancario', 'IPAB')
	, ('01-007','Servicio de Administración Tributaria', 'SAT')