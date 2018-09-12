using System;
using System.Collections.Generic;
using System.Data;

namespace TestApplication
{
	class CompanyController
	{
		public static void Main(string[] args)
		{
			CompanyController application = new CompanyController();
			application.Run();
		}
		public void Run()
		{
			using (Repository.CompanyRepository Company = new Repository.CompanyRepository())
			{
				bool running = true;
				while (running)
				{
					Console.WriteLine(" ");
					Console.WriteLine("press '1' to add or update a Company");
					Console.WriteLine("press '2' to see all current Companys");
					Console.WriteLine("press '3' to delete a Company");
					Console.WriteLine("press 'x' to go back to the menu");
					char innerKey = Console.ReadKey().KeyChar;
					switch (innerKey)
					{
						case '1':
							Console.WriteLine(" ");
							Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Company. Else just press enter to generate a new Company");
							string tempCompany = Console.ReadLine();
							int CompanyId;
							Int32.TryParse(tempCompany, out CompanyId);
							Console.WriteLine(" ");
							Console.WriteLine("Please enter the name of the Company:");
							string value = Console.ReadLine();
							var c = Company.CreatingOrUpdatingCompany(CompanyId, value);
							if (c != null)
							{
								
								Console.WriteLine("Die Company Wurde erstellt!");
								Console.Write(c.Name == null ? "---\t" : c.Name + "\t");
								Console.Write(c.Id == 0 ? "---\t" : c.Id + "\t");
								Console.Write(c.CreatedTime == null ? "---\t" : c.CreatedTime + "\t");
								Console.Write(c.Country == null ? "---\t" : c.Country + "\t");
								Console.Write(c.City == null ? "---\t" : c.City + "\t");
								Console.Write(c.Zip == 0 ? "---\t" : c.Zip + "\t");
								Console.Write(c.Street == null ? "---\t" : c.Street + "\t");
								Console.Write(c.DepartementName == null ? "---\t" : c.DepartementName + "\t");
								Console.Write(c.ManagerId == 0 ? "---\t" : c.ManagerId + "\t");
							}
							break;
						case '2':
							Console.WriteLine(" ");
							List<Models.Company> dt = Company.ReadCompany();
							Console.WriteLine(("   Id").PadRight(10, ' ') + ("   Name").PadRight(10, ' ') + ("   CreatedTimed").PadRight(10, ' ') + ("   Country").PadRight(10, ' ') + ("   City").PadRight(10, ' ') + ("   Zip").PadRight(10, ' ') + ("   Street").PadRight(10, ' ') + ("   Departement").PadRight(10, ' '));
							if (dt != null)
							{
								foreach (Models.Company content in dt)
								{
									Console.Write(content.Id == 0 ? "---\t" : content.Id + "\t");
									Console.Write(content.Name == null ? "---\t" : content.Name + "\t");
									Console.Write(content.CreatedTime == null ? "---\t" : content.CreatedTime + "\t");
									Console.Write(content.Country == null ? "---\t" : content.Country + "\t");
									Console.Write(content.City == null ? "---\t" : content.City + "\t");
									Console.Write(content.Zip == 0 ? "---\t" : content.Zip + "\t");
									Console.Write(content.Street == null ? "---\t" : content.Street + "\t");
									Console.Write(content.DepartementName == null ? "---\t" : content.DepartementName + "\t");
									Console.Write(content.ManagerId == 0 ? "---\t" : content.ManagerId + "\t");
									Console.WriteLine(" ");
								}
							}
							Console.WriteLine(" ");
							Console.WriteLine("Finished! Now press enter to clear!");
							Console.ReadLine();
							Console.Clear();
							break;
						case '3':
							Console.WriteLine(" ");
							Console.WriteLine("Please insert the Id of the Compony you want to delete:");
							string DeleteTempCompany = Console.ReadLine();
							int DeleteCompanyId;
							Int32.TryParse(DeleteTempCompany, out DeleteCompanyId);
							try
							{
								bool success = Company.DeleteCompany(DeleteCompanyId);
								if (success) {
									Console.WriteLine("successfully deleted! Press enter to go to the menu ");
								}else {
									Console.WriteLine("deletion failed! Press enter to go to the menu");
								}

								Console.ReadLine();
								Console.Clear();

							}
							catch (SystemException ex)
							{
								Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
							}
							break;
						case 'x':
							Console.Clear();
							running = false;
							break;
						default:
							Console.WriteLine(" ");
							Console.WriteLine("Falsche Eingabe");
							break;
					}
				}
			}
		}
	}
}