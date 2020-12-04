CREATE TRIGGER dbo.trg_Autor_Audit
ON dbo.Author
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    --
    -- CHECK IF OPREATION IS INSERT, UPDATE OR DELETE
    ---
    DECLARE @operation AS CHAR(3);
    DECLARE @audit_session uniqueidentifier = NEWID();

    SET @operation = N'INS';
    IF EXISTS(SELECT * FROM DELETED)
        BEGIN
            -- UPDATE OR DELETE
            SET @operation = 
                CASE
                    WHEN EXISTS(SELECT * FROM INSERTED) THEN N'UPD' -- UPDATE
                    ELSE N'DEL'
                END    
        END
    ELSE
        BEGIN
            IF NOT EXISTS(SELECT * FROM INSERTED) RETURN; -- NOTHIN HAS BEEN UPDATED
        END

    INSERT INTO dbo.AUTHOR_AUDIT(
        AUDIT_OPEATION
    ,   AUDIT_ROW_TYPE
    ,   AUDIT_SESSION
    ,   AUTHOR_ID
    ,   FIRST_NAME
    ,   LAST_NAME
    ,   NATIONALITY_SHORT
    ,   DESCRIPTION
    )
    SELECT          @operation      AS AUDIT_OPERATION
                ,   'NEW'           AS AUDIT_ROW_TYPE
                ,   @audit_session  AS AUDIT_SESSION
                ,   I.AUTHOR_ID
                ,   I.FIRST_NAME
                ,   I.LAST_NAME
                ,   I.NATIONALITY_SHORT
                ,   I.DESCRIPTION
    FROM            INSERTED AS I
    UNION
    SELECT          @operation      AS AUDIT_OPERATION
                ,   'OLD'           AS AUDIT_ROW_TYPE
                ,   @audit_session  AS AUDIT_SESSION
                ,   D.AUTHOR_ID
                ,   D.FIRST_NAME
                ,   D.LAST_NAME
                ,   D.NATIONALITY_SHORT
                ,   D.DESCRIPTION
    FROM            DELETED AS D
END
