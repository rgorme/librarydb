CREATE OR ALTER PROCEDURE dbo.proc_GetBooks
@BOOK_ID INT = -999
AS
	IF @BOOK_ID <> -999
		BEGIN
			SELECT      *
			FROM        dbo.BOOK
			WHERE		BOOK_ID = @BOOK_ID
		END
	ELSE
		BEGIN
			SELECT      *
			FROM        dbo.BOOK
		END