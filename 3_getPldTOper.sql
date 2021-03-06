USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPldTOper]    Script Date: 20/12/2017 11:13:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_getPldTOper](@periodNumber int = 0)
AS
BEGIN
	DECLARE
		@xml_data XML
		, @reportedYear int = LEFT(CONVERT(varchar, GETDATE(), 112), 4)
		, @dateBegin varchar(6) = ''
		, @dateEnd varchar(6) = ''
		, @today varchar(6) = LEFT(CONVERT(varchar, GETDATE(), 112), 6)
		, @dollar numeric(18, 4) = 0
		, @limit numeric (18, 2) = 0

     SET @dollar = (SELECT
				  lrexch_value
				FROM CIERRE.dbo.td_logexchangeRate
				WHERE lrexch_status = 1)
     SET @limit =  (SELECT
				    a.cfg_valor AS [Limit]
				FROM CATALOGOS.dbo.tc_config a
				WHERE a.cfg_descrip = 'PLD_USD_Limit')
     SET @dateBegin = CAST(@reportedYear AS varchar)
	SET @dateEnd = CAST(@reportedYear AS varchar)

	 --gets period
     SELECT
	   @dateBegin = @dateBegin + LEFT(a.cfg_valor, 2)
	   , @dateEnd = @dateEnd + RIGHT(a.cfg_valor, 2)
	FROM CATALOGOS.dbo.tc_config a
	WHERE a.cfg_descrip = 'PLD_Period_' + CAST(@periodNumber AS varchar)


	IF (@today BETWEEN @dateBegin AND @dateEnd) OR (@dateBegin >= @today)
	BEGIN 
	   SET @dateBegin = CAST((@reportedYear - 1) AS varchar) + RIGHT(@dateBegin, 2)
	   SET @dateEnd = CAST((@reportedYear - 1) AS varchar) + RIGHT(@dateEnd, 2)
	END

	SELECT 
		REPLICATE('0', 5-LEN(b.SUCURSAL)) + CAST(b.SUCURSAL AS varchar) + ' - ' + RTRIM(LTRIM(c.descripcion)) AS [Sucursal]
		, a.pldTO_client AS [Cliente]
		, a.pldTO_import AS [Importe]
		, a.pldTO_period AS [Periodo]
		, b.TITULAR AS [Nombre]
		, b.DIRECCION AS [Domicilio]
		, b.COLONIA AS [Colonia]
		, b.CIUDAD AS [Ciudad]
		,CASE 
			WHEN b.TIP_IDEN_CTE = 1 THEN 'IFE'
			WHEN b.TIP_IDEN_CTE = 2 THEN 'CARTILLA'
			WHEN b.TIP_IDEN_CTE = 3 THEN 'PASAPORTE'
			WHEN b.TIP_IDEN_CTE = 4 THEN 'CEDULA PROFESIONAL'
			WHEN b.TIP_IDEN_CTE = 5 THEN 'OTRA' END AS [Tipo_ID]
		, b.PASAPORTE AS [Numero_ID]
		, b.TELEF AS [Telefono]
		, b.FEC_NACIMIENTO AS [Fecha_Nacimiento]
	FROM LEAP.dbo.tp_pldTOper a
		INNER JOIN ISILOANSWEB.dbo.T_CTE b WITH(NOLOCK) ON (a.pldTO_client = b.ACREDITADO)
		INNER JOIN CATALOGOS.dbo.tc_departamento c WITH(NOLOCK) ON (b.SUCURSAL = c.id_departamento)
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, a.pldTO_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) OR (LEFT(CONVERT(varchar, a.pldTO_dateCreate, 112), 6) BETWEEN @dateBegin AND @dateEnd))
	   AND (a.pldTO_import * @dollar) > @limit
	ORDER BY a.pldTO_dateCreate, b.SUCURSAL, a.pldTO_client

	SELECT 
		REPLICATE('0', 5-LEN(b.SUCURSAL)) + CAST(b.SUCURSAL AS varchar) + ' - ' + RTRIM(LTRIM(c.descripcion)) AS [departament]
		, a.pldTO_client AS [clientID]
		, a.pldTO_import AS [amount]
		, a.pldTO_period AS [report]
		, RTRIM(LTRIM(REPLACE(b.TITULAR, '*', ''))) AS [client]
		, RTRIM(LTRIM(b.DIRECCION)) AS [street]
		, RTRIM(LTRIM(b.COLONIA)) AS [colony]
		, RTRIM(LTRIM(b.CIUDAD)) AS [city]
		, CASE 
			WHEN b.TIP_IDEN_CTE = 1 THEN 'IFE'
			WHEN b.TIP_IDEN_CTE = 2 THEN 'CARTILLA'
			WHEN b.TIP_IDEN_CTE = 3 THEN 'PASAPORTE'
			WHEN b.TIP_IDEN_CTE = 4 THEN 'CEDULA PROFESIONAL'
			WHEN b.TIP_IDEN_CTE = 5 THEN 'OTRA' END AS [typeID]
		, RTRIM(LTRIM(b.PASAPORTE)) AS [numberID]
		, RTRIM(LTRIM(b.TELEF)) AS [phone]
		, RTRIM(LTRIM(b.FEC_NACIMIENTO)) AS [dateBirth]
	INTO #tmpXML
	FROM LEAP.dbo.tp_pldTOper a
		INNER JOIN ISILOANSWEB.dbo.T_CTE b WITH(NOLOCK) ON (a.pldTO_client = b.ACREDITADO)
		INNER JOIN CATALOGOS.dbo.tc_departamento c WITH(NOLOCK) ON (b.SUCURSAL = c.id_departamento)
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, a.pldTO_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) OR (LEFT(CONVERT(varchar, a.pldTO_dateCreate, 112), 6) BETWEEN @dateBegin AND @dateEnd))
	ORDER BY a.pldTO_dateCreate, b.SUCURSAL, a.pldTO_client

	SET @xml_data = (SELECT [client].* FROM #tmpXML AS [client] FOR XML AUTO, ROOT ('reportPLD_Relevantes'), ELEMENTS)

	SELECT @xml_data AS [returnXML]
END


