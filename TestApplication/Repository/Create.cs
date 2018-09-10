using System;
using System.Data.SqlClient;

class Create
{
	static void Main(string[] args)
	{
		Create test = new Create();
		char key = Console.ReadKey().KeyChar;
		test.Creating(key);
	}

	void Creating(int key)
	{
		using (SqlConnection conn = new SqlConnection())
			Method(key, conn);
		Console.WriteLine("Data displayed! Now press enter to clear!");
		Console.ReadLine();
		Console.Clear();
	}

	private static void Method(int key, SqlConnection conn)
	{
		conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
		conn.Open();
		string queryPlace = "";
		switch (key)
		{
			case '1':
				queryPlace = "dbo.spCreateOrUpdateCompany";
				break;
			case '2':
				queryPlace = "dbo.spCreateOrUpdateDepartement";
				break;
			case '3':
				queryPlace = "dbo.spCreateOrUpdateEmployee";
				break;
			default:
				queryPlace = "dbo.spCreateorUpdateAddress";
				break;
		}

		using (SqlCommand insertCommand = new SqlCommand(queryPlace, conn)) {
			insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
			switch (key)
			{
				case '1':
						Console.WriteLine(" ");
							Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Company. Else just press enter to generate a new Company");
								string tempCompany = Console.ReadLine();
								int CompanyId;
								Int32.TryParse(tempCompany, out CompanyId);
								insertCommand.Parameters.AddWithValue("@Id", (CompanyId == 0) ? -1 : CompanyId);
						Console.WriteLine(" ");
							Console.WriteLine("Please enter the name of the Company:");
								insertCommand.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
					break;
				case '2':
						Console.WriteLine(" ");
							Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Departement. Else just press enter to generate a new Departement:");
								string tempDepartement = Console.ReadLine();
								int DepartementId;
								Int32.TryParse(tempDepartement, out DepartementId);
								Console.WriteLine(DepartementId);
								insertCommand.Parameters.AddWithValue("@Id", (DepartementId == 0) ? -1 : DepartementId);
						Console.WriteLine(" ");
							Console.WriteLine("Please enter the name of the Departement:");
								insertCommand.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = Console.ReadLine();
						Console.WriteLine(" ");
							Console.WriteLine("Please enter the Id of the Company this Departement belongs to. If you want to do it later, press enter:");
								string temp = Console.ReadLine();
								int id;
								Int32.TryParse(temp, out id);
								insertCommand.Parameters.AddWithValue("@CompanyId", (id == 0) ? -1 : id);
					break;
				case '3':
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
					break;
				default:
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
							Console.ReadKey()
					break;
			}

			Console.WriteLine("Commands executed! Total rows affected are " + insertCommand.ExecuteNonQuery());
			Console.WriteLine("Done! Press enter to clear the Console");
			Console.ReadLine();
			Console.Clear();
		};


	}
}