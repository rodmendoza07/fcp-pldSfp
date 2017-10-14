USE [LEAP]
GO

/****** Object:  UserDefinedTableType [dbo].[udt_personPLD]    Script Date: 03/05/2017 05:20:09 p. m. ******/
CREATE TYPE [dbo].[udt_personPLD] AS TABLE(
	[id_persona] [varchar](200) NULL,
	[peso1] [varchar](5) NULL,
	[peso2] [varchar](5) NULL,
	[nombre] [varchar](100) NULL,
	[paterno] [varchar](200) NULL,
	[materno] [varchar](200) NULL,
	[curp] [varchar](20) NULL,
	[rfc] [varchar](20) NULL,
	[fecha_nacimiento] [varchar](20) NULL,
	[sexo] [varchar](15) NULL,--10
	[lista] [varchar](30) NULL,
	[estatus] [varchar](50) NULL,
	[dependencia] [varchar](200) NULL,
	[puesto] [varchar](200) NULL,
	[area] [varchar](200) NULL,
	[iddispo] [varchar](100) NULL,
	[idrel] [varchar](100) NULL,
	[parentesco] [varchar](100) NULL,
	[razonsoc] [varchar](100) NULL,
	[rfcmoral] [varchar](50) NULL,--20
	[issste] [varchar](100) NULL,
	[imss] [varchar](100) NULL,--22
	[ingresos] [varchar](100) NULL,
	[nombrecomp] [varchar](200) NULL,
	[apellidos] [varchar](200) NULL,
	[entidad] [varchar](200) NULL,
	[curp_ok] [varchar](5) NULL,
	[periodo] [varchar](20) NULL,
	[expediente] [varchar](100) NULL,
	[fecha_resolucion] [varchar](100) NULL,--30
	[causa_irregularidad] [varchar](100) NULL,
	[sancion] [varchar](100) NULL,
	[fecha_cargo_ini] [varchar](100) NULL,
	[fecha_cargo_fin] [varchar](100) NULL,
	[duracion] [varchar](200) NULL,
	[monto] [varchar](100) NULL,
	[autoridad_sanc] [varchar](200) NULL,--37
	[admon_local] [varchar](200) NULL,
	[numord] [varchar](50) NULL,
	[rubro] [varchar](100) NULL,--40
	[central_obrera] [varchar](200) NULL,
	[numsocios] [varchar](10) NULL,
	[fecha_vigencia] [varchar](100) NULL,
	[titulo] [varchar](100) NULL,
	[domicilio_a] [varchar](200) NULL,
	[domicilio_b] [varchar](200) NULL,
	[colonia] [varchar](100) NULL,
	[cp] [varchar](20) NULL,
	[ciudad] [varchar](200) NULL,
	[lada] [varchar](20) NULL,--50
	[telefono] [varchar](100) NULL,
	[fax] [varchar](100) NULL,
	[email] [varchar](200) NULL,
	[pais] [varchar](200) NULL,
	[gafi] [varchar](200) NULL,
	[id_prospecto] [int] NULL
)
GO


