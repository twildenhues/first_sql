using System;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using Dapper;
using System.Linq;

namespace TestApplication.Repository
{
	class CompanyRepository : IDisposable
	{
		private SqlConnection conn = new SqlConnection();
		public CompanyRepository() {
			conn.ConnectionString = Properties.Settings.Default.ConStringTappqa;
			conn.Open();
		}
		public List<Models.Company> ReadCompany()
		{
			string sqlcmd = "SELECT Id, Name, CreatedTime, Country, City, Zip, Street, DepartementName, ManagerId FROM viCompany";			
			var test = conn.Query<Models.Company>(sqlcmd).ToList();
				return test;	
		}
		public Models.Company Read(int Id)
		{
			string sqlcmd = "SELECT Id, Name, CreatedTime, Country, City, Zip, Street, DepartementName, ManagerId FROM viCompany where Id = @Id";
			var param = new DynamicParameters();
			param.Add("@Id", Id);
			var company = conn.QueryFirstOrDefault<Models.Company>(sqlcmd, param);
			return company;

		}
		public bool DeleteCompany(int CompanyId)
		{
			try
			{
				using (SqlCommand command = new SqlCommand("DELETE FROM Company WHERE Company.Id = @Id", conn))
				{
					command.Parameters.AddWithValue("@Id", CompanyId);
					int retval = command.ExecuteNonQuery();
					return (retval > 0);
				}
			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
				return false;
			}
		}
		public Models.Company CreatingOrUpdatingCompany(int CompanyId, string value)
		{

			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
				insertCommand.Parameters.AddWithValue("@Id", (CompanyId == 0) ? -1 : CompanyId);
				insertCommand.Parameters.AddWithValue("@Name", value);
				int dbId = (int) insertCommand.ExecuteScalar() ;
				return Read(dbId);
			}
		}

		public void Dispose()
		{
			conn.Close();
		}
	}
}