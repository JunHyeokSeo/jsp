<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/25
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("passwd");
%>
ID : <%=id%><br>
PW : <%=pw%>

