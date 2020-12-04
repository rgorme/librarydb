DECLARE @DB_BOOK_ID int

SET @DB_BOOK_ID = @BOOK_ID

EXECUTE [dbo].[proc_getBooks]
   @DB_BOOK_ID