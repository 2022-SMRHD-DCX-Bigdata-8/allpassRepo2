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
		
		// 날짜 데이터타입을 문자열로 바꿔주기 위한 클래스 사용
	
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
				events:[
					$.ajax({
						url: 'calList.do' ,
						type: 'post' , 
						data: {"mb_id" : "test"} , 
						dataType: "json" , 
						success: function(res){
							// res[0].started_at.toISOString();
							
							
							console.log('로그 확인', res[0].started_at.substr(0, 10));
							
							for(var i = 0 ; i < res.length ; i++){
								// 날짜에서 시간부분을 지우기위해 substr 사용
								var start = res[i].started_at.substr(0, 10);
								var end = res[i].ended_at.substr(0, 10);
								
								calendar.addEvent({
									title: res[i].cal_title ,
									start: start, 
									end: end, 
									color: res[i].cal_color 
								})
							}
						} , 
						error: function(e){
							alret('calList 요청 실패');
						}
					})					
				] , 
				timeZone: 'UTC', 
				// ====== 이 밑은 시간남으면 부가기능으로 괜찮아 보이는 기능 ====== 
				/*eventAdd: function(obj){ // 일정 추가시 발생하는 이벤트
					console.log('addEvent');					
				} , 
				eventChange: function(obj){ // 일정 수정시 발생하는 이벤트
					console.log('changeEvent');
				} , 	
				eventRemove: function(obj){ // 일정 삭제시 발생하는 이벤트
					console.log('removeEvent');
				}, 
				select: function(arg){ // 캘린더에서 클릭 및 드래그로 일정을 생성할 수 있음
					var title = prompt('일정 이름을 입력해주세요.');
					if (title){
						calendar.addEvent({
							title: title ,
							start: arg.start , 
							end: arg.end , 
							allDay: arg.allDay
						})
					}
					var allEvent = calendar.getEvents(); // 모든 이벤트를 array형식으로 가져옴
					
					var events = new Array(); // JSON 데이터를 받기 위한 배열 선언
					for(var i = 0 ; i < allEvent.length ; i++){
						var obj = new Object(); // JSON을 담기 위해 Object 선언
						obj.title = allEvent[i]._def.title; // 이벤트 명칭
						obj.start = allEvent[i]._instance.range.start; // 시작날짜
						obj.end = allEvent[i]._instance.range.end; // 종료 날짜
						
						events.push(obj);
					}
					
					var jsondata = JSON.stringify(events);
					console.log(jsondata);
					
					// 여기부터 뭔가 문제가 있다
					$(function saveData()){
						$.ajax({
							url: "addCalData.do",
							method: "post", 
							dataType: "json", 
							data: jsondata , 
							success: function(res){
								alert('dd');
							}, 
							error: function(e){
								alert("에러 발생" + e);
							}							
						})
					}
					// 여기까지 뭔가 문제가 있다
				}*/
				// ====== 이 위는 시간남으면 부가기능으로 괜찮아 보이는 기능 ======
				
				
				

				/*events: [
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
				]*/
				
				/*events:[{					
					
					id: 'a' , 
					title: 'test' , 
					start: '2023-08-17' , 
					end: '2023-08-20', 
					backgroundColor: '#a2c6ff'
				}] , */
				eventClick: function(info){
					var url = "goUpDelSchedule.do";
					var name = "upDelSchedule";
					var option = "width=500, height=500, scrollbars=no, status=no, toolbars=no, location=no"
					window.open(url, name, option);
				}
			});			

			// 캘린더 렌더링
			calendar.render();	

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