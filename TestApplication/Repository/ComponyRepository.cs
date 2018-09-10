using System;
using System.Data.SqlClient;

namespace TestApplication.Repository
{
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
				switch (key) {
					case '1':
							test.CreatingOrUpdatingCompony(); ;
						break;
					case '2':
							test.ReadCompony(); ;
						break;

					default:
							test.DeleteCompony(); ;
						break;
				}
			}
		}

		private void ReadCompony()
		{
			throw new NotImplementedException();
		}

		private void DeleteCompony()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingCompony()
		{
			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}

}
