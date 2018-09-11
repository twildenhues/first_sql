using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class CompanyRepository
	{
		private SqlConnection conn = new SqlConnection();
		public CompanyRepository() {
			using (conn)
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
			}
		}

		public DataTable ReadCompany()
		{
			SqlCommand view = new SqlCommand("SELECT * FROM viCompany", conn);
			Console.WriteLine(("   Id").PadRight(25, ' ') + ("   Name").PadRight(25, ' ') + ("   CreatedTimed").PadRight(25, ' ') + ("   Country").PadRight(25, ' ') + ("   City").PadRight(25, ' ') + ("   Zip").PadRight(25, ' ') + ("   Street").PadRight(25, ' ') + ("   Departement").PadRight(25, ' '));
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				return dt;
			}
		}
		public void DeleteCompany()
		{
			try
			{
				Console.WriteLine("Please insert the Id of the Compony you want to delete:");
				string tempCompany = Console.ReadLine();
				int CompanyId;
				Int32.TryParse(tempCompany, out CompanyId);
				using (SqlCommand command = new SqlCommand("DELETE FROM Company WHERE Company.Id = '" + CompanyId + "'", conn))
				{
					command.ExecuteNonQuery();
				}
				Console.WriteLine("successfully deleted! Press enter to go to the menu ");
				Console.ReadLine();

			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
			}
		}
		public void CreatingOrUpdatingCompany()
		{

			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
				Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Company. Else just press enter to generate a new Company");
				string tempCompany = Console.ReadLine();
				int CompanyId;
				Int32.TryParse(tempCompany, out CompanyId);
				insertCommand.Parameters.AddWithValue("@Id", (CompanyId == 0) ? -1 : CompanyId);
				Console.WriteLine(" ");
				Console.WriteLine("Please enter the name of the Company:");
				insertCommand.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
				insertCommand.ExecuteNonQuery();
			}
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}