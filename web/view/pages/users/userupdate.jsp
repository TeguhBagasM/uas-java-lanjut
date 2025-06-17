<%@page import="tokoatk.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Validasi sesi
    if (session.getAttribute("user") == null) {
        response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
        return;
    }

    String username = request.getParameter("username");
    String fullname = request.getParameter("fullname");
    String password = request.getParameter("password");

    if (username != null && fullname != null) {
        User user = new User();
        user.username = username;
        user.fullname = fullname;
        boolean success = user.update();
        if (success && password != null && !password.isEmpty()) {
            success = user.updatePassword(password);
        }
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