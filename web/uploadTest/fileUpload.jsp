<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%--파일 업로드--%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%--파일 중복문제 해결--%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%
    //직접 생성한 'upload'의 RealPath 반환
	String uploadPath=request.getRealPath("upload");
	System.out.println("path="+uploadPath);

	//첨부파일 크기(단위:Byte) : 10MB
	int size = 10*1024*1024;
	String name="";
	String subject="";
	String filename1="";
	String filename2="";
	String origfilename1="";
	String origfilename2="";

	try{
		//첨부파일은 MultipartRequest 객체를 생성하면서 업로드가 수행된다.
        //cos에는 업로드를 수행하는 별도의 메소드가 없다. 객체 생성하면서 자동으로 업로드가 수행된다. (다른 라이브러리에는 존재한다)
		MultipartRequest multi=new MultipartRequest(request,
													uploadPath, //업로드할 디렉토리 위치
													size,       //첨부파일의 크기
													"utf-8",    //인코딩
								                    new DefaultFileRenamePolicy());

		//request.getParameter로 받을 수 없다.
		name=multi.getParameter("name");
		subject=multi.getParameter("subject");

		//업로드 된 파일의 'name'값을 모를 때, name 값을 아래 메소드로 먼저 구해온다.
		Enumeration files=multi.getFileNames();

		String file1 =(String)files.nextElement();          //String file1 = "fileName1";
        //중복 발생한다면, filename과 origfilename이 서로 다르다.
		filename1=multi.getFilesystemName(file1);		    //실제 서버에 저장된 파일명(중복 문제 해결된 파일명)
		origfilename1= multi.getOriginalFileName(file1);    //클라이언트가 입력한 파일명

// 	    String file2 = "fileName2";
		String file2 =(String)files.nextElement();
		filename2=multi.getFilesystemName(file2);
		origfilename2=multi.getOriginalFileName(file2);

	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html>
<body>
<form name="filecheck" action="fileCheck.jsp" method="post">
	<input type="hidden" name="name" value="<%=name%>">
	<input type="hidden" name="subject" value="<%=subject%>">
	<input type="hidden" name="filename1" value="<%=filename1%>">
	<input type="hidden" name="filename2" value="<%=filename2%>">
	<input type="hidden" name="origfilename1" value="<%=origfilename1%>">
	<input type="hidden" name="origfilename2" value="<%=origfilename2%>">
</form>
<%--onclick : form 객체의 submit 이벤트 발생--%>
<a href="#" onclick="javascript:filecheck.submit()">업로드 확인 및 다운로드 페이지 이동</a>
</body>
</html>
