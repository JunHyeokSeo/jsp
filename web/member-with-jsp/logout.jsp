<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/06
  Time: 12:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //세션 삭제
    session.invalidate();
%>
<script>
    alert('로그아웃 되었습니다.');
    location.href = "loginform.html";
</script>
