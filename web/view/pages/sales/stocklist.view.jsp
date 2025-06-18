<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock List - ATK Store</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>
    <body>
        <% 
            if (session.getAttribute("user") == null) {
                response.sendRedirect("${pageContext.request.contextPath}/view/auth/formlogin.jsp?logout=0");
                return;
            }
            String message = (String) session.getAttribute("message");
            if (message != null) {
                session.removeAttribute("message");
            }
        %>
        <%@ include file="../../layouts/navbar.jsp" %>
        
        <div class="main-container">
            <div class="welcome-section">
                <% if ("success".equals(message)) { %>
                    <div class="alert alert-success">Operasi berhasil (Tambah).</div>
                <% } else if ("error".equals(message)) { %>
                    <div class="alert alert-error">Operasi gagal. Silakan coba lagi.</div>
                <% } %>
                <h1 class="welcome-title mb-2">
                    <i class="fas fa-shopping-cart"></i> Stock Lists
                </h1>
                <a href="${pageContext.request.contextPath}/view/pages/sales/formstocktambah.jsp" class="btn btn-primary mb-2">
                    <i class="fas fa-plus"></i> Transaksi Baru
                </a>

                <table id="stockTable" class="table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID Transaksi</th>
                            <th>Username</th>
                            <th>Waktu</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sales" items="${list}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>${sales.id}</td>
                                <td>${sales.username}</td>
                                <td>${sales.waktu}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/view/pages/sales/formstocktambah.jsp?id=${sales.id}" class="btn btn-warning">
                                        <i class="fas fa-eye"></i> Lihat Detail
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <%@ include file="../../layouts/footer.jsp" %>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#stockTable').DataTable({
                    "paging": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "lengthChange": true,
                    "autoWidth": false,
                    "responsive": false,
                    "language": {
                        "search": "Cari:",
                        "lengthMenu": "Tampilkan _MENU_ data",
                        "info": "Menampilkan _START_ sampai _END_ dari _TOTAL_ data",
                        "paginate": {
                            "first": "Pertama",
                            "last": "Terakhir",
                            "next": "Selanjutnya",
                            "previous": "Sebelumnya"
                        },
                        "emptyTable": "Tidak ada data tersedia"
                    }
                });
            });
        </script>
    </body>
</html>