using System;
using System.Data.SqlClient;

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
							test.CreatingOrUpdatingEmployee(); ;
						break;
					case '2':
							test.ReadEmployee(); ;
						break;

					case '3':
							test.DeleteEmployee(); ;
						break;
					default:
							Console.WriteLine("Falsche Eingabe");
						break;
				}	
			}
		}

		private void ReadEmployee()
		{
			throw new NotImplementedException();
		}

		private void DeleteEmployee()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingEmployee()
		{
			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}

}
