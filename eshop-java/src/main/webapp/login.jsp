<%@ page import="java.sql.*, FrontEnd.passwordFunctions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-PT">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.8">
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
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

    <div class="container">
        <div class="half">
            <img src="images/image2.jpg">
        </div>
        <div class="half">
            <div class="content">
                <div class="form-container">
                    <h2>LOGIN</h2>
                    <form action="<%= request.getRequestURI() %>" method="post">
                        <p class="left-align">Nome de Utilizador</p>
                        <input type="text" name="nome" placeholder="Nome de Utilizador">
                        <p class="left-align">Password</p>
                        <input type="password" name="password" placeholder="Password">
                        <button type="submit">Iniciar Sessão</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <%
		String username = request.getParameter("nome");
    	String password = request.getParameter("password");
    	String url = "jdbc:mysql://localhost:3306/loja";
        String dbUsername = "root";
        String dbPassword = "root";
    	
    	if (username != null && !username.isEmpty() && password != null && !password.isEmpty()) {
    		try {
            	Class.forName("com.mysql.jdbc.Driver");
            	Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            	Statement stat = conn.createStatement();
            	String strselect = "select username, password from cliente where username = '"+username+"'";

            	ResultSet rset = stat.executeQuery(strselect);
           	
            	if (rset.next()) {
            		String PasswordRecebida = rset.getString("password");
            		String decriptada = passwordFunctions.decriptarPassword(PasswordRecebida);
                
                	if (password.equals(decriptada)) {
                		session.setAttribute ("utilizador", username);
                		response.sendRedirect("index.jsp");
                	} else {
						out.println("<script>alert('Password errada.');</script>");
					}
            	} else {
					out.println("<script>alert('Utilizador não encontrado.');</script>");
				}
            	
            	rset.close();
            	stat.close();
            	conn.close();
        	} 
    	
    		catch (SQLException e) {
            	e.printStackTrace();
        	} 
    	
	    	catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }
    	}
	%>
</body>

</html>
