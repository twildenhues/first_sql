CREATE PROCEDURE [dbo].[spCreateOrUpdateCompany]
	@Name nvarchar(128),
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Company where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Company (Name)
		VALUES (@Name)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Company
			SET [Name] = @Name
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END