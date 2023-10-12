<%@ page import="board.BoardDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardDataBean" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/10
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
<html>
<head>
    <title>게시판 목록</title>
</head>
<body>
<%
    // 검색 항목과 검색어를 받는 부분
    String sel = request.getParameter("sel");
    String find = request.getParameter("find");

    //1. 한 화면(페이지)에 출력할 데이터 개수
    int page_size = 10;

    String pageNum = request.getParameter("page");
    if (pageNum == null) {
        pageNum = "1";  //최근글이 보이는 페이지
    }

    //2. 현재 페이지 번호
    int currentPage = Integer.parseInt(pageNum);

    //3. 총 데이터 갯수
    int count = 0;
    BoardDBBean dao = BoardDBBean.getInstance();
    count = dao.getCount(sel, find);
    //    System.out.println("count : " + count);

    //startRow : 각 page에 추출할 데이터의 시작번호
    //endRow : 각 page에 추출할 데이터의 끝번호
    int startRow = (currentPage - 1) * page_size + 1;
    int endRow = currentPage * page_size;

    List<BoardDataBean> list = null;
    if (count > 0) {
        list = dao.getList(startRow, endRow, sel, find);
    }
//    System.out.println("list : " + list);
    if (count == 0) {
%>
작성된 글이 없습니다.
<% } else {%>
<a href="writeForm.jsp">글작성</a>
글갯수 : <%=count%>
<table border="1" width="700" align="center">
    <caption>게시판 목록</caption>
    <tr>
        <%--NUM : 게시판 고유번호, 번호 : 특정 데이터를 추출할 때 새로 부여하는 임의의 번호--%>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
        <th>IP주소</th>
    </tr>
    <%
        //number : 브라우저의 각 페이지에 출력될 시작번호
        int number = count - (currentPage - 1) * page_size;
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        for (int i = 0; i < list.size(); i++) {
            BoardDataBean board = list.get(i);
    %>
    <tr>
        <td><%=number--%>
        </td>
        <td>
            <a href="content.jsp?num=<%=board.getNum()%>&page=<%=currentPage%>&sel=<%=sel%>&find=<%=find%>"><%=board.getSubject()%></a>
        </td>
        <td><%=board.getWriter()%>
        </td>
        <td><%=sd.format(board.getReg_date())%>
        </td>
        <td><%=board.getReadcount()%>
        </td>
        <td><%=board.getIp()%>
        </td>
    </tr>
    <% } %>
</table>
<% } %>

<%--페이지 링크--%>
<center>
    <%
        if (count > 0) {
            //4. pageCount : 총 페이지 수
            //page_size로 딱 나누어 떨어지면 몫 그대로 사용, 그렇지 않다면 1 추가
            int pageCount = count / page_size + ((count % page_size) == 0 ? 0 : 1);

            //startPage : 각 블럭의 시작 페이지 번호 : 1, 11, 21 ...
            //endPage : 각 블럭의 끝 페이지 번호 : 10, 20, 30,,
            int startPage = ((currentPage - 1) / 10) * 10 + 1;
            int block = 10;     // 블럭 1개의 크기 : 10개의 페이지로 구성
            int endPage = startPage + block - 1;

			//내용이 없는 페이지 제외
            if (endPage > pageCount) {
                endPage = pageCount;
            }

    %>
            <%-- 1page로 이동--%>
            <a href="list.jsp?page=1&sel=<%=sel%>&find=<%=find%>" style="text-decoration: none"><</a>
    <%
        //이전 블럭으로 이동
        if (startPage > 10) { %>
        <a href="list.jsp?page=<%=startPage-1%>&sel=<%=sel%>&find=<%=find%>">[이전]</a>
    <%  }   %>
    <%
            for (int i = startPage; i <= endPage; i++) {
				if (i == currentPage){
    %>
                    [<%=i%>]
                <% } else { %>
                    <a href="list.jsp?page=<%=i%>&sel=<%=sel%>&find=<%=find%>">[<%=i%>]</a>
                <%  } %>
    <%
            }

	//다음 블럭으로 이동
    if (endPage < pageCount) { %>
    <a href="list.jsp?page=<%=endPage+1%>&sel=<%=sel%>&find=<%=find%>">[다음]</a>
    <%  }   %>
            <%-- 마지막 page로 이동--%>
            <a href="list.jsp?page=<%=pageCount%>&sel=<%=sel%>&find=<%=find%>" style="text-decoration: none">></a>
    <%
        }
    %>
</center>
<br><br><br>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    $(function () {
        $('form').submit(function () {
            if ($('select').val() === "") {
                alert('검색할 항목을 선택하세요.');
                return false;
            }

            if ($('#find').val() === "") {
                alert('검색어를 입력하세요.');
                $('#find').focus();
                return false;
            }
        });
    });
</script>
<center>
    <form action="list.jsp">
        <select name="sel" id="sel">
            <option value="">검색</option>
            <option value="writer">작성자</option>
            <option value="subject">제목</option>
            <option value="content">내용</option>
        </select>
        <input type="text" name="find" id="find">
        <input type="submit" value="검색">
    </form>
</center>
</body>
</html>
