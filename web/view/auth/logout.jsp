<%
    // Invalidate session
    session.invalidate();
    
    // Redirect to login page with success message
    response.sendRedirect("formlogin.jsp?logout=1");
%>