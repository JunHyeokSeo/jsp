<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%--request 객체의 범위 : forward로 넘긴 페이지까지 (보통 한번 넘기는 것이 일반적이지만 현재 예제에서는 forward를 두번 연속 사용한다)--%>
    <%--forward로 넘길수록 request 객체의 범위가 늘어난다.--%>
    <%--오직 forward로 넘겨야만 request 객체가 유지된다.--%>
    ID : <%=request.getParameter("id")%> <br>
    password : <%=request.getParameter("password")%> <br>
    
    request 객체로 공유한 값 출력 <br>
    <%=request.getAttribute("name")%>