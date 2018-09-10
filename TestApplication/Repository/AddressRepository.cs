﻿using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class AddressRepository
	{

		static void Main(string[] args)
		{
			AddressRepository test = new AddressRepository();
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
						test.CreatingOrUpdatingAddress(conn); ;
						break;
					case '2':
						test.ReadAddress(conn); ;
						break;
					case '3':
						test.DeleteAddress(conn);
						break;
					default:
						Console.WriteLine("Falsche Eingabe");
						break;
				}
			}
		}

		private void ReadAddress(SqlConnection conn)
		{
			SqlCommand view = new SqlCommand("SELECT * FROM viAddress", conn);
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
				conn.Close();
			}
		}

		private void DeleteAddress(SqlConnection conn)
		{
			try
			{
				Console.WriteLine("Please insert the Id of the Address you want to delete:");
				string tempAddress = Console.ReadLine();
				int AddressId;
				Int32.TryParse(tempAddress, out AddressId);
				using (SqlCommand command = new SqlCommand("DELETE FROM Address WHERE Address.Id = '" + AddressId + "'", conn))
				{
					command.ExecuteNonQuery();
				}
				conn.Close();

			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
			}
		}

		void CreatingOrUpdatingAddress(SqlConnection conn)
		{
			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;

				Console.WriteLine(" ");
					Console.WriteLine("Enter the Id of the an existingAddress if you want to change something, and just press enter to generate a new Address:");
						string tempAddress = Console.ReadLine();
						int AddressId;
						Int32.TryParse(tempAddress, out AddressId);
						insertCommand.Parameters.AddWithValue("@Id", (AddressId == 0) ? -1 : AddressId);
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the Country:");
						insertCommand.Parameters.Add("@Country", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the City:");
						insertCommand.Parameters.Add("@City", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the ZIP of the City:");
						string tempZip = Console.ReadLine();
						int Zip;
						Int32.TryParse(tempZip, out Zip);
						insertCommand.Parameters.AddWithValue("@Zip", (Zip == 0) ? -1 : Zip);
				Console.WriteLine(" ");
					Console.WriteLine("Does this Address belongs to an Employee or a Company ? ");
					Console.WriteLine("enter 'E' for Employee and 'C' for Company");
				var input = Console.ReadKey().KeyChar;
				switch (input) {
					case 'E':
						Console.WriteLine("Enter the Id of the Employee:");
						string EmployeeId = Console.ReadLine();
						int Employee;
						Int32.TryParse(EmployeeId, out Employee);
						insertCommand.Parameters.AddWithValue("@EmployeeId", (Employee == 0) ? -1 : Employee);
						;
						break;
					case 'C':
						Console.WriteLine("Enter the Id the Company:");
						string CompanyId = Console.ReadLine();
						int Company;
						Int32.TryParse(CompanyId, out Company);
						insertCommand.Parameters.AddWithValue("@CompanyId", (Company == 0) ? -1 : Company);
						;
						break;
					default: Console.WriteLine("Falsche Eingabe!");
						break;


				}
				insertCommand.ExecuteNonQuery();
				conn.Close();
				Console.WriteLine("Finished! Now press enter to clear!");
				Console.ReadLine();
				Console.Clear();
			}
		}
	}
}
