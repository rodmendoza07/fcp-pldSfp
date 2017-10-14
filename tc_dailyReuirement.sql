USE [LEAP]
GO

/****** Object:  Table [dbo].[tp_personabloqueada]    Script Date: 06/04/2017 01:16:36 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tc_dailyRequirement](
	[id_personabloqueda] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [varchar](200) NULL,
	[peso1] [varchar](5) NULL,
	[peso2] [varchar](5) NULL,
	[nombre] [varchar](100) NULL,
	[paterno] [varchar](200) NULL,
	[materno] [varchar](200) NULL,
	[curp] [varchar](20) NULL,
	[rfc] [varchar](20) NULL,
	[fecha_nacimiento] [varchar](20) NULL,
	[sexo] [varchar](15) NULL,
	[lista] [varchar](30) NULL,
	[estatus] [varchar](50) NULL,
	[dependencia] [varchar](200) NULL,
	[puesto] [varchar](200) NULL,
	[area] [varchar](200) NULL,
	[iddispo] [varchar](100) NULL,
	[idrel] [varchar](100) NULL,
	[parentesco] [varchar](100) NULL,
	[razonsoc] [varchar](100) NULL,
	[rfcmoral] [varchar](50) NULL,
	[issste] [varchar](100) NULL,
	[imss] [varchar](100) NULL,
	[ingresos] [varchar](100) NULL,
	[nombrecomp] [varchar](200) NULL,
	[apellidos] [varchar](200) NULL,
	[entidad] [varchar](200) NULL,
	[curp_ok] [varchar](5) NULL,
	[periodo] [varchar](20) NULL,
	[expediente] [varchar](100) NULL,
	[fecha_resolucion] [varchar](100) NULL,
	[causa_irregularidad] [varchar](100) NULL,
	[sancion] [varchar](100) NULL,
	[fecha_cargo_ini] [varchar](100) NULL,
	[fecha_cargo_fin] [varchar](100) NULL,
	[duracion] [varchar](200) NULL,
	[monto] [varchar](100) NULL,
	[autoridad_sanc] [varchar](200) NULL,
	[admon_local] [varchar](200) NULL,
	[numord] [varchar](50) NULL,
	[rubro] [varchar](100) NULL,
	[central_obrera] [varchar](200) NULL,
	[numsocios] [varchar](10) NULL,
	[fecha_vigencia] [varchar](100) NULL,
	[titulo] [varchar](100) NULL,
	[domicilio_a] [varchar](200) NULL,
	[domicilio_b] [varchar](200) NULL,
	[colonia] [varchar](100) NULL,
	[cp] [varchar](20) NULL,
	[ciudad] [varchar](200) NULL,
	[lada] [varchar](20) NULL,
	[telefono] [varchar](100) NULL,
	[fax] [varchar](100) NULL,
	[email] [varchar](200) NULL,
	[pais] [varchar](200) NULL,
	[gafi] [varchar](200) NULL,
	dr_registerDate DATETIME NOT NULL,
	dr_fileDate DATETIME NOT NULL,
	dr_oficioNumber VARCHAR(50) NOT NULL,
	dr_fileNumber VARCHAR(50) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[id_personabloqueda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_id_personadailyRequirement] UNIQUE NONCLUSTERED 
(
	[id_personabloqueda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE dbo.tc_dailyRequirement ADD CONSTRAINT c_tc_dr_registerDate DEFAULT (GETDATE()) FOR dr_registerDate