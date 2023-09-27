<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<center>
<H2>계산</H2>
선택한 상품 목록
<hr>
<%
	// session scope 에 저장된 productlist 라는 이름의 ArrayList 객체를 가져옴.
	ArrayList list = (ArrayList)session.getAttribute("productlist");

	// 선택한 상품이 하나도 없는 경우
	if(list == null) {
		out.println("선택한 상품이 없습니다.!!!");
	}
	else {

		// 선택한 상품이 있을 경우 리스트를 출력함.
		for(Object productname:list) {
			out.println(productname+"<br>");
		}
	}
%>
</center>
</body>
</html>