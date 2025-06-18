<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Sales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    ArrayList<Sales> list = Sales.getList();
    if (list == null) {
        list = new ArrayList<>();
    }
    request.setAttribute("list", list);
    RequestDispatcher dispatcher = request.getRequestDispatcher("stocklist.view.jsp");
    dispatcher.forward(request, response);
%>