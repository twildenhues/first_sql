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
			Console.WriteLine("press 'C' or 'c' to access the Company");
			Console.WriteLine("press 'D' or 'd' to access the Departement");
			Console.WriteLine("press 'E' or 'e' to access the Employee");
			Console.WriteLine("press 'A' or 'a' to access the Address");
			Console.WriteLine("press 'x' to close the Window");
			while (running) {
				char key = Console.ReadKey().KeyChar;
				switch(key){
					case 'C':
							Repository.CompanyRepository uCompany = new Repository.CompanyRepository();
						break;
					case 'c':
						Repository.CompanyRepository lCompany = new Repository.CompanyRepository();
						break;
					case 'D':
						Repository.DepartementRepository uDepartement = new Repository.DepartementRepository();
						break;
					case 'd':
						Repository.DepartementRepository lDepartement = new Repository.DepartementRepository();
						break;
					case 'E':
							Repository.EmployeeRepository uEmployee = new Repository.EmployeeRepository();
						break;
					case 'e': Repository.EmployeeRepository lEmployee = new Repository.EmployeeRepository();
						break;
					case 'A': Repository.AddressRepository uAddress = new Repository.AddressRepository();
						break;
					case 'a': Repository.AddressRepository lAddress = new Repository.AddressRepository();
						break;
					case 'x': running = false;
						break;
					default: ;
						break;

				}
			}
		}
	}
}
