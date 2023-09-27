<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>
	
	<h2>includeMain2.jsp 페이지 입니다</h2>

	<%
		request.setCharacterEncoding("utf-8");
		String siteName1 = request.getParameter("siteName1");
	%>

	<hr>
	<jsp:include page="includeSub2.jsp">
		<jsp:param name="siteName" value="<%=siteName1%>"/>
	</jsp:include>

	includeMain2.jsp 페이지의 나머지 내용입니다.<p>

	</body>
</html>