<%
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("view/auth/formlogin.jsp");
    } else {
        response.sendRedirect("home.jsp");
    }
%>