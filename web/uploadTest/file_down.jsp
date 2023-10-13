<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<%--업로드는 라이브러리의 메소드를 사용하지만, 다운로드는 출력스트림을 통해 진행한다--%>
<%--업로드된 파일을 바이너리 형태로 서버에 저장했으므로, 해당 바이너리 코드를 처음부터 끝까지 읽어 배열에 저장하고 이를 출력스트림을 통해 출력하면 다운로드가 된다--%>
<%
    String fileName = request.getParameter("file_name");
    System.out.println("fileName=" + fileName);

    String savePath = "upload";
    //servletContext 객체 생성
    ServletContext context = getServletContext();
    String sDownloadPath = context.getRealPath(savePath);
    // "\\" 사용이유 - 운영체제마다 path 설정이 다름. 각자 운영체제에 맞게 자유롭게 수정 가능
    String sFilePath = sDownloadPath + "/" + fileName;
    System.out.println("sFilePath=" + sFilePath);

    // jsp에서 OutputStream 사용시 IllegalStateException 해결법 : 2줄 추가
    out.clear();
    out = pageContext.pushBody();

    try {
        byte[] b = new byte[4096];
        File oFile = new File(sFilePath);

        FileInputStream in = new FileInputStream(sFilePath);

        String sMimeType = getServletContext().getMimeType(sFilePath);
        System.out.println("sMimeType>>>" + sMimeType);

        // 다운로드 파일의 파일형식(마임타입) 설정
        // octet-stream은 8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
        if (sMimeType == null) sMimeType = "application/octet-stream";

        response.setContentType(sMimeType);

        // 한글 파일명 처리 : 한글 파일명이 깨지는 것을 방지해 준다.
        String sEncoding = new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);

        // 다운로드 파일 헤드 지정
        response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);

        // 출력 스트림 생성 : 위의 15, 16라인과 충돌발생함.
        ServletOutputStream out2 = response.getOutputStream();
        int numRead;

        // 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
        while ((numRead = in.read(b, 0, b.length)) != -1) {
            out2.write(b, 0, numRead);
        }
        out2.flush();
        out2.close();
        in.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

%>
