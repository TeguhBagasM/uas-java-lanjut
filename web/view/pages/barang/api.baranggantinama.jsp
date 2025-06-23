<%@page import="tokoatk.Barang"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String namabaru = request.getParameter("namabaru");
    
    if (id != null && namabaru != null && !namabaru.trim().isEmpty()) {
        Barang barang = new Barang();
        if (barang.baca(id)) {
            barang.setNama(namabaru);
            if (barang.update()) {
                out.print("ok");
            } else {
                out.print("fail");
                // Tambahkan logging untuk debug
                System.out.println("Update gagal untuk id: " + id);
            }
        } else {
            out.print("fail");
            System.out.println("Baca gagal untuk id: " + id);
        }
    } else {
        out.print("fail");
        System.out.println("Parameter id atau namabaru null/empty");
    }
%>