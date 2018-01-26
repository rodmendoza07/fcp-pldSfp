USE [LEAP]
GO

/****** Object:  Table [dbo].[tc_listaPLD]    Script Date: 19/04/2017 04:20:08 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.tc_listaPLD') IS NOT NULL 
  DROP TABLE dbo.tc_listaPLD; 


CREATE TABLE [dbo].[tc_listaPLD](
	[id_listaPLD] [int] IDENTITY(1,1) NOT NULL,
	[siglas] [varchar](10) NULL,
	[nombre] [varchar](300) NULL,
	[alerta] [int] NULL,
	[tipo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_listaPLD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_id_listaPLD] UNIQUE NONCLUSTERED 
(
	[id_listaPLD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO LEAP.dbo.tc_listaPLD
	(
		siglas
		, nombre
		, alerta
		, tipo
	)
VALUES 
	('DEA', 'La Administración para el Control de Drogas', 0, 1)
	, ('PPE', 'Persona politica expuesta', 1, 2)
	, ('PGR', 'Procuraduría General de la República', 1, 1)
	, ('PGJ', 'Procuraduría General de Justicia', 1, 1)
	, ('PRE', 'Personas relacionadas con empresa', 1, 3)
	, ('OFAC', 'Office of Foreign Assets Control', 1, 1)