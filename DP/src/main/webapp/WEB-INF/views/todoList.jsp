<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>To Do List</title>


<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<style>
@font-face {
	font-family: 'GmarketSansMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'SBAggroB';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

hr {
	width: 465px;
}

.main {
	margin-top: 60px;
}

.todo {
	font-size: 25px;
	width: 200px;
	background-color: #a2c6ff;
	border-radius: 10px;
	margin-left: 5px;
	padding-top: 5px;
}

.form-control {
	width: 400px !important;
}

body {
	margin: 20px;
	background-color: #fff9e9;
}

.task {
	margin-top: 5px;
	padding-bottom: 15px;
}

.task-done {
	background-color: #3f4756;
	border-radius: 10px;
}

#task-board {
	width: 465px;
	font-family: 'GmarketSansMedium';
	height: 500px;
	overflow-y: auto;
	padding: 10px;
}

#task-board::-webkit-scrollbar {
	width: 10px;
}

#task-board::-webkit-scrollbar-thumb {
	height: 30%;
	background: #217af4;
	border-radius: 10px;
}

#task-board::-webkit-scrollbar-track {
	background: rgba(33, 122, 244, .1);
}

h1 {
	font-family: 'SBAggroB';
	font-size: 55px;
	color: #5a8100;
}

.input-area {
	font-family: 'GmarketSansMedium';
}
#task-modify, #modify-button {
	width: width: 400px;
    height: 100px;
    left: 0;
    right: 0;
    display: none;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    background: rgba(255, 255, 255, 0.25);
    box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
    backdrop-filter: blur(50px);
    -webkit-backdrop-filter: blur(1.5px);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.18);
}
</style>

