USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[getAllPersonPLD]    Script Date: 14/12/2017 04:51:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_inquery]
AS
BEGIN
     ; WITH cte AS(
	    SELECT DISTINCT
		    per.id_persona
		    , pros.curp
		    , pros.rfc
		    , pros.sexo
		    , per.lista
		    , per.estatus
		    , per.entidad
		    , CONVERT(varchar, fecha_aviso, 112) AS [fecha]
		    , UPPER(RTRIM(LTRIM(pros.nombre)) + ' ' + RTRIM(LTRIM(pros.paterno)) + ' ' + RTRIM(LTRIM(pros.materno))) AS nombrecomp
		    , UPPER(RTRIM(LTRIM(per.nombre)) + ' ' + RTRIM(LTRIM(per.paterno)) + ' ' + RTRIM(LTRIM(per.materno))) AS nombrecomps
		    , det.fecha_validado
		    , pros.id_cte_isi
		    , ROW_NUMBER() OVER(PARTITION BY per.id_persona ORDER BY per.id_persona) AS [Counter]
		    , per.id_prospecto
		    , det.estatus_bloqueo
		    , list.tipo
	    FROM LEAP.dbo.tp_personaBloqueada per 
		    INNER JOIN LEAP.dbo.td_PLD_detalle det ON (per.id_persona = det.id_persona)
		    INNER JOIN LEAP.dbo.tp_prospecto pros ON (per.id_prospecto = pros.id_prospecto)
		    INNER JOIN ISILOANSWEB.dbo.T_CTE b ON (pros.id_cte_isi = b.ACREDITADO)
		    INNER JOIN LEAP.dbo.tc_listaPLD list ON (per.lista = list.siglas)
	    GROUP BY per.id_persona, pros.curp, pros.rfc, pros.sexo, per.lista, per.estatus, per.entidad, CONVERT(varchar, fecha_aviso, 112), per.nombrecomp, det.fecha_validado, b.TITULAR, pros.nombre, pros.paterno, pros.materno,per.nombre, per.paterno, per.materno, id_cte_isi, per.id_prospecto, estatus_bloqueo, list.tipo
     )
	SELECT
	   *
	FROM cte
	WHERE [Counter] = 1
	ORDER BY [fecha] DESC, fecha_validado DESC
END