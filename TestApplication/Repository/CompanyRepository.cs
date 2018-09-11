using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class CompanyRepository
	{

		static void Main(string[] args)
		{
			CompanyRepository test = new CompanyRepository();
			Console.WriteLine("press '1' to add or update a Company");
			Console.WriteLine("press '2' to see all current Companys");
			Console.WriteLine("press '3' to delete a Company");
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
						Console.WriteLine(" ");
						test.CreatingOrUpdatingCompany(conn); ;
						break;
					case '2':
						Console.WriteLine(" ");
						test.ReadCompany(conn);
						break;
					case '3':
						Console.WriteLine(" ");
						test.DeleteCompany(conn);
						break;
					default:
						Console.WriteLine(" ");
						Console.WriteLine("Falsche Eingabe");
						break;
				}
			}
		}

		private void ReadCompany(SqlConnection conn)
		{
			SqlCommand view = new SqlCommand("SELECT * FROM viCompany", conn);
			Console.WriteLine(("   Id").PadRight(25, ' ') + ("   Name").PadRight(25, ' ') + ("   CreatedTimed").PadRight(25, ' ') + ("   Country").PadRight(25, ' ') + ("   City").PadRight(25, ' ') + ("   Zip").PadRight(25, ' ') + ("   Street").PadRight(25, ' ') + ("   Departement").PadRight(25, ' '));
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				Console.WriteLine(" ");
				foreach (DataRow row in dt.Rows)
				{
					for (int i = 0; i < dt.Columns.Count; i++)
					{
						Console.Write(("   " + row[i].ToString()).PadRight(25, ' '));
					}
					Console.WriteLine();
				}
				conn.Close();
				Console.WriteLine("Finished! Now press enter to clear!");
				Console.ReadLine();
				Console.Clear();
			}
		}
		private void DeleteCompany(SqlConnection conn)
		{
			try
			{
				Console.WriteLine("Please insert the Id of the Compony you want to delete:");
				string tempCompany = Console.ReadLine();
				int CompanyId;
				Int32.TryParse(tempCompany, out CompanyId);
				using (SqlCommand command = new SqlCommand("DELETE FROM Company WHERE Company.Id = '" + CompanyId + "'", conn))
				{
					Console.WriteLine("successfully deleted ");
					command.ExecuteNonQuery();
				}
				conn.Close();

			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
			}
		}
		void CreatingOrUpdatingCompany(SqlConnection conn)
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
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}