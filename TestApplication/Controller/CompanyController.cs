using System;
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
								Console.Write(c.Name == null ? "Name not found\t" : c.Name + "\t");
								Console.Write(c.Id == 0 ? "Id not found\t" : c.Id + "\t");
								Console.Write(c.CreatedTime == null ? "CreatedTime not found\t" : c.CreatedTime + "\t");
								Console.Write(c.Country == null ? "Country not found\t" : c.Country + "\t");
								Console.Write(c.City == null ? "City not found\t" : c.City + "\t");
								Console.Write(c.Zip == 0 ? "Zip not found\t" : c.Zip + "\t");
								Console.Write(c.Street == null ? "Street not found\t" : c.Street + "\t");
								Console.Write(c.DepartementName == null ? "DepartementName not found\t" : c.DepartementName + "\t");
								Console.Write(c.ManagerId == 0 ? "ManagerId not found\t" : c.ManagerId + "\t");
							}
							break;
						case '2':
							Console.WriteLine(" ");
							DataTable dt = Company.ReadCompany();
							Console.WriteLine(("   Id").PadRight(25, ' ') + ("   Name").PadRight(25, ' ') + ("   CreatedTimed").PadRight(25, ' ') + ("   Country").PadRight(25, ' ') + ("   City").PadRight(25, ' ') + ("   Zip").PadRight(25, ' ') + ("   Street").PadRight(25, ' ') + ("   Departement").PadRight(25, ' '));
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
							Console.WriteLine(" ");
							Console.WriteLine("Please insert the Id of the Compony you want to delete:");
							string DeleteTempCompany = Console.ReadLine();
							int DeleteCompanyId;
							Int32.TryParse(DeleteTempCompany, out DeleteCompanyId);
							try
							{
								Company.DeleteCompany(DeleteCompanyId);
								Console.WriteLine("successfully deleted! Press enter to go to the menu ");
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