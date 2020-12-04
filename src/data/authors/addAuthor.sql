DECLARE @DB_FIRST_NAME varchar(250)
DECLARE @DB_LAST_NAME varchar(250)
DECLARE @DB_NATIONALITY_SHORT varchar(5)
DECLARE @DB_DESCRIPTION varchar(max)
DECLARE @DB_AUTHOR_ID int

SET @DB_FIRST_NAME = @FIRST_NAME
SET @DB_LAST_NAME = @LAST_NAME
SET @DB_NATIONALITY_SHORT = @NATIONALITY_SHORT
SET @DB_DESCRIPTION = @DESCRIPTION
SET @DB_AUTHOR_ID = 0

EXECUTE [dbo].[proc_InsertOrUpdateAuthor] 
   @DB_FIRST_NAME
  ,@DB_LAST_NAME
  ,@DB_NATIONALITY_SHORT
  ,@DB_DESCRIPTION
  ,@DB_AUTHOR_ID