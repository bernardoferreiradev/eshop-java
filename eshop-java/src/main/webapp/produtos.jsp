<%@ page import="java.sql.*, javax.servlet.http.HttpSession, java.util.ArrayList, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-PT">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos</title>
    <link rel="stylesheet" href="produtos.css">
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

    <% 
        HttpSession sessao = request.getSession(false);
        if (sessao == null || sessao.getAttribute("utilizador") == null) {
            out.println("<h1>Bem-vindo, utilizador! Veja os nossos produtos abaixo. Também o convidamos a fazer login!</h1>");
        } else {
            String utilizador = (String) sessao.getAttribute("utilizador");
            out.println("<h1>Bem-vindo, " + utilizador + "! Vê os nossos produtos abaixo.</h1>");
        }

        class Produto {
            int id;
            String nome;
            String descricao;
            float preco;
            String urlImagem;
            String fornecedorNome;
            
            public Produto(int id, String nome, String descricao, float preco, String urlImagem, String fornecedorNome) {
                this.id = id;
                this.nome = nome;
                this.descricao = descricao;
                this.preco = preco;
                this.urlImagem = urlImagem;
                this.fornecedorNome = fornecedorNome;
            }
        }

        List<Produto> produtos = new ArrayList<>();
        
        String searchQuery = request.getParameter("search");
        String query = "SELECT * FROM produto";
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            query += " WHERE nome LIKE '%" + searchQuery + "%' OR descricao LIKE '%" + searchQuery + "%'";
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/loja";
            String user = "root"; 
            String password = "root"; 
            Connection con = DriverManager.getConnection(url, user, password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                produtos.add(new Produto(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("descricao"),
                    rs.getFloat("preco"),
                    rs.getString("url_imagem"),
                    rs.getString("fornecedor_nome")
                ));
            }

            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <div class="products-container">
        <%
            for (Produto produto : produtos) {
        %>
        <div class="product">
            <h2><%= produto.nome %></h2>
            <p><%= produto.descricao %></p>
            <p>Preço: €<%= produto.preco %></p>
            <p>Fornecedor: <%= produto.fornecedorNome %></p>
            <img src="<%= produto.urlImagem %>" alt="<%= produto.nome %>">
            <form action="adicionarCarrinho.jsp" method="post">
                <input type="hidden" name="produtoId" value="<%= produto.id %>">
            </form>
            <form action="paginaProduto.jsp" method="get">
    			<input type="hidden" name="id" value="<%= produto.id %>">
    			<button type="submit">Ver Produto</button>
			</form>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
