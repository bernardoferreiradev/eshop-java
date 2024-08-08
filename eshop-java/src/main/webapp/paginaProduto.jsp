<%@ page import="java.sql.*, javax.servlet.http.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-PT">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Produto</title>
    <link rel="stylesheet" href="paginaProdutocss.css">
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

    <div class="product-details-container">
        <%
            HttpSession sessao = request.getSession(false);
            if (sessao == null || sessao.getAttribute("utilizador") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String productId = request.getParameter("id");
            if (productId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/loja";
                    String user = "root";
                    String password = "root";
                    Connection con = DriverManager.getConnection(url, user, password);

                    String produtoQuery = "SELECT * FROM produto WHERE id=" + productId;
                    Statement produtoStmt = con.createStatement();
                    ResultSet produtoRs = produtoStmt.executeQuery(produtoQuery);

                    if (produtoRs.next()) {
                        int id = produtoRs.getInt("id");
                        String nome = produtoRs.getString("nome");
                        String descricao = produtoRs.getString("descricao");
                        float preco = produtoRs.getFloat("preco");
                        String urlImagem = produtoRs.getString("url_imagem");
                        String fornecedorNome = produtoRs.getString("fornecedor_nome");
                        int avaliacaoId = produtoRs.getInt("avaliacao_id");

                        String avaliacaoQuery = "SELECT * FROM avaliacao WHERE id=" + avaliacaoId;
                        Statement avaliacaoStmt = con.createStatement();
                        ResultSet avaliacaoRs = avaliacaoStmt.executeQuery(avaliacaoQuery);
        %>
                        <div class="product">
                            <img src="<%= urlImagem %>" alt="<%= nome %>">
                            <div class="product-details">
                                <h1>Detalhes do Produto</h1>
                                <h2>Nome do Produto: <%= nome %></h2>
                                <p>Descrição: <%= descricao %></p>
                                <p>Preço: €<%= preco %></p>
                                <p>Fornecedor: <%= fornecedorNome %></p>
                                <div class="buttons-container">
                                    <form action="adicionarCarrinho.jsp" method="post">
                                        <input type="hidden" name="produtoId" value="<%= id %>">
                                        <button type="submit">Adicionar ao Carrinho</button>
                                    </form>
                                    <form action="compra.jsp" method="post">
                                        <input type="hidden" name="produtoId" value="<%= id %>">
                                        <button type="submit">Comprar Agora</button>
                                    </form>
                                </div>
        <%
                                if (avaliacaoRs.next()) {
                                    String descricaoAvaliacao = avaliacaoRs.getString("descricao");
                                    String usernameCliente = avaliacaoRs.getString("username_cliente");
        %>
                                <div class="avaliacao-detalhes">
                                    <h3>Avaliação do Produto</h3>
                                    <p><strong>Cliente:</strong> <%= usernameCliente %></p>
                                    <p><strong>Avaliação:</strong> <%= descricaoAvaliacao %></p>
                                </div>
        <%
                                }
                                avaliacaoRs.close();
                                avaliacaoStmt.close();
        %>
                            </div>
                        </div>
        <%
                    } else {
                        out.println("<p>Produto não encontrado.</p>");
                    }

                    produtoRs.close();
                    produtoStmt.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                out.println("<p>ID do produto não especificado.</p>");
            }
        %>
    </div>
</body>
</html>
