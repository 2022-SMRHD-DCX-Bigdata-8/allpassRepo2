<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 메인 페이지</title>
</head>
<style>
.submit {
	margin-top: 50px;
	width: 80%;
}

.submit input {
	width: 50%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: linear-gradient(to left, #aec6ff, #e2bf8a);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>
<body>
	<%-- Get the email and nickname values from the session --%>
	<%
	Member user = (Member) session.getAttribute("user");

	String email = (String) session.getAttribute("email");
	String nickname = (String) session.getAttribute("nickname");
	%>


	<%-- 카카오 로그인 사용자의 경우 카카오 정보를 보여줌 --%>
	<%-- 일반 로그인 사용자의 경우 일반 정보를 보여줌 --%>
	<%
	if (nickname != null) {
	%>
	<p>카카오 로그인 시</p>
	<p>
		이메일 :
		<%=email%></p>
	<p>
		닉네임 :
		<%=nickname%></p>
	<%
	}
	%>

	<%
	if (user != null) {
	%>
	<p>일반 로그인 시</p>
	<p>
		아이디 :
		<%=user.getMb_id()%></p>
	<p>
		닉네임 :
		<%=user.getMb_nick()%></p>

	<h1>
		<<span style="color: blue"><%=user.getMb_nick()%></span>>님의 임시 메인
		페이지입니다~
	</h1>

	<%
	}
	%>

	<a href="goCalendar.do">캘린더 가기</a>
	<br>
	<a href="goTodo.do">투두리스트 가기</a>
	<div class="submit">
		<a href="logout.do" onclick="alert('로그아웃되었습니다!'), alert('메인 페이지1로 이동합니다.')"><input type="submit" value="LOGOUT" style="cursor: pointer"></a>
	</div>

	<script>
    // 카카오 로그인한 사용자 세션에서 이메일 및 닉네임 값 가져오기
    var email = '<%=session.getAttribute("email")%>';
    var nickname = '<%=session.getAttribute("nickname")%>
		';

		// Send the data to the servlet
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'StoreKakaoInfoServlet', true);
		xhr.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded');
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				// Handle the response if needed
			}
		};
		var data = 'email=' + encodeURIComponent(email) + '&nickname='
				+ encodeURIComponent(nickname);
		xhr.send(data);
	</script>

</body>
</html>
