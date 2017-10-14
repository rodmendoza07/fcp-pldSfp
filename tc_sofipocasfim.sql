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
	('27-020','Multiplica M�xico, S.A. de C.V., S.F.P.','MULTIPLICA MEXICO','En Operaci�n','03/04/2013')
	, ('27-021','La Perseverancia del Valle de Tehuac�n, S.A. de C.V., S.F.P.','PERSEVERANCIA','En Operaci�n','03/04/2013')
	, ('27-022','Operadora de Recursos Reforma, S.A. de C.V., S.F.P.','REFORMA','En Operaci�n','03/04/2013')
	, ('27-023','Financiera Planf�a, S.A. de C.V., S.F.P.','PLANFIA','En Operaci�n','03/04/2013')
	, ('27-024','Caja de la Sierra Gorda, S.A. de C.V., S.F.P.','SIERRA GORDA','En Operaci�n','03/04/2013')
	, ('27-025','Financiera del Sector Social, S.A. de C.V., S.F.P.','SECTOR SOCIAL','En Operaci�n','03/04/2013')
	, ('27-026','Administradora de Caja Bienestar, S.A. de C.V., S.F.P.','CAJA BIENESTAR','En Operaci�n','03/04/2013')
	, ('27-027','Ficrea, S. A. de C.V., S.F.P.','FICREA','Revocada','07/01/2015')
	, ('27-028','Acci�n y Evoluci�n, S.A. de C.V., S.F.P.','ACCI�N Y EVOLUCI�N','En Operaci�n','03/04/2013')
	, ('27-029','Opciones Empresariales del Noreste, S.A. de C.V., S.F.P.','OPCIONES EMPRESARIALES','En Operaci�n','03/04/2013')
	, ('27-030','Financiera Sofitab, S.A de C.V., .S.F.P.','SOFITAB','En Operaci�n','03/04/2013')
	, ('27-031','Caja Progressa, S.A. de C.V., S.F.P.','PROGRESSA','En Operaci�n','03/04/2013')
	, ('27-032','Mascaja, S.A. de C.V., S.F.P.','MASCAJA','En Operaci�n','03/04/2013')
	, ('27-033','Libertad Servicios Financieros, S.A. de C.V., S.F.P.','LIBERTAD','En Operaci�n','03/04/2013')
	, ('27-034','Capital Activo, S.A. de C.V., S.F.P.','CAPITAL ACTIVO','En Operaci�n','03/04/2013')
	, ('27-035','J.P. SOFIEXPRESS, S.A. de C.V., S.F.P.','SOFIEXPRESS','En Operaci�n','03/04/2013')
	, ('27-036','Apoyo M�ltiple, S.A. de C.V., S.F.P','APOYO MULTIPLE','En Operaci�n','03/04/2013')
	, ('27-037','Financiera T. Agiliza, S.A. de C.V., S.F.P.','T AGILIZA','En Operaci�n','03/04/2013')
	, ('27-038','Consejo de Asistencia al Micro Emprendedor, S.A. de C.V., S.F.P.','CAME','En Operaci�n','20/03/2015')
	, ('27-039','Sociedad Financiera Agropecuaria de Ahorro y Cr�dito Rural, S.A. de C.V., S.F.P.','SOFAGRO SOFIPO','Revocada','23/05/2016')
	, ('27-040','Impulso para el Desarrollo de M�xico, S.A. de C.V., S.F.P.','IMPULSO','En Operaci�n','03/04/2013')
	, ('27-041','Devida Hipotecaria, S.A. de C.V., S.F.P.','DEVIDA','En Operaci�n','08/07/2013')
	, ('27-042','Paso Seguro Creando Futuro, S.A. de C.V., S.F.P.','PASO SEGURO','En Operaci�n','03/04/2013')
	, ('27-043','Capital de Inversi�n Oportuno en M�xico, S.A. de C.V., S.F.P.','OPORMEX','Fusionada','23/05/2016')
	, ('27-044','Financiera S�mate, S.A. de C.V., S.F.P.','S�MATE','En Operaci�n','08/07/2013')
	, ('27-045','KU-BO Financiero, S.A. de C.V., S.F.P.','KU-BO','En Operaci�n','03/12/2013')
	, ('27-046','Financiera Sustentable de M�xico, S.A. de C.V., S.F.P.','F SUSTENTABLE','En Operaci�n','01/09/2014')
	, ('27-047','Crediclub, S.A. de C.V., S.F.P.','CREDICLUB','En Operaci�n','09/11/2015')
	, ('27-048','Comercializadora Financiera de Automotores, S.A. de C.V., S.F.P.','F AUTOMOTORES','En Operaci�n','22/01/2016')
	, ('27-049','SFP Porvenir, S.A. de C.V.','SFP PORVENIR','En Operaci�n','08/03/2017')