<%@page import="tokoatk.User"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    User user = new User();
    if(user.login(username, password)) {
        session.setAttribute("fullname", user.getFullname());
        response.sendRedirect("home.jsp");
    } else {
            response.sendRedirect("formlogin.jsp");
    }

%>