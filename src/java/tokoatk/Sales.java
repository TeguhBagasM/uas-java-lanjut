package tokoatk;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Sales {
    private String id;
    private LocalDateTime waktu;
    private String username;

    public Sales() {}

    public String getId() { return id; }
    public LocalDateTime getWaktu() { return waktu; }
    public String getUsername() { return username; }

    public boolean baca(String id) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesm WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            rs = st.executeQuery();

            boolean result = rs.next();
            if (result) {
                this.id = rs.getString("id");
                this.waktu = rs.getTimestamp("waktu") != null ? rs.getTimestamp("waktu").toLocalDateTime() : null;
                this.username = rs.getString("username");
            }
            return result;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (rs != null) rs.close(); if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean tambah(String username) {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            LocalDateTime dt = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmssS");
            this.id = dt.format(formatter);
            this.waktu = dt; // Set waktu saat ini

            String sql = "INSERT INTO salesm (id, waktu, username) VALUES (?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.id);
            st.setTimestamp(2, java.sql.Timestamp.valueOf(this.waktu));
            st.setString(3, username);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            String sql = "DELETE FROM salesm WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean addDetail(String barangId, Integer qty, Integer harga) {
        SalesDetail detail = new SalesDetail();
        detail.setSalesId(this.id);
        detail.setBarangId(barangId);
        detail.setQty(qty);
        detail.setHarga(harga);
        return detail.tambah();
    }

    public ArrayList<SalesDetail> getDetail() {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        ArrayList<SalesDetail> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesd WHERE salesId=?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.id);
            rs = st.executeQuery();

            while (rs.next()) {
                SalesDetail entry = new SalesDetail();
                entry.setId(rs.getInt("id"));
                entry.setSalesId(rs.getString("salesId"));
                entry.setBarangId(rs.getString("barangId"));
                entry.setQty(rs.getInt("qty"));
                entry.setHarga(rs.getInt("harga"));
                result.add(entry);
            }
            return result;
        } catch (Exception ex) {
            return null;
        } finally {
            try { if (rs != null) rs.close(); if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public static ArrayList<Sales> getList() {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        ArrayList<Sales> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesm";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                Sales entry = new Sales();
                entry.baca(rs.getString("id"));
                result.add(entry);
            }
            return result;
        } catch (Exception ex) {
            return null;
        } finally {
            try { if (rs != null) rs.close(); if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}