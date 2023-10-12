<%@ page import="reboard.ReBoardDBBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/12
  Time: 4:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="reboard" class="reboard.ReBoardDataBean"/>
<jsp:setProperty name="reboard" property="*"/>
<%
    reboard.setIp(request.getRemoteAddr());
    String nowPage = request.getParameter("page");

	ReBoardDBBean dao = ReBoardDBBean.getInstance();
    int result = dao.reply(reboard);
	if (result == 1){
%>
        <script>
            alert('댓글 작성 성공');
            location.href = "list.jsp?page=<%=nowPage%>";
        </script>
<%  } else {    %>
        <script>
            alert('댓글 작성 실패');
            history.go(-1);
        </script>
<%  }%>