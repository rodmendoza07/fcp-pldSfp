BEGIN TRY
    BEGIN TRAN
    INSERT INTO CATALOGOS.dbo.tc_config(
		  cfg_descrip
		  , cfg_valor
		  , cfg_estatus)
    VALUES('PLD_period_1', '01-03', 1)
	   , ('PLD_period_2', '04-06', 1)
	   , ('PLD_period_3', '07-09', 1)
	   , ('PLD_period_4', '10-12', 1)
	   , ('PLD_USD_Limit', '7000', 1)
    IF @@TRANCOUNT > 0
	   COMMIT TRAN
END TRY 
BEGIN CATCH
    IF @@TRANCOUNT > 0
	   ROLLBACK TRAN
END CATCH