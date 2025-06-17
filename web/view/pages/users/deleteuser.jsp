<%@page import="tokoatk.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validasi sesi
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String username = request.getParameter("username");
    if (username != null) {
        User user = new User();
        user.username = username; // Set username untuk metode hapus
        boolean success = user.hapus(); // Panggil metode hapus
        if (success) {
            response.sendRedirect("userlist.jsp?message=success");
        } else {
            response.sendRedirect("userlist.jsp?message=error");
        }
    } else {
        response.sendRedirect("userlist.jsp");
    }
%>