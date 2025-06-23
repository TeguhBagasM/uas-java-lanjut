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
            }
        } else {
            out.print("fail");
        }
    } else {
        out.print("fail");
    }
%>