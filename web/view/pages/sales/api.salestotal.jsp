<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="tokoatk.DbConnection"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String salesId = request.getParameter("salesId");
    if (salesId == null || salesId.trim().isEmpty()) {
        out.print("0");
        return;
    }
    
    salesId = salesId.trim(); // Bersihkan whitespace
    Connection conn = null;
    PreparedStatement st = null;
    ResultSet rs = null;
    
    try {
        conn = DbConnection.connect();
        if (conn == null) {
            out.print("ERROR: Koneksi database gagal");
            return;
        }
        
        String sql = "SELECT qty, harga FROM salesd WHERE salesId = ?";
        st = conn.prepareStatement(sql);
        st.setString(1, salesId);
        rs = st.executeQuery();
        
        int total = 0;
        int count = 0;
        
        while (rs.next()) {
            int qty = rs.getInt("qty");
            int harga = rs.getInt("harga");
            int subtotal = qty * harga;
            total += subtotal;
            count++;
        }
        
        out.print(total);
        
    } catch (SQLException e) {
        out.print("ERROR: Database error - " + e.getMessage());
    } catch (Exception e) {
        out.print("ERROR: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            // Log error penutupan jika diperlukan
        }
    }
%>