<%
    // Check if user is logged in
    if(session.getAttribute("fullname") == null) {
        response.sendRedirect("../auth/formlogin.jsp");
        return;
    }
    
    // Forward to view
    RequestDispatcher dispatcher = request.getRequestDispatcher("home.view.jsp");
    dispatcher.forward(request, response);
%>