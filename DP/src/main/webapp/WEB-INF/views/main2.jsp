<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
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
	height: 8%;
	width: 100%;
	padding-top: 5px;
	padding-left: 20px;
}

#username {
	color: #ffffff;
	font-family: 'Cafe24Supermagic-Bold-v1.0';
	font-size: 30px;
}

#logoutBtn {
	margin-top: 0px;
	width: 100px;
	height: 50px;
	border: 1;
	border-bottom-width: 5;
	border-right-width: 5;
	outline: none;
	border-radius: 20px;
	background: linear-gradient(to left, #aec6ff, #e2bf8a);
	color: rgb(255, 255, 255);
	font-size: 1.0em;
	font-weight: bold;
	letter-spacing: 2px;
}

#todoMain {
	width: 27%;
	height: 84%;
	float: left;
	background-color: red;
}

#calMain {
	width: 53%;
	height: 84%;
	float: left;
	background-color: green;
}

#chatMain {
	width: 20%;
	height: 84%;
	float: left;
	background-color: blue;
}

#footer {
	background: linear-gradient(to top, #613f0e 80%, #ffebce);
	width: 100%;
	height: 8%;
	float: left;
	margin: 0;
}
</style>
</head>
<body>
	<%
	Member m = (Member) session.getAttribute("user");
	String email = (String) session.getAttribute("email");
	String nickname = (String) session.getAttribute("nickname");
	%>


	<div id="layout">
		<div id="header">
			<span id="username">
				<%
				if (email != null) {
				%> <%=nickname%> <%
 				} else if (m != null) {
				 %> <%=m.getMb_nick()%>
				<%
				}
				%>님
			</span>
			<a href="logout.do" onclick="alert('로그인 페이지로 이동합니다.')">
			<input type="button" value="LOGOUT" style="cursor: pointer"	onclick="alert('로그아웃 되었습니다!')" id="logoutBtn">
			</a>

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

		<div id="footer"></div>
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
<<<<<<< HEAD



=======
>>>>>>> branch 'main' of https://github.com/2022-SMRHD-DCX-Bigdata-8/allpassRepo2.git
</body>
</html>