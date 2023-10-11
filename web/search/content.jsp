<%@ page import="board.BoardDataBean" %>
<%@ page import="board.BoardDBBean" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/11
  Time: 10:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("page");
    String sel = request.getParameter("sel");
    String find = request.getParameter("find");
    BoardDBBean dao = BoardDBBean.getInstance();

	//조회수 1 증가 + 상세정보 구하기
    BoardDataBean board = dao.updateContent(num);

	// content 줄바꿈 구현 - 방법 1.
    String content = board.getContent().replace("\n", "<br>");

    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<html>
<head>
    <title>상세 페이지</title>
</head>
<body>
<table border="1" width="500" align="center">
    <caption>상세 페이지</caption>
    <tr>
        <th>번호</th>
        <td><%=board.getNum()%></td>
        <th>조회수</th>
        <td><%=board.getReadcount()%></td>
    </tr>
    <tr>
        <th>작성자</th>
        <td><%=board.getWriter()%></td>
        <th>작성일</th>
        <td><%=sd.format(board.getReg_date())%></td>
    </tr>
    <tr>
        <th>제목</th>
        <td colspan="3"><%=board.getSubject()%></td>
    </tr>
    <tr>
        <th>내용</th>
        <td colspan="3">
            <%--줄바꿈 구현 - 방법 1.--%>
            <%=content%>
            <%--줄바꿈 구현 - 방법 2.--%>
            <pre><%=board.getContent()%></pre>
        </td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=num%>&page=<%=nowPage%>&sel=<%=sel%>&find=<%=find%>'">
            <input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=num%>&page=<%=nowPage%>&sel=<%=sel%>&find=<%=find%>'">
            <input type="button" value="글목록" onclick="location.href='list.jsp?page=<%=nowPage%>&sel=<%=sel%>&find=<%=find%>'">
        </td>
    </tr>
</table>
</body>
</html>
