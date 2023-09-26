<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Enumeration"%>
<html>
<head>
<title>Attribute Test</title>
</head>
<body>
	<h2>영역과 속성 테스트</h2>
	<table border="1">
		<tr>
			<td colspan="2">Application 영역에 저장된 내용들</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=application.getAttribute("name")%></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><%=application.getAttribute("id")%></td>
		</tr>
	</table>
	<br>
	<table border="1">
		<tr>
			<td colspan="2">Session 영역에 저장된 내용들</td>
		</tr>
        <%--name 값을 알지 못하는 경우--%>
		<%
		Enumeration e = session.getAttributeNames();
		while (e.hasMoreElements()) {
			String attributeName = (String) e.nextElement();
			String attributeValue = (String) session.getAttribute(attributeName);
		%>
		<tr>
			<td><%=attributeName%></td>
			<td><%=attributeValue%></td>
		</tr>
		<%
		}
		%>
        <%--name 값을 알고 있는 경우--%>
        <tr>
            <td>email</td>
            <td><%=session.getAttribute("email")%></td>
        </tr>
        <tr>
            <td>address</td>
            <td><%=session.getAttribute("address")%></td>
        </tr>
        <tr>
            <td>tel</td>
            <td><%=session.getAttribute("tel")%></td>
        </tr>
	</table>
</body>
</html>
