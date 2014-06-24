USE myDatabase
GO
IF OBJECT_ID ('dbo.fnFormatPhoneNumber') IS NOT NULL
    DROP FUNCTION dbo.fnFormatPhoneNumber;
GO
/* ========================================================================= */
-- Author: Samantha Smith
-- Created: 06/15/2014
-- Purpose: Format Phone Number Using a Mask
-- Usage Instructions: dbo.fnFormatPhoneNumber('1235556666', '###-###-####')
/* ========================================================================= */

CREATE FUNCTION dbo.fnFormatPhoneNumber(@phone VARCHAR(10), @mask VARCHAR(20))
	RETURNS VARCHAR(20)
AS
BEGIN

	DECLARE @formatted VARCHAR(20) 	
		, @INDEX INT = 1
		, @POS INT = 0;
		
	SET @formatted = @mask;
	WHILE (@INDEX <= LEN(@phone))
		BEGIN
			--Find location of masking character  
			SET  @POS = CHARINDEX( '#', @mask,  @POS + 1 );
			
			-- Replace masking character with phone number digit
			SET @formatted = STUFF(@formatted, @POS,1, SUBSTRING(@phone, @INDEX, 1));
			
			SET @INDEX = @INDEX + 1;
		END
		
	RETURN @formatted
			
END