</head>
<body>
	<%
		Member m = (Member)session.getAttribute("user");
	%>
	<!-- 모두를 감싸주는 div -->
	<div class="main-top" style="width: 465px; margin: 0 auto;">
		<!-- 타이틀 ~ 입력태그까지 감싸는 div 시작-->
		<div class="main">
			<h1><%=m.getMb_id() %>님의<br> To-do List</h1>
			<br>
			<div class="input-area">
				<div class="row g-2">
					<div class="col-auto">
						<input type="text" class="form-control" id="task-input"
							autofocus="autofocus" placeholder="To Do List 를 입력해주세요~">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-outline-warning mb-3"
							id="add-button">추가</button>
					</div>
					<div class="col-auto">
						<input type="text" class="form-control" id="task-modify"
							autofocus="autofocus" placeholder="수정할 To Do List 를 입력해주세요~" value="">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-outline-warning mb-3"
							id="modify-button">수정</button>
					</div>
				</div>
			</div>
			<hr>
			<br>
		</div>
		<!-- 타이틀 ~ 입력태그까지 감싸는 div 끝-->


		<!-- 할일 전체를 감싸는 구역 시작-->
		<div id="task-board">

			<!-- 할일1 시작
            <div class="row g-3 task">
                <div class="col todo">
                    <span class="todo">요리하기</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success">완료</button>
                    <button class="btn btn-outline-danger">삭제</button>
                </div>
            </div>
            할일1 끝-->

			<!-- 할일2 시작
            <div class="row g-3 task task-done">
                <div class="col todo">
                    <span class="todo">청소하기</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success">완료</button>
                    <button class="btn btn-outline-danger">삭제</button>
                </div>
            </div>
           할일2 끝 -->
		</div>
		<!-- 할일 전체를 감싸는 구역 끝-->
	</div>
	<!-- 모두를  감싸는 구역 끝-->

	<script src="https://code.jquery.com/jquery-3.7.0.js"
		integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
		crossorigin="anonymous"></script>


	<script>
        // 1. 유저가 할일을 입력한다
        // 2. 버튼을 누르면 할 일이 추가 된다
        // 3. 추가된 목록을 다시 웹 페이지에 보여준다
        // 4. '완료'버튼을 누르면 할일에 배경색이 들어간다(task-done 클래스의 스타일)
        //  완료인지 미완료인지 구분 필요
        // -> 할 일을 저장할 때 상태값을 저장해야 한다
        // 4.1 할 일 저장(미완료) -> 완료 클릭 (완료) -> 또 클릭 (미완료)
        //          -> 객체 형태로 저장
        // 4-2 (만약) 할 일 상태가 완료(true) -> 배경색
        // 4-2 (만약) 할 일 상태가 미완료(false) -> 배경색
        // 5. 삭제 버튼을 누르면 해당 할 일이 삭제

        // 사용자가 input창에 적는 할일
        let taskInput = document.getElementById("task-input");
        // 유저가 입력할 할일을 순차적으로 저장하는 배열
        let taskList = [];
        function todoSearch() {
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("서치 성공!");
                    taskList = res;
                    render();
                },
                error: function (e) {
                    console.log('서치 실패ㅠ');
                }
            });
        };
		todoSearch();
        // 할 일 추가 버튼
        let addButton = document.getElementById("add-button");
		// 할일 전체를 담는 큰 div 생성
        let taskBoard = document.getElementById("task-board");

        // 내가 누른 완료버튼에 해당하는 할일 덩어리의 완료여부를 바꿔주는 함수
        const toggleCheck = function (i) {
            console.log('내가 선택한 할일', i);

            // 배열의 형태로 저장된 할 일을 만드는 함수 생성
            if (taskList[i].todo_status) {
                taskList[i].todo_status = false;
            } else {
                taskList[i].todo_status = true;
            };

            // 변동사항이 생겼으면 최신배열 재출력
            render();
        };

        // 내가 누른 삭제버튼에 해당하는 할일을 지워주는 함수
      //  const deleteTask = function (i) {
        //    taskList.splice(i, 1);

      //      render();
    //    }

        // 배열 형태로 저장된 할 일을 웹페이지에 출력하는 함수
        const render = function () {
			console.log(taskList);
            let resultHTML = '';
            for (let i = 0; i < taskList.length; i++) {
                //완료 여부에 따른 할일 출력 isComplete == true : class "task task-done"
                //완료 여부에 따른 할일 출력 isComplete == false : class "task"
                if (taskList[i].todo_content != "") {
                    if (taskList[i].todo_status == "true") {
                        resultHTML += `
            <div class="row g-3 task task-done">
                <div class="col todo">
                    <span class="todo">${taskList[i].todo_content}</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">완료</button>
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">☆☆</button>
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')" title="위로">▲</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">삭제</button>
                    <button class="btn btn-outline-danger" onclick = "todoModifyOpen('${taskList[i].todo_seq}')">수정</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')" title="아래로">▼</button>
                </div>
            </div>
            `;
                    } else {
                        resultHTML += `
            <div class="row g-3 task">
                <div class="col todo">
                    <span class="todo">${taskList[i].todo_content}</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">완료</button>
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">☆☆</button>
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')" title="위로">▲</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">삭제</button>
                    <button class="btn btn-outline-danger" onclick = "todoModifyOpen('${taskList[i].todo_seq}')">수정</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')" title="아래로">▼</button>
                </div>
            </div>
            `;
                    };
                };
            };
            taskBoard.innerHTML = resultHTML;
        };
		
        // 쓰기
		function todoWrite(){
			let taskInput = $("#task-input").val();
			$.ajax({
				url : "todoWrite.do",
				type : "post",
				data : {
					"taskInput" : taskInput
				},
				success : function(res){
					console.log("쓰기 성공!");
					todoSearch();
				},
				error : function(e){
					console.log("쓰기 실패ㅠ")
				}
			});
		};

        // 삭제
        function todoDelete(todo_seq) {
            $.ajax({
                url: "todoDelete.do",
                type: "post",
                data: {
                    "todo_seq": todo_seq
                },
                success: function (res) {
                    console.log("삭제 성공!");
					todoSearch();
                },
                error: function (e) {
                    console.log("삭제 실패ㅠ");
                }
            });
        };

        // 완료
        function todoDone(todo_seq, todo_status) {
            if (todo_status === "false") {
                $.ajax({
                    url: "todoDone.do",
                    type: "post",
                    data: {
                        "todo_seq": todo_seq
                    },
                    success: function (res) {
                        console.log("완료 성공!");
                        todoSearch();
                    },
                    error: function (e) {
                        console.log("완료 실패ㅠ");
                    }
                });
            } else {
                $.ajax({
                    url: "todoDoneCencel.do",
                    type: "post",
                    data: {
                        "todo_seq": todo_seq
                    },
                    success: function (res) {
                        console.log("완료 취소 성공!");
                        todoSearch();
                    },
                    error: function (e) {
                        console.log("완료 취소 실패ㅠ");
                    }
                });
            };
        };
        
        // 업
        function todoUp(todo_seq, i) {
        	console.log(todo_seq, i);
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("todoUpstairs 서치 성공!");
                    taskList = res;
                    let todo_seq_1;
                    i = parseInt(i);
        			if(i-1 >= 0){
        				console.log(taskList[i].todo_seq, taskList[i-1].todo_seq);
        				todoUpstairs(taskList[i].todo_seq, taskList[i-1].todo_seq);
        			}else{
                    	console.log("todo_seq_1 is NULL");
                    	alert("최상위 입니다~");
                        todoSearch();
        			};
                },
                error: function (e) {
                    console.log('todoUpstairs 서치 실패ㅠ');
                }
            });
        };

        // 업 완료 
        function todoUpstairs(todo_seq, todo_seq_1) {
        	console.log(todo_seq, todo_seq_1);
            $.ajax({
                url: "todoChange.do",
                type: "post",
                data: {
                    "todo_seq": todo_seq,
                    "todo_seq_1": todo_seq_1,
                },
                success: function (res) {
                    console.log("업 성공!");
                    todoSearch();
                },
                error: function (e) {
                    console.log('업 실패ㅠ');
                }
            });
        };

        // 다운
        function todoDown(todo_seq, i) {
        	console.log(todo_seq, i);
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("todoUpstairs 서치 성공!");
                    taskList = res;
                    i = parseInt(i);
        			if(i+1 < taskList.length){
        				console.log(taskList[i].todo_seq, taskList[i+1].todo_seq);
        				todoDownstairs(taskList[i].todo_seq, taskList[i+1].todo_seq);
        			}else{
                    	console.log("todo_seq_1 is NULL");
                    	alert("최하위 입니다~");
                        todoSearch();
        			};
                },
                error: function (e) {
                    console.log('todoUpstairs 서치 실패ㅠ');
                }
            });
        };

        // 다운 완료 
        function todoDownstairs(todo_seq, todo_seq_1){
        	console.log(todo_seq, todo_seq_1);
            $.ajax({
                url: "todoChange.do",
                type: "post",
                data: {
                    "todo_seq": todo_seq,
                    "todo_seq_1": todo_seq_1,
                },
                success: function (res) {
                    console.log("다운 성공!");
                    todoSearch();
                },
                error: function (e) {
                    console.log("다운 실패ㅠ");
                }
            });
        };

		// 수정 변수 선언 
		let todo_seq;
	    const taskModify = document.getElementById("task-modify");
	    const modifyButton = document.getElementById("modify-button");
	    const bodyClick = document.body;

	 	// 수정 열기
        function todoModifyOpen(i){
	 		todo_seq = i;
	        console.log(todo_seq);
	        taskModify.style.display = "flex"
	        modifyButton.style.display = "flex"
		};
	 	
		// 수정 esc 닫기 
        window.addEventListener("keyup", e => {
            if (taskModify.style.display === "flex" && e.key === "Escape") {
            	taskModify.style.display = "none"
                modifyButton.style.display = "none"
            };
        });

	 	// 수정 클릭 닫기
	 	bodyClick.addEventListener("click", e => {
            const evTarget = e.target;
            if (evTarget.classList.contains("main")) {
            	taskModify.style.display = "none"
            	modifyButton.style.display = "none"
            };
        });

		// 수정 클릭 
        modifyButton.addEventListener("click", e => {
            if (($("#task-modify").val().trim() == "")) {
                alert("수정할 To Do List 를 입력해주세요~");
            }else{
	 			todo_seq = todo_seq;
	        	console.log(todo_seq);
	        	todoModify(todo_seq);
            };
        });

        // 수정 엔터
        $("#task-modify").on("keydown", function (i) {
            if (i.keyCode == 13) {
                if (($("#task-modify").val().trim() == "")) {
                    alert("수정할 To Do List 를 입력해주세요~");
                } else {
        	 		todo_seq = todo_seq;
        	        console.log(todo_seq);
        	        todoModify(todo_seq);
                    $("#task-input").prop("value", "");
                };
            };
        });

        // 수정 완료
        function todoModify(todo_seq) {
            console.log(todo_seq);
        	let todo_content = $("#task-modify").val();
            console.log(todo_content);
            $.ajax({
                url: "todoModify.do",
                type: "post",
                data: {
                    "todo_seq": todo_seq,
                    "todo_content": todo_content
                },
                success: function (res) {
                    console.log("수정 성공1");
                    todoSearch();
                },
                error: function (e) {
                    console.log("수정 실패ㅠ");
                }
            });
            taskModify.style.display = "none"
            modifyButton.style.display = "none"
            $("#task-modify").prop("value", "");
        };

		// 클릭
		$("#add-button").on("click", function(){
			if(($("#task-input").val().trim() == "")){
				alert("To Do List 를 입력해주세요~");
			}else{
				todoWrite();
			};
		});

        // 엔터
        $("#task-input").on("keydown", function (i) {
            if (i.keyCode == 13) {
                if (($("#task-input").val().trim() == "")) {
                    alert("To Do List 를 입력해주세요~");
                } else {
                    todoWrite();
                    $("#task-input").prop("value", "");
                };
            };
        });

	</script>
</body>
</html>