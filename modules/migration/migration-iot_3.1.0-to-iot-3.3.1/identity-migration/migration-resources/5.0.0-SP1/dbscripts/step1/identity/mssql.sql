IF NOT  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_AUTH_SESSION_STORE]') AND TYPE IN (N'U'))
CREATE TABLE IDN_AUTH_SESSION_STORE (
        SESSION_ID VARCHAR (100) DEFAULT NULL,
        SESSION_TYPE VARCHAR(100) DEFAULT NULL,
        SESSION_OBJECT VARBINARY(MAX),
        TIME_CREATED DATETIME,
        PRIMARY KEY (SESSION_ID, SESSION_TYPE)
);

UPDATE IDP_AUTHENTICATOR SET NAME='samlsso' WHERE NAME = 'saml2sso' AND TENANT_ID = '-1234';

DECLARE @COMMAND NVARCHAR(200);SELECT @COMMAND='ALTER TABLE IDP_PROVISIONING_ENTITY DROP CONSTRAINT ' + A.CONSTRAINT_NAME + ';' FROM (SELECT * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME='IDP_PROVISIONING_ENTITY' AND COLUMN_NAME='ENTITY_TYPE') A INNER JOIN (SELECT * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME='IDP_PROVISIONING_ENTITY' AND COLUMN_NAME='TENANT_ID') B ON A.CONSTRAINT_NAME=B.CONSTRAINT_NAME INNER JOIN (SELECT * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME='IDP_PROVISIONING_ENTITY' AND COLUMN_NAME='ENTITY_LOCAL_USERSTORE') C ON B.CONSTRAINT_NAME=C.CONSTRAINT_NAME INNER JOIN (SELECT * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE WHERE TABLE_NAME='IDP_PROVISIONING_ENTITY' AND COLUMN_NAME='ENTITY_NAME') D ON C.CONSTRAINT_NAME=D.CONSTRAINT_NAME;EXEC (@COMMAND);