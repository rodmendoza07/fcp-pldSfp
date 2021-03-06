USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPldLiqAnt]    Script Date: 24/04/2017 07:30:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_getPldLiqAnt] (
	@dateBegin varchar(8) = ''
	, @dateEnd varchar(8) = ''
)
AS
BEGIN
	DECLARE
		@xml_data XML
	SELECT
		pldLA_id AS [ID]
		, pldLA_credit AS [Crédito]
		, pldLA_client AS [Cliente]
		, pldLA_fechaLiq AS [Fecha Liquidación]
		, pldLA_Nombre AS [Nombre]
		, pldLA_Domicilio AS [Domicilio]
		, pldLA_Colonia AS [Colonia]
		, pldLA_Ciudad AS [Ciudad]
		, pldLA_Tipo_ID AS [Tipo ID]
		, pldLA_Numero_ID AS [Número ID]
		, pldLA_Telefono AS [Teléfono]
		, pldLA_FechaNac AS [Fecha Naciemiento]
		, pldLA_Transaccion AS [Días]
		, pldLA_FecOper AS [Fecha Operación]
		, pldLA_Importe AS [Importe]
	FROM LEAP.dbo.tp_PldLiqAnticipada
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND pldLA_fechaLiq = CONVERT(varchar, GETDATE(), 112)) OR (pldLA_fechaLiq BETWEEN @dateBegin AND @dateEnd))

	SELECT
		pldLA_id AS [rowID]
		, pldLA_credit AS [credit]
		, pldLA_client AS [clientID]
		, pldLA_fechaLiq AS [dateSettlement]
		, RTRIM(LTRIM(REPLACE(pldLA_Nombre, '*', ''))) AS [client]
		, RTRIM(LTRIM(pldLA_Domicilio)) AS [street]
		, RTRIM(LTRIM(pldLA_Colonia)) AS [colony]
		, RTRIM(LTRIM(pldLA_Ciudad)) AS [city]
		, RTRIM(LTRIM(pldLA_Tipo_ID)) AS [typeID]
		, RTRIM(LTRIM(pldLA_Numero_ID)) AS [numberID]
		, RTRIM(LTRIM(pldLA_Telefono)) AS [phone]
		, RTRIM(LTRIM(pldLA_FechaNac)) AS [dateBirth]
		, pldLA_Transaccion AS [days]
		, pldLA_FecOper AS [dateOper]
		, pldLA_Importe AS [amount]
	INTO #tmpXML
	FROM LEAP.dbo.tp_PldLiqAnticipada
	WHERE ((@dateBegin = '' AND @dateEnd = '' AND pldLA_fechaLiq = CONVERT(varchar, GETDATE(), 112)) OR (pldLA_fechaLiq BETWEEN @dateBegin AND @dateEnd))

	SET @xml_data = (SELECT  * FROM #tmpXML AS [client] FOR XML AUTO, ROOT ('reportPLD_LiqAnt'), ELEMENTS)

	SELECT @xml_data AS [returnXML]
END