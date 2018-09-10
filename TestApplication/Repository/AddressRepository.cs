using System;
using System.Data.SqlClient;

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
						test.CreatingOrUpdatingAddress(); ;
						break;
					case '2':
						test.ReadAddress(); ;
						break;

					default:
						test.DeleteAddress(); ;
						break;
				}
			}
		}

		private void ReadAddress()
		{
			throw new NotImplementedException();
		}

		private void DeleteAddress()
		{
			throw new NotImplementedException();
		}

		void CreatingOrUpdatingAddress()
		{
			Console.WriteLine("Data displayed! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}

}
