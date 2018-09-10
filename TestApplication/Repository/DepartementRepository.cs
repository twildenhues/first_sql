using System;
using System.Data.SqlClient;

	class DepartementRepository
	{

		static void Main(string[] args)
		{
			DepartementRepository test = new DepartementRepository();
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
						test.CreatingOrUpdatingDepartement(); ;
						break;
					case '2':
						test.ReadDepartement(); ;
						break;

					default:
						test.DeleteDepartement(); ;
						break;
				}
			}
		}

		private void ReadDepartement()
		{
			throw new NotImplementedException();
		}

		private void DeleteDepartement()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingDepartement()
		{
			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}