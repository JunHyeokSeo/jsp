<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/22
  Time: 4:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int num = Integer.parseInt(request.getParameter("gugu"));
%>
<h1>구구단 <%=num%>단</h1>
<%
    for(int i=0; i<10; i++){
%>
    <%=num%> * <%=i%> = <%= num * i%><br>
<%
    }
%>