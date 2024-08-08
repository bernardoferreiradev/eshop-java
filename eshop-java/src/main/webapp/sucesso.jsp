<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Obrigado por comprar aqui!</title>
<link rel="stylesheet" type="text/css" href="sucesso.css">
</head>
<body>
    <% 
        HttpSession sessao = request.getSession(false);
        if (session == null || session.getAttribute("utilizador") == null) {
            response.sendRedirect("login.jsp");
        } else {
    %>
            <div class="container">
                <h1>Compra realizada com sucesso!</h1>
                <h2>Obrigado por nos escolher e volte sempre!</h2>
            </div>
    <% } %>
</body>
</html>
