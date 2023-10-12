<%@ page import="reboard.ReBoardDataBean" %>
<%@ page import="reboard.ReBoardDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/12
  Time: 11:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int page_size = 10;

    String pageNum = request.getParameter("page");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);

    int count = 0;
    ReBoardDBBean dao = ReBoardDBBean.getInstance();
    count = dao.getCount();

    int startRow = (currentPage - 1) * page_size + 1;
    int endRow = currentPage * page_size;

    List<ReBoardDataBean> list = null;
    if (count > 0) {
        list = dao.getList(startRow, endRow);
    }
	if (count == 0){
%>
        작성된 글이 없습니다
<%  } else { %>
        <a href="writeForm.jsp">글작성</a>
        글갯수 : <%=count%>개
        <table border="1" width="700" align="center">
            <caption>게시판 목록</caption>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
                <th>IP주소</th>
            </tr>
<%
        int number = count - (currentPage - 1) * page_size;
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < list.size(); i++) {
            ReBoardDataBean board = list.get(i);
%>
            <tr>
                <td><%=number--%></td>
                <td>
<%
                    //댓글 제목 앞 여백추가
                    //level != 0 || step != 0 : 댓글
                    if (board.getRe_level() > 0){   //댓글
                        for (int j = 0; j <= board.getRe_level(); j++) {
%>
							&nbsp;&nbsp;
<%                        }
                    }
%>
                    <a href="content.jsp?num=<%=board.getNum()%>&page=<%=currentPage%>"><%=board.getSubject()%></a>
                </td>
                <td><%=board.getWriter()%></td>
                <td><%=sd.format(board.getReg_date())%></td>
                <td><%=board.getReadcount()%></td>
                <td><%=board.getIp()%></td>
            </tr>
<%
        }
%>
        </table>
<%  }   %>

<center>
    <%
        if (count > 0) {
            int pageCount = count / page_size + ((count % page_size == 0) ? 0 : 1);
            int block = 10;
            int startPage = (((currentPage - 1) / block) * block + 1);
            int endPage = startPage + block - 1;

            if (endPage > pageCount) {
                endPage = pageCount;
			}
    %>
            <%--전체 목록 단위 이동 - 첫 페이지로 이동--%>
            <a href="list.jsp?page=1" style="text-decoration: none"> < </a>
    <%
            if (startPage > block) {
    %>
                <%--블럭 단위 이동--%>
                <a href="list.jsp?page=<%=startPage - 1%>">[이전]</a>
	<%
            }
            for (int i = startPage; i <= endPage; i++) {
                if (i == currentPage) {
    %>
					[<%=i%>]
    <%          } else {    %>
                    <a href="list.jsp?page=<%=i%>">[<%=i%>]</a>
    <%          }
            }
            if (endPage < pageCount) {
    %>
                <%--블럭 단위 이동--%>
                <a href="list.jsp?page=<%=startPage + block%>">[다음]</a>
    <%      }   %>
                <%--전체 목록 단위 이동 - 마지막 페이지로 이동--%>
                <a href="list.jsp?page=<%=pageCount%>" style="text-decoration: none"> > </a>
    <%
        }
    %>
</center>