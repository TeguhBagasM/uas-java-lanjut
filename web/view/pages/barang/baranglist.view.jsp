<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Barang List - ATK Store</title>
        <!-- FontAwesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css" rel="stylesheet">
        <!-- Custom CSS -->
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
                    <div class="alert alert-success">Operasi berhasil (Tambah/Edit/Hapus).</div>
                <% } else if ("error".equals(message)) { %>
                    <div class="alert alert-error">Operasi gagal. Silakan coba lagi.</div>
                <% } %>
                <h1 class="welcome-title mb-2">
                    <i class="fas fa-box"></i> Barang Lists
                </h1>
                <a href="${pageContext.request.contextPath}/view/pages/barang/formbarangtambah.jsp" class="btn btn-primary mb-2">
                    <i class="fas fa-plus"></i> Tambah Barang Baru
                </a>

                <table id="barangTable" class="table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Nama</th>
                            <th>Jenis</th>
                            <th>Harga</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="barang" items="${list}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>${barang.id}</td>
                                <td><span id="nama${barang.id}">${barang.nama}</span></td>
                                <td>${barang.jenis}</td>
                                <td><fmt:formatNumber type="number" pattern="0,000" value="${barang.harga}" /></td>
                                <td>
                                    <button type="button" onclick="gantiNama('${barang.id}', '${barang.nama}')" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Edit Nama
                                    </button>
                                    <a href="${pageContext.request.contextPath}/view/pages/barang/deletebarang.jsp?id=${barang.id}" class="btn btn-danger" onclick="return confirm('Yakin ingin menghapus barang ini?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <button type="button" onclick="showStat()" class="btn btn-primary">Show Stat</button>
            </div>
        </div>

        <%@ include file="../../layouts/footer.jsp" %>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#barangTable').DataTable({
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

            function gantiNama(id, namaLama) {
                let namabaru = prompt("Edit nama barang? (Sekarang: " + namaLama + ")", namaLama);
                if (namabaru && namabaru !== namaLama) {
                    $.post("${pageContext.request.contextPath}/view/pages/barang/api.baranggantinama.jsp", 
                          { id: id, namabaru: namabaru }, 
                          function(result) {
                              if (result === "ok") {
                                  $('#nama' + id).html(namabaru);
                                  alert("Nama barang berhasil diubah!");
                              } else {
                                  alert("Gagal mengubah nama barang!");
                              }
                          }).fail(function() {
                              alert("Error: Tidak dapat terhubung ke server!");
                          });
                }
            }

            function showStat() {
                $.post("${pageContext.request.contextPath}/view/pages/barang/api.barangstat.jsp", 
                      function(result) {
                          let obj = JSON.parse(result);
                          alert("Banyak data: " + obj.banyak + "\nRata-rata: " + obj.rata2);
                      }).fail(function() {
                          alert("Error: Tidak dapat mengambil statistik!");
                      });
            }
        </script>
    </body>
</html>