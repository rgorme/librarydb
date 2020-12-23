CREATE TRIGGER dbo.trg_Book_Audit
ON dbo.Book
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

    INSERT INTO dbo.BOOK_AUDIT(
        AUDIT_OPEATION
    ,   AUDIT_ROW_TYPE
    ,   AUDIT_SESSION
    ,   BOOK_ID
    ,   BOOK_TITLE
    ,   BOOK_PAGE_NUMBER
    ,   BOOK_ISBN
    ,   BOOK_RESUME
    )
    SELECT          @operation      AS AUDIT_OPERATION
                ,   'NEW'           AS AUDIT_ROW_TYPE
                ,   @audit_session  AS AUDIT_SESSION
                ,   I.BOOK_ID
                ,   I.BOOK_TITLE
                ,   I.BOOK_PAGE_NUMBER
                ,   I.BOOK_ISBN
                ,   I.BOOK_RESUME
    FROM            INSERTED AS I
    UNION
    SELECT          @operation      AS AUDIT_OPERATION
                ,   'OLD'           AS AUDIT_ROW_TYPE
                ,   @audit_session  AS AUDIT_SESSION
                ,   D.BOOK_ID
                ,   D.BOOK_TITLE
                ,   D.BOOK_PAGE_NUMBER
                ,   D.BOOK_ISBN
                ,   D.BOOK_RESUME
    FROM            DELETED AS D
END
