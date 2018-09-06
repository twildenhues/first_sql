CREATE PROCEDURE [dbo].[spCreateOrUpdateEmployee]
	@Name nvarchar(128),
	@Id int = -1
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Departement where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Departement(DepartementName)
		VALUES (@Name)

		Set @DBId = @@IDENTITY
	end
	else
	begin

		UPDATE [dbo].Departement
			SET [DepartementName] = @Name
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END