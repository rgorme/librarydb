DECLARE @DB_BOOK_ID int

SET @DB_BOOK_ID = @BOOK_ID

EXECUTE [dbo].[proc_deleteBook] 
   @DB_BOOK_ID