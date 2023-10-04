<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/04
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board" class="javaBeanExam.board.BoardDataBean"/>
<jsp:setProperty name="board" property="*"/>
<table border=1 width=500 align=center>
    <caption>게시판</caption>
    <tr>
        <th>작성자</th>
        <td>
            <%=board.getWriter()%>
        </td>
    </tr>
    <tr>
        <th>비밀번호</th>
        <td>
            <%=board.getPasswd()%>
        </td>
    </tr>
    <tr>
        <th>제목</th>
        <td>
            <%=board.getSubject()%>
        </td>
    </tr>
    <tr>
        <th>내용</th>
        <td>
            <%=board.getContent()%>
        </td>
    </tr>
</table>