<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tambah Barang - ATK Store</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>
    <body>
        <% 
            if (session.getAttribute("user") == null) {
                response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
                return;
            }
        %>
        <%@ include file="../../layouts/navbar.jsp" %>
        
        <div class="main-container">
            <div class="form-container">
                <h2 class="form-title">Tambah Barang</h2>
                <form action="${pageContext.request.contextPath}/view/pages/barang/barangtambah.jsp" method="post">
                    <div class="form-group">
                        <label for="nama">Nama</label>
                        <input type="text" id="nama" name="nama" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="jenis">Jenis</label>
                        <input type="text" id="jenis" name="jenis" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="harga">Harga</label>
                        <input type="number" id="harga" name="harga" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Tambah
                    </button>
                    <a href="${pageContext.request.contextPath}/view/pages/barang/baranglist.jsp" class="btn btn-outline">Batal</a>
                </form>
            </div>
        </div>

        <%@ include file="../../layouts/footer.jsp" %>
    </body>
</html>