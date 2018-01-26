USE [CATALOGOS]
GO
ALTER PROCEDURE [dbo].sp_USD_Limit(
	@limit numeric(18, 2) = 0
)
AS
BEGIN
    BEGIN TRY
	   DECLARE
		  @msg varchar(300) = ''
	   IF @limit = 0
	   BEGIN
		  SELECT
			 a.cfg_valor AS [Limit]
		  FROM CATALOGOS.dbo.tc_config a
		  WHERE a.cfg_descrip = 'PLD_USD_Limit'
	   END
	   ELSE
	   BEGIN
		  UPDATE CATALOGOS.dbo.tc_config
		  SET cfg_valor = @limit
		  WHERE cfg_descrip = 'PLD_USD_Limit'
	   END
    END TRY
    BEGIN CATCH
	   SET @msg = (SELECT CAST(ERROR_MESSAGE() as VARCHAR(300)))
	   RAISERROR(@msg, 16, 1)
    END CATCH
END