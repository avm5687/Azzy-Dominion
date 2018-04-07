import java.sql.*;
import oracle.jdbc.*;
import oracle.jdbc.pool.OracleDataSource;
// Weimport java.io to be able to read from the command line
import java.io.*;
import java.util.Scanner;
import javax.swing.JOptionPane;
class hw6
{
	public static void main(String[] args) throws Exception
	{
		String[] array = {"Student Number", "Name", "Standing", "GPA"};
		Scanner sc = new Scanner(System.in);
		System.out.println("Please enter your login information.");
		System.out.print("Connecting to the database...");
		System.out.flush();S
		ystem.out.println("Connecting...");
		OracleDataSource ods = new OracleDataSource();
		ods.setURL("jdbc:oracle:oci:@pdbcldb");
		System.out.print("Username: ");
		String user = sc.next();ods.setUser(user);
		char[] password = System.console().readPassword("Password: ");
		ods.setPassword(String.valueOf(password));

		for (int i = 0; i < password.length; i++) 
			password[i] = ' ';
		Connection conn = ods.getConnection();

		System.out.println("connected.");
		String a = (String) JOptionPane.showInputDialog(null, "Select Option", "Query", JOptionPane.QUESTION_MESSAGE, null, array, array[0]);
		PreparedStatement pStmt = con.prepareStatement("select * from Student" +"where" + a + "=?");
		System.out.println("What would you like to search by?");
		String b = sc.next();
		if(a.equals(array[0]))
			pStmt.setInt(1, Integer.parseInt(b));
		if(a.equals(array[1]) || a.equals(array[2]))
			pStmt.setString(1, b);
		else
			pStmt.setDouble(1, Double.parseDouble(b));


		ResultSet rset = pStmt.executeQuery();
		while (rset.next()) 
		{
			System.out.println(rset.getInt("studentnum") + " " +rset.getString("name") + " " + rset.getString("standing")+ " " +rset.getDouble("gpa"));
		}
		rset.close();
		stmt.close();
		conn.close();
		System.out.println("Goodbye.");
	}
}