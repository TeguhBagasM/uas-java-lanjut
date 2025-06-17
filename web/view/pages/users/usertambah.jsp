<%@page import="tokoatk.User"%>
<%
    String username = request.getParameter("username").toString();
    String fullname = request.getParameter("fullname").toString();
    String password = request.getParameter("password").toString();
    
    User user = new User();
    user.username = username;
    user.fullname = fullname;
    boolean success = user.tambah(password);
    
    if (success) {
            response.sendRedirect("userlist.jsp?message=success");
        } else {
            response.sendRedirect("userlist.jsp?message=error");
        }
%>