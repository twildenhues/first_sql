using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class AddressRepository
	{

		public void Run()
		{
			AddressRepository test = new AddressRepository();
			Console.WriteLine("press '1' to add or update a Address");
			Console.WriteLine("press '2' to see all current Addresses");
			Console.WriteLine("press '3' to delete a Address");
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
							Console.WriteLine(" ");
							test.CreatingOrUpdatingAddress(conn); ;
						break;
					case '2':
							Console.WriteLine(" ");
							test.ReadAddress(conn); ;
						break;
					case '3':
							Console.WriteLine(" ");
							test.DeleteAddress(conn);
						break;
					default:
							Console.WriteLine(" ");
							Console.WriteLine("Falsche Eingabe");
						break;
				}
			}
		}

		private void ReadAddress(SqlConnection conn)
		{
			Console.WriteLine(("   Id").PadRight(25, ' ')+("   Country").PadRight(25, ' ') + ("   City").PadRight(25, ' ') + ("   Zip").PadRight(25, ' ') + ("   Street").PadRight(25, ' '));
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
						Console.Write("   "+(row[i].ToString()).PadRight(25, ' '));
					}
					Console.WriteLine();
				}
				conn.Close();
				Console.WriteLine("Finished! Now press enter to clear!");
				Console.ReadLine();
				Console.Clear();
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

		void CreatingOrUpdatingAddress(SqlConnection conn)
		{
			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateAddress", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
					Console.WriteLine("Enter the Id of the an existing Address if you want to change something, and just press enter to generate a new Address:");
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
					Console.WriteLine("enter 'e' for Employee and 'c' for Company");
				var input = Console.ReadKey().KeyChar;
				switch (input) {
					case 'e':
						Console.WriteLine(" ");
							Console.WriteLine("Enter the Id of the Employee:");
								string EmployeeId = Console.ReadLine();
								int Employee;
								Int32.TryParse(EmployeeId, out Employee);
								insertCommand.Parameters.AddWithValue("@EmployeeId", (Employee == 0) ? -1 : Employee);
						break;
					case 'c':
						Console.WriteLine(" ");
							Console.WriteLine("Enter the Id the Company:");
								string CompanyId = Console.ReadLine();
								int Company;
								Int32.TryParse(CompanyId, out Company);
								insertCommand.Parameters.AddWithValue("@CompanyId", (Company == 0) ? -1 : Company);
						break;
					default:
							Console.WriteLine("Falsche Eingabe!");
						break;
				}
				insertCommand.ExecuteNonQuery();
			}
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}
