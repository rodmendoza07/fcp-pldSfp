USE LEAP
GO

ALTER PROCEDURE [dbo].[sp_getReportReplacement](
	@clientNumber INT = 0
	, @repotType INT = 0
)
AS
BEGIN
	DECLARE
		@startDate DATETIME

	BEGIN TRY
		
		CREATE TABLE #reportTemplate (
			idPros INT
			, typeReport INT
			, periodo VARCHAR(100)
			, folio INT NOT NULL IDENTITY(1,1)
			, orgSupervisor VARCHAR(10)
			, sugObligado VARCHAR(10)
			, localidad VARCHAR(15)
			, sucursal VARCHAR(20)
			, tipoOper VARCHAR(20)
			, moneyInst VARCHAR(15)
			, cuenta VARCHAR(15)
			, monto VARCHAR(17)
			, moneda VARCHAR(10)
			, fechaOper VARCHAR(15)
			, fechaDetect VARCHAR(15)
			, nacionalidad INT
			, tipoPersona INT
			, razonSocial VARCHAR(15)
			, nombre varchar(100)
			, paterno varchar(100)
			, materno varchar(100)
			, rfc varchar(20)
			, curp varchar(30)
			, fechaNacimiento varchar(15)
			, domicilio VARCHAR(60)
			, colionia VARCHAR(30)
			, poblacion VARCHAR(100)
			, telefono VARCHAR(25)
			, actividad VARCHAR(10)
			, agent VARCHAR(100)
			, paterno1 VARCHAR(100)
			, materno1 VARCHAR(100)
			, rfc1 VARCHAR(100)
			, curp1 VARCHAR(100)
			, cuentasRelacionadas VARCHAR(100)
			, cuenta1 VARCHAR(100)
			, sugeto1 VARCHAR(100)
			, titCuentaRelacionada VARCHAR(100)
			, paterno2 VARCHAR(100)
			, materno2 VARCHAR(100)
			, desOper VARCHAR(1000)
			, reasons1 VARCHAR(100)
		)
		
		IF @repotType = 1 BEGIN
			INSERT INTO #reportTemplate (
				idPros
				, typeReport
				, periodo
				, orgSupervisor
				, sugObligado
				, localidad
				, sucursal
				, tipoOper
				, moneyInst
				, cuenta
				, monto
				, moneda
				, fechaOper
				, fechaDetect
				, nacionalidad
				, tipoPersona
				, razonSocial
				, nombre
				, paterno
				, materno
				, rfc
				, curp
				, fechaNacimiento
				, domicilio
				, colionia
				, poblacion
				, telefono
				, actividad
				, agent
				, paterno1
				, materno1
				, rfc1
				, curp1
				, cuentasRelacionadas
				, cuenta1
				, sugeto1
				, titCuentaRelacionada
				, paterno2
				, materno2
				, desOper
				, reasons1
			) SELECT
				pros.id_prospecto
				, 2
				, ''--CONVERT(varchar, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0), 112)
				, '001002'
				, '027049'
				, ''
				, dp.CLAVE_CNBV
				, CASE 
				WHEN hist.APLICACION = 6 AND hist.CONCEPTO = 4 THEN '8'
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 2 THEN '40'
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 1 THEN '9'
				WHEN cred.[STATUS] = 1 AND cred.[SUBSISTEMA] = 0 THEN '41'
				END AS tipoOper
				, '01'
				, cred.NUMERO
				, cred.IMP_CRED
				, 'MXN'
				, CASE 
				WHEN hist.APLICACION = 6 AND hist.CONCEPTO = 4 THEN hist.FEC_OPERA
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 2 THEN hist.FEC_OPERA
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 1 THEN hist.FEC_OPERA
				WHEN cred.[STATUS] = 1 AND cred.[SUBSISTEMA] = 0 THEN 
					(SELECT TOP 1 SUBSTRING(REG_CREDIT, 161,8)FROM ISILOANSWEB.dbo.T_CRED2 x WHERE x.NUMERO = hist.NUMERO)
				END AS fechaOper
				, ''
				, 1	
				, 1
				, ''
				, pros.nombre
				, pros.paterno
				, pros.materno
				, pros.RFC
				, pros.CURP
				, CONVERT(VARCHAR, pros.fechanacimiento, 112)
				, pros.calle + CONVERT(VARCHAR, pros.numero) AS domicilio
				, pros.colonia
				, pros.c_localidad
				, pros.telefono1
				, prof.clave_pld
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
			FROM LEAP.dbo.tp_prospecto pros
				INNER JOIN LEAP.dbo.tc_profesion prof ON (pros.profesion_id = prof.id_profesion)
				left JOIN CATALOGOS.dbo.tc_departamento dp ON (pros.id_sucursal = dp.id_departamento)
				INNER JOIN ISILOANSWEB.dbo.T_CRED cred ON (pros.id_cte_isi = cred.CLIENTE)
				INNER JOIN ISILOANSWEB.dbo.T_HIST hist ON (cred.NUMERO = hist.NUMERO)
			WHERE pros.id_cte_isi = @clientNumber
		END 

		IF @repotType = 2 BEGIN
			INSERT INTO #reportTemplate (
				idPros
				, typeReport
				, periodo
				, orgSupervisor
				, sugObligado
				, localidad
				, sucursal
				, tipoOper
				, moneyInst
				, cuenta
				, monto
				, moneda
				, fechaOper
				, fechaDetect
				, nacionalidad
				, tipoPersona
				, razonSocial
				, nombre
				, paterno
				, materno
				, rfc
				, curp
				, fechaNacimiento
				, domicilio
				, colionia
				, poblacion
				, telefono
				, actividad
				, agent
				, paterno1
				, materno1
				, rfc1
				, curp1
				, cuentasRelacionadas
				, cuenta1
				, sugeto1
				, titCuentaRelacionada
				, paterno2
				, materno2
				, desOper
				, reasons1
			) SELECT
				pros.id_prospecto
				, 2
				, ''--CONVERT(varchar, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0), 112)
				, '001002'
				, '027049'
				, ''
				, dp.CLAVE_CNBV
				, CASE 
				WHEN hist.APLICACION = 6 AND hist.CONCEPTO = 4 THEN '8'
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 2 THEN '40'
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 1 THEN '9'
				WHEN cred.[STATUS] = 1 AND cred.[SUBSISTEMA] = 0 THEN '41'
				END AS tipoOper
				, '01'
				, cred.NUMERO
				, cred.IMP_CRED
				, 'MXN'
				, CASE 
				WHEN hist.APLICACION = 6 AND hist.CONCEPTO = 4 THEN hist.FEC_OPERA
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 2 THEN hist.FEC_OPERA
				WHEN hist.APLICACION = 1 AND hist.CONCEPTO = 1 THEN hist.FEC_OPERA
				WHEN cred.[STATUS] = 1 AND cred.[SUBSISTEMA] = 0 THEN 
					(SELECT TOP 1 SUBSTRING(REG_CREDIT, 161,8)FROM ISILOANSWEB.dbo.T_CRED2 x WHERE x.NUMERO = hist.NUMERO)
				END AS fechaOper
				, ''
				, 1
				, 1
				, ''
				, pros.nombre
				, pros.paterno
				, pros.materno
				, pros.RFC
				, pros.CURP
				, CONVERT(VARCHAR, pros.fechanacimiento, 112)
				, pros.calle + CONVERT(VARCHAR, pros.numero) AS domicilio
				, pros.colonia
				, pros.c_localidad
				, pros.telefono1
				, prof.clave_pld
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
			FROM LEAP.dbo.tp_prospecto pros
				INNER JOIN LEAP.dbo.tc_profesion prof ON (pros.profesion_id = prof.id_profesion)
				left JOIN CATALOGOS.dbo.tc_departamento dp ON (pros.id_sucursal = dp.id_departamento)
				INNER JOIN ISILOANSWEB.dbo.T_CRED cred ON (pros.id_cte_isi = cred.CLIENTE)
				INNER JOIN ISILOANSWEB.dbo.T_HIST hist ON (cred.NUMERO = hist.NUMERO)
			WHERE pros.id_cte_isi = @clientNumber
				
		END

		IF @repotType = 3 BEGIN
			INSERT INTO #reportTemplate (
				idPros
				, typeReport
				, periodo
				, orgSupervisor
				, sugObligado
				, localidad
				, sucursal
				, tipoOper
				, moneyInst
				, cuenta
				, monto
				, moneda
				, fechaOper
				, fechaDetect
				, nacionalidad
				, tipoPersona
				, razonSocial
				, nombre
				, paterno
				, materno
				, rfc
				, curp
				, fechaNacimiento
				, domicilio
				, colionia
				, poblacion
				, telefono
				, actividad
				, agent
				, paterno1
				, materno1
				, rfc1
				, curp1
				, cuentasRelacionadas
				, cuenta1
				, sugeto1
				, titCuentaRelacionada
				, paterno2
				, materno2
				, desOper
				, reasons1
			) SELECT
				pros.id_empleados
				, 3
				, ''--CONVERT(varchar, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0), 112)
				, '001002'
				, '027049'
				, ''
				, dp.CLAVE_CNBV
				, ''
				, '01'
				, ''
				, ''
				, 'MXN'
				, ''
				, ''
				, 1
				, 1
				, ''
				, pros.nombre
				, pros.ap_paterno
				, pros.ap_materno
				, pros.RFC
				, pros.CURP
				, CONVERT(VARCHAR, pros.fnacimiento, 112)
				, pros.direccion 
				, ''
				, ''
				, pros.telefono
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
				, ''
			FROM CATALOGOS.dbo.tc_empleados pros
				left JOIN CATALOGOS.dbo.tc_departamento dp ON (pros.cve_depto = dp.id_departamento)
				--INNER JOIN ISILOANSWEB.dbo.T_CRED cred ON (pros.id_cte_isi = cred.CLIENTE)
				--INNER JOIN ISILOANSWEB.dbo.T_HIST hist ON (cred.NUMERO = hist.NUMERO)
			WHERE pros.id_empleados = @clientNumber
		END

		SELECT * FROM #reportTemplate	
		DROP TABLE #reportTemplate

	END TRY

	BEGIN CATCH
	END CATCH
END

-- EXEC LEAP.dbo.sp_getReportReplacement @clientNumber = 9, @repotType = 3