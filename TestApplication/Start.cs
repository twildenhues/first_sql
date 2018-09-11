using System;
using System.Data;

namespace TestApplication
{
	class Start
	{
		public static void Main(string[] args) {
			Start application = new Start();
			application.Run();
		}
		private void Run() {
			Repository.CompanyRepository Company = new Repository.CompanyRepository();
			/*Repository.DepartementRepository Departement = new Repository.DepartementRepository();
				Departement.Run();
			Repository.EmployeeRepository Employee = new Repository.EmployeeRepository();
				Employee.Run();
			Repository.AddressRepository Address = new Repository.AddressRepository();
				Address.Run();*/
			bool running = true;
			Intro();
			while (running) {
				char key = Console.ReadKey().KeyChar;
				switch(key){
					case 'C':
					case 'c':
							Console.WriteLine(" ");
								Console.WriteLine("press '1' to add or update a Company");
								Console.WriteLine("press '2' to see all current Companys");
								Console.WriteLine("press '3' to delete a Company");
									char innerKey = Console.ReadKey().KeyChar;
										switch (innerKey)
										{
											case '1':
												Console.WriteLine(" ");
												Company.CreatingOrUpdatingCompany(); ;
												break;
											case '2':
												Console.WriteLine(" ");
												DataTable dt = Company.ReadCompany();
												foreach (DataRow row in dt.Rows)
												{
													for (int i = 0; i < dt.Columns.Count; i++)
													{
														Console.Write(("   " + row[i].ToString()).PadRight(25, ' '));
													}
													Console.WriteLine();
												}
												Console.WriteLine(" ");
												Console.WriteLine("Finished! Now press enter to clear!");
												Console.ReadLine();
												Console.Clear();
												break;
											case '3':
							
												break;
											default:
													Console.WriteLine(" ");
													Console.WriteLine("Falsche Eingabe");
												break;
										}
							Console.Clear();
							Intro();
						break;
					case 'D':
					case 'd':
							Console.WriteLine(" ");
							Console.Clear();
							Intro();
						break;
					case 'E':
					case 'e':
							Console.WriteLine(" ");
							Console.Clear();
							Intro();
						break;
					case 'A':
					case 'a':
							Console.WriteLine(" ");
							Console.Clear();
							Intro();
						break;
					case 'x':
							running = false;
						break;
					default:
							Console.WriteLine(" ");
							Console.WriteLine("Falsche Eingabe");
						break;

				}
			}
		}
		private void Intro() {
			Console.WriteLine("press 'C' or 'c' to access the Company");
			Console.WriteLine("press 'D' or 'd' to access the Departement");
			Console.WriteLine("press 'E' or 'e' to access the Employee");
			Console.WriteLine("press 'A' or 'a' to access the Address");
			Console.WriteLine("press 'x' to close the Window");
		}
	}
}
