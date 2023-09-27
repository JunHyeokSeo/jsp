<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/25
  Time: 12:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String writer = request.getParameter("writer");
    String passwd = request.getParameter("passwd");
    String subject = request.getParameter("subject");

	//줄바꿈 미적용
    String content01 = request.getParameter("content");

    //줄바꿈을 유지한 채 내용 가져오기
    //replace("\n", "<br>") : \n을 <br> 태그로 치환 시킨다
    String content02 = request.getParameter("content").replace("\n", "<br>");
%>

작성자 : <%=writer%><br>
비밀번호 : <%=passwd%><br>
제목 : <%=subject%><br>
<%--
    줄바꿈 미적용 --%>
내용(줄바꿈 미적용) : <%=content01%><br><br>

<%--
    줄바꿈 적용 - 방법 1
    pre 태그 : 입력한 형태 그대로 보여주는 태그 --%>
내용(pre 태그를 사용한 줄바꿈 적용) : <pre><%=content01%></pre><br>


<%--
    줄바꿈 적용 - 방법 2
    String 객체의 replace 메소드 사용 --%>
내용03(replace 메소드를 사용한 줄바꿈 적용) : <br><%=content02%><br>

