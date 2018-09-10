using System;
using System.Data.SqlClient;
using System.Data;

class ComponyRepository
{

	static void Main(string[] args)
	{
		ComponyRepository test = new ComponyRepository();
		char key = Console.ReadKey().KeyChar;
		using (SqlConnection conn = new SqlConnection())
		{
			conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
			conn.Open();
			switch (key)
			{
				case '1':
					test.CreatingOrUpdatingCompany(conn); ;
					break;
				case '2':
					test.ReadCompany(conn);
					break;
				case '3':
					test.DeleteCompany();
					break;
				default:
					Console.WriteLine("Falsche Eingabe");
					break;
			}
		}
	}

	private void ReadCompany(SqlConnection conn)
	{
		SqlCommand view = new SqlCommand("SELECT * FROM viCompany", conn);
		using (SqlDataAdapter a = new SqlDataAdapter(view))
		{
			DataTable dt = new DataTable();
			a.Fill(dt);
			Console.WriteLine(" ");
			foreach (DataRow row in dt.Rows)
			{
				for (int i = 0; i < dt.Columns.Count; i++)
				{
					Console.Write(row[i].ToString() + "\t");
				}
				Console.WriteLine();
			}
		}
	}
		private void DeleteCompany()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingCompany(SqlConnection conn)
		{

			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;

				Console.WriteLine(" ");
				Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Company. Else just press enter to generate a new Company");
				string tempCompany = Console.ReadLine();
				int CompanyId;
				Int32.TryParse(tempCompany, out CompanyId);
				insertCommand.Parameters.AddWithValue("@Id", (CompanyId == 0) ? -1 : CompanyId);
				Console.WriteLine(" ");
				Console.WriteLine("Please enter the name of the Company:");
				insertCommand.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();

				Console.WriteLine("Data displayed! Now press enter to clear!");
				Console.ReadLine();
				Console.Clear();
			}
		}
	}