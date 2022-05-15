package electro.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONObject;

import electro.db.DatabaseConnection;
import electro.model.*;

public class PricingService {

	private String success;
	
	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public void addPricing(Pricing pricing) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			connection = DatabaseConnection.getDBConnection();
			
			// insert value
			preparedStatement = connection.prepareStatement("insert into pricing (start_unit,end_unit,price) values (?,?,?)");
			preparedStatement.setInt(1, pricing.getStart_unit());
			preparedStatement.setInt(2, pricing.getEnd_unit());
			double price = 0;
			if((pricing.getEnd_unit()-pricing.getStart_unit())<=50) {
				price=(pricing.getEnd_unit()-pricing.getStart_unit())*10;
			}else if((pricing.getEnd_unit()-pricing.getStart_unit())<=100) {
				price=(pricing.getEnd_unit()-pricing.getStart_unit())*20;
			}else {
				price=(pricing.getEnd_unit()-pricing.getStart_unit())*30;
			}
			preparedStatement.setDouble(3, price);
			preparedStatement.execute();
			preparedStatement.close();
			connection.close();
			setSuccess("success");

		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public String getPricing() {
		
		ArrayList<Pricing> PricingList = new ArrayList<Pricing>();
		Connection connection;
		PreparedStatement preparedStatement;
		String table="";
		
		try {
			//view Pricing
			connection = DatabaseConnection.getDBConnection();
			preparedStatement = connection.prepareStatement("SELECT * FROM pricing");

			ResultSet resultSet = preparedStatement.executeQuery();
			
			table = "<table class='table'><thead>"
		            +"<tr>"
		            +"<th >ID</th>"
	                +"<th >Start Unit</th>"
	                +"<th >End Unit</th>"
	                +"<th >Price</th>"
	                +"<th >Action</th>"
	                +"</tr>"
	            +"</thead><tbody>";
			
			while (resultSet.next()) {
				
				String button = "<button type='button' onclick='edit("+resultSet.getString(1)+")' class='btn btn-primary'>Edit</button><br><button type='button' onclick='deletes("+resultSet.getString(1)+")' class='btn btn-warning'>Delete</button>";
				
				table = table+"<tr><td >"+resultSet.getString(1)+"</td>"
						+ "<td >"+resultSet.getString(2)+"</td>"
						+ "<td >"+resultSet.getString(3)+"</td>"
						+ "<td >"+resultSet.getString(4)+"</td>"
						+ "<td >"+button+"</td>"
					  + "</tr>";
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return table+"</table>";
	}


	public void editPricing(Pricing pricing) {
		Connection connection;
		PreparedStatement preparedStatement;

		try {
			connection = DatabaseConnection.getDBConnection();
			
				//update Pricing
				preparedStatement = connection.prepareStatement("UPDATE pricing SET start_unit=?,end_unit=?,price=? where id=?");
				preparedStatement.setInt(1, pricing.getStart_unit());
				preparedStatement.setInt(2, pricing.getEnd_unit());
				double price = 0;
				if((pricing.getEnd_unit()-pricing.getStart_unit())<=50) {
					price=(pricing.getEnd_unit()-pricing.getStart_unit())*10;
				}else if((pricing.getEnd_unit()-pricing.getStart_unit())<=100) {
					price=(pricing.getEnd_unit()-pricing.getStart_unit())*20;
				}else {
					price=(pricing.getEnd_unit()-pricing.getStart_unit())*30;
				}
				preparedStatement.setDouble(3, price);
				preparedStatement.setInt(4,pricing.getId());
				preparedStatement.execute();
				preparedStatement.close();
				connection.close();
				setSuccess("success");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			System.out.println(e.getMessage());
		}
	}

	public void deletePricing(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			connection = DatabaseConnection.getDBConnection();
			
			//delete Pricing
			preparedStatement = connection.prepareStatement("DELETE FROM pricing WHERE id=?");
			preparedStatement.setInt(1, id);
			preparedStatement.execute();
			setSuccess("success");
		
		}catch (ClassNotFoundException | SQLException  e) {
			System.out.println(e.getMessage());
		}
	}

	public JSONObject getOneUser(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		JSONObject json = new JSONObject();
		
		try {
			connection = DatabaseConnection.getDBConnection();
			
			preparedStatement = connection.prepareStatement("SELECT * FROM pricing where id=?");
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next())
			{
				json.put("id", rs.getInt(1));
				json.put("start", rs.getInt(2));
				json.put("end", rs.getInt(3));

			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess("unsuccess");
		}
		return json;
	}

	
}
