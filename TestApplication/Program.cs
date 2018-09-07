using System;
using System.Data.SqlClient;

namespace SqlTest_CSharp
{
	class Program
	{
		static void Main(string[] args)
		{
			using (SqlConnection conn = new SqlConnection())
			{

				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();

				SqlCommand viewCompany = new SqlCommand("SELECT * FROM viCompany", conn);

				using (SqlDataReader reader = viewCompany.ExecuteReader())
				{
					Console.WriteLine("Id\t\tName\t\tCreatedTime\t\tCountry\t\tCity\t\tZip\t\tStreet\t");
					while (reader.Read())
					{
						Console.WriteLine(String.Format("{0} \t | {1} \t | {2} \t | {3} \t | {4} \t | {5} \t | {6} \t |",
							reader[0].ToString().PadLeft(5,' '), reader[1], reader[2], reader[3], reader[4], reader[5], reader[6]));
					}
				}

				Console.WriteLine("----------------------------------------------------------------------------------------------------------------------------");

				SqlCommand viewDepartement = new SqlCommand("SELECT * FROM viDepartement", conn);
				using (SqlDataReader reader = viewDepartement.ExecuteReader())
				{
					Console.WriteLine("Id\t\tCompanyId\t\tManagerId\t\tDepartementName\t\tCreatedTime\t");
					while (reader.Read())
					{
						Console.WriteLine(String.Format("{0} \t | {1} \t\t | {2} \t | {3} \t | {4} \t |",
							reader[0], reader[1], reader[2], reader[3], reader[4]));
					}
				}

				Console.WriteLine("----------------------------------------------------------------------------------------------------------------------------");

				SqlCommand viewEmployee = new SqlCommand("SELECT * FROM viEmployee", conn);
				using (SqlDataReader reader = viewEmployee.ExecuteReader())
				{
					Console.WriteLine("Id\t\tFirst Name\t\tLast Name\t\tBirthday\t\tDepartementId\t\tCreatedTime\t\tCountry\t\tCity\t\tZip\t\tStreet\t");
					while (reader.Read())
					{
						Console.WriteLine(String.Format("{0} \t | {1} \t | {2} \t | {3} \t | {4} \t | {5} \t | {6} \t | {7} \t | {8} \t | {9} \t |",
							reader[0], reader[1], reader[2], reader[3], reader[4], reader[5], reader[6], reader[7], reader[8], reader[9]));
					}
				}

				Console.WriteLine("----------------------------------------------------------------------------------------------------------------------------");

				Console.WriteLine("Data displayed! Now press enter to move to the next section!");
				Console.ReadLine();
				Console.Clear();
			}
		}
	}
}