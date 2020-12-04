--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
-- =============================================
-- Author:		Rasmus Gormsbøl Larsen
-- Create date: 04-12-2020
-- Description:	Oprettelse af ny forfatter
-- =============================================
CREATE OR ALTER PROCEDURE dbo.proc_InsertOrUpdateBook
	@BOOK_TITLE	VARCHAR(1000),
	@BOOK_PAGE_NUMBER INT,
	@BOOK_ISBN VARCHAR(13),
	@BOOK_RESUME VARCHAR(MAX),
	@BOOK_ID INT = 0
AS
BEGIN
	
IF @BOOK_ID = 0
	BEGIN
		--INSERT
		INSERT INTO [dbo].[BOOK] ([BOOK_TITLE], [BOOK_PAGE_NUMBER], [BOOK_ISBN], [BOOK_RESUME])
		VALUES (@BOOK_TITLE, @BOOK_PAGE_NUMBER, @BOOK_ISBN, @BOOK_RESUME)
		SELECT SCOPE_IDENTITY() AS BOOK_ID;
	END
ELSE
	BEGIN
		--UPDATE
		UPDATE [dbo].[BOOK]
			SET [BOOK_TITLE] = @BOOK_TITLE, [BOOK_PAGE_NUMBER] = @BOOK_PAGE_NUMBER, [BOOK_ISBN] = @BOOK_ISBN, [BOOK_RESUME] = @BOOK_RESUME, [MODIFIED] = CURRENT_TIMESTAMP
		WHERE [BOOK_ID] = @BOOK_ID
		SELECT		*
		FROM		BOOK
		WHERE		BOOK_ID = @BOOK_ID;
	END
END