USE LEAP
GO

CREATE TABLE tc_operationdof (
	opdof_id INT NOT NULL IDENTITY(1,1)
	, opdof_key VARCHAR(5) NOT NULL CONSTRAINT c_tc_operationdof_opdof_key DEFAULT('')
	, opdof_optype VARCHAR(200) NOT NULL CONSTRAINT c_tc_operationdof_opdof_optype DEFAULT('')
	, opdof_description VARCHAR(250) NOT NULL CONSTRAINT c_tc_operationdof_opdof_description DEFAULT('')
	, opdof_status INT NOT NULL CONSTRAINT c_tc_operationdof_opdof_status DEFAULT(1)
	, opdof_regdate DATETIME NOT NULL CONSTRAINT c_tc_operationdof_opdof_regdate DEFAULT(GETDATE())
	, opdof_moddate DATETIME NOT NULL CONSTRAINT c_tc_operationdof_opdof_moddate DEFAULT('')
)

INSERT INTO tc_operationdof (
	opdof_key
	, opdof_optype
	, opdof_description
) VALUES
	('08','OTORGAMIENTO DE CREDITO','')
	, ('09','PAGO DE CREDITO',' ')
	, ('27','PAGO DE RENTAS DE ARRENDAMIENTO FINANCIERO',' ')
	, ('28','VENTA DE BIENES ARRENDADOS',' ')
	, ('29','ADQUISICION DE BIENES DEL FUTURO ARRENDATARIO','')
	, ('35','CONTRATACION DE ARRENDAMIENTO FINANCIERO',' ')
	, ('38','VENTA DE TARJETAS PREPAGADAS','')
	, ('39','RECARGA DE TARJETAS PREPAGADAS','')
	, ('40','DISPOSICION DE CREDITO',' ')
	, ('41','LIQUIDACION DE CREDITO','Se deberá utilizar cuando el credito sea pagado en su totalidad, ya sea como último pago o como una operación de prepago')
	, ('42','APORTACIONES A UN CONTRATO','Se deberá utilizar cuando se realicen operaciones de aportaciones a cualquier tipo de contrato generado por la SOFOM ( arrendamiento financiero o factoraje financiero) diferentes al pago de creditos')
	, ('43','APORTACIONES A UN FIDEICOMISO',' ')
	, ('44','PAGOS DE FACTORAJE FINANCIERO','')
	, ('45','PAGO DE SERVICIOS','Se deberá utilizar cuando se realicen operaciones de pago de cualquier servicio accesorio al contrato de crédito ejemplo seguros')
	, ('46','CONTRATACION DE UN FIDEICOMISO','')
	, ('47','CONTRATACION FACTORAJE FINANCIERO','')
	, ('48','RETIRO DE UN FIDEICOMISO','')
	, ('49','CESION DE DERECHOS','Se deberá utilizar cuando se realicen operaciones en donde la SOFOM venda la cartera o ceda los derechos de cobro a un tercero.')
