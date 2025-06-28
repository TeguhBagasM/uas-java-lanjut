<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Stock Tambah - ATK Store</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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
            .autocomplete-suggestions {
                border: 1px solid #ddd;
                background-color: #fff;
                max-height: 150px;
                overflow-y: auto;
                position: absolute;
                z-index: 1000;
            }
            .autocomplete-suggestion {
                padding: 5px;
                cursor: pointer;
            }
            .autocomplete-suggestion:hover {
                background-color: #f0f0f0;
            }
        </style>
        <script>
            // Fungsi untuk memformat angka ke Rupiah
            function formatRupiah(angka) {
                if (!angka || isNaN(angka)) return 'Rp 0';
                var number = parseFloat(angka).toFixed(0);
                var number_string = number.replace(/[^,\d]/g, '').toString(),
                    split = number_string.split(','),
                    sisa = split[0].length % 3,
                    rupiah = split[0].substr(0, sisa),
                    ribuan = split[0].substr(sisa).match(/\d{3}/gi);

                if (ribuan) {
                    separator = sisa ? '.' : '';
                    rupiah += separator + ribuan.join('.');
                }

                rupiah = split[1] !== undefined ? rupiah + ',' + split[1] : rupiah;
                return 'Rp ' + rupiah;
            }

            $(document).ready(function() {
                var barangData = {
                    <c:forEach var="barang" items="${barangList}" varStatus="status">
                        "${barang.nama}": { id: "${barang.id}", harga: ${barang.harga} }<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                };

                var $input = $("#namaBarang");
                var $suggestions = $("<div class='autocomplete-suggestions'></div>").insertAfter($input);

                $input.on("input", function() {
                    var query = $(this).val().toLowerCase();
                    $suggestions.empty();

                    if (query.length > 0) {
                        $.each(barangData, function(nama, data) {
                            if (nama.toLowerCase().includes(query)) {
                                var $suggestion = $("<div class='autocomplete-suggestion'>" + nama + " (" + formatRupiah(data.harga) + ")</div>");
                                $suggestion.data("id", data.id);
                                $suggestion.data("harga", data.harga);
                                $suggestion.appendTo($suggestions);
                            }
                        });
                    }
                });

                $suggestions.on("click", ".autocomplete-suggestion", function() {
                    var $this = $(this);
                    $input.val($this.text().split(' (')[0]);
                    $("#barangId").val($this.data("id"));
                    $("#harga").val($this.data("harga")); // Simpan nilai numerik
                    $("#hargaDisplay").val(formatRupiah($this.data("harga"))); // Tampilkan format Rupiah
                    $suggestions.empty();
                });

                $(document).on("click", function(e) {
                    if (!$(e.target).closest(".form-group").length) {
                        $suggestions.empty();
                    }
                });

                $("#calculateTotal").on("click", function() {
                    var salesId = "${sales.id}";
                    if (salesId) {
                        $.post("${pageContext.request.contextPath}/view/pages/sales/api.salestotal.jsp", 
                              { salesId: salesId }, 
                              function(result) {
                                  var total = parseFloat(result) || 0;
                                  alert("Total Keseluruhan: " + formatRupiah(total));
                              }).fail(function(xhr, status, error) {
                                  alert("Error: " + error + ". Periksa log server.");
                              });
                    } else {
                        alert("Error: Sales ID tidak tersedia.");
                    }
                });
            });
        </script>
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
                            <th>Nama Barang</th>
                            <th>Qty</th>
                            <th>Harga</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${sales.getDetail()}">
                            <tr>
                                <td>${row.getBarangNama()}</td>
                                <td>${row.qty}</td>
                                <td><fmt:formatNumber value="${row.harga}" type="currency" currencySymbol="Rp " pattern="#,##0" /></td>
                                <td><fmt:formatNumber value="${row.total}" type="currency" currencySymbol="Rp " pattern="#,##0" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <form action="${pageContext.request.contextPath}/view/pages/sales/stocktambah.jsp" method="post">
                    <input type="hidden" name="salesId" value="${sales.id}">
                    <input type="hidden" id="barangId" name="barangId">
                    <input type="hidden" id="harga" name="harga">
                    <div class="form-group">
                        <label for="namaBarang">Nama Barang</label>
                        <input type="text" id="namaBarang" class="form-control" required placeholder="Ketik untuk mencari...">
                    </div>
                    <div class="form-group">
                        <label for="qty">Qty</label>
                        <input type="number" id="qty" name="qty" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="hargaDisplay">Harga</label>
                        <input type="text" id="hargaDisplay" class="form-control" readonly>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Tambah Transaksi
                    </button>
                    <a href="${pageContext.request.contextPath}/view/pages/sales/stocklist.jsp" class="btn btn-outline">Kembali</a>
                    <button type="button" id="calculateTotal" class="btn btn-secondary">
                        <i class="fas fa-calculator"></i> Hitung Total
                    </button>
                </form>
            </div>
        </div>

        <%@ include file="../../layouts/footer.jsp" %>
    </body>
</html>