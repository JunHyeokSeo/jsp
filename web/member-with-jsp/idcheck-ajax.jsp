<%@ page import="member.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/06
  Time: 11:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
//    System.out.println(id);
    MemberDAO dao = MemberDAO.getInstance();
    int result = dao.memberAuth(id);
//    System.out.println(result);

    //웹 브라우저에 출력되는 값이 콜백함수로 리턴된다
    out.print(result);
%>
