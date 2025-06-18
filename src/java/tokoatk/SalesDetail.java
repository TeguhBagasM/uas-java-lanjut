package tokoatk;

import java.sql.*;

public class SalesDetail {
    private Integer id;
    private String salesId;
    private String barangId;
    private Integer qty;
    private Integer harga;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getSalesId() { return salesId; }
    public void setSalesId(String salesId) { this.salesId = salesId; }
    public String getBarangId() { return barangId; }
    public void setBarangId(String barangId) { this.barangId = barangId; }
    public Integer getQty() { return qty; }
    public void setQty(Integer qty) { this.qty = qty; }
    public Integer getHarga() { return harga; }
    public void setHarga(Integer harga) { this.harga = harga; }
    public Integer getTotal() { return harga != null && qty != null ? harga * qty : 0; }
    public String getBarangNama() {
        Barang barang = new Barang();
        barang.baca(barangId);
        return barang.getNama();
    }

    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            String sql = "INSERT INTO salesd (salesId, barangId, qty, harga) VALUES (?, ?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, salesId);
            st.setString(2, barangId);
            st.setInt(3, qty != null ? qty : 0);
            st.setInt(4, harga != null ? harga : 0);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean baca(Integer id) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM salesd WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();

            boolean result = rs.next();
            if (result) {
                this.id = id;
                this.salesId = rs.getString("salesId");
                this.barangId = rs.getString("barangId");
                this.qty = rs.getInt("qty");
                this.harga = rs.getInt("harga");
            }
            return result;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (rs != null) rs.close(); if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            String sql = "DELETE FROM salesd WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}