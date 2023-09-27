<%@ page contentType="text/html;charset=utf-8"%>

<%
    // 한글 인코딩
    // 1. form 파일에서 한글값이 get 방식으로 전송될 때는 tomcat이 자동으로 utf-8로 인코딩 해줌
    // 2. form 파일에서 한글값이 post 방식으로 전송될 때는 자동으로 인코딩 되지 않으므로 직접 인코딩 해야함

    // 위치도 중요함. 값을 받는 코드보다 상단에 정의되어 있어야 한다.

    // 폼파일에서 한글값이 post방식으로 전송될때 utf-8로 인코딩을 시켜주는 역할
	request.setCharacterEncoding("utf-8");
%>

<html>
<h1>Request 객체1</h1>

<%
	String name = request.getParameter("name");
	String studentNum = request.getParameter("studentNum");
	String gender = request.getParameter("gender");
	String major = request.getParameter("major");
%>

<body>
성명: <%=name%><p>
학번: <%=studentNum%><p>
성별 : <%=gender%><p>
전공 : <%=major%>
</body>
</html>

