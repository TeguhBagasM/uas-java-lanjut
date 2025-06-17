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
        user.username = username;
        boolean success = user.hapus();
        if (success) {
            session.setAttribute("message", "success");
        } else {
            session.setAttribute("message", "error");
        }
        response.sendRedirect("userlist.jsp");
    } else {
        session.setAttribute("message", "error");
        response.sendRedirect("userlist.jsp");
    }
%>