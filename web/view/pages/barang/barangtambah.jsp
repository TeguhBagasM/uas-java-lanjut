<%@page import="tokoatk.Barang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String nama = request.getParameter("nama");
    String jenis = request.getParameter("jenis");
    String hargaStr = request.getParameter("harga");
    Integer harga = hargaStr != null ? Integer.parseInt(hargaStr) : 0;

    if (nama != null && jenis != null) {
        Barang barang = new Barang();
        barang.setNama(nama);
        barang.setJenis(jenis);
        barang.setHarga(harga);
        boolean success = barang.tambah();
        if (success) {
            session.setAttribute("message", "success");
        } else {
            session.setAttribute("message", "error");
        }
        response.sendRedirect("baranglist.jsp");
    } else {
        session.setAttribute("message", "error");
        response.sendRedirect("baranglist.jsp");
    }
%>