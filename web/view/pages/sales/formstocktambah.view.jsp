<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock Tambah - ATK Store</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function() {
                var hargaMap = {
                    <c:forEach var="barang" items="${barangList}" varStatus="status">
                        "${barang.id}": ${barang.harga}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                };

                $("#barangId").change(function() {
                    var selectedBarangId = $(this).val();
                    if (selectedBarangId && hargaMap[selectedBarangId]) {
                        $("#harga").val(hargaMap[selectedBarangId]);
                    } else {
                        $("#harga").val("");
                    }
                });
            });
        </script>
        <style>
            .detail-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .detail-table th, .detail-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .detail-table th {
                background-color: #f2f2f2;
            }
        </style>
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
            <div class="form-container">
                <% if ("success".equals(message)) { %>
                    <div class="alert alert-success">Detail transaksi berhasil ditambahkan.</div>
                <% } else if ("error".equals(message)) { %>
                    <div class="alert alert-error">Gagal menambahkan detail transaksi. Silakan coba lagi.</div>
                <% } %>
                <h2 class="form-title">Transaksi Detail - ${sales.id}</h2>
                <table class="detail-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Barang ID</th>
                            <th>Nama Barang</th>
                            <th>Qty</th>
                            <th>Harga</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${sales.getDetail()}">
                            <tr>
                                <td>${row.id}</td>
                                <td>${row.barangId}</td>
                                <td>${row.getBarangNama()}</td>
                                <td>${row.qty}</td>
                                <td>${row.harga}</td>
                                <td>${row.total}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <form action="${pageContext.request.contextPath}/view/pages/sales/stocktambah.jsp" method="post">
                    <input type="hidden" name="salesId" value="${sales.id}">
                    <div class="form-group">
                        <label for="barangId">Barang ID</label>
                        <select id="barangId" name="barangId" class="form-control" required>
                            <option value="">Pilih Barang</option>
                            <c:forEach var="barang" items="${barangList}">
                                <option value="${barang.id}">${barang.nama} - ${barang.harga}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="qty">Qty</label>
                        <input type="number" id="qty" name="qty" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="harga">Harga</label>
                        <input type="number" id="harga" name="harga" class="form-control" readonly>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Tambah Detail
                    </button>
                    <a href="${pageContext.request.contextPath}/view/pages/sales/stocklist.jsp" class="btn btn-outline">Kembali</a>
                </form>
            </div>
        </div>

        <%@ include file="../../layouts/footer.jsp" %>
    </body>
</html>