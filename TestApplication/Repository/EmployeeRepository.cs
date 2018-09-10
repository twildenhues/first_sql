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
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
							test.CreatingOrUpdatingEmployee(conn); ;
						break;
					case '2':
							test.ReadEmployee(conn); ;
						break;
					case '3':
							test.DeleteEmployee();
						break;
					default:
						Console.WriteLine("Falsche Eingabe");
						break;
				}	
			}
		}

		private void ReadEmployee(SqlConnection conn)
		{
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
						Console.Write(row[i].ToString() + "\t");
					}
					Console.WriteLine();
				}
			}
		}

		private void DeleteEmployee()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingEmployee(SqlConnection conn)
		{
			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;

				Console.WriteLine(" ");
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
			}

			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}

}
