USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_getProfileTrans]    Script Date: 24/04/2017 07:15:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_getProfileTrans](
	@dateBegin varchar(8) = ''
	, @dateEnd varchar(8) = ''
)
AS
BEGIN
	DECLARE
		@xml_data XML

	SELECT 
		a.pldt_id AS [ID]
		, a.pldt_client AS [Cliente ID]
		, a.pldt_headLine AS [Cliente]
		, a.pldt_credit AS [Crédito]
		, CAST(a.pldt_lastPay AS int) AS [Último Pago]
		, a.pldt_nPagos0 AS [No. Pagos/Trans. Mensual]
		, a.pldt_mPagos0 AS [Monto Pagos/Monto Mensual]
		, a.pldt_nextPay AS [Próximo Pago]
		, a.pldt_nPagos1 AS [No. Pagos/Trans. Periodo]
		, a.pldt_mPagos1 AS [Monto Pagos/Monto Periodo]
		, a.pldt_ratioIn AS [ratioIn]
		, a.pldt_breakProfile AS [Rompe Esquema]			
		, CONVERT(varchar, pldt_dateCreate, 112) AS [Reporte]
		, CASE 
			WHEN a.pldt_typeProfileTrans = 0 THEN 'PTH' 
			ELSE 'PTI' END AS [Tipo]
	FROM LEAP.dbo.tp_pldTrans a
		LEFT JOIN ISILOANSWEB.dbo.T_CTE b ON (a.pldt_client = b.ACREDITADO)
	WHERE 1 = 1
		AND ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, pldt_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) OR (CONVERT(varchar, pldt_dateCreate, 112) BETWEEN REPLACE(@dateBegin, '/', '') AND REPLACE(@dateEnd, '/', '')))
	ORDER BY 13, pldt_ratioIn DESC
			
	SELECT 
		client.pldt_id AS [rowID]
		, client.pldt_client AS [clientID]
		--, RTRIM(LTRIM(REPLACE(client.pldt_headLine, '*', ''))) AS [client]
		, RTRIM(LTRIM(REPLACE(b.TITULAR, '*', ''))) AS [client]
		, client.pldt_credit AS [credit]
		, CAST(client.pldt_lastPay AS int) AS [lastPay]
		, client.pldt_nPagos0 AS [npays_tranM]
		, client.pldt_mPagos0 AS [mpays_amountM]
		, client.pldt_nextPay AS [nextPay]
		, client.pldt_nPagos1 AS [nPays1_tranReport]
		, client.pldt_mPagos1 AS [mPays1_amountReport]
		, CAST(client.pldt_ratioIn AS decimal(10,4)) AS [ratioIn]
		, client.pldt_breakProfile AS [breakSchema]
		, CONVERT(varchar, client.pldt_dateCreate, 112) AS [report]
		, CASE 
			WHEN client.pldt_typeProfileTrans = 0 THEN 'PTH' 
			ELSE 'PTI' END AS [typeReport]
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
	FROM LEAP.dbo.tp_pldTrans AS [client]
		LEFT JOIN ISILOANSWEB.dbo.T_CTE b ON (client.pldt_client = b.ACREDITADO)
	WHERE 1 = 1
		AND ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, pldt_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) 
			OR (CONVERT(varchar, pldt_dateCreate, 112) BETWEEN REPLACE(@dateBegin, '/', '') AND REPLACE(@dateEnd, '/', '')))
	ORDER BY 13, pldt_ratioIn DESC

	SET @xml_data = (SELECT [client].* FROM #tmpXML AS [client] FOR XML AUTO, ROOT ('reportPLD_Trans'), ELEMENTS)

	SELECT @xml_data AS [returnXML]
END

