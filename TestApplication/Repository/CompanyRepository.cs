using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class CompanyRepository : IDisposable
	{
		private SqlConnection conn = new SqlConnection();
		public CompanyRepository() {
			conn.ConnectionString = Properties.Settings.Default.ConStringTappqa;
			conn.Open();
		}

		public DataTable ReadCompany()
		{
			SqlCommand view = new SqlCommand("SELECT Id, Name, CreatedTime, Country, City, Zip, Street, DepartementName, ManagerId FROM viCompany", conn);
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				return dt;
			}
		}

		public Models.Company Read(int Id)
		{
			SqlCommand cmd = new SqlCommand("SELECT Id, Name, CreatedTime, Country, City, Zip, Street, DepartementName, ManagerId FROM viCompany where Id = @Id", conn);
			cmd.Parameters.AddWithValue("@Id", Id);
			using (SqlDataAdapter a = new SqlDataAdapter(cmd))
			{
				DataTable dt = new DataTable();
				Models.Company mdl = new Models.Company();
				a.Fill(dt);
				if (dt.Rows.Count != 0) {
					mdl.Id = (int)dt.Rows[0][0];
					mdl.Name = dt.Rows[0][1].ToString();
					mdl.CreatedTime = (DateTime)dt.Rows[0][2];
					mdl.Country = dt.Rows[0][3].ToString();
					mdl.City = dt.Rows[0][4].ToString();
					mdl.Zip = (int) dt.Rows[0][5];
					mdl.Street = dt.Rows[0][6].ToString();
					mdl.DepartementName = dt.Rows[0][7].ToString();
					mdl.ManagerId = (int) dt.Rows[0][8];
					return mdl;
				} else {
					return null;
				}
			}
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