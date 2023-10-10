<%@ page import="board.BoardDBBean" %>
<%@ page import="board.BoardDataBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board" class="board.BoardDataBean"/>
<jsp:setProperty name="board" property="*"/>

<%
    //글을 작성한 사용자의 IP 주소 구하기
    String ip = request.getRemoteAddr();
	board.setIp(ip);

    BoardDBBean dao = BoardDBBean.getInstance();
    int result = dao.insert(board);
    if (result == 1) {
%>
<script>
    alert("글 작성 성공");
    location.href = "list.jsp";
</script>
<%  } else {  %>
<script>
    alert("글 작성 실패");
    history.go(-1);
</script>
<%  }   %>
