<%@ page import="reboard.ReBoardDBBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/12
  Time: 10:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="reboard" class="reboard.ReBoardDataBean"/>
<jsp:setProperty name="reboard" property="*"/>
<%
    //클라이언트의 IP 주소 구하기
    String ip = request.getRemoteAddr();
    reboard.setIp(ip);

    ReBoardDBBean dao = ReBoardDBBean.getInstance();
    int result = dao.insert(reboard);
	if (result == 1) {
%>
    <script>
        alert('글작성 성공');
        location.href = "list.jsp";
    </script>
<%  } else {    %>
    <script>
        alert('글작성 실패');
        history.go(-1);
    </script>
<%  }%>