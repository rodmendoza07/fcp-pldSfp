USE [LEAP]
GO
/****** Object:  StoredProcedure [dbo].[sp_setPersonONPLD]    Script Date: 03/05/2017 01:21:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	ALTER procedure [dbo].[sp_setPersonONPLD] ( @udt_personPLD udt_personPLD readonly, 
	@usuario varchar(50),
	@ip_sucursal varchar(50),
	 @sucursal varchar(50),
	 @opt int = 0)
	AS
	declare 
		@IDLast int
		, @id_personaTemp VARCHAR(20) = ''

	BEGIN TRAN 
		BEGIN TRY  
			IF (select count(*) from @udt_personPLD )>0 
			BEGIN 
				insert into tp_personaBloqueada (id_persona,
				peso1,peso2,nombre,paterno,
				materno,curp,rfc,fecha_nacimiento,
				sexo,lista,estatus,dependencia,
				puesto,area,iddispo,
				idrel,parentesco,razonsoc,
				rfcmoral,issste,imss,
				ingresos,nombrecomp,
				apellidos,entidad,
				curp_ok,periodo,expediente,
				fecha_resolucion,causa_irregularidad,
				sancion,fecha_cargo_ini,
				fecha_cargo_fin,duracion,
				monto,autoridad_sanc,admon_local,numord,rubro,
				central_obrera,numsocios,fecha_vigencia,
				titulo,domicilio_a,domicilio_b,
				colonia,cp,ciudad,lada,telefono,
				fax,email,pais,gafi, id_prospecto
				) select * from @udt_personPLD
		
			set @IDLast = @@IDENTITY

				insert into td_PLD_detalle (id_persona, fecha_aviso,
					 usuario_operativo, tipo_bloqueo,
					 ip_sucursal, sucursal , estatus_bloqueo)  
				select id_persona , CURRENT_TIMESTAMP,
						@usuario,  ISNULL(lista,'LEAP'),
						@ip_sucursal, @sucursal, 1
					from @udt_personPLD

			set @IDLast = @@IDENTITY

			exec leap.dbo.sp_setLogCatalog 'tp_personaBloqueada', 'Nuevo: Persona en PLD' , @usuario, @ip_sucursal, '', @IDLast
			exec leap.dbo.sp_setLogCatalog 'td_PLD_detalle', 'Nuevo: detalle en PLD' , @usuario, @ip_sucursal, '', @IDLast
		
		END
	END TRY

	BEGIN CATCH
		DECLARE
			@message varchar(1500) = ' ' + ISNULL(CAST(ERROR_MESSAGE() AS varchar), '')+ '/Proc.: ' + ISNULL(CAST(ERROR_PROCEDURE() AS varchar), '') + '/Línea: ' + ISNULL(CAST(ERROR_LINE() AS varchar), '')
	 IF @@TRANCOUNT > 0
		ROLLBACK TRAN 
		RAISERROR (@message, 16, 1)

	END CATCH
	 IF @@TRANCOUNT > 0
		COMMIT TRAN 
			
