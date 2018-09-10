using System;
using System.Data.SqlClient;

class Create
{
	static void Main(string[] args)
	{
		Create test = new Create();
		char key = Console.ReadKey().KeyChar;
		test.Creating(key);
	}

	void Creating(int key)
	{
		using (SqlConnection conn = new SqlConnection())
			Method(key, conn);
		Console.WriteLine("Data displayed! Now press enter to clear!");
		Console.ReadLine();
		Console.Clear();
	}

	private static void Method(int key, SqlConnection conn)
	{
		conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
		conn.Open();
		string queryPlace = "";
		switch (key)
		{
			case '1':
				queryPlace = "dbo.spCreateOrUpdateCompany";
				break;
			case '2':
				queryPlace = "dbo.spCreateOrUpdateDepartement";
				break;
			case '3':
				queryPlace = "dbo.spCreateOrUpdateEmployee";
				break;
			default:
				queryPlace = "SELECT * FROM viAddress";
				break;
		}

		using (SqlCommand insertCommand = new SqlCommand(queryPlace, conn)) {
			insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
			switch (key)
			{
				case '1':
					Console.WriteLine(" ");
					Console.WriteLine("Please enter the name of the Company:");
						insertCommand.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
					Console.WriteLine(" ");
					Console.WriteLine("Please enter now the Id:");
					insertCommand.Parameters.Add("@Id", System.Data.SqlDbType.Int).Value = Console.ReadLine();
					break;
				case '2':
					insertCommand.Parameters.Add(new SqlParameter("0", 10));
					insertCommand.Parameters.Add(new SqlParameter("1", "Test Column"));
					insertCommand.Parameters.Add(new SqlParameter("2", DateTime.Now));
					insertCommand.Parameters.Add(new SqlParameter("3", false)); ;
					break;
				case '3':
					insertCommand.Parameters.Add(new SqlParameter("0", 10));
					insertCommand.Parameters.Add(new SqlParameter("1", "Test Column"));
					insertCommand.Parameters.Add(new SqlParameter("2", DateTime.Now));
					insertCommand.Parameters.Add(new SqlParameter("3", false)); ;
					break;
				default:
					insertCommand.Parameters.Add(new SqlParameter("0", 10));
					insertCommand.Parameters.Add(new SqlParameter("1", "Test Column"));
					insertCommand.Parameters.Add(new SqlParameter("2", DateTime.Now));
					insertCommand.Parameters.Add(new SqlParameter("3", false)); ;
					break;
			}

			Console.WriteLine("Commands executed! Total rows affected are " + insertCommand.ExecuteNonQuery());
			Console.WriteLine("Done! Press enter to move to the next step");
			Console.ReadLine();
			Console.Clear();
		};


	}
}