USE LEAP
GO

CREATE PROCEDURE [dbo].[sp_authorithymaintenance]
(
	@opt INT = 0
	, @authId INT = 0
	, @enableauth INT = 0
	, @siglas VARCHAR(10) = ''
	, @authname	VARCHAR(300) = ''
	, @authtype INT = 0

)
AS
BEGIN
	IF @opt = -1 BEGIN
		BEGIN TRY
			SELECT
				cat.id_listaPLD AS id 
				, cat.siglas
				,'<span class="label ' + list.label + '">' + cat.siglas + '</span>' AS siglaslabels
				, cat.nombre
				, cat.alerta
			FROM LEAP.dbo.tc_listaPLD cat
				INNER JOIN LEAP.dbo.tc_tipo_lista_pld list ON (cat.tipo = list.id_tipo_lista_pld)
			WHERE alerta <> 0 
				OR alerta <> NULL
			ORDER BY cat.id_listaPLD ASC
		END TRY
		BEGIN CATCH
			SELECT 'Error al mostrar opciones' AS [message]
		END CATCH
	END
	ELSE IF @opt = 0 BEGIN
		BEGIN TRY
			SELECT 
				cat.id_listaPLD AS id 
				, '<span class="label ' + list.label + '">' + cat.siglas + '</span>' AS siglas
				, cat.siglas AS acronym
				, cat.nombre
				, cat.alerta
				, list.descripcion AS listType
				, list.id_tipo_lista_pld AS listTypeId
			FROM LEAP.dbo.tc_listaPLD cat
				INNER JOIN LEAP.dbo.tc_tipo_lista_pld list ON (cat.tipo = list.id_tipo_lista_pld)
			ORDER BY cat.id_listaPLD ASC
		END TRY
		BEGIN CATCH
			SELECT 'Error al mostrar opciones' AS [message]
		END CATCH
	END
	ELSE IF @opt = 1 BEGIN
		BEGIN TRY
			UPDATE LEAP.dbo.tc_listaPLD SET
				nombre = @authname
				, alerta = @enableauth
				, siglas = @siglas
				, tipo = @authtype
			WHERE id_listaPLD = @authId
			SELECT 'Autoridad ' + @siglas + ' actualizada exitosamente' as [message]
		END TRY
		BEGIN CATCH
			SELECT 'Error al actualizar el registro' AS [message]
		END CATCH
	END
	ELSE IF @opt = 2 BEGIN
		BEGIN TRY
			INSERT INTO LEAP.dbo.tc_listaPLD
				(
					siglas
					, nombre
					, alerta
					, tipo
				)
			VALUES
				(
					@siglas
					, @authname
					, 1
					, @authtype
				)
			SELECT 'Autoridad' + @siglas + ' registrada exitosamente' as [message]
		END TRY
		BEGIN CATCH
			SELECT 'Error al registrar Autoridad' AS [message]
		END CATCH
	END
	ELSE IF @opt = -2 BEGIN
		BEGIN TRY
			SELECT
				tipo.id_tipo_lista_pld AS listTypeId
				, tipo.descripcion AS typeName
			FROM LEAP.dbo.tc_tipo_lista_pld tipo
			WHERE tipo.estatus = 1
		END TRY
		BEGIN CATCH
			SELECT 'Error al mostrar opciones' AS [message]
		END CATCH
	END
END