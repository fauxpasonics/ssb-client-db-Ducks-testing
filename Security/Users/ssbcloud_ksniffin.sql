IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ssbcloud\ksniffin')
CREATE LOGIN [ssbcloud\ksniffin] FROM WINDOWS
GO
CREATE USER [ssbcloud\ksniffin] FOR LOGIN [ssbcloud\ksniffin] WITH DEFAULT_SCHEMA=[ssbcloud\ksniffin]
GO
REVOKE CONNECT TO [ssbcloud\ksniffin]
