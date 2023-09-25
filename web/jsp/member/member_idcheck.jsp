<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.example.dao.MemberDAOImpl" %>
<%
 request.setCharacterEncoding("UTF-8");
 
 String id=request.getParameter("memid"); 
 System.out.println("id="+id);		// id="test";
 
 MemberDAOImpl md=new MemberDAOImpl();

 int re = md.checkMemberId(id);
 // re=1  이면 중복ID
 // re=-1 이면 사용가능ID

 // 웹브라우저에 출력되는 값이 callback함수로 리턴된다.
//  out.println(re);
%>
 
<%=re%>