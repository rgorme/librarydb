CREATE OR ALTER PROCEDURE dbo.proc_deleteAuthor
    @AUTHOR_ID INT
AS
	DECLARE		@AUTHOR_DELETED BIT ;
    DELETE		dbo.AUTHOR
    WHERE       AUTHOR_ID = @AUTHOR_ID
	SET			@AUTHOR_DELETED = @@ROWCOUNT;
	SELECT		@AUTHOR_DELETED	AS AUTHOR_DELETED