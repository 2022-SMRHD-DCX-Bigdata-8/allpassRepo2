<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$("#join_id_input").keyup(function() {
			var username = $(this).val();
			$.ajax({
				type : "GET",
				url : "checkUsername.jsp", // 중복 확인을 처리할 서블릿 경로
				data : {
					username : username
				},
				success : function(res) {

					console.log(res.length, res)
					var span = $("#usernameError");
					if (res.trim() === "true") {
						span.html("이미 사용 중인 아이디입니다!").css("color", "red");
					} else {
						span.html("사용가능한 아이디입니다.").css("color", "black");

					}
				}
			});
		});
	});
</script>

<script>
	$(document).ready(function() {
		$("#join_nick_input").keyup(function() {
			var usernick = $(this).val();
			$.ajax({
				type : "GET",
				url : "checkNick.jsp", // 중복 확인을 처리할 서블릿 경로
				data : {
					usernick : usernick
				},
				success : function(res) {

					console.log(res.length, res)
					var span = $("#userNickError");
					if (res.trim() == "true") {
						span.html("이미 사용 중인 닉네임입니다!").css("color", "red");
					} else {
						span.html("사용가능한 닉네임입니다.").css("color", "black");

					}
				},
				error : function(e) {
					alert("실패");
				}
			});
		});
	});
</script>



<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/53a8c415f1.js"
	crossorigin="anonymous" rel="stylesheet"></script>
<!-- <link rel="stylesheet" href="./login.css"> -->
</head>


<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

.wrap {
	width: 100%;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #d6c1a1;
}

.join {
	width: 30%;
	height: 840px;
	background: white;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	color: #7c653f;
}

h2 {
	color: #3f4756;
	font-size: 2em;
}

.join_sns {
	padding: 20px;
	display: flex;
}

.join_sns li {
	padding: 0px 15px;
}

.join_sns a {
	width: 50px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 10px;
	border-radius: 50px;
	background: white;
	font-size: 20px;
	box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px
		rgba(0, 0, 0, 0.1);
}

.join_id {
	margin-top: 20px;
	width: 80%;
}

.join_id input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.join_pw {
	margin-top: 20px;
	width: 80%;
}

.join_pw input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.join_pwcheck {
	margin-top: 20px;
	width: 80%;
}

.join_pwcheck input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.join_phone {
	margin-top: 20px;
	width: 80%;
}

.join_phone input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.join_nick {
	margin-top: 20px;
	width: 80%;
}

.join_nick input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.join_img {
	margin-top: 20px;
	width: 80%;
}

.join_img input {
	width: 100%;
	height: 50px;
	margin-top: 10px;
	padding: 0px 20px;
	outline: none;
}

.join_etc {
	align-content: center;
	padding: 10px;
	width: 80%;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
}

.submit {
	margin-top: 50px;
	width: 80%;
}

.submit input {
	width: 100%;
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


	<form action="join">
	<div class="wrap">
		<div class="join">
			<h2>회원가입</h2>
			<div class="join_id">
				<h4>아이디</h4>
				<input type="text" name="join_id" id="join_id_input"
					placeholder="ID"> <span id="usernameError"></span>
			</div>
			<div class="join_pw">
				<h4>비밀번호</h4>
				<input type="password" name="join_pw" id="join_pw_input" placeholder="Password" >
			</div>

			<div class="join_pwcheck">
				<h4>비밀번호 확인</h4>
				<input type="password" name="join_pwcheck" id="join_pwcheck_input"
					placeholder="Password_check">
			</div>


			<div class="join_phone">
				<h4>전화번호</h4>
				<input type="tel" name="join_phone" id="" placeholder="전화번호">
			</div>

			<div class="join_nick">
				<h4>닉네임</h4>
				<input type="text" name="join_nick" id="join_nick_input"
					placeholder="ID"> <span id="userNickError"></span>


			</div>
			<div class="join_img">
				<h4>프로필 사진</h4>
				<input type="file" name="join_img" accept="image/*">
			</div>


			<div class="join_etc"></div>

			<div class="submit">
				<input type="submit" value="JOIN" style="cursor: pointer"
					onclick="submitForm()">
			</div>
		</div>
	</div>
</form>
	<script>
		function submitForm() {
			event.preventDefault(); // 폼 전송 이벤트 막기
			var username = $("#join_id_input").val();
			var usernick = $("#join_nick_input").val();
			 var password = $("#join_pw_input").val();
		        var passwordCheck = $("#join_pwcheck_input").val();

		        if (password !== passwordCheck) {
		            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다. 다시 입력하세요!");
		            return;
		        }
			$.ajax({
				type : "GET",
				url : "checkUsername.jsp",
				data : {
					username : username
				},
				success : function(res) {
					if (res.trim() === "true") {
						alert("이미 사용 중인 아이디입니다. 다시 입력하세요!");
					} else {
						$.ajax({
							type : "GET",
							url : "checkNick.jsp",
							data : {
								usernick : usernick
							},
							success : function(res) {
								if (res.trim() === "true") {
									alert("이미 사용 중인 닉네임입니다. 다시 입력하세요!");
								} else {
									$("form")[0].submit();
									alert("회원가입 완료!");
									resetForm();
								}
							},
							error : function(e) {
								alert("닉네임 중복 확인 실패");
							}
						});
					}
				},
				error : function(e) {
					alert("아이디 중복 확인 실패");
				}
			});
		}
	
		function resetForm() {
			$("#join_id_input").val("");
			$("#join_pw_input").val("");
		    $("#join_pwcheck_input").val("");
			$("#join_nick_input").val("");
			$("#usernameError").html("");
			$("#userNickError").html("");
		}
	</script>
	
</body>
</html>