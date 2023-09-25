<%@ page contentType = "text/html; charset=utf-8" %>

<%!
    /**소스 코드 보기에도 나타나지 않음**/

	/** a와 b의 합을 리턴한다. **/
	public int add(int a, int b) {
		return a + b;
	}
%>

<html>
<head><title>자바 주석</title></head>

<body>

<%
	int val1 = 10; // val1에 10을 할당
	int val2 = 20; // val2에 20을 할당
	
	/* va1과 va2의 값을 더한 결과를
	   result에 할당한다. */
	int result = add(val1, val2);
%>

<%--
표현식 태그 내부에 주석 작성 가능.
코드상에도 보이지 않음
다만, 다중행 태그만 사용 가능
--%>
<%= val1 %> + <%= val2 %> = <%= result /* 결과는? */ %>

</body>
</html>