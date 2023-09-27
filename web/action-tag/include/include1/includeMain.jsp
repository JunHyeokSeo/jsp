<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>

	<h1>포함하는 페이지 includeMain.jsp 입니다.</h1>

	<%
		request.setCharacterEncoding("utf-8");
	%>

	<hr>

	<jsp:include page="includeSub.jsp" flush="false"/>
	includeMain.jsp의 나머지 내용입니다.

	</body>
</html>