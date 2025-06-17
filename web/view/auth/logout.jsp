<%
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("../auth/formlogin.jsp");
    } else {
        response.sendRedirect("home.jsp");
    }
%>