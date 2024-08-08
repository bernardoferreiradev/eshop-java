<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-PT">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comprar Produto</title>
    <link rel="stylesheet" href="compra.css">
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
            <div class="search-container">
                <form action="produtos.jsp" method="get">
                    <input type="text" name="search" placeholder="Pesquisar produtos...">
                    <button type="submit">Pesquisar</button>
                </form>
            </div>
            <div class="nav-icon-container">
                <img src="images/1.png" />
            </div>
        </div>
    </div>

    <div class="compra-container">
        <%
            HttpSession sessao = request.getSession(false);
            if (sessao == null || sessao.getAttribute("utilizador") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String moradaCliente = null;
            String usernameCliente = (String) sessao.getAttribute("utilizador");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/loja";
                String user = "root";
                String password = "root";
                Connection con = DriverManager.getConnection(url, user, password);

                String moradaQuery = "SELECT morada FROM cliente WHERE username = ?";
                PreparedStatement moradaStmt = con.prepareStatement(moradaQuery);
                moradaStmt.setString(1, usernameCliente);
                ResultSet moradaRs = moradaStmt.executeQuery();

                if (moradaRs.next()) {
                    moradaCliente = moradaRs.getString("morada");
                }

                moradaRs.close();
                moradaStmt.close();

                String productId = request.getParameter("produtoId");

                if (productId != null) {
                    String produtoQuery = "SELECT * FROM produto WHERE id=?";
                    PreparedStatement produtoStmt = con.prepareStatement(produtoQuery);
                    produtoStmt.setInt(1, Integer.parseInt(productId));
                    ResultSet produtoRs = produtoStmt.executeQuery();

                    if (produtoRs.next()) {
                        String nome = produtoRs.getString("nome");
                        String descricao = produtoRs.getString("descricao");
                        float preco = produtoRs.getFloat("preco");
                        String urlImagem = produtoRs.getString("url_imagem");
        %>
                        <div class="product">
                            <img src="<%= urlImagem %>" alt="<%= nome %>">
                            <div class="product-details">
                                <h1>Comprar Produto</h1>
                                <h2>Nome do Produto: <%= nome %></h2>
                                <p>Descrição: <%= descricao %></p>
                                <p>Preço Unitário: €<%= preco %></p>
                                <p>Morada de Entrega: <%= moradaCliente != null ? moradaCliente : "Morada não disponível" %></p>
                                <form action="sucesso.jsp" method="post">
                                    <input type="hidden" name="produtoId" value="<%= productId %>">
                                    <label for="quantidade">Quantidade:</label>
                                    <input type="number" id="quantidade" name="quantidade" value="1" min="1" onchange="calcularPrecoTotal()">
                                    <p>Preço Total: €<span id="precoTotal"><%= preco %></span></p>
                                    <button type="submit">Confirmar Compra</button>
                                </form>
                            </div>
                        </div>
                        <script>
                            function calcularPrecoTotal() {
                                var precoUnitario = <%= preco %>;
                                var quantidade = document.getElementById('quantidade').value;
                                var precoTotal = precoUnitario * quantidade;
                                document.getElementById('precoTotal').innerText = precoTotal.toFixed(2);
                            }
                        </script>
        <%
                    } else {
                        out.println("<p>Produto não encontrado.</p>");
                    }

                    produtoRs.close();
                    produtoStmt.close();
                } else {
                    out.println("<p>ID do produto não especificado.</p>");
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>
