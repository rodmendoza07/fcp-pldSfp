USE LEAP
GO

ALTER PROCEDURE [dbo].[sp_dailyRequirement]
(
	@name VARCHAR(100) = ''
	, @firstname VARCHAR(200) = ''
	, @lastname VARCHAR(200) = ''
	, @rfc VARCHAR(20) = ''
	, @curp VARCHAR(20) = ''
	, @birthdate VARCHAR(20) = ''
	, @file VARCHAR(50) = ''
	, @oficio VARCHAR(50) = ''
	, @fileDate DATETIME = GETDATE
	, @authority VARCHAR(30) = 'UIF'
	--, @udt_personPLD udt_personPLD readonly
	, @appUser VARCHAR(15) = ''
	, @ipAddress VARCHAR(15) = ''
)
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DECLARE
			@branchOffice INT = 0
			, @udt_personPLD udt_personPLD
			, @gender VARCHAR(10) = ''
			, @msg VARCHAR(300) = '' 
		SELECT
			@branchOffice = cve_depto
		FROM CATALOGOS.dbo.tc_empleados
		WHERE usuario = @appUser
		
		-- SELECT @branchOffice

		INSERT INTO LEAP.dbo.tc_dailyRequirement (
			nombre
			, paterno
			, materno
			, curp
			, rfc
			, fecha_nacimiento
			, dr_fileDate
			, lista
			, dr_fileNumber
			, dr_oficioNumber
		)
		VALUES (
			@name
			, @firstname
			, @lastname
			, @curp
			, @rfc
			, @birthdate
			, @fileDate
			, @authority
			, @file
			, @oficio
		)

		INSERT INTO @udt_personPLD
		(
			id_persona
			, peso1
			, peso2
			, nombre
			, paterno
			, materno
			, curp
			, rfc
			, fecha_nacimiento
			, sexo --10
			, lista
			, estatus
			, dependencia
			, puesto
			, area
			, iddispo
			, idrel
			, parentesco
			, razonsoc
			, rfcmoral --20
			, issste
			, imss
			, ingresos
			, nombrecomp
			, apellidos
			, entidad
			, curp_ok
			, periodo
			, expediente
			, fecha_resolucion--30
			, causa_irregularidad
			, sancion
			, fecha_cargo_ini
			, fecha_cargo_fin
			, duracion
			, monto
			, autoridad_sanc
			, admon_local
			, numord
			, rubro--40
			, central_obrera 
			, numsocios
			, fecha_vigencia
			, titulo
			, domicilio_a
			, domicilio_b
			, colonia
			, cp
			, ciudad
			, lada--50
			, telefono
			, fax
			, email
			, pais
			, gafi
			, id_prospecto
		) SELECT
			'PRV' + CONVERT(varchar, GETDATE(), 112) + REPLACE(CONVERT(varchar, GETDATE(),114),':','') 
			, ''
			, ''
			, pros.nombre
			, pros.paterno
			, pros.materno
			, pros.CURP
			, pros.RFC
			, CONVERT(varchar,pros.fechanacimiento,120)
			, CASE 
				WHEN pros.sexo = 'F' THEN 'Femenino'
				WHEN pros.sexo = 'M' THEN 'Masculino'
				END AS gender--10
			, @authority
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''--20
			, ''
			, ''
			, ''
			, pros.nombre + ' ' + pros.paterno + ' ' + pros.materno
			, pros.paterno + ' ' + pros.materno
			, ''
			, ''
			, ''
			, ''
			, ''--30
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''
			, ''--40
			, ''
			, ''
			, ''
			, ''
			, pros.calle
			, ''
			, pros.colonia
			, pros.codigopostal
			, pros.municipiodelegacion
			, pros.ladatel1--50
			, pros.telefono1
			, ''
			, ISNULL(isiCte.E_MAIL, '')
			, ''
			, ''
			, pros.id_prospecto
		FROM LEAP.dbo.tp_prospecto pros
			INNER JOIN ISILOANSWEB.dbo.T_CTE isiCte ON (pros.id_cte_isi = isiCte.ACREDITADO)
			INNER JOIN LEAP.dbo.td_expediente files ON (pros.id_cte_isi = files.id_cte_isi)
		WHERE nombre LIKE '%' + @name + '%'
			AND paterno LIKE '%' + @firstname + '%'

		IF (SELECT COUNT (*) FROM @udt_personPLD) <> 0 BEGIN
			EXEC LEAP.dbo.sp_setPersonONPLD @udt_personPLD, @appUser, @ipAddress, @branchOffice, 1
		END

		IF @@TRANCOUNT > 0 BEGIN
			COMMIT TRAN
			SELECT 
				dr.nombre + ' ' + dr.paterno + ' ' + dr.materno AS [name]
				, '<span class="label ' + tipo.label + '">' + dr.lista + '</span>' AS authority
				, dr.dr_fileNumber AS [file]
				, dr.dr_oficioNumber AS oficio
				, dr.dr_fileDate AS fileDate
			FROM LEAP.dbo.tc_dailyRequirement dr
				INNER JOIN LEAP.dbo.tc_listaPLD lt ON (dr.lista = lt.siglas)
				INNER JOIN LEAP.dbo.tc_tipo_lista_pld tipo ON (lt.tipo = tipo.id_tipo_lista_pld)
			WHERE CONVERT(varchar, dr.dr_registerDate, 112) = CONVERT(VARCHAR, GETDATE(), 112)
			ORDER BY id_persona DESC
			SELECT 'El nombre se guardo correctamente' AS [message]
		END
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
				ROLLBACK TRAN
		SET @msg = (SELECT SUBSTRING(ERROR_MESSAGE(), 1, 300))
	END CATCH
END