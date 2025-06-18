package tokoatk;

import java.sql.*;
import java.util.ArrayList;

public class Barang {
    private String nama;
    private String jenis;
    private Integer harga;

    // Konstruktor default
    public Barang() {}

    // Getter dan Setter (hapus id)
    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }
    public String getJenis() { return jenis; }
    public void setJenis(String jenis) { this.jenis = jenis; }
    public Integer getHarga() { return harga; }
    public void setHarga(Integer harga) { this.harga = harga != null ? harga : 0; }

    // Metode baca tetap menggunakan id dari database
    public boolean baca(int id) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM barang WHERE id=?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();

            boolean result = rs.next();
            if (result) {
                this.nama = rs.getString("nama");
                this.jenis = rs.getString("jenis");
                this.harga = rs.getInt("harga");
            }
            return result;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (rs != null) rs.close(); if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean update() {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            String sql = "UPDATE barang SET nama=?, jenis=?, harga=? WHERE id=(SELECT id FROM barang WHERE nama=? LIMIT 1)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.nama);
            st.setString(2, this.jenis);
            st.setInt(3, this.harga != null ? this.harga : 0);
            st.setString(4, this.nama); // Menggunakan nama sebagai identifier sementara
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
            String sql = "DELETE FROM barang WHERE id=(SELECT id FROM barang WHERE nama=? LIMIT 1)";
            st = conn.prepareStatement(sql);
            st.setString(1, nama); // Menggunakan nama sebagai identifier sementara
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st = null;

        try {
            conn = DbConnection.connect();
            String sql = "INSERT INTO barang (nama, jenis, harga) VALUES (?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, nama);
            st.setString(2, jenis);
            st.setInt(3, harga != null ? harga : 0);
            int rowsAffected = st.executeStatement();
            return rowsAffected > 0;
        } catch (Exception ex) {
            return false;
        } finally {
            try { if (st != null) st.close(); if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    public static ArrayList<Barang> getList() {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        ArrayList<Barang> result = new ArrayList<>();

        try {
            conn = DbConnection.connect();
            String sql = "SELECT * FROM barang";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while (rs.next()) {
                Barang entry = new Barang();
                entry.nama = rs.getString("nama");
                entry.jenis = rs.getString("jenis");
                entry.harga = rs.getInt("harga");
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