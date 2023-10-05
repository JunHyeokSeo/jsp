<%@ page import="java.util.Random" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/22
  Time: 2:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 난수 발생
    Random r = new Random();

    int r1 = r.nextInt(10);     // 0 ~ 9

    int r2 = r.nextInt(45) + 1; // 1 ~ 45
%>

난수 1 : <%=r1%><br>
난수 2 : <%=r2%><br>