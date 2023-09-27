<%@ page contentType="text/html;charset=utf-8"%>

<html>
	<body>
	<h2>포워딩하는 페이지: forwardFrom1.jsp</h2>

	<%
        //화면에 출력이 되지 않지만, 인코딩은 적용이 됨
		request.setCharacterEncoding("utf-8");
	%>

    <%--forward가 있는 화면은 출력되지 않음--%>
   forwardFrom1.jsp의 내용 입니다.<br>
   화면에 절대 표시 안됩니다.

	<%	// request 객체로 공유 설정
		request.setAttribute("name","홍길동");
	%>
	
	<jsp:forward page="forwardTo1.jsp"/>  

	</body>
</html>