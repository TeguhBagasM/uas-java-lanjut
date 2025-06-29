<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="util.Helper"%>
<%@page import="tokoatk.DbConnection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    int totalUsers = Helper.getTotalUsers();
    int totalBarang = Helper.getTotalBarang();
    int totalTransaksi = Helper.getTotalTransaksi();
    double totalPenjualan = Helper.getTotalPenjualan();
    
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("totalBarang", totalBarang);
    request.setAttribute("totalTransaksi", totalTransaksi);
    request.setAttribute("totalPenjualan", totalPenjualan);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - ATK Store</title>
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin: 30px 0;
                padding: 0 20px;
            }
            
            .stat-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 25px;
                border-radius: 15px;
                text-align: center;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                position: relative;
                overflow: hidden;
            }
            
            .stat-card:nth-child(1) {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            
            .stat-card:nth-child(2) {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            }
            
            .stat-card:nth-child(3) {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            }
            
            .stat-card:nth-child(4) {
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            }
            
            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(255,255,255,0.1);
                opacity: 0;
                transition: opacity 0.3s ease;
            }
            
            .stat-card:hover::before {
                opacity: 1;
            }
            
            .stat-icon {
                font-size: 3em;
                margin-bottom: 15px;
                opacity: 0.9;
            }
            
            .stat-number {
                font-size: 2.5em;
                font-weight: bold;
                margin-bottom: 10px;
                line-height: 1;
            }
            
            .stat-label {
                font-size: 1.1em;
                opacity: 0.9;
                font-weight: 500;
            }
            
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .welcome-section {
                text-align: center;
                margin-bottom: 30px;
            }
            
            .welcome-title {
                color: #333;
                margin-bottom: 10px;
                font-size: 2.2em;
            }
            
            .welcome-text {
                color: #666;
                font-size: 1.1em;
                margin-bottom: 30px;
            }
            
            .action-buttons {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
                margin-top: 40px;
            }
            
            .btn {
                display: inline-block;
                padding: 15px 25px;
                text-decoration: none;
                border-radius: 10px;
                transition: all 0.3s ease;
                font-weight: 500;
                border: none;
                cursor: pointer;
            }
            
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }
            
            .btn i {
                margin-right: 8px;
            }
            
            @media (max-width: 768px) {
                .stats-container {
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 15px;
                    padding: 0 10px;
                }
                
                .stat-card {
                    padding: 20px;
                }
                
                .stat-number {
                    font-size: 2em;
                }
                
                .stat-icon {
                    font-size: 2.5em;
                }
            }
        </style>
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
                    Anda berhasil login ke sistem ATK Store. Berikut adalah ringkasan data sistem.
                </p>
            </div>
            
            <!-- Statistics Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-number">${totalUsers}</div>
                    <div class="stat-label">Total Users</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stat-number">${totalBarang}</div>
                    <div class="stat-label">Total Barang</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-number">${totalTransaksi}</div>
                    <div class="stat-label">Total Transaksi</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="stat-number">
                        Rp <c:out value="${String.format('%,.0f', totalPenjualan)}" />
                    </div>
                    <div class="stat-label">Total Penjualan</div>
                </div>
            </div>
        </div>
        
        <%@ include file="view/layouts/footer.jsp" %>
    </body>
</html>