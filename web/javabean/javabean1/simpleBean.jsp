<%@ page contentType="text/html; charset=utf-8" %>

<% request.setCharacterEncoding("utf-8");%>

<%--
useBean은 Java에서 클래스에 대한 객체를 생성하는 것과 같다

<jsp:useBean id="sb" class="javaBeanExam.javaBean.SimpleBean" />  ==  SimpleBean sb = new SimpleBean();

--%>
<jsp:useBean id="sb" class="javaBeanExam.javaBean.SimpleBean" />
<jsp:setProperty name="sb" property="*" />

<html>
	<body>

	<h1>간단한 자바빈 프로그래밍</h1>
	<br>

    <%--자바빈 클래스의 getter 메소드를 호출해서 반환된 property를 브라우저에 출력하는 역할--%>
    <%--
    프로퍼티 방식은 여러개가 있지만 sb.getName 처럼 직접 메소드를 호출하는 방식을 자주 사용
    DAO와 같은 Java 파일에서는 JSP 문법(getProperty) 사용 불가.
    --%>
    이름 : <%=sb.getName()%><br>
    이름 : <jsp:getProperty name="sb" property="name"/><br>
	메시지: <%=sb.getMsg()%><br>
	메시지: <jsp:getProperty name="sb" property="msg" /><br>

	</body>
</html>