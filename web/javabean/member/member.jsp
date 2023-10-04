<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/04
  Time: 12:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="javaBeanExam.member.MemberDataBean"/>
<jsp:setProperty name="member" property="*"/>

<%--여러개의 취미를 모두 불러오기 위한 방법--%>
<%
    String[] hobbies = request.getParameterValues("hobby");
    String hobby = "";
    for (String h : hobbies)
        hobby += h + " ";
	member.setHobby(hobby);
%>

<table border=1 width=600 align=center>
    <caption>회원 가입폼</caption>
    <tr>
        <th>ID</th>
        <td>
            <%=member.getId()%>
        </td>
    </tr>
    <tr>
        <th>비밀번호</th>
        <td>
            <%=member.getPasswd()%>
        </td>
    </tr>
    <tr>
        <th>성명</th>
        <td>
            <%=member.getName()%>
        </td>
    </tr>
    <tr>
        <th>주민번호</th>
        <td>
            <%=member.getJumin1()%> - <%=member.getJumin2()%>
        </td>
    </tr>
    <tr>
        <th>E-Mail</th>
        <td>
            <%=member.getMailid()%>@<%=member.getDomain()%>
        </td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td>
            <%=member.getTel1()%>-<%=member.getTel2()%>-<%=member.getTel3()%>
        </td>
    </tr>
    <tr>
        <th>핸드폰</th>
        <td>
            <%=member.getPhone1()%>-<%=member.getPhone2()%>-<%=member.getPhone3()%>
        </td>
    </tr>
    <tr>
        <th>우편번호</th>
        <td>
            <%=member.getPost()%>
        </td>
    </tr>
    <tr>
        <th>주소</th>
        <td>
            <%=member.getAddress()%>
        </td>
    </tr>
    <tr>
        <th>성별</th>
        <td>
            <%=member.getGender()%>
        </td>
    </tr>
    <tr>
        <th>취미</th>
        <td>
            <%=member.getHobby()%>
        </td>
    </tr>
    <tr>
        <th>자기소개</th>
        <td>
            <%=member.getIntro()%>
        </td>
    </tr>
</table>