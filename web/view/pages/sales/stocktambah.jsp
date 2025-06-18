<%@page import="tokoatk.Sales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String salesId = request.getParameter("salesId");
    String barangId = request.getParameter("barangId");
    String qtyStr = request.getParameter("qty");
    String hargaStr = request.getParameter("harga");
    Integer qty = qtyStr != null ? Integer.parseInt(qtyStr) : 0;
    Integer harga = hargaStr != null ? Integer.parseInt(hargaStr) : 0;

    if (salesId != null && barangId != null) {
        Sales sales = new Sales();
        sales.baca(salesId);
        boolean success = sales.addDetail(barangId, qty, harga);
        if (success) {
            session.setAttribute("message", "success");
        } else {
            session.setAttribute("message", "error");
        }
        response.sendRedirect("formstocktambah.jsp?id=" + salesId);
    } else {
        session.setAttribute("message", "error");
        response.sendRedirect("formstocktambah.jsp?id=" + salesId);
    }
%>