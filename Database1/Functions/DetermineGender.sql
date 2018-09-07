CREATE FUNCTION dbo.determine_gender(@genderAsInt int)    
	RETURNS nvarchar(64)    
	AS 
    BEGIN   
		RETURN(	
				SELECT CASE @genderAsInt	
					WHEN 1 THEN 'Male'
					WHEN 2 THEN 'Female'
					WHEN 3 THEN 'something else' 
					ELSE		'no gender given'
				END
		)
END