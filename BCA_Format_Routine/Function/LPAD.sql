-- Left pad string function
CREATE FUNCTION dbo.LPAD

               (@SourceString VARCHAR(MAX),

                @FinalLength  INT,

                @PadChar      CHAR(1))

RETURNS VARCHAR(MAX)

AS

  BEGIN

    RETURN

      (SELECT Replicate(@PadChar,@FinalLength - Len(@SourceString)) + @SourceString)

  END

GO