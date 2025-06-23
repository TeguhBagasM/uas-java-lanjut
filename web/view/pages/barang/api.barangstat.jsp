<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
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
    
    // Pastikan output bersih tanpa spasi atau karakter tambahan
    out.print("{\"banyak\": " + banyak + ", \"rata2\": " + rata2 + "}");
%>