<%@ page import="upload.BoardDBBean" %>
<%@ page import="upload.BoardDataBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/17
  Time: 9:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board" class="upload.BoardDataBean"/>
<jsp:setProperty name="board" property="*"/>

<%
    String nowPage = request.getParameter("page");
    String path = request.getServletContext().getRealPath("upload");
    System.out.println("path : " + path);

    BoardDBBean dao = BoardDBBean.getInstance();
    BoardDataBean db = dao.getContent(board.getNum());

    if (db.getPasswd().equals(board.getPasswd())) {
        int result = dao.delete(db, path);
		if (result == 1) {
%>
            <script>
                alert("글삭제 성공");
                location.href = "list.jsp?page=<%=nowPage%>";
            </script>
<%      }
	} else  {   %>
            <script>
                alert("비번이 일치하지 않습니다");
                history.go(-1);
            </script>
<%  }   %>
