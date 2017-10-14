USE LEAP
GO

CREATE PROCEDURE [dbo].[sp_unblockClientPLD] (
	@prospect INT = 0
	, @ocComment VARCHAR(MAX) = ''
	, @appUser VARCHAR(15) = ''
	, @blockStatus INT = 0
)
AS
BEGIN
	BEGIN TRY

		SELECT
			pb.id_persona
		INTO #personaTmp
		FROM LEAP.dbo.tp_personabloqueada pb
		WHERE pb.id_prospecto = @prospect

		IF @blockStatus = 2 BEGIN
			UPDATE LEAP.dbo.td_PLD_detalle SET
				comentario_oficial = @ocComment
				, fecha_validado = GETDATE()
				, usu_oficial_cumplimiento = @appUser
				, estatus_bloqueo = @blockStatus
				, fecha_desbloqueo = GETDATE()
				, comentario_desbloqueo = @ocComment
				, usuario_desbloqueo = @appUser
			WHERE id_persona IN (SELECT * FROM #personaTmp)
		END
		IF @blockStatus = 1 BEGIN
			UPDATE LEAP.dbo.td_PLD_detalle SET
				comentario_oficial = @ocComment
				, fecha_validado = GETDATE()
				, usu_oficial_cumplimiento = @appUser
			WHERE id_persona IN (SELECT * FROM #personaTmp)
		END

		DROP TABLE #personaTmp

		SELECT 'Exitoso' AS [message]

	END TRY
	BEGIN CATCH
		SELECT 'Error al desbloquear el cliente' AS [message]
	END CATCH
END