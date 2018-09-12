using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class CompanyRepository
	{
		private SqlConnection conn = new SqlConnection();
		public CompanyRepository() {
			conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
			conn.Open();
		}

		public DataTable ReadCompany()
		{
			SqlCommand view = new SqlCommand("SELECT * FROM viCompany", conn);
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				return dt;
			}
		}
		public void DeleteCompany(int CompanyId)
		{
			try
			{
				using (SqlCommand command = new SqlCommand("DELETE FROM Company WHERE Company.Id = '" + CompanyId + "'", conn))
				{
					command.ExecuteNonQuery();
				}
			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
			}
		}
		public void CreatingOrUpdatingCompany(int CompanyId, string value)
		{

			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
				insertCommand.Parameters.AddWithValue("@Id", (CompanyId == 0) ? -1 : CompanyId);
				insertCommand.Parameters.AddWithValue("@Name", value);
				insertCommand.ExecuteNonQuery();
			}
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}