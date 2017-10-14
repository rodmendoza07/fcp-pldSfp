USE LEAP
GO

ALTER PROCEDURE [dbo].[sp_dailyRegister] (
	@option INT = 0
	, @name VARCHAR(50) = ''
	, @firstName VARCHAR(50) = ''
)
AS
BEGIN
	BEGIN TRY
		DECLARE
			@date date = GETDATE()

		IF @option = 0 BEGIN
			SELECT 
				dr.nombre + ' ' + dr.paterno + ' ' + dr.materno AS [name]
				, '<span class="label '+ tipo.label + '">' + dr.lista + '</span>' AS authority
				, dr.dr_fileNumber AS [file]
				, dr.dr_oficioNumber AS oficio
				, dr.dr_fileDate AS fileDate
			FROM LEAP.dbo.tc_dailyRequirement dr
				INNER JOIN LEAP.dbo.tc_listaPLD lt ON (lt.siglas = dr.lista)
				INNER JOIN LEAP.dbo.tc_tipo_lista_pld tipo ON (lt.tipo = tipo.id_tipo_lista_pld)
			WHERE CONVERT(varchar, dr.dr_registerDate, 112) = CONVERT(VARCHAR, @date, 112)
			ORDER BY id_persona DESC
		END

		IF @option = 1 BEGIN
			SELECT 
				p.id_cte_isi
				, REPLICATE('0',5 - LEN(suc.id_departamento)) + CAST(suc.id_departamento AS varchar) + ' ' + suc.descripcion AS branchOffice
				, CAST(c.F_CTEDESDE as varchar) AS dateCreationClient
				, p.nombre + ' ' + p.paterno + ' ' + p.materno AS clientName
				, p.calle + ' ' + p.numero + ' ' + p.numero_int + ' ' + p.colonia + ' ' + p.municipiodelegacion + ' ' + e.nombre + ' ' + p.codigopostal AS [address]
				, p.RFC
				, p.CURP
				, c.TELEF AS localphone
				, c.TELEF_2 AS mobilephone
				, c.E_MAIL AS email
				, pr.label AS ocupation
				, cred.NUMERO AS creditNumber
				, cred.IMP_CRED AS amount
				, ISNULL(cred.FECH_ALTA, 0) AS creationDate
				, c.COTIT1 AS cotitular
				, cred.NOM_BENEF As benefit
			FROM LEAP.dbo.tp_prospecto p
				INNER JOIN ISILOANSWEB.dbo.T_CTE c ON (p.id_cte_isi = c.ACREDITADO)
				INNER JOIN CATALOGOS.dbo.tc_estado e ON (p.estado = e.id_estado AND e.id_pais = 157)
				INNER JOIN CATALOGOS.dbo.tc_departamento suc ON (p.id_sucursal = suc.id_departamento)
				INNER JOIN LEAP.dbo.tc_profesion pr ON (c.OCUPACION = pr.id_profesion)
				LEFT OUTER JOIN ISILOANSWEB.dbo.T_CRED cred ON (cred.CLIENTE = c.ACREDITADO)
			WHERE p.nombre LIKE '%' + @name + '%'
				AND p.materno LIKE '%' + @firstName + '%'
		END
	END TRY
	BEGIN CATCH
		SELECT 'Error al hacer la consulta' AS [message]
	END CATCH
END
