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
			bool running = true;
			Intro();
			while (running) {
				char key = Console.ReadKey().KeyChar;
				switch(key){
					case 'C':
							Repository.CompanyRepository uCompany = new Repository.CompanyRepository();
							Console.WriteLine(" ");
							uCompany.Run();
							Console.Clear();
							Intro();
						break;
					case 'c':
							Repository.CompanyRepository lCompany = new Repository.CompanyRepository();
							Console.WriteLine(" ");
							lCompany.Run();
							Console.Clear();
							Intro();
						break;
					case 'D':
							Repository.DepartementRepository uDepartement = new Repository.DepartementRepository();
							Console.WriteLine(" ");
							uDepartement.Run();
							Console.Clear();
							Intro();
						break;
					case 'd':
							Repository.DepartementRepository lDepartement = new Repository.DepartementRepository();
							Console.WriteLine(" ");
							lDepartement.Run();
							Console.Clear();
							Intro();
						break;
					case 'E':
							Repository.EmployeeRepository uEmployee = new Repository.EmployeeRepository();
							Console.WriteLine(" ");
							uEmployee.Run();
							Console.Clear();
							Intro();
						break;
					case 'e':
							Repository.EmployeeRepository lEmployee = new Repository.EmployeeRepository();
							Console.WriteLine(" ");
							lEmployee.Run();
							Console.Clear();
							Intro();
						break;
					case 'A':
							Repository.AddressRepository uAddress = new Repository.AddressRepository();
							Console.WriteLine(" ");
							uAddress.Run();
							Console.Clear();
							Intro();
						break;
					case 'a':
							Repository.AddressRepository lAddress = new Repository.AddressRepository();
							Console.WriteLine(" ");
							lAddress.Run();
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
