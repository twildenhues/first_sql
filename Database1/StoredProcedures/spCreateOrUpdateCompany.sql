CREATE PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Name nvarchar(128) = NULL,
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Company where Id = @Id)
	
	if(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Company	(
									Name, 
									CreatedTime
									)
		VALUES (@Name, GETDATE())

		Set @DBId = @@IDENTITY
	END
	ELSE
	BEGIN

		UPDATE [dbo].Company
			SET [Name] = CASE WHEN @Name IS NULL THEN [Name] ELSE @Name END
			WHERE Id = @Id
	END
	
	Select @DBId
	return @DBId
END