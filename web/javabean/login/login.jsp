<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/04
  Time: 11:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="login" class="javaBeanExam.member.MemberDataBean"/>
<jsp:setProperty name="login" property="*"/>

ID : <%=login.getId()%><br>
PW : <%=login.getPasswd()%><br>

