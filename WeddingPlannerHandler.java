import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
public class WeddingPlannerHandler {
//this is where the driver is and where i am going to read data from sql
String dbUrl = "jdbc:mysql://localhost:3306/weddingPlanner";
String dbClass="com.mysql.cj.jdbc.Driver";	//JDBC driver name 
	
Connection con;
Statement  stat;//reserve a space for my database
String query;

	
   public void connect() {
	   System.out.println("connect()...");//because i have too many methods so this print line just for readability 
	   try {
		   Class.forName(dbClass).getDeclaredConstructor().newInstance();//load a new Driver class
		   con = DriverManager.getConnection(dbUrl , "root" , "EBGHASAS7");// DB & username & password
		   stat = con.createStatement();// we create a statement to select /insert/update/delete from sql
	   }
	   catch (SQLException e) {
		   e.printStackTrace();
	   }
	   catch (Exception e) {
		   e.printStackTrace();
	   }
   }//connect method end 
public void disconnect() {//to disconnet the connection with sql
	System.out.println("disconnect()...");
	try {
		if(!(con.isClosed())) {
			con.close();
		}
	} 
	catch(Exception e) {
		e.printStackTrace();
	}
}//disconnect method end

public void getCustomer() {// one of our tables called customer and wanna get it's data 
	System.out.println("getCustomer() ....");//to know where we are 
	String customerData="";
	String query="SELECT * FROM customer";//to get all the data inside customer
	ResultSet rs ;//built in class called resultset that has the pointer to wail through my data 
	
	//before getting any data from any database we should establish the connection and finish it after being done 
	try {
		connect();
		rs = stat.executeQuery(query);
		while(rs.next()) {
			customerData+= rs.getObject(1).toString()+" ";
			customerData+= rs.getObject(2).toString()+" ";
			customerData+= rs.getObject(3).toString()+" ";
		}
		System.out.println(customerData);
	} 
	catch(Exception e) {
		e.printStackTrace();
	}
	disconnect();
}//end of getCustomer

public void insertCustomer() {
	System.out.println("insertCustomer()...");
	String query="insert into Customer values('100','Cyrine','Alsaket' )";
	String q3= "insert into EventSupplier values('101','403','2500','30')";
	try {
		connect();
		stat.executeUpdate(query);
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	disconnect();
	
	
}//end of insetCustomer method
public void insertEventSupplier() {
	System.out.println("insertEventSupplier()...");
	String q3= "insert into EventSupplier values('102','404','2500','30')";
	
	try {
		connect();
		stat.executeUpdate(q3);
		
	} catch(Exception e) {
		e.printStackTrace();
	}
	disconnect();
}
public void deleteEventSupplier() {
    System.out.println("deleteEventSupplier()...");
    try {
        connect();

        // Delete by EventID and SupplierID (both needed since they are composite PK)
        String query = "DELETE FROM EventSupplier " +
                       "WHERE EventID = 101 AND SupplierID = 402";
        stat.executeUpdate(query);

        System.out.println("EventSupplier row deleted successfully!");

    } catch (Exception e) {
        e.printStackTrace();
    }
    disconnect();
}

public void DeletePk() {
	System.out.println("DeletePK is on ....");
	int customerID =7;
	
	try {
		connect();
		//delete from deepest child which is payment
		String q1="DELETE from payment WHERE EventID IN"+
		"(SELECT EventID FROM Event Where customerID ="+customerID+")";
		
		stat.executeUpdate(q1);
		
		String q2 = "DELETE FROM EventSupplier WHERE EventID IN " +
	            "(SELECT EventID FROM Event WHERE CustomerID ="+ customerID +")";
		stat.executeUpdate(q2);	
		
		String q3="DELETE From Event WHERE CustomerID = "+customerID;
		stat.executeUpdate(q3);
		
		String q4="DELETE FROM CustomerPhone WHERE CustomerID = "+customerID;
		stat.executeUpdate(q4);
		
		String q5="DELETE FROM Customer WHERE CustomerID="+customerID;
		stat.executeUpdate(q5);
		
		System.out.println("Customer " +customerID+ " deleted successfully!");
		
	} catch(Exception e){
		e.printStackTrace();
		
	}
	disconnect();
}// end of deletePk method

}
