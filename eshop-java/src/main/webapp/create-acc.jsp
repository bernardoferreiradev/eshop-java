<%@ page import="java.sql.* , FrontEnd.passwordFunctions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-PT">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.8">
    <title>Criar Conta</title>
    <link rel="stylesheet" href="create-acc.css">
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
                <img src="images/2.png" class="menu-button" />
            </div>
        </div>
    </div>

    <div class="container">
        <div class="half">
            <img src="images/image1.jpg">
        </div>
        <div class="half">
            <div class="content">
                <div class="form-container">
                    <h2>CRIAR CONTA</h2>
                    <form action="create-acc.jsp" method="post"> 
                        <p class="left-align">Nome</p>
                        <input type="text" name="nome" placeholder="Nome">
                        <p class="left-align">Nome de Utilizador</p>
                        <input type="text" name="username" placeholder="Nome de Utilizador">
                        <p class="left-align">Password</p>
                        <input type="password" name="password" id="password" placeholder="Password">
                        <p class="left-align">Data de Nascimento</p>
                        <input type="date" name="data" placeholder="Data">
                        <p class="left-align">Email</p>
                        <input type="text" name="email" placeholder="E-mail">
                        <p class="left-align">Telemóvel</p>
                        <input type="text" name="telemovel" placeholder="Telemóvel">
                        <p class="left-align">Morada</p>
                        <input type="text" name="morada" placeholder="Morada">
                        <button type="submit">Submeter</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@ page import="java.sql.*, FrontEnd.passwordFunctions" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nome = request.getParameter("nome");
        String dataNasc = request.getParameter("data");
        String telemovel = request.getParameter("telemovel");
        String morada = request.getParameter("morada");
        String email = request.getParameter("email");
        
        String url = "jdbc:mysql://localhost:3306/loja";
        String dbUsername = "root";
        String dbPassword = "root";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            String passwordEncriptada = passwordFunctions.encriptarPassword(password);
            
            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "INSERT INTO cliente (username, password, nome, dataNasc, telemovel, morada, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, passwordEncriptada);
            pstmt.setString(3, nome);
            pstmt.setString(4, dataNasc);
            pstmt.setString(5, telemovel);
            pstmt.setString(6, morada);
            pstmt.setString(7, email);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>

    
</body>

</html>
