<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table align="center">
		<caption>일정 추가</caption>
		<tr align="center">
			<td>일정 제목</td>
			<td><input type="text" name="title"></td>			
		</tr>
		<tr align="center">
			<td>시작 날짜</td>
			<td><input type="date" name="start"></td>			
		</tr>
		<tr align="center">
			<td>종료 날짜</td>
			<td><input type="date" name="end"></td>			
		</tr>
		<tr align="center">
			<td>표시 색깔</td>
			<td><input type="color" name="color"></td>			
		</tr>
		<tr align="center">
			<td colspan="2">
				<button id="addBtn" type="button">추가</button>
			</td>
		</tr>
	
	</table>	

	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

	<script type="text/javascript">
		// Ajax 기술 활용! -> Jquery 라이브러리도 필요하다

		// jquery 방식으로 사용하고자 하는 버튼 선택
		var addbtn = $('#addBtn');
		var title = $('input[name=title]');
		var start = $('input[name=start]');
		var end = $('input[name=end]');
		var color = $('input[name=color]');
		
		// button 이벤트 연결하기
		addbtn.on('click', request);
		
		// 연결될 function 생성
		function request() {
			console.log("클릭!");

			$.ajax({				
				url : 'addCalData.do', // 어디로 요청을 보낼건지
				type : 'post', // get or post
				data : {
					title : title.val(), 
					start : start.val(), 
					end : end.val(), 
					color : color.val() 
				},
				success : function(res) { // res : response
					// 요청이 성공이면 실행할 내용
					console.log('addCalData 요청 성공');
					window.close();
				},
				error : function(e) {
					// 요청이 실패라면 실행할 내용
					alert('addCalData 요청 실패');
				}
			});
		}
	</script>


</body>
</html>