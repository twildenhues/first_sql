﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlTest_CSharp
{
	class Program
	{
		static void Main(string[] args)
		{
			// Create the connection to the resource!
			// This is the connection, that is established and
			// will be available throughout this block.
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
							reader[0], reader[1], reader[2], reader[3], reader[4], reader[5], reader[6]));
					}
				}
				SqlCommand viewDepartement = new SqlCommand("SELECT * FROM viDepartement", conn);

				Console.WriteLine("----------------------------------------------------------------------------------------------------------------------------");

				using (SqlDataReader reader = viewDepartement.ExecuteReader())
				{
					Console.WriteLine("Id\t\tCompanyId\t\tManagerId\t\tDepartementName\t\tCreatedTime\t");
					while (reader.Read())
					{
						Console.WriteLine(String.Format("{0} \t | {1} \t\t | {2} \t | {3} \t | {4} \t |",
							reader[0], reader[1], reader[2], reader[3], reader[4]));
					}
				}
				SqlCommand viewEmployee = new SqlCommand("SELECT * FROM viEmployee", conn);

				Console.WriteLine("----------------------------------------------------------------------------------------------------------------------------");

				using (SqlDataReader reader = viewEmployee.ExecuteReader())
				{
					Console.WriteLine("Id\t\tFirst Name\t\tLast Name\t\tBirthday\t\tDepartementId\t\tCreatedTime\t\tCountry\t\tCity\t\tZip\t\tStreet\t");
					while (reader.Read())
					{
						Console.WriteLine(String.Format("{0} \t | {1} \t\t | {2} \t | {3} \t | {4} \t | {5} \t | {6} \t | {7} \t | {8} \t | {9} \t |",
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