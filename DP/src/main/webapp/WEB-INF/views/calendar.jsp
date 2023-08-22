<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.entity.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 제이쿼리 스크립트 <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.js"></script>
 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>


<!-- Fullcalendar CSS -->
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<!-- Fullcalendar core CDN -->
<script	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<!-- 풀캘린더 언어 설정관련 CDN -->
<script	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
	
	<style type="text/css">
		
		#calBack{
			width: 1025px;
			height: 650px;
			background: #fff9f0;
			border-radius: 30px;
			
			padding-top: 25px;
			padding-left: 25px;
			
			position: relative;
			
			left: 440px;
			top: 250px;
		}
		
		#calendar {
			width: 1000px;
			height: 625px;			
		}
		
		body{
			background: #d6c1a1;
		}
		
	</style>

</head>
<body>

	<!-- 캘린더가 출력되는 div -->
	<div id="calBack">
		<div id="calendar"></div>
	</div>
	
	
	<!-- <button id="reloadBtn" type="button">캘린더 새로고침</button>
	 -->
	<script type="text/javascript">
		// calendar를 전역변수로 선언
		var calendar = null;
		
		// 컨트롤러에서 만든 JSON데이터들
		<%
			String calList = (String)request.getAttribute("calList");
			String calSession = (String)request.getAttribute("calSession");
			String status = (String)request.getAttribute("status");
		%>
		
		var calListJson = []; // JSON데이터를 배열로 표현하기 위한 함수
		calListJson = <%=calList%>; // 배열로 바뀐 변수에 데이터 넣어주기
		
		console.log("배열로 표현된 JSON : ", calListJson);
		console.log(typeof(calListJson));
		
		// for문 돌리기 위해 길이 구해서 size변수에 넣어주기
		var size = Object.values(calListJson).length ;
		console.log(size);
		
		// 위에서 구한 길이를 활용해서 캘린더에 일정 표시
		for(var i = 0, result=[] ; i < size ; i++) {			
			// 날짜에서 시간부분을 지우기위해 substr 사용
			var start = calListJson[i].started_at.substr(0, 10);
			var end = calListJson[i].ended_at.substr(0, 10);
			// 풀캘린더가 종료날짜를 하루 빼고 적용하길래 임의로 1 더해주기
			var end2 = end.substr(0, 8);
			var day = end.substr(8, 2) * 1 + 1;
			// 일자가 10일 미만인 경우에는 09가 아니라 9로 표시되서
			// 풀캘린더에 표시가 안 되므로 임의로 일자 앞에 0 붙여주기
			if(day < 10){
				day = "0" + day;
			}
			end = end2 + day;
			
			result.push({
				"id": calListJson[i].cal_seq , 
				"title": calListJson[i].cal_title , 
				"start": start , 
				"end": end , 
				"color": calListJson[i].cal_color							
			});
			console.log("일정을 추가하기 위한 반복문 실행");
		};		
		
		// 캘린더 출력하기 위한 코드
		document.addEventListener('DOMContentLoaded', function() {
			var Calendar = FullCalendar.Calendar;
	
			var calendarEl = document.getElementById('calendar');
			
			calendar = new FullCalendar.Calendar(calendarEl, {
				initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				headerToolbar : { // 헤더에 표시할 툴 바
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				//editable : true, // 일정 수정 가능 여부
				//navLinks : true, // 달력에 날짜 클릭시 해달 날짜의 일별달력으로 이동
				nowIndicator : true, // 현재 시간 마크
				selectable : true,  // 달력 일자 드래그 설정가능
				locale : 'ko',  // 한국어 설정
				dateClick: function(info){ // 날짜 클릭시 일정 추가 화면 팝업
					$.ajax({
						url: 'calAddSession.do' , 
						type: 'post' , 
						data: {"start" : info.dateStr} , 
						dataType: 'json' , 
						success: function(res){
							console.log("calSession2로그 : ", typeof(res));
							
							var url = "goAddSchedule.do";
							var name = "addSchedule";
							var option = "left=710, top=100, width=500, height=500, scrollbars=no, status=no, toolbars=no, location=no"
							window.open(url, name, option);
						} , 
						error: function(e){
							alert("goAddSchedule.do 요청실패 : ", e);
						}
					});
					
					
				},  
				eventClick: function(info){ // 일정 클릭시 수정/삭제화면 팝업
					$.ajax({
						url: 'calUpDelSession.do' ,
						type: 'post' , 
						data: {"cal_seq" : info.event.id} , 
						dataType: 'json' , 
						success: function(res){
							console.log("calSession로그 : ", res.started_at);
							
							var url = "goUpDelSchedule.do";
							var name = "upDelSchedule";
							var option = "left=710, top=100, width=500, height=500, scrollbars=no, status=no, toolbars=no, location=no"
							window.open(url, name, option);
						} , 
						error: function(e){
							alert('goUpDelSchedule 요청 실패');
						}						
					});	
					console.log(typeof(info.event));
				} ,				 
				events: result, 
				timeZone: 'UTC'
			});	
			
			// 캘린더 렌더링
			calendar.render();	
			console.log("첫렌더링", calendar);
	
		});
		// 캘린더 출력하기 위한 코드
		// ===============================================
			
		
		
	</script>

</body>
</html>