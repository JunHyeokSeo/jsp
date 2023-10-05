<%@ page import="member.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/05
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="member.MemberDTO"/>
<jsp:setProperty name="member" property="*"/>

<%
    String[] hobbies = request.getParameterValues("hobby");
    String hobby = "";
    for (String h : hobbies) {
        hobby += h + " ";
    }
    member.setHobby(hobby);

    //DAO 객체 생성
    MemberDAO dao = MemberDAO.getInstance();
    int result = dao.insert(member);
    if (result == 1) {
%>
<script>
    alert("회원가입 성공");
    location.href = "loginform.html";
</script>

<% } else {%>

<script>
    alert("회원가입 실패");
    history.go(-1);
</script>

<% } %>