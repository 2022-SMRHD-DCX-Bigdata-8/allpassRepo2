<%@page import="com.smhrd.entity.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 뭔지 모르겠음 일단 혹시 모르니 임시 저장
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
	-->

<!-- Fullcalendar CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<!-- Fullcalendar core CDN -->
<!-- <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

<!-- Fullcalendar interaction CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.8/index.global.min.js"></script>

<!-- Fullcalendar daygrid CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.5/index.global.min.js"></script>

<!-- Fullcalendar timegrid CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/timegrid@6.1.8/index.global.min.js"></script>

<!-- Fullcalendar list CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/list@6.1.8/index.global.min.js"></script>

<!-- Fullcalendar multimonth CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@fullcalendar/multimonth@6.1.8/index.global.min.js"></script>

<!-- 풀캘린더 언어 설정관련 CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<!-- 제이쿼리 스크립트 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<!-- 캘린더 관련 스크립트 -->
<script type="text/javascript">
	
		// calendar를 전역변수로 선언
		var calendar = null;

	
		// 캘린더 출력하기 위한 코드
		document.addEventListener('DOMContentLoaded', function() {
			var Calendar = FullCalendar.Calendar;

			var calendarEl = document.getElementById('calendar');

			calendar = new Calendar(calendarEl, {
				initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
				headerToolbar : { // 헤더에 표시할 툴 바
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				editable : true, // 일정 수정 가능 여부
				locale : 'ko',  // 한국어 설정
				navLinks : true, // 달력에 날짜 클릭시 해달 날짜의 일별달력으로 이동
				selectable : true,  // 달력 일자 드래그 설정가능
				nowIndicator : true, // 현재 시간 마크
				select: function(info){
					var url = "goAddSchedule.do";
					var name = "addSchedule";
					var option = "width=500, height=500, scrollbars=no, status=no, toolbars=no, location=no"
					window.open(url, name, option);
					console.log("날짜클릭");
				}, 
				timeZone: 'UTC' , 
				events: [
					$.ajax({
						type: "get" ,
						url: "calList.do" , 
						data: "{}" ,
						success: function(response){
							result = response.result
							for(var i = 0 ; i < result.length ; i++){
								calendar.addEvent({
									id: result[i]['mb_id'], 
									title: result[i]['cal_title'] ,
									start: result[i]['started_at'], 
									end: result[i]['ended_at'], 
									color: result[i]['cal_color'] 
								})
							}
						}
					})					
				]
				
				/*events:[{					
					
					id: 'a' , 
					title: 'test' , 
					start: '2023-08-17' , 
					end: '2023-08-20', 
					backgroundColor: '#a2c6ff'
				}]*/
			});
			
			//var event = calendar.getEventById("a");
			//var start = event.start;
			//var end = event.end;

			// 캘린더 렌더링
			calendar.render();	
			
			/*calendar.on('dateClick', function(info) {
				var url = "goAddSchedule.do";
				var name = "addSchedule";
				var option = "width=500, height=500, scrollbars=no, status=no, toolbars=no, location=no"
				window.open(url, name, option);
				console.log("날짜클릭");
			});*/

		});
		// 캘린더 출력하기 위한 코드
		// ================================================
			
	
	</script>

</head>
<body>


	<!-- 캘린더가 출력되는 div -->
	<div id="calendar" style="float: left; width: 70%"></div>


</body>
</html>