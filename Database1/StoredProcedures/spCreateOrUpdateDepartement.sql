CREATE PROCEDURE [dbo].[spCreateOrUpdateDepartement]
	@Name nvarchar(128),
	@Id int = -1,
	@CompanyId int 
AS
BEGIN 

	declare @DBId int
	Set @DBId = (select Id from Departement where Id = @Id)
	
	if(@DBId is null)
	begin 

		INSERT INTO [dbo].Departement(DepartementName, CompanyId)
		VALUES (@Name, @CompanyId)

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