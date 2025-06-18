<%@page import="tokoatk.Sales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String id = request.getParameter("id");
    Sales sales = new Sales();
    if (id == null) {
        sales.tambah(session.getAttribute("user").toString()); 
    } else {
        sales.baca(id);
    }
    request.setAttribute("sales", sales);
    RequestDispatcher dispatcher = request.getRequestDispatcher("formstocktambah.view.jsp");
    dispatcher.forward(request, response);
%>