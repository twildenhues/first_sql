using System;
using System.Data.SqlClient;
using System.Data;

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
				switch (key)
				{
					case '1':
						test.CreatingOrUpdatingDepartement(conn); ;
						break;
					case '2':
						test.ReadDepartement(conn);
						break;
					case '3':
						test.DeleteDepartement(conn); 
						break;
					default:
						Console.WriteLine("Falsche Eingabe"); 
						break;
				}
			}
		}

		private void ReadDepartement(SqlConnection conn)
		{
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
						Console.Write(row[i].ToString() + "\t");
					}
					Console.WriteLine();
					conn.Close();
				}
			}
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
		using (SqlCommand insertCommand = new SqlCommand("dbo.spCreateOrUpdateCompany", conn))
		{
			insertCommand.CommandType = System.Data.CommandType.StoredProcedure;
			Console.WriteLine(" ");
				Console.WriteLine("Please enter now the Id, if you want to change the name of an existing Departement. Else just press enter to generate a new Departement:");
					string tempDepartement = Console.ReadLine();
					int DepartementId;
					Int32.TryParse(tempDepartement, out DepartementId);
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

			conn.Close();
			Console.WriteLine("Finished! Now press enter to clear!");
			Console.ReadLine();
			Console.Clear();
		}
	}
}