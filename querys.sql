/*
select *
from LEAP.dbo.td_PLD_detalle
where usu_oficial_cumplimiento = 'RICAPG'

SELECT *
FROM LEAP.dbo.tp_personabloqueada

select *
from LEAP.dbo.tc_dailyRequirement
order by id_personabloqueda desc

select *
from CATALOGOS.dbo.tc_empleados
where nombre like 'marco%'

select
	d.descripcion
	, 
from CATALOGOS.dbo.tc_empleados e
	inner join CATALOGOS.dbo.tc_departamento d on (e.cve_depto = d.id_departamento)
where nombre like '%ricardo%'


INSERT INTO CATALOGOS.dbo.tc_menus (tcmenu_id_ap, tcmenu_descrip, tcmenu_parent, tcmenu_url, tcmenu_estatus, tcmenu_order, tcmenu_class)
VALUES (22, 'Cobranza', 0, '#', 1, 1, '{ active: view.page == "/collection/management" || view.page == "/collection/management/client/" + view.urlClient + "/credit/" + view.urlCredit || view.page == "/collection/report" }', 'fa fa-dollar')

INSERT INTO CATALOGOS.dbo.tc_menus (tcmenu_id_ap, tcmenu_descrip, tcmenu_parent, tcmenu_url, tcmenu_estatus, tcmenu_order, tcmenu_class)
VALUES (22, 'Gestión', 229, '#/collection/management', 1, 2, '{ active: view.page == "/collection/management" || view.page == "/collection/management/client/" + view.urlClient + "/credit/" + view.urlCredit }')

select *
from CATALOGOS.dbo.tc_menus

update CATALOGOS.dbo.tc_menus set
	tcmenu_descrip = 'Prev. Lavado de Dinero'
	, tcmenu_class = '{active:view.page == "/pld/dailyRequirement" || view.page == "/pld/moneyLaunderingConfig" || view.page == "/pld/inquiries" || view.page == "/pld/quienesquien"}'
	, tcmenu_icon = 'fa fa-shield'
where tcmenu_id = 232

update CATALOGOS.dbo.tc_menus set
	tcmenu_descrip = 'Consultas'
	, tcmenu_url = '#/pld/inquiries'
	, tcmenu_class = '{active:view.page == "/pld/inquiries"}'
	, tcmenu_order = 2
where tcmenu_id = 233

insert into CATALOGOS.dbo.tc_menus
	(tcmenu_id_ap
	, tcmenu_descrip
	, tcmenu_parent
	, tcmenu_url
	, tcmenu_order
	, tcmenu_class)
VALUES (
	22
	, 'Consulta Quién es Quién'
	, 232
	, '#/pld/quienesquien'
	, 3
	, '{active:view.page == "/pld/quienesquien"}'),
	(22
	, 'Autoridades'
	, 232
	, '#/pld/moneyLaunderingConfig'
	, 4
	, '{active:view.page == "/pld/moneyLaunderingConfig"}'),
	(22
	, 'Requerimientos del día'
	, 232
	, '#/pld/dailyRequirement'
	, 5
	, '{active:view.page == "/pld/dailyRequirement"}')

SELECT COTIT1, COTIT2, *
FROM ISILOANSWEB.dbo.T_CTE


select * from CATALOGOS.dbo.tc_empleados

 update CATALOGOS.dbo.te_users_passw_encrypt set
	peusr_passw_encrypt = 'e054a7bd8e9905906b4fe8b98d0022a4'
	, peusr_passw_encrypt_lock = 0
	, peusr_passw_encrypt_reset = 0
where peusr_user_id =13

select * from CATALOGOS.dbo.te_users_passw_encrypt
where peusr_user_id = 13

SELECT *
FROM LEAP.dbo.tp_prospecto

select *
from LEAP.dbo.tc_estado

SELECT *
FROM LEAP.dbo.tc_profesion

SELECT *
FROM ISILOANSWEB.dbo.T_CRED

exec LEAP.dbo.sp_dailyRegister @option = 1, @name = 'LILIANA', @firstName = 'cARLOS'
SELECT OCUPACION, *
FROM ISILOANSWEB.dbo.T_CTE
where BEN_NOMBRE like '%alejandro%'
	and BEN_PATERNO like '%fernandez%'

select *
from ISILOANSWEB.dbo.T_CRED
where CLIENTE in (473
, 482
, 491
, 500
, 509
, 518
, 527
, 536)

select *
from LEAP.dbo.tp_prospecto
where nombre like '%Alejandro%'
	and paterno like '%FERNAN%'

SELECT *
FROM CATALOGOS.dbo.tc_departamento

DECLARE
	@name varchar(50) = '%ale%'
	, @firstname varchar(50) = '%fer%'

	SELECT 
				p.id_cte_isi
				, REPLICATE('0',5 - LEN(suc.id_departamento)) + CAST(suc.id_departamento AS varchar) + ' ' + suc.descripcion AS branchOffice
				, CAST(c.F_CTEDESDE as varchar) AS dateCreationClient
				, p.nombre + ' ' + p.paterno + ' ' + p.materno AS clientName
				, p.calle + ' ' + p.numero + ' ' + p.numero_int + ' ' + p.colonia + ' ' + p.municipiodelegacion + ' ' + e.nombre + ' ' + p.codigopostal AS [address]
				, p.RFC
				, p.CURP
				, c.TELEF AS localphone
				, c.TELEF_2 AS mobilephone
				, c.E_MAIL AS email
				, pr.label AS ocupation
				, ISNULL(cred.NUMERO, '-') AS creditNumber
				, ISNULL(cred.IMP_CRED, 0) AS amount
				, ISNULL(cred.FECH_ALTA, 0) AS creationDate
				, c.COTIT1 AS cotitular
				, cred.NOM_BENEF As benefit
			FROM LEAP.dbo.tp_prospecto p
				INNER JOIN ISILOANSWEB.dbo.T_CTE c ON (p.id_cte_isi = c.ACREDITADO)
				INNER JOIN CATALOGOS.dbo.tc_estado e ON (p.estado = e.id_estado AND e.id_pais = 157)
				INNER JOIN CATALOGOS.dbo.tc_departamento suc ON (p.id_sucursal = suc.id_departamento)
				INNER JOIN LEAP.dbo.tc_profesion pr ON (c.OCUPACION = pr.id_profesion)
				LEFT OUTER JOIN ISILOANSWEB.dbo.T_CRED cred ON (cred.CLIENTE = c.ACREDITADO)
			WHERE p.nombre LIKE '%' + @name + '%'
				AND p.materno LIKE '%' + @firstName + '%'

SELECT * FROM LEAP.dbo.tp_personabloqueada

exec CATALOGOS.dbo.getInfoUser 'RICAPG', 'Porvenir#244'
*/

ALTER TABLE LEAP.dbo.tc_tipo_lista_pld
ADD label VARCHAR(30)

ALTER TABLE LEAP.dbo.tc_tipo_lista_pld
ADD CONSTRAINT def_label DEFAULT('') FOR label