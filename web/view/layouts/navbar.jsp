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
            <a href="${pageContext.request.contextPath}/about.jsp" class="nav-link">Tentang</a>
            <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-link">Kontak</a>
        </div>
        
        <div class="nav-actions">
            <a href="cart.jsp" class="nav-icon">
                <i class="fas fa-shopping-cart"></i>
                <span class="cart-count">0</span>
            </a>
            <% if (session.getAttribute("user") != null) { %>
                <div class="user-menu">
                    <span class="user-name">Hi, ${sessionScope.fullname}</span>
                    <a href="view/auth/logout.jsp" class="btn btn-outline">Logout</a>
                </div>
            <% } else { %>
                <a href="view/auth/formlogin.jsp" class="btn btn-primary">Login</a>
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