using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class EmployeeRepository
	{

		static void Main(string[] args)
		{
			EmployeeRepository test = new EmployeeRepository();
			Console.WriteLine("press '1' to add or update an Employee");
			Console.WriteLine("press '2' to see all current Employees");
			Console.WriteLine("press '3' to delete an Employee");
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
							Console.WriteLine(" ");
							test.CreatingOrUpdatingEmployee(conn); ;
						break;
					case '2':
							Console.WriteLine(" ");
							test.ReadEmployee(conn); ;
						break;
					case '3':
							Console.WriteLine(" ");
							test.DeleteEmployee(conn);
						break;
					default:
							Console.WriteLine(" ");
							Console.WriteLine("Falsche Eingabe");
						break;
				}	
			}
		}

		private void ReadEmployee(SqlConnection conn)
		{
			Console.WriteLine(
				("   Id").PadRight(25, ' ')+("   First Name").PadRight(25, ' ')+("   Last Name").PadRight(25, ' ')+("   Birthday").PadRight(25, ' ')+("   DepartementId").PadRight(25, ' ')+("   CreatedTime").PadRight(25, ' ')+("   Country").PadRight(25, ' ')+("   City").PadRight(25, ' ')+("   Zip").PadRight(25, ' ')+("   Street").PadRight(25, ' '));
			SqlCommand view = new SqlCommand("SELECT * FROM viEmployee", conn);
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				Console.WriteLine(" ");
				foreach (DataRow row in dt.Rows)
				{
					for (int i = 0; i < dt.Columns.Count; i++)
					{
						Console.Write("   " + (row[i].ToString()).PadRight(25, ' '));
					}
					Console.WriteLine();
				}
			}
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}

		private void DeleteEmployee(SqlConnection conn)
		{
			try
			{
				Console.WriteLine("Please insert the Id of the Employee you want to delete:");
				string tempEmployee = Console.ReadLine();
				int EmployeeId;
				Int32.TryParse(tempEmployee, out EmployeeId);
				using (SqlCommand command = new SqlCommand("DELETE FROM Employee WHERE Employee.Id = '" + EmployeeId + "'", conn))
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

		void CreatingOrUpdatingEmployee(SqlConnection conn)
		{
			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateEmployee", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
					Console.WriteLine("Enter the Id of the an existing person if you want to change something, and only press enter to generate a new person:");
						string tempEmployee = Console.ReadLine();
						int EmployeeId;
						Int32.TryParse(tempEmployee, out EmployeeId);
						insertCommand.Parameters.AddWithValue("@Id", (EmployeeId == 0) ? -1 : EmployeeId);
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the first name of the Employee:");
						insertCommand.Parameters.Add("@FirstName", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the last name of the Employee:");
						insertCommand.Parameters.Add("@LastName", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the birthday of the Employee and use this syntax YYYY-MM-DD:");
						insertCommand.Parameters.Add("@Birthday", System.Data.SqlDbType.Date).Value = Console.ReadLine();
				Console.WriteLine(" ");
					Console.WriteLine("Please enter the gender of the Employee ..");
					Console.WriteLine("enter '1' for male");
					Console.WriteLine("enter '2' for female");
					Console.WriteLine("enter '3' for something else");
						string tempGender = Console.ReadLine();
						int Gender;
						Int32.TryParse(tempGender, out Gender);
						insertCommand.Parameters.AddWithValue("@Gender", (Gender == 0) ? -1 : Gender);
				Console.WriteLine(" ");
					Console.WriteLine("Enter the Id of the an existing person if you want to change something, and only press enter to generate a new person:");
						string dId = Console.ReadLine();
						int dIdAsInt;
						Int32.TryParse(dId, out dIdAsInt);
						insertCommand.Parameters.AddWithValue("@DepartementId", (dIdAsInt == 0) ? -1 : dIdAsInt);
				insertCommand.ExecuteNonQuery();
			}
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}
