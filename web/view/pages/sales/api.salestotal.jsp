<%@page import="tokoatk.Sales"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String salesId = request.getParameter("salesId");

    if (salesId != null && !salesId.trim().isEmpty()) {
        Sales sales = new Sales();
        if (sales.baca(salesId)) { // Memuat data Sales
            ArrayList<SalesDetail> details = sales.getDetail(); // Ambil detail transaksi
            int total = 0;
            if (details != null) {
                for (SalesDetail detail : details) {
                    total += detail.getTotal(); // Gunakan getTotal() yang sudah ada
                }
            }
            out.print(total); // Kembalikan total sebagai teks polos
        } else {
            out.print("0"); // Jika salesId tidak ditemukan
        }
    } else {
        out.print("0"); // Jika salesId tidak valid
    }
%>