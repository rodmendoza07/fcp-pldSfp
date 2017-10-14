USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[getAllPersonPLD]    Script Date: 24/04/2017 10:51:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getAllPersonPLD](
	@tipo int = 0
	, @fecha_limite_ini datetime
	, @fecha_limite_fin datetime
)
AS
BEGIN
	DECLARE
		@xml_data XML

	SELECT 
		per.id_persona
		, per.curp
		, per.rfc
		, per.sexo
		, lista
		, CASE 
			WHEN estatus = '' THEN '-'
			ELSE estatus
			END AS estatus
		, CASE 
			WHEN entidad = '' THEN '-'
			ELSE entidad
			END AS entidad
		, pros.id_cte_isi
		, pros.id_prospecto
		, CONVERT(varchar, fecha_aviso, 112) AS [fecha]
		, UPPER(RTRIM(LTRIM(per.nombre)) + ' ' + RTRIM(LTRIM(per.paterno)) + ' ' + RTRIM(LTRIM(per.materno))) AS nombrecomp
		, det.estatus_bloqueo
		, pros.id_cte_isi
	FROM LEAP.dbo.tp_personaBloqueada per 
		INNER JOIN LEAP.dbo.td_PLD_detalle det ON (per.id_persona = det.id_persona)
		INNER JOIN LEAP.dbo.tp_prospecto pros ON (per.id_prospecto = pros.id_prospecto)
		INNER JOIN ISILOANSWEB.dbo.T_CTE b ON (pros.id_cte_isi = b.ACREDITADO)
		INNER JOIN LEAP.dbo.tc_listaPLD list ON (per.lista = list.siglas)
	WHERE CONVERT(varchar, fecha_aviso, 112) BETWEEN @fecha_limite_ini AND @fecha_limite_fin
		AND ((list.tipo = @tipo AND @tipo <> 1 AND det.estatus_bloqueo = 1) OR (@tipo = 1 AND det.estatus_bloqueo = 1 AND list.tipo = @tipo))
	GROUP BY per.id_persona, per.curp, per.rfc, per.sexo, per.lista, per.estatus, per.entidad, CONVERT(varchar, fecha_aviso, 112), per.nombrecomp, det.fecha_validado, per.nombre, per.paterno, per.materno, pros.id_cte_isi, det.estatus_bloqueo, pros.id_prospecto
	ORDER BY CONVERT(varchar, fecha_aviso, 112) DESC, fecha_validado DESC

	SELECT 
		per.id_persona AS [personID]
		, per.id_prospecto AS [prospectID]
		, pros.id_cte_isi AS [clientID]
		, per.curp AS [curp]
		, per.rfc AS [rfc]
		, per.sexo AS [sex]
		, lista AS [list]
		, estatus AS [status]
		, entidad AS [entity]
		, CONVERT(varchar, fecha_aviso, 112) AS [report]
		, UPPER(RTRIM(LTRIM(per.nombre)) + ' ' + RTRIM(LTRIM(per.paterno)) + ' ' + RTRIM(LTRIM(per.materno))) AS nombrecomp
		--, RTRIM(LTRIM(b.TITULAR)) AS [client]
		, fecha_validado AS [dateValidate]
		, RTRIM(LTRIM(b.DIRECCION)) AS [street]
		, RTRIM(LTRIM(b.COLONIA)) AS [colony]
		, RTRIM(LTRIM(b.CIUDAD)) AS [city]
		,CASE 
			WHEN b.TIP_IDEN_CTE = 1 THEN 'IFE'
			WHEN b.TIP_IDEN_CTE = 2 THEN 'CARTILLA'
			WHEN b.TIP_IDEN_CTE = 3 THEN 'PASAPORTE'
			WHEN b.TIP_IDEN_CTE = 4 THEN 'CEDULA PROFESIONAL'
			WHEN b.TIP_IDEN_CTE = 5 THEN 'OTRA' END AS [Tipo ID]
		, RTRIM(LTRIM(b.PASAPORTE)) AS [Número ID]
		, RTRIM(LTRIM(b.TELEF)) AS [Teléfono]
		, RTRIM(LTRIM(b.FEC_NACIMIENTO)) AS [Fecha Nacimiento]
	INTO #tmpXLM
	FROM LEAP.dbo.tp_personaBloqueada per 
		INNER JOIN LEAP.dbo.td_PLD_detalle det ON (per.id_persona = det.id_persona)
		INNER JOIN LEAP.dbo.tp_prospecto pros ON (per.id_prospecto = pros.id_prospecto)
		INNER JOIN ISILOANSWEB.dbo.T_CTE b ON (pros.id_cte_isi = b.ACREDITADO)
		INNER JOIN LEAP.dbo.tc_listaPLD list ON (per.lista = list.siglas)
	WHERE CONVERT(varchar, fecha_aviso, 112) BETWEEN @fecha_limite_ini AND @fecha_limite_fin
		AND ((list.tipo = @tipo AND @tipo <> 1) OR (@tipo = 1 AND det.estatus_bloqueo = 1 AND list.tipo = @tipo))
	GROUP BY per.id_persona, per.curp, per.rfc, per.sexo, per.lista, per.estatus, per.entidad, CONVERT(varchar, fecha_aviso, 112), per.nombrecomp, det.fecha_validado, pros.id_prospecto, per.id_prospecto, pros.id_cte_isi
		, b.DIRECCION, b.TIP_IDEN_CTE, b.COLONIA, b.CIUDAD, b.PASAPORTE, b.TELEF, b.FEC_NACIMIENTO, b.TITULAR, per.nombre, per.paterno, per.materno
	ORDER BY CONVERT(varchar, fecha_aviso, 112) DESC, fecha_validado DESC

	--2 PE
	--1 PB
	--3 PR

	IF @tipo = 1
		SET @xml_data = (SELECT * FROM #tmpXLM AS [client] FOR XML AUTO, ROOT ('reportPLD_PB'), ELEMENTS)

	IF @tipo  = 2
		SET @xml_data = (SELECT * FROM #tmpXLM AS [client] FOR XML AUTO, ROOT ('reportPLD_PE'), ELEMENTS)
		
	IF @tipo = 3
		SET @xml_data = (SELECT * FROM #tmpXLM AS [client] FOR XML AUTO, ROOT ('reportPLD_PR'), ELEMENTS)
		
	SELECT @xml_data AS [returnXML]
END