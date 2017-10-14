USE LEAP
GO

CREATE TABLE tc_moneyinstrumentdof (
	midof_id INT NOT NULL IDENTITY(1,1)
	, midof_key VARCHAR(10) NOT NULL CONSTRAINT c_tc_moneyinstrumentdof_midof_key DEFAULT ('')
	, midof_moneyinstrumenttype VARCHAR(200) NOT NULL CONSTRAINT c_tc_moneyinstrumentdof_midof_moneyinstrumenttype DEFAULT ('')
	, midof_description VARCHAR(250) NOT NULL CONSTRAINT c_tc_moneyinstrumentdof_midof_description DEFAULT ('')
	, midof_status INT NOT NULL CONSTRAINT c_tc_moneyinstrument_midof_status DEFAULT (1)
	, midof_regdate DATETIME NOT NULL CONSTRAINT c_tc_moneyinstrument_midof_regdate DEFAULT (GETDATE())
	, midof_moddate DATETIME NOT NULL CONSTRAINT c_tc_moneyinstrument_midof_moddate DEFAULT ('')
)

INSERT INTO tc_moneyinstrumentdof (
	midof_key
	, midof_moneyinstrumenttype
	, midof_description
) VALUES 
	('01','EFECTIVO','')
	, ('03','TRANSFERENCIAS','')
	, ('04','CHEQUES DE VIAJERO','')
	, ('05','ORO O PLATINO AMONEDADOS','')
	, ('06','PLATA AMONEDADA','')
	, ('08','DERECHOS','Se deberá utilizar cuando se otorguen derechos como medio de pago')
	, ('10','CHEQUES  ','')
	, ('11','BIENES','Se deberá utilizar cuando se utilice cualquier mercancia ó bien como medio de pago')
	, ('12','CHEQUE DE CAJA','')