package tokoatk;

import java.sql.*;
import java.util.ArrayList;

public class User {
    private int id; 
    public String username;
    public String fullname;

    // Konstruktor default
    public User() {
    }

    // Konstruktor dengan parameter
    public User(int id, String username, String fullname) {
        this.id = id;
        this.username = username;
        this.fullname = fullname;
    }

    // Getter dan Setter untuk id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean login(String username, String password) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * from users where username=? and md5(?)=password";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            rs = st.executeQuery();

            boolean result = rs.next();
            if (result) {
                this.id = rs.getInt("id"); // Ambil id
                this.username = username;
                this.fullname = rs.getString("fullname");
            }
            conn.close();
            return result;
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
            String sql = "SELECT * from users where username=?";
            st = conn.prepareStatement(sql);
            st.setString(1, username);
            rs = st.executeQuery();

            boolean result = rs.next();
            if (result) {
                this.id = rs.getInt("id"); // Ambil id
                this.username = username;
                this.fullname = rs.getString("fullname");
            }
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
        ArrayList<User> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT id, username, fullname from users"; // Ambil id
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                User entry = new User();
                entry.id = rs.getInt("id"); // Set id
                entry.username = rs.getString("username");
                entry.fullname = rs.getString("fullname");
                result.add(entry);
            }
            conn.close();
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}