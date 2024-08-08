<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao != null) {
        sessao.invalidate();
    }
    response.sendRedirect("login.jsp");
%>
