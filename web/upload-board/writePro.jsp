<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="upload.BoardDataBean" %>
<%@ page import="upload.BoardDBBean" %><%--
  Created by IntelliJ IDEA.
  User: jun
  Date: 2023/10/16
  Time: 10:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getServletContext().getRealPath("upload");
    System.out.println("path" + path);

    int size = 1024 * 1024;

    MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    String writer = multi.getParameter("writer");
    String subject = multi.getParameter("subject");
    String email = multi.getParameter("email");
    String content = multi.getParameter("content");
    String passwd = multi.getParameter("passwd");

    String OriginalUploadFileName = multi.getOriginalFileName("upload");
    String FileSystemName = multi.getFilesystemName("upload");

    BoardDataBean board = new BoardDataBean();
	board.setWriter(writer);
	board.setEmail(email);
	board.setSubject(subject);
	board.setContent(content);
	board.setPasswd(passwd);
	board.setIp(request.getRemoteAddr());
	board.setUpload(FileSystemName);

    BoardDBBean dao = BoardDBBean.getInstance();
    int result = dao.insert(board);

    if (result == 1) {
%>
        <script>
            alert('글작성 성공');
            location.href = 'list.jsp';
        </script>
<%  } else {%>
        <script>
            alert('글작성 실패');
            history.go(-1);
        </script>
<%  } %>