<%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/09/27
  Time: 12:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--공통부분을 모듈화 한 뒤, content만 parameter로 전달하여 각기 다른 페이지를 생성--%>
<jsp:forward page="templateTest.jsp" >
    <jsp:param name="CONTENTPAGE" value="comp.jsp"/>
</jsp:forward>