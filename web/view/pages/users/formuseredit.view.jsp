<%@page import="tokoatk.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit User - ATK Store</title>
        <!-- FontAwesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>
    <body>
        <% 
            // Validasi sesi
            if (session.getAttribute("user") == null) {
                response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
                return;
            }
            String username = request.getParameter("username");
            User user = new User();
            boolean userExists = false;
            if (username != null && user.baca(username)) {
                userExists = true;
            }
        %>
        <!-- Include Navbar -->
        <%@ include file="../../layouts/navbar.jsp" %>
        
        <div class="main-container">
            <div class="form-container">
                <h2 class="form-title">Edit User</h2>
                <% if (!userExists) { %>
                    <div class="alert alert-error">User tidak ditemukan.</div>
                <% } else { %>
                    <form action="${pageContext.request.contextPath}/view/pages/users/userupdate.jsp" method="post">
                        <input type="hidden" name="username" value="<%= user.getUsername() %>">
                        <div class="form-group">
                            <label for="fullname">Fullname</label>
                            <input type="text" id="fullname" name="fullname" class="form-control" value="<%= user.getFullname() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password (kosongkan jika tidak diubah)</label>
                            <input type="password" id="password" name="password" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Simpan
                        </button>
                        <a href="${pageContext.request.contextPath}/view/pages/users/userlist.jsp" class="btn btn-outline">Batal</a>
                    </form>
                <% } %>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../../layouts/footer.jsp" %>
    </body>
</html>