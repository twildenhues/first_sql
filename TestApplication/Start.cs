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
			CompanyController Company = new CompanyController();
			Models.Company test = new Models.Company();
			Repository.DepartementRepository Departement = new Repository.DepartementRepository();
			Repository.EmployeeRepository Employee = new Repository.EmployeeRepository();
			Repository.AddressRepository Address = new Repository.AddressRepository();
			bool running = true;
			Intro();
			while (running) {
				char key = Console.ReadKey().KeyChar;
				switch(key){
					case 'C':
					case 'c':
							Company.Run();
							Console.Clear();
							Intro();
						break;
					case 'D':
					case 'd':
							Console.WriteLine(" ");
							Departement.Run();
							Console.Clear();
							Intro();
						break;
					case 'E':
					case 'e':
							Console.WriteLine(" ");
							Employee.Run();
							Console.Clear();
							Intro();
						break;
					case 'A':
					case 'a':
							Console.WriteLine(" ");
							Address.Run();
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
