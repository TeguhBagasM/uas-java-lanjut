<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
    </head>
    <body>
        <h1>User List</h1>
        <a href="formusertambah.jsp">user baru</a>
        <hr>
    <c:forEach var="user" items="${list}">
        ${user.getFullname()}
    </c:forEach>
    </body>
</html>