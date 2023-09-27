<%@ page contentType="text/html;charset=utf-8"%>

<%
	String name = request.getParameter("name");
%>

포함되는 페이지 includeSub.jsp 입니다.<p>
<b><%=name%> 님 어서 오세요 !!</b>
<hr>