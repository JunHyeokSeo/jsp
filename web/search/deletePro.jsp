<%@ page import="board.BoardDBBean" %>
<%@ page import="board.BoardDataBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/11
  Time: 2:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board" class="board.BoardDataBean"/>
<jsp:setProperty name="board" property="*"/>
<%
    String nowPage = request.getParameter("page");
    String sel = request.getParameter("sel");
    String find = request.getParameter("find");

    BoardDBBean dao = BoardDBBean.getInstance();

	//DB에서 비번 구해오기
    BoardDataBean old = dao.getContent(board.getNum());

	//비번 비교
    if (old.getPasswd().equals(board.getPasswd())) {
        int result = dao.delete(board.getNum());
		if (result == 1){
%>
            <script>
                alert('글삭제 성공');
                location.href = "list.jsp?page=<%=nowPage%>&sel=<%=sel%>&find=<%=find%>s";
            </script>
<%      }
    } else {    %>
            <script>
                alert('비번이 일치하지 않습니다');
                history.go(-1);
            </script>
<%  }   %>