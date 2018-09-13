CREATE PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Name nvarchar(128) = NULL,
	@Id int = -1,
	@Delete DateTime = NULL
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Company where Id = @Id)
	
	if(@DBId is null AND @Delete IS NULL)
	BEGIN 

		INSERT INTO [dbo].Company	(
									Name, 
									CreatedTime,
									DeletedTime
									)
		VALUES (@Name, GETDATE(), @Delete)

		Set @DBId = @@IDENTITY
	END
	ELSE
	BEGIN

		UPDATE [dbo].Company
			SET [Name] = CASE WHEN @Name IS NULL THEN [Name] ELSE @Name END,
				[DeletedTime] = CASE WHEN @Delete IS NULL THEN [DeletedTime] ELSE @Delete END
			WHERE Id = @Id
	END
	
	Select @DBId
	return @DBId
END