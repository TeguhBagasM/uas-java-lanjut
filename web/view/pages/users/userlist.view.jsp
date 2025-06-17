<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - ATK Store</title>
        <!-- FontAwesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css" rel="stylesheet">
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
            String message = (String) session.getAttribute("message");
            if (message != null) {
                session.removeAttribute("message");
            }
        %>
        <!-- Include Navbar -->
        <%@ include file="../../layouts/navbar.jsp" %>
        
        <div class="main-container">
            <div class="welcome-section">
                <% if ("success".equals(message)) { %>
                    <div class="alert alert-success">Operasi User Behasil.</div>
                <% } else if ("error".equals(message)) { %>
                    <div class="alert alert-error">Operasi gagal. Silakan coba lagi.</div>
                <% } %>
                <h1 class="welcome-title mb-2">
                    <i class="fas fa-home"></i> User Lists
                </h1>
                <a href="${pageContext.request.contextPath}/view/pages/users/formusertambah.jsp" class="btn btn-primary mb-2">
                    <i class="fas fa-plus"></i> Tambah User Baru
                </a>

                <table id="userTable" class="table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Fullname</th>
                            <th>Username</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${list}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>${user.fullname}</td>
                                <td>${user.username}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/view/pages/users/formuseredit.jsp?username=${user.username}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/view/pages/users/deleteuser.jsp?username=${user.username}" class="btn btn-danger" onclick="return confirm('Yakin ingin menghapus user ini?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Include Footer -->
        <%@ include file="../../layouts/footer.jsp" %>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
        <!-- Initialize DataTables -->
        <script>
            $(document).ready(function() {
                $('#userTable').DataTable({
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