<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="pt-PT">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Desportiva</title>
    <link rel="stylesheet" href="css.css">
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

    <header>
        <div class="header-inner-content">
            <div class="header-bottom-side">
                <div class="header-bottom-side-left">
                    <h2>Do que é que estás à espera?</h2>
                    <p>
                        O sucesso nem sempre tem haver com grandeza. Tem que haver com consistência. Trabalho duro consistente supera o sucesso.
                    </p>
                    <a href="produtos.jsp">
                        <button>Ver Agora &#8594;</button>
                    </a>
                </div>
                <div class="header-bottom-side-right">
                    <img src="images/3.png" />
                </div>
            </div>
        </div>
    </header>
</body>
</html>
