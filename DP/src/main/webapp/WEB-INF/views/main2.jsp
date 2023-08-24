<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>임시 메인 페이지</title>
<!-- 부트스트랩5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<style type="text/css">
@font-face {
	font-family: 'Cafe24Supermagic-Bold-v1.0';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/Cafe24Supermagic-Bold-v1.0.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
}

#layout, body, html {
	width: 100%;
	height: 100%;
	/* position을 fixed로 주면 태그를 #layout만 줘도 됨 */
}

body {
	/*background-image: url("assets/img/paper-1468883_1920.jpg");*/
	background-color: #ffebce !important;
	margin: 0 !important;
}

#header {
	background: linear-gradient(to bottom, #613f0e 80%, #ffebce);
	height: 10%;
	width: 100%;
	padding: 15px;
}

#username {
	color: #ffffff;
	font-family: 'Cafe24Supermagic-Bold-v1.0';
	font-size: 30px;
}

#logoutBtn {
	height: 48px;
	width: 100px;
	border-color: #613f0e;
	margin-left: 10px;
	background-color: #ffffff;
}

#todoMain {
	width: 30%;
	height: 80%;
	float: left;
}

#calMain {
	width: 50%;
	height: 80%;
	float: left;
}

#chatMain {
	width: 20%;
	height: 80%;
	float: left;
}

#footer {
	background-color: #613f0e;
	width: 100%;
	height: 10%;
	float: left;
}
</style>
</head>
<body>
	<%
	Member user = (Member) session.getAttribute("user");
	String email = (String) session.getAttribute("email");
	String nickname = (String) session.getAttribute("nickname");
	%>

	<div id="layout">
		<div id="header">
			<%
			if (user != null) {
			%>
			<span id="username"><%=user.getMb_id()%>님</span>
			<%
			} else if (nickname != null) {
			%>
			<span id="username"><%=nickname%>님</span>
			<%
			} ;
			%>
			<a href="logout.do" onclick="alert('로그아웃 되었습니다!')"><button
					type="button" id="logoutBtn">로그아웃</button></a>
		</div>

		<div id="todoMain">
			<jsp:include page="todoList.jsp"></jsp:include>
		</div>
		<div id="calMain">
			<jsp:include page="calendar.jsp"></jsp:include>
		</div>
		<div id="chatMain">
			<jsp:include page="Chatting.jsp"></jsp:include>
		</div>
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