using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestApp
{
	class Program
	{
		static void Main(string[] args)
		{
			SqlConnection myConnection = new SqlConnection("user id=username;" +
									   "password=password;server=serverurl;" +
									   "Trusted_Connection=yes;" +
									   "database=database; " +
									   "connection timeout=30");
		}
	}
}
