<%@ page import="board.BoardDBBean" %>
<%@ page import="board.BoardDataBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/11
  Time: 12:12 PM
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

    //DB에 저장된 비번 구해오기
    BoardDataBean old = dao.getContent(board.getNum());

	//비번 비교
    if (old.getPasswd().equals(board.getPasswd())) {
        int result = dao.update(board);
        if (result == 1) {
%>

<script>
    alert('글수정 성공');
    location.href = "content.jsp?num=<%=board.getNum()%>&page=<%=nowPage%>&sel=<%=sel%>&find=<%=find%>";
</script>
<% } else { %>
<script>
    alert("글수정 실패");
    history.go(-1);
</script>
<% }
}
%>
