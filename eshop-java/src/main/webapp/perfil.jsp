<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-PT">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Perfil</title>
    <link rel="stylesheet" href="perfil.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="navbar">
        <div class="header-inner-content">
            <nav>
                <ul>
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="produtos.jsp">Produtos</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="create-acc.jsp">Criar Conta</a></li>
                    <li><a href="perfil.jsp">Perfil</a></li>
                </ul>
            </nav>
            <div class="nav-icon-container">
                <img src="images/1.png" />
            </div>
        </div>
    </div>

    <% 
        HttpSession sessao = request.getSession(false);
        if (sessao == null || sessao.getAttribute("utilizador") == null) {
    %>
    <script>
        alert("Sem sessão iniciada. Faça login para aceder a esta página. A enviar para a página de login...");
        window.location.href = "login.jsp";
    </script>
    <%    
        } else {
            try {
                String username = (String) session.getAttribute("utilizador");
                String url = "jdbc:mysql://localhost:3306/loja";
                String dbUsername = "root";
                String dbPassword = "root";

                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                Statement stat = conn.createStatement();
                String strselect = "SELECT username, nome, dataNasc, telemovel, morada, email FROM cliente WHERE username='" + username + "'";
                ResultSet rs = stat.executeQuery(strselect);

                if (rs.next()) {
    %>
                    <div class="perfil-container">
                        <h1>Detalhes do perfil!</h1>
                        <div class="profile-details">
                            <p><strong>Username:</strong> <%= rs.getString("username") %></p>
                            <p><strong>Nome:</strong> <%= rs.getString("nome") %></p>
                            <p><strong>Data de Nascimento:</strong> <%= rs.getString("dataNasc") %></p>
                            <p><strong>Telemóvel:</strong> <%= rs.getString("telemovel") %></p>
                            <p><strong>Morada:</strong> <%= rs.getString("morada") %></p>
                            <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                        </div>
                        <form action="logout.jsp" method="post">
                            <button type="submit">Logout</button>
                        </form>
                    </div>
    <%              
                }
                rs.close();
                stat.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
