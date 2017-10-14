USE LEAP
GO

CREATE TABLE tc_nationalitypld (
	nat_id INT NOT NULL IDENTITY(1,1)
	, nat_description VARCHAR(250) NOT NULL CONSTRAINT c_tc_naitonality_nat_description DEFAULT ('')
	, nat_status INT NOT NULL CONSTRAINT c_tc_nationality_nat_status DEFAULT(1)
	, nat_regdate DATETIME NOT NULL CONSTRAINT c_tc_nationality_nat_regdate DEFAULT(GETDATE())
	, nat_moddate DATETIME NOT NULL CONSTRAINT c_tc_nationality_nat_moddate DEFAULT('')
)
INSERT INTO tc_nationalitypld (
	 nat_description
) VALUES
	('Mexicana')
	, ('Extranjero')