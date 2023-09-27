<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>

	<h2>포워딩하는 페이지: forwardTagFrom2.jsp</h2>

<%
   request.setCharacterEncoding("utf-8");

   String name = request.getParameter("name");
   String selectedColor = request.getParameter("color");
%>
<%-- \" 쌍따옴표 내부에 문자열을 넣기 위해 escape 문자 사용 --%>
<jsp:forward page="<%=selectedColor+\".jsp\"%>">
    <jsp:param name="selectedColor" value="<%=selectedColor%>"/>
	<jsp:param name="name" value="<%=name%>"/>
</jsp:forward>