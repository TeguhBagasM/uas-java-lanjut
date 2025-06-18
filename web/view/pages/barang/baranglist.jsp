<%@page import="tokoatk.Barang"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Barang> list = Barang.getList();
    
    request.setAttribute("list", list);
    
    RequestDispatcher dispacher = request.getRequestDispatcher("baranglist.view.jsp");
    dispacher.forward(request, response);
%>
