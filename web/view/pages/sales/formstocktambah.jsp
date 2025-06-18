<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.Barang"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String id = request.getParameter("id");
    Sales sales = new Sales();
    String username = "";
    if (session.getAttribute("user") instanceof String) {
        username = (String) session.getAttribute("user");
    } else if (session.getAttribute("user") instanceof tokoatk.User) {
        username = ((tokoatk.User) session.getAttribute("user")).getUsername(); 
    }
    if (id == null) {
        sales.tambah(username);
    } else {
        sales.baca(id);
    }
    request.setAttribute("sales", sales);

    // Tambahkan daftar barang
    ArrayList<Barang> barangList = Barang.getList();
    if (barangList == null) {
        barangList = new ArrayList<>();
    }
    request.setAttribute("barangList", barangList);

    RequestDispatcher dispatcher = request.getRequestDispatcher("formstocktambah.view.jsp");
    dispatcher.forward(request, response);
%>
%>