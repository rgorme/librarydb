CREATE OR ALTER PROCEDURE dbo.proc_GetAuthors
@AUTHOR_ID INT = -999
AS
    IF  @AUTHOR_ID <> -999
        BEGIN
            SELECT      *
            FROM        dbo.AUTHOR
            WHERE       AUTHOR_ID = @AUTHOR_ID
        END
    ELSE
        BEGIN
            SELECT      *
            FROM        dbo.AUTHOR
        END