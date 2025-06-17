<%
    if(session.getAttribute("fullname")==null) {
        response.sendRedirect("formlogin.jsp");
    } else {
        response.sendRedirect("home.jsp");
    }
%>