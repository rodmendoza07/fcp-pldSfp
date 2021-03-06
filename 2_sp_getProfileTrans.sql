USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_getProfileTrans]    Script Date: 20/12/2017 11:10:01 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_getProfileTrans](
	@periodNumber int = 0
)
AS
BEGIN
	DECLARE
		@xml_data XML
		, @reportedYear int = LEFT(CONVERT(varchar, GETDATE(), 112), 4)
		, @dateBegin varchar(6) = ''
		, @dateEnd varchar(6) = ''
		, @today varchar(6) = LEFT(CONVERT(varchar, GETDATE(), 112), 6)
		
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
		a.pldt_id AS [ID]
		, a.pldt_client AS [Cliente_ID]
		, UPPER(REPLACE(a.pldt_headLine, '*', ' ')) AS [Cliente]
		, a.pldt_credit AS [Credito]
		, CAST(a.pldt_lastPay AS int) AS [Ultimo_Pago]
		, a.pldt_nPagos0 AS [No_Pagos_Trans_Mensual]
		, a.pldt_mPagos0 AS [Monto_Pagos_Monto_Mensual]
		, a.pldt_nextPay AS [Proximo_Pago]
		, a.pldt_nPagos1 AS [No_Pagos_Trans_Periodo]
		, a.pldt_mPagos1 AS [Monto_Pagos_Monto_Periodo]
		, a.pldt_ratioIn AS [ratioIn]
		, a.pldt_breakProfile AS [Rompe_Esquema]			
		, CONVERT(varchar, pldt_dateCreate, 112) AS [Reporte]
		, CASE 
			WHEN a.pldt_typeProfileTrans = 0 THEN 'PTH' 
			ELSE 'PTI' END AS [Tipo]
	FROM LEAP.dbo.tp_pldTrans a
		LEFT JOIN ISILOANSWEB.dbo.T_CTE b ON (a.pldt_client = b.ACREDITADO)
	WHERE 1 = 1
		AND ((@dateBegin = '' AND @dateEnd = '' AND CONVERT(varchar, pldt_dateCreate, 112) = CONVERT(varchar, GETDATE(), 112)) 
			 OR (LEFT(CONVERT(varchar, pldt_dateCreate, 112), 6) BETWEEN @dateBegin AND @dateEnd))
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
			 OR (LEFT(CONVERT(varchar, pldt_dateCreate, 112), 6) BETWEEN @dateBegin AND @dateEnd))
	ORDER BY 13, pldt_ratioIn DESC

	SET @xml_data = (SELECT [client].* FROM #tmpXML AS [client] FOR XML AUTO, ROOT ('reportPLD_Trans'), ELEMENTS)

	SELECT @xml_data AS [returnXML]
END