<nav class="navbar">
    <div class="nav-container">
        <a href="index.jsp" class="nav-logo">
            <i class="fas fa-store"></i>
            ATK Store
        </a>
        
        <div class="nav-menu" id="nav-menu">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-link">Home</a>
            <a href="${pageContext.request.contextPath}/view/pages/users/userlist.jsp" class="nav-link">Users</a>
            <a href="${pageContext.request.contextPath}/view/pages/barang/baranglist.jsp" class="nav-link">Barang</a>
            <a href="${pageContext.request.contextPath}/view/pages/sales/stocklist.jsp" class="nav-link">Sales</a>
        </div>
        
        <div class="nav-actions">
            <% if (session.getAttribute("user") != null) { %>
                <div class="user-menu">
                    <span class="user-name">Hi, ${sessionScope.fullname}</span>
                    <a href="${pageContext.request.contextPath}/view/auth/logout.jsp" class="btn btn-outline">Logout</a>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/view/auth/formlogin.jsp" class="btn btn-primary">Login</a>
            <% } %>
        </div>
        
        <div class="nav-toggle" id="nav-toggle">
            <span class="bar"></span>
            <span class="bar"></span>
            <span class="bar"></span>
        </div>
    </div>
</nav>

<script>
document.getElementById('nav-toggle').addEventListener('click', function() {
    const navMenu = document.getElementById('nav-menu');
    navMenu.classList.toggle('active');
});
</script>