using System;
using System.Data.SqlClient;

class Read
{
	static void Main(string[] args) {
		Read test = new Read();
		char key = Console.ReadKey().KeyChar;
		test.Reading(key);
	}

		void Reading(int key)
		{
			using (SqlConnection conn = new SqlConnection())
				NewMethod(key, conn);
			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}

	private static void NewMethod(int key, SqlConnection conn)
	{
		conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
		conn.Open();
		string queryPlace = "";
		switch (key)
		{
			case '1':
				queryPlace = "SELECT * FROM viCompany";
				break;
			case '2':
				queryPlace = "SELECT * FROM viDepartement";
				break;
			case '3':
				queryPlace = "SELECT * FROM viEmployee";
				break;
			default:
				queryPlace = "SELECT * FROM viAddress";
				break;
		}
		SqlCommand view = new SqlCommand(queryPlace, conn);
		using (SqlDataReader reader = view.ExecuteReader())
		{
			Console.WriteLine(" ");
			while (reader.Read())
			{
				for (int i = 0; i < reader.FieldCount; i++)
				{
					Console.WriteLine(reader[i].ToString());
				}
			}
		}
	}
}