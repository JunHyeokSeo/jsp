<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/06
  Time: 11:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = (String) session.getAttribute("id");
    if (id != null) {   //세션이 있는 경우(정상적인 접근)
%>
    <%=id%>님 환영합니다 <br><br><br>
    <a href="updateform.jsp">정보수정</a><br>
    <a href="logout.jsp">로그아웃</a><br>
    <a href="deleteform.jsp">회원탈퇴</a><br>

<%  } else {            //세션이 없는 경우(비정상적인 접근)%>
    <a href="memberform.html">회원가입</a><br>
    <a href="loginform.html">로그인</a><br>
<%  } %>