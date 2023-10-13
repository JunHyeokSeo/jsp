<%@ page import="reboard.ReBoardDBBean" %>
<%@ page import="reboard.ReBoardDataBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/12
  Time: 4:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board" class="reboard.ReBoardDataBean"/>
<jsp:setProperty name="board" property="*"/>
<%
    board.setIp(request.getRemoteAddr());
    String nowPage = request.getParameter("page");
    ReBoardDBBean dao = ReBoardDBBean.getInstance();
    ReBoardDataBean old = dao.getObject(board.getNum());
    if (old.getPasswd().equals(board.getPasswd())) {
        int result = dao.update(board);
        if (result == 1) {
%>
            <script>
                alert('글수정 성공');
                location.href = "list.jsp?page=<%=nowPage%>";
            </script>
<%      }
    } else { %>
            <script>
                alert("비번이 일치하지 않습니다.");
                history.go(-1);
            </script>
<%  }       %>
