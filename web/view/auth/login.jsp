<%@page import="tokoatk.User"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    User user = new User();
    if(user.login(username, password)) {
        session.setAttribute("fullname", user.getFullname());
        session.setAttribute("user", user); 
        response.sendRedirect("../view/home.jsp");
    } else {
        response.sendRedirect("formlogin.jsp?error=1");
    }
%>