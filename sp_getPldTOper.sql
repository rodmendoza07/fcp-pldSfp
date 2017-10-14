USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPldTOper]    Script Date: 24/04/2017 05:31:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_getPldTOper](
	@dateBegin varchar(8) = ''
	, @dateEnd varchar(8) = ''
)
AS
BEGIN
	DECLARE
		@xml_data XML

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
			WHEN b.TIP_IDEN_CTE = 5 THEN 'OTRA' END AS [Tipo ID]
		, b.PASAPORTE AS [Número ID]
		, b.TELEF AS [Teléfono]
		, b.FEC_NACIMIENTO AS [Fecha Nacimiento]
	FROM LEAP.dbo.tp_pldTOper a
		INNER JOIN ISILOANSWEB.dbo.T_CTE b WITH(NOLOCK) ON (a.pldTO_client = b.ACREDITADO)
		INNER JOIN CATALOGOS.dbo.tc_departamento c WITH(NOLOCK) ON (b.SUCURSAL = c.id_departamento)
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, a.pldTO_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) OR (CONVERT(varchar, a.pldTO_dateCreate, 112) BETWEEN REPLACE(@dateBegin, '/', '') AND REPLACE(@dateEnd, '/', '')))
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
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, a.pldTO_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) OR (CONVERT(varchar, a.pldTO_dateCreate, 112) BETWEEN REPLACE(@dateBegin, '/', '') AND REPLACE(@dateEnd, '/', '')))
	ORDER BY a.pldTO_dateCreate, b.SUCURSAL, a.pldTO_client

	SET @xml_data = (SELECT [client].* FROM #tmpXML AS [client] FOR XML AUTO, ROOT ('reportPLD_Relevantes'), ELEMENTS)

	SELECT @xml_data AS [returnXML]
END


