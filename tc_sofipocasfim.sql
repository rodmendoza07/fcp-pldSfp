USE LEAP 
GO 

CREATE TABLE tc_sofipocasfim(
	sfpcasfim_id INT NOT NULL IDENTITY(1,1)
	, sfpcasfim_key VARCHAR(10) NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_key DEFAULT ('')
	, sfpcasfim_name VARCHAR(250) NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_name DEFAULT ('')
	, sfpcasfim_shortname VARCHAR(30) NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_shortname DEFAULT ('')
	, sfpcasfim_opstatus VARCHAR(50) NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_opstatus DEFAULT ('')
	, sfpcasfim_update VARCHAR(30) NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_update DEFAULT ('')
	, sfpcasfim_status INT NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_status DEFAULT (1)
	, sfpcasfim_regdate DATETIME NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_regdate DEFAULT (GETDATE())
	, sfpcasfim_moddate DATETIME NOT NULL CONSTRAINT c_tc_sofipocasfim_sfpcasfim_moddate DEFAULT ('')
)
INSERT INTO tc_sofipocasfim (
	sfpcasfim_key
	, sfpcasfim_name
	, sfpcasfim_shortname
	, sfpcasfim_opstatus
	, sfpcasfim_update
) VALUES 
	('27-020','Multiplica México, S.A. de C.V., S.F.P.','MULTIPLICA MEXICO','En Operación','03/04/2013')
	, ('27-021','La Perseverancia del Valle de Tehuacán, S.A. de C.V., S.F.P.','PERSEVERANCIA','En Operación','03/04/2013')
	, ('27-022','Operadora de Recursos Reforma, S.A. de C.V., S.F.P.','REFORMA','En Operación','03/04/2013')
	, ('27-023','Financiera Planfía, S.A. de C.V., S.F.P.','PLANFIA','En Operación','03/04/2013')
	, ('27-024','Caja de la Sierra Gorda, S.A. de C.V., S.F.P.','SIERRA GORDA','En Operación','03/04/2013')
	, ('27-025','Financiera del Sector Social, S.A. de C.V., S.F.P.','SECTOR SOCIAL','En Operación','03/04/2013')
	, ('27-026','Administradora de Caja Bienestar, S.A. de C.V., S.F.P.','CAJA BIENESTAR','En Operación','03/04/2013')
	, ('27-027','Ficrea, S. A. de C.V., S.F.P.','FICREA','Revocada','07/01/2015')
	, ('27-028','Acción y Evolución, S.A. de C.V., S.F.P.','ACCIÓN Y EVOLUCIÓN','En Operación','03/04/2013')
	, ('27-029','Opciones Empresariales del Noreste, S.A. de C.V., S.F.P.','OPCIONES EMPRESARIALES','En Operación','03/04/2013')
	, ('27-030','Financiera Sofitab, S.A de C.V., .S.F.P.','SOFITAB','En Operación','03/04/2013')
	, ('27-031','Caja Progressa, S.A. de C.V., S.F.P.','PROGRESSA','En Operación','03/04/2013')
	, ('27-032','Mascaja, S.A. de C.V., S.F.P.','MASCAJA','En Operación','03/04/2013')
	, ('27-033','Libertad Servicios Financieros, S.A. de C.V., S.F.P.','LIBERTAD','En Operación','03/04/2013')
	, ('27-034','Capital Activo, S.A. de C.V., S.F.P.','CAPITAL ACTIVO','En Operación','03/04/2013')
	, ('27-035','J.P. SOFIEXPRESS, S.A. de C.V., S.F.P.','SOFIEXPRESS','En Operación','03/04/2013')
	, ('27-036','Apoyo Múltiple, S.A. de C.V., S.F.P','APOYO MULTIPLE','En Operación','03/04/2013')
	, ('27-037','Financiera T. Agiliza, S.A. de C.V., S.F.P.','T AGILIZA','En Operación','03/04/2013')
	, ('27-038','Consejo de Asistencia al Micro Emprendedor, S.A. de C.V., S.F.P.','CAME','En Operación','20/03/2015')
	, ('27-039','Sociedad Financiera Agropecuaria de Ahorro y Crédito Rural, S.A. de C.V., S.F.P.','SOFAGRO SOFIPO','Revocada','23/05/2016')
	, ('27-040','Impulso para el Desarrollo de México, S.A. de C.V., S.F.P.','IMPULSO','En Operación','03/04/2013')
	, ('27-041','Devida Hipotecaria, S.A. de C.V., S.F.P.','DEVIDA','En Operación','08/07/2013')
	, ('27-042','Paso Seguro Creando Futuro, S.A. de C.V., S.F.P.','PASO SEGURO','En Operación','03/04/2013')
	, ('27-043','Capital de Inversión Oportuno en México, S.A. de C.V., S.F.P.','OPORMEX','Fusionada','23/05/2016')
	, ('27-044','Financiera Súmate, S.A. de C.V., S.F.P.','SÚMATE','En Operación','08/07/2013')
	, ('27-045','KU-BO Financiero, S.A. de C.V., S.F.P.','KU-BO','En Operación','03/12/2013')
	, ('27-046','Financiera Sustentable de México, S.A. de C.V., S.F.P.','F SUSTENTABLE','En Operación','01/09/2014')
	, ('27-047','Crediclub, S.A. de C.V., S.F.P.','CREDICLUB','En Operación','09/11/2015')
	, ('27-048','Comercializadora Financiera de Automotores, S.A. de C.V., S.F.P.','F AUTOMOTORES','En Operación','22/01/2016')
	, ('27-049','SFP Porvenir, S.A. de C.V.','SFP PORVENIR','En Operación','08/03/2017')