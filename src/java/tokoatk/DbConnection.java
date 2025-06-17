package tokoatk;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
    public static Connection connect() {
        String DBDRIVER = "com.mysql.cj.jdbc.Driver";
        String DBCONNECTION = "jdbc:mysql://localhost:3306/tokoatk";
        String DBUSER = "root";
        String DBPASS = "";

        try {
            Class.forName(DBDRIVER);
            return DriverManager.getConnection(DBCONNECTION, DBUSER, DBPASS);
        } catch(Exception e) {
            throw new IllegalArgumentException("SQL Error");
        }
    }
}