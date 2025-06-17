package tokoatk;

import java.sql.*;
import java.util.ArrayList;

public class User {

    public String username;
    public String fullname;

     public boolean login(String username, String password) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "SELECT * from users where username=? and md5(?)=password";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            rs = st.executeQuery();

            boolean result = rs.next();
            this.username = username;
            this.fullname = rs.getString("fullname");
            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean baca(String username) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "SELECT * from users where username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            rs = st.executeQuery();

            boolean result = rs.next();
            this.username = username;
            this.fullname = rs.getString("fullname");
            conn.close();

            return result;
        } catch (Exception ex) {
            return false;
        }
    }

    public String getFullname() {
        return this.fullname;
    }

    public String getUsername() {
        return this.username;
    }

    public boolean update() {
       
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "UPDATE users set fullname=? where username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, fullname);
            st.setString(2, this.username);

            st.executeUpdate();

            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    public boolean updatePassword(String password) {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "UPDATE users set password=md5(?) where username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, username);

            st.executeUpdate();

            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "DELETE FROM users where username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);

            st.executeUpdate();

            conn.close();

            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean tambah(String password) {
        Connection conn = null;
        PreparedStatement st;

        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "INSERT INTO users (username,fullname,password) values (?,?,MD5(?))";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, fullname);
            st.setString(3, password);
            st.executeUpdate();
            conn.close();
            
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
    
    public static ArrayList<User> getList() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<User> result = new ArrayList<User>();

        try {
            conn = DbConnection.connect();

            // prepare select statement
            String sql = "SELECT * from users";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while(rs.next()) {
                User entry = new User();
                entry.baca(rs.getString("username"));
                result.add(entry);
            }
            conn.close();

            return result;
        } catch (Exception ex) {
            return null;
        }
    }
}