<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - ATK Store</title>
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="view/layouts/navbar.jsp" %>
        
        <div class="main-container">
            <div class="welcome-section">
                <h1 class="welcome-title">
                    <i class="fas fa-home"></i>
                    Selamat Datang, ${fullname}!
                </h1>
                <p class="welcome-text">
                    Anda berhasil login ke sistem ATK Store. Pilih menu di bawah untuk melanjutkan.
                </p>
                
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/view/pages/users/userlist.jsp" class="btn btn-primary btn-large">
                        <i class="fas fa-users"></i> Kelola User
                    </a>
                    <a href="${pageContext.request.contextPath}/view/pages/barang/baranglist.jsp" class="btn btn-primary btn-large">
                        <i class="fas fa-box"></i> Kelola Barang
                    </a>
                    <a href="categories.jsp" class="btn btn-primary btn-large">
                        <i class="fas fa-tags"></i> Kelola Kategori
                    </a>
                    <a href="reports.jsp" class="btn btn-primary btn-large">
                        <i class="fas fa-chart-bar"></i> Laporan
                    </a>
                </div>
            </div>
        </div>
        
        <%@ include file="view/layouts/footer.jsp" %>
    </body>
</html>