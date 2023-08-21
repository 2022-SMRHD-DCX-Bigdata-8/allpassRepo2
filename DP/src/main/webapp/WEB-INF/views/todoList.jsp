<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
</style>

</head>
<body>
	<!-- 모두를 감싸주는 div -->
	<div style="width: 465px; margin: 0 auto;">
		<!-- 타이틀 ~ 입력태그까지 감싸는 div 시작-->
		<div class="main">
			<%--<h1>${user.mb_id }의 To-do List</h1> --%>
			<h1>7반의 To-do List</h1>
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
            }

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
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')">▲</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">삭제</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')">▼</button>
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
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')">▲</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">삭제</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')">▼</button>
                </div>
            </div>
            `;
                    }
                }
            }
            taskBoard.innerHTML = resultHTML;
        };

        // 추가 버튼을 누르면 새 할일을 할 일 목록에 추가하는 함수
        const addTask = function () {
            let task = {
                "taskContent": taskInput.value,
                "isComplete": false
            }

            // console.log(task);

            // 배열에 할 일 추가
            taskList.push(task)
            // console.log(taskList);

            // 입력창 비워주기 용도
            //taskInput.value = "";

            // 웹페이지에 업데이트된 할일 목록을 다시 출력하는 함수
            render();
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
                type: "get",
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
                    for(let j = i; j > 0; j--){
        				if(taskList[j-1].todo_seq !== null){
        					console.log("true");
        					todo_seq_1 = taskList[j-1].todo_seq;
        					break;
                    	};
        			};
        			if(todo_seq_1 >= 0){
                    	console.log(todo_seq_1);
        				console.log(taskList[i].todo_seq, todo_seq_1);
        				todoUpstairs(taskList[i].todo_seq, todo_seq_1);
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

        // 위층
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
                    let todo_seq_1;
                    i = parseInt(i);
                    for(let j = i; j < taskList.length - 1; j++){
                    	console.log(j, j+1);
        				if(taskList[j+1].todo_seq !== null){
        					console.log("true");
        					todo_seq_1 = taskList[j+1].todo_seq;
        					break;
                    	};
        			};
        			if(todo_seq_1 >= 0){
                    	console.log(todo_seq_1);
        				console.log(taskList[i].todo_seq, todo_seq_1);
        				todoDownstairs(taskList[i].todo_seq, todo_seq_1);
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

        // 아래층
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
                    console.log('다운 실패ㅠ');
                }
            });
        }

		// 클릭
		$("#add-button").on("click", function(){
			if(($("#task-input").val().trim() == "")){
				alert("To Do List 를 입력해주세요~");
			}else{
				todoWrite();
			}
		});

        // 엔터
        $("#task-input").on("keydown", function (i) {
            if (i.keyCode == 13) {
                console.log("엔터 누름");
                if (($("#task-input").val().trim() == "")) {
                    alert("To Do List 를 입력해주세요~");
                } else {
                    todoWrite();
                }
            }
        });
        
	</script>
</body>
</html>