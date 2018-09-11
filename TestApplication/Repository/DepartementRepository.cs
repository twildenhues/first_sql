using System;
using System.Data.SqlClient;
using System.Data;

namespace TestApplication.Repository
{
	class DepartementRepository
	{

		static void Main(string[] args)
		{
			DepartementRepository test = new DepartementRepository();
			Console.WriteLine("press '1' to add or update a Departement");
			Console.WriteLine("press '2' to see all current Departements");
			Console.WriteLine("press '3' to delete a Departement");
			char key = Console.ReadKey().KeyChar;
			using (SqlConnection conn = new SqlConnection())
			{
				conn.ConnectionString = "Data Source=tappqa;Initial Catalog=Training-TW-Company;Integrated Security=True";
				conn.Open();
				switch (key)
				{
					case '1':
						Console.WriteLine(" ");
						test.CreatingOrUpdatingDepartement(conn);
						break;
					case '2':
						Console.WriteLine(" ");
						test.ReadDepartement(conn);
						break;
					case '3':
						Console.WriteLine(" ");
						test.DeleteDepartement(conn);
						break;
					default:
						Console.WriteLine(" ");
						Console.WriteLine("Falsche Eingabe");
						break;
				}
			}
		}

		private void ReadDepartement(SqlConnection conn)
		{
			Console.WriteLine(("   Id").PadRight(25, ' ') + ("   CompanyId").PadRight(25, ' ') + ("   ManagerId").PadRight(25, ' ') + ("   DepartementName").PadRight(25, ' ') + ("   CreatedTime").PadRight(25, ' ') + ("   First Name").PadRight(25, ' ') + ("   Last Name").PadRight(25, ' ') + ("   Gender").PadRight(25, ' '));
			SqlCommand view = new SqlCommand("SELECT * FROM viDepartement", conn);
			using (SqlDataAdapter a = new SqlDataAdapter(view))
			{
				DataTable dt = new DataTable();
				a.Fill(dt);
				Console.WriteLine(" ");
				foreach (DataRow row in dt.Rows)
				{
					for (int i = 0; i < dt.Columns.Count; i++)
					{
						Console.Write("   " + (row[i].ToString()).PadRight(25, ' '));
					}
					Console.WriteLine();

				}
			}
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}

		private void DeleteDepartement(SqlConnection conn)
		{
			try
			{
				Console.WriteLine("Please insert the Id of the Compony you want to delete:");
				string tempDepartement = Console.ReadLine();
				int DepartementId;
				Int32.TryParse(tempDepartement, out DepartementId);
				using (SqlCommand command = new SqlCommand("DELETE FROM Departement WHERE Departement.Id = '" + DepartementId + "'", conn))
				{
					Console.WriteLine("successfully deleted ");
					command.ExecuteNonQuery();
				}
				conn.Close();

			}
			catch (SystemException ex)
			{
				Console.WriteLine(string.Format("An error occurred: {0}", ex.Message));
			}
		}

		void CreatingOrUpdatingDepartement(SqlConnection conn)
		{
			using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateDepartement", conn))
			{
				insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
				Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Departement. Else just press enter to generate a new Departement:");
				string tempDepartement = Console.ReadLine();
				int DepartementId;
				Int32.TryParse(tempDepartement, out DepartementId);
				insertCommand.Parameters.AddWithValue("@Id", (DepartementId == 0) ? -1 : DepartementId);
				Console.WriteLine(" ");
				Console.WriteLine("Please enter the name of the Departement:");
				insertCommand.Parameters.Add("@Name", SqlDbType.NVarChar).Value = Console.ReadLine();
				Console.WriteLine(" ");
				Console.WriteLine("Please enter the Id of the Company this Departement belongs to. If you want to do it later, press enter:");
				string temp = Console.ReadLine();
				int id;
				Int32.TryParse(temp, out id);
				insertCommand.Parameters.AddWithValue("@CompanyId", (id == 0) ? -1 : id);
				Console.WriteLine(" ");
				Console.WriteLine("Please enter the PersonId that belongs to the Manager in this Apartement. You can skip this by pressing enter:");
				insertCommand.Parameters.Add("@ManagerId", SqlDbType.NVarChar).Value = Console.ReadLine();

				insertCommand.ExecuteNonQuery();
			}
			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}