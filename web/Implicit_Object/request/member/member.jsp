<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/25
  Time: 2:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");
    String name = request.getParameter("name");
    String jumin1 = request.getParameter("jumin1");
    String jumin2 = request.getParameter("jumin2");
    String mailid = request.getParameter("mailid");
    String domain = request.getParameter("domain");
    String tel1 = request.getParameter("tel1");
    String tel2 = request.getParameter("tel2");
    String tel3 = request.getParameter("tel3");
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String post = request.getParameter("post");
    String address = request.getParameter("address");
    String gender = request.getParameter("gender");

    String[] hobby = request.getParameterValues("hobby");
    String h = ""; // String h = "공부-게임-등산"
    for (String tmp: hobby) {
        h += tmp + '-';
    }

    String intro = request.getParameter("intro");
	String introduce =request.getParameter()
%>
취미 : <%=h%>
