CREATE PROCEDURE [dbo].[spCreateOrUpdateDepartement]
	@Name nvarchar(128) = NULL,
	@Id int = -1 ,
	@CompanyId int = NULL,
	@ManagerId int = null
AS
BEGIN 

	DECLARE @DBId int
	SET @DBId = (select Id from Departement where Id = @Id)
	
	if(@DBId is null)
	BEGIN 

		INSERT INTO [dbo].Departement(
									DepartementName, 
									CompanyId, 
									CreatedTime,
									ManagerId
									)
		VALUES (
				@Name, 
				@CompanyId, 
				GETDATE(),
				CASE WHEN @ManagerId = -1 THEN NULL ELSE @ManagerId END
				)

		SET @DBId = @@IDENTITY
	END
	ELSE
	BEGIN

		UPDATE [dbo].Departement
			SET [DepartementName] = CASE WHEN @Name IS NULL THEN [DepartementName] ELSE @Name END, 
				[CompanyId] =  CASE WHEN @CompanyId IS NULL THEN [CompanyId] ELSE @CompanyId END,
				[ManagerId] = CASE WHEN @ManagerId IS NULL THEN [ManagerId] ELSE @ManagerId END
			WHERE Id = @Id
	end
	
	Select @DBId
	return @DBId
END