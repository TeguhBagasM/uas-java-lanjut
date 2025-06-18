<%@page import="tokoatk.Barang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String id = request.getParameter("id");
    if (id != null) {
        Barang barang = new Barang();
        barang.setId(id);
        boolean success = barang.hapus();
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