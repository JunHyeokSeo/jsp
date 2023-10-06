<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = (String) session.getAttribute("id");
    MemberDAO dao = MemberDAO.getInstance();
    MemberDTO member = dao.getMember(id);

    // hobbies[0]="공부", hobbies[0]="게임", hobbies[0]="등산"
    String[] hobbies = member.getHobby().split(" ");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 수정 폼</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        function openDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    document.getElementById('post').value = data.zonecode;
                    document.getElementById('address').value = data.address;
                }
            }).open();
        }
    </script>

    <!-- 외부 자바스크립트 파일 불러오기 -->
    <script src="member.js"></script>

    <script>
        $(function () {
            //핸드폰 앞자리 선택
            $("#phone1 option[value='<%=member.getPhone1()%>']").attr("selected", true);

            //성별 선택
            $("input:radio[name='gender'][value='<%=member.getGender()%>']").attr("checked", true);

            //취미 선택
            <% for (String hobby : hobbies) { %>
            $("input:checkbox[name='hobby'][value='<%=hobby%>']").attr("checked", true)
            <% } %>

            //뒤로가기
            $('#cancel').click(function () {
                history.go(-1);
            });
        });
    </script>

</head>
<body>

<form method="post" action="update.jsp">
    <%--setProperty로 id 값을 저장 후 update.jsp에 넘겨주기 위함--%>
    <input type="hidden" name="id" value="<%=member.getId()%>">
    <table border=1 align="center">
        <caption>회원 수정 폼</caption>
        <tr>
            <td>ID</td>
            <td><%=member.getId()%></td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td><input type=password id="passwd" name="passwd">
            </td>
        </tr>
        <tr>
            <td>성명</td>
            <td><input type=text id="name" name="name" value="<%=member.getName()%>"></td>
        </tr>
        <tr>
            <td>주민번호</td>
            <td><input type=text size=6 maxlength=6 id="jumin1" name="jumin1" value="<%=member.getJumin1()%>">-
                <input type=text size=7 maxlength=7 id="jumin2" name="jumin2" value="<%=member.getJumin2()%>">
            </td>
        </tr>
        <tr>
            <td>E-Mail</td>
            <td><input type=text size=10 id="mailid" name="mailid" value="<%=member.getMailid()%>">@
                <input type=text size=10 id="domain" name="domain" value="<%=member.getDomain()%>">
                <select id="email">
                    <option value="">직접입력</option>
                    <option value="naver.com">네이버</option>
                    <option value="daum.net">다음</option>
                    <option value="nate.com">네이트</option>
                    <option value="gmail.com">gmail</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td><input type=text size=4 maxlength=4 id="tel1" name="tel1" value="<%=member.getTel1()%>">-
                <input type=text size=4 maxlength=4 id="tel2" name="tel2" value="<%=member.getTel2()%>">-
                <input type=text size=4 maxlength=4 id="tel3" name="tel3" value="<%=member.getTel3()%>">
            </td>
        </tr>
        <tr>
            <td>핸드폰</td>
            <td>
                <select id="phone1" name="phone1" value="<%=member.getPhone1()%>">
                    <option value="">번호선택</option>
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                </select>-
                <input type=text size=4 maxlength=4 id="phone2" name="phone2" value="<%=member.getPhone2()%>">-
                <input type=text size=4 maxlength=4 id="phone3" name="phone3" value="<%=member.getPhone3()%>">
            </td>
        </tr>
        <tr>
            <td>우편번호</td>
            <td><input type=text size=5 maxlength=5 id="post" name="post" value="<%=member.getPost()%>">
                <input type=button value="우편검색" onClick="openDaumPostcode()">
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td><input type=text size=45 id="address" name="address" value="<%=member.getAddress()%>"></td>
        </tr>
        <tr>
            <td>성별</td>
            <td><input type=radio id="male" name="gender" value="남자">남자
                <input type=radio id="female" name="gender" value="여자">여자
            </td>
        </tr>
        <tr>
            <td>취미</td>
            <td><input type=checkbox id="h1" name="hobby" value="공부">공부
                <input type=checkbox id="h2" name="hobby" value="게임">게임
                <input type=checkbox id="h3" name="hobby" value="등산">등산
                <input type=checkbox id="h4" name="hobby" value="낚시">낚시
                <input type=checkbox id="h5" name="hobby" value="쇼핑">쇼핑
            </td>
        </tr>
        <tr>
            <td>자기소개</td>
            <td><textarea rows=5 cols=50 id="intro" name="intro"
                          placeholder="자기소개를 100자 이내로 입력하세요"><%=member.getIntro()%></textarea>
            </td>
        </tr>
        <tr>
            <td colspan=2 align=center>
                <input type=submit value="정보수정">
                <input type=button value="취소" id="cancel">
            </td>
        </tr>
    </table>
</form>

</body>
</html>