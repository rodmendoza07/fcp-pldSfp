USE LEAP
GO

CREATE TABLE tc_typepersonpld (
	typep_id INT NOT NULL IDENTITY(1,1)
	, typep_description VARCHAR(100) NOT NULL CONSTRAINT c_tc_typepersonpld_typep_description DEFAULT('')
	, typep_status INT NOT NULL CONSTRAINT c_tc_typepersonpld_typep_estatus DEFAULT(1)
	, typep_regdate DATETIME NOT NULL CONSTRAINT c_tc_typepersonpld_typep_regdate DEFAULT(GETDATE())
	, typep_moddate DATETIME NOT NULL CONSTRAINT c_tc_typepersonpld_typep_moddate DEFAULT('')
)

INSERT INTO tc_typepersonpld (
	typep_description
) VALUES 
	('Persona Física')
	, ('Persona Moral')