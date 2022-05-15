package electro.db;

import java.sql.*;

public class DatabaseConnection {
	
	private static Connection connection;

	public static Connection getDBConnection() throws ClassNotFoundException, SQLException {

		// This creates new connection object when connection is closed or it is null
		if (connection == null || connection.isClosed()) {
			Class.forName("com.mysql.jdbc.Driver");
			//db drive and database , user and password
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/electro", "root", "");
		}
		
		return connection;
	}

}
