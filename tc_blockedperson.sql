USE [LEAP]
GO

IF OBJECT_ID('[dbo].[tc_blockedperson]') IS NOT NULL 
  DROP TABLE [dbo].[tc_blockedperson]; 

CREATE TABLE [dbo].[tc_blockedperson](
	[blkd_id] [int] IDENTITY(1,1) NOT NULL,
	[blkd_description] [varchar](40) NOT NULL,
	[blkd_estatus] [bit] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tc_blockedperson] ADD  CONSTRAINT [DF_tc_blockedperson_blkd_description]  DEFAULT ('') FOR [blkd_description]
GO

ALTER TABLE [dbo].[tc_blockedperson] ADD  CONSTRAINT [DF_tc_blockedperson_blkd_estatus]  DEFAULT ((1)) FOR [blkd_estatus]
GO