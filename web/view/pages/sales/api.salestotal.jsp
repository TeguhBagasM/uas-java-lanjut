<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<%
    String salesId = request.getParameter("salesId");
    System.out.println("Menerima salesId: " + salesId + " pada " + new java.util.Date());

    if (salesId == null || salesId.trim().isEmpty()) {
        System.out.println("salesId null atau kosong");
        out.print("0");
        return;
    }

    Sales sales = new Sales();
    try {
        if (sales.baca(salesId)) {
            System.out.println("Sales ditemukan untuk ID: " + salesId);
            ArrayList<SalesDetail> details = sales.getDetail();
            int total = 0;
            if (details != null) {
                System.out.println("Jumlah detail: " + details.size());
                for (SalesDetail detail : details) {
                    if (detail != null) {
                        int qty = (detail.getQty() != null) ? detail.getQty() : 0;
                        int harga = (detail.getHarga() != null) ? detail.getHarga() : 0;
                        int itemTotal = qty * harga;
                        total += itemTotal;
                        System.out.println("Detail - qty: " + qty + ", harga: " + harga + ", total: " + itemTotal);
                    } else {
                        System.out.println("Detail null untuk salesId: " + salesId);
                    }
                }
            } else {
                System.out.println("Detail list null untuk salesId: " + salesId);
            }
            System.out.println("Total akhir: " + total);
            out.print(total);
        } else {
            System.out.println("Sales tidak ditemukan untuk ID: " + salesId);
            out.print("0");
        }
    } catch (Exception e) {
        System.out.println("Exception di api.salestotal.jsp: " + e.getMessage());
        e.printStackTrace(new java.io.PrintWriter(System.out));
        out.print("0");
    }
%>