SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]
AS
BEGIN


-- TM
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = 'ods.vw_TM_LoadDimCustomer', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';

-- CRM Contact
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = '[ods].[vw_DynamicsContact_LoadDimCustomer]', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';

---- CRM Account
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = '[ods].[vw_DynamicsAccount_LoadDimCustomer]', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';

---- Eloqua
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = '[etl].[vw_Eloqua_Load_DimCustomer]', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';

---- Live A
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = '[ods].[vw_LA_Cust_LoadDimCustomer]', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';

-- Skidata
EXEC MDM.etl.LoadDimCustomer @ClientDB = 'Ducks', @LoadView = '[ods].[vw_SKIDATA_LoadDimCustomer]', @LogLevel = '2', @DropTemp = '1', @IsDataUploaderSource = '0';


EXECUTE rpt.Contacts_And_Email_Waterfall_Load

END;












GO
