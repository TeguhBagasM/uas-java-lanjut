<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    try {
        ArrayList<Barang> list = Barang.getList();
        
        int banyak = (list != null) ? list.size() : 0;
        int total = 0;
        double rata2 = 0.0;
        
        if (banyak > 0) {
            for (Barang barang : list) {
                total += (barang.getHarga() != null) ? barang.getHarga() : 0;
            }
            rata2 = (double) total / banyak;
        }
        
        // Format rata2 dengan 2 desimal
        String jsonResponse = String.format("{\"banyak\": %d, \"rata2\": %.2f}", banyak, rata2);
        out.print(jsonResponse);
        
    } catch (Exception e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.print("{\"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
    }
%>