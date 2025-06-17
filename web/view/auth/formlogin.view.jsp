<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - ATK Store</title>
        <link rel="stylesheet" href="../../css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="main-container">
            <div class="form-container">
                <h2 class="form-title">
                    <i class="fas fa-sign-in-alt"></i>
                    Login ke ATK Store
                </h2>
                
                <% 
                    String error = request.getParameter("error");
                    if (error != null && error.equals("1")) {
                %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-triangle"></i>
                        Username atau password salah!
                    </div>
                <% } %>
                
                <form action="login.jsp" method="post">
                    <div class="form-group">
                        <label for="username">
                            <i class="fas fa-user"></i> Username
                        </label>
                        <input type="text" id="username" name="username" class="form-control" 
                               placeholder="Masukkan username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">
                            <i class="fas fa-lock"></i> Password
                        </label>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Masukkan password" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </button>
                </form>
            </div>
        </div>
        
    </body>
</html>