<%@ page import="reboard.ReBoardDBBean" %>
<%@ page import="reboard.ReBoardDataBean" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/12
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("page");

    ReBoardDBBean dao = ReBoardDBBean.getInstance();

	//조회수 1 증가 + 상세정보(DTO 객체) 구하기
    ReBoardDataBean board = dao.updateContent(num);

	//부모글 정보 구하기
    int ref = board.getRef();
	int re_level = board.getRe_level();
    int re_step = board.getRe_step();

	String content = board.getContent().replace("\n", "<br>");
    SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<html>
<head>
    <title>상세 페이지</title>
</head>
<body>
<table border="1" width="400" align="center">
    <caption>상세 페이지</caption>
    <tr>
        <td>번호</td>
        <td><%=board.getNum()%></td>
        <td>조회수</td>
        <td><%=board.getReadcount()%></td>
    </tr>
    <tr>
        <td>작성자</td>
        <td><%=board.getWriter()%></td>
        <td>작성일</td>
        <td><%=sd.format(board.getReg_date())%></td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3"><%=board.getSubject()%></td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3">
            <pre><%=board.getContent()%></pre>
            <%=content%>
        </td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <input type="button" value="댓글" onclick="location.href='replyForm.jsp?num=<%=num%>&page=<%=nowPage%>&ref=<%=ref%>&re_level=<%=re_level%>&re_step=<%=re_step%>'">
            <input type="button" value="수정" onclick="location.href='updateForm.jsp'">
            <input type="button" value="삭제" onclick="location.href='deleteForm.jsp'">
            <input type="button" value="목록" onclick="location.href='list.jsp?page=<%=nowPage%>'">
        </td>
    </tr>
</table>
</body>
</html>
