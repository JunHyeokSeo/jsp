<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="upload.BoardDataBean" %>
<%@ page import="upload.BoardDBBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
	// 업로드할 디렉토리 path 구하기
	String path = request.getRealPath("upload");
	System.out.println("path:"+ path);

	// 첨부파일의 크기(단위:Byte) : 1MB
	int size = 1024 * 1024;

	//파일을 수정할수도 안할수도 있다.
    //파일을 수정하지 않는다면 file에 null값이 들어간다.
    //따라서 첨부파일을 선택했을 때와 하지 않았을 때 두가지 경우를 구분하여 작성해야 한다.
    MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

    int num = Integer.parseInt(multi.getParameter("num"));
    String nowPage = multi.getParameter("page");
    String writer = multi.getParameter("writer");
    String subject = multi.getParameter("subject");
    String email = multi.getParameter("email");
    String content = multi.getParameter("content");
    String passwd = multi.getParameter("passwd");

    String OriginalFileName = multi.getOriginalFileName("upload");
    String FileSystemName = multi.getFilesystemName("upload");

    BoardDataBean board = new BoardDataBean();
    board.setNum(num);
    board.setWriter(writer);
    board.setEmail(email);
    board.setSubject(email);
    board.setContent(content);
    board.setPasswd(passwd);
    board.setIp(request.getRemoteAddr());
//    board.setUpload(FileSystemName);

    BoardDBBean dao = BoardDBBean.getInstance();
    BoardDataBean db = dao.getContent(num);

    if (FileSystemName != null) {               //첨부파일을 수정한 경우
        board.setUpload(FileSystemName);
    } else {                                    //첨부파일을 수정하지 않은 경우
        board.setUpload(db.getUpload());
    }

    if (db.getPasswd().equals(passwd)) {        //비번이 일치한 경우
        int result = dao.update(board);
		if (result == 1){
%>
        <script>
            alert("글수정 성공");
            location.href = 'list.jsp?page<%=nowPage%>';
        </script>
<%      }
	} else {                                   //비번이 일치하지 않은 경우
%>
            <script>
                alert("비번이 일치하지 않습니다.");
                history.go(-1);
            </script>
<%    }     %>