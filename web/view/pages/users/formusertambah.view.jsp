<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add User</title>
    </head>
    <body>
        <h1>Add User</h1>
        <form action="usertambah.jsp" method="post">
            Username: <input name="username"><br>
            Fullname: <input name="fullname"><br>
            Password: <input name="password"><br>
            <button type="submit">Tambah</button>
        </form>
    </body>
</html>