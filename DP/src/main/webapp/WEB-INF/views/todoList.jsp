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
	<!-- ��θ� �����ִ� div -->
	<div class="main-top" style="width: 465px; margin: 0 auto;">
		<!-- Ÿ��Ʋ ~ �Է��±ױ��� ���δ� div ����-->
		<div class="main">
			<h1>${user.mb_id }�� To-do List</h1>
			<br>
			<div class="input-area">
				<div class="row g-2">
					<div class="col-auto">
						<input type="text" class="form-control" id="task-input"
							autofocus="autofocus" placeholder="To Do List �� �Է����ּ���~">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-outline-warning mb-3"
							id="add-button">�߰�</button>
					</div>
					<div class="col-auto">
						<input type="text" class="form-control" id="task-modify"
							autofocus="autofocus" placeholder="������ To Do List �� �Է����ּ���~" value="">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-outline-warning mb-3"
							id="modify-button">����</button>
					</div>
				</div>
			</div>
			<hr>
			<br>
		</div>
		<!-- Ÿ��Ʋ ~ �Է��±ױ��� ���δ� div ��-->


		<!-- ���� ��ü�� ���δ� ���� ����-->
		<div id="task-board">

			<!-- ����1 ����
            <div class="row g-3 task">
                <div class="col todo">
                    <span class="todo">�丮�ϱ�</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success">�Ϸ�</button>
                    <button class="btn btn-outline-danger">����</button>
                </div>
            </div>
            ����1 ��-->

			<!-- ����2 ����
            <div class="row g-3 task task-done">
                <div class="col todo">
                    <span class="todo">û���ϱ�</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success">�Ϸ�</button>
                    <button class="btn btn-outline-danger">����</button>
                </div>
            </div>
           ����2 �� -->
		</div>
		<!-- ���� ��ü�� ���δ� ���� ��-->
	</div>
	<!-- ��θ�  ���δ� ���� ��-->

	<script src="https://code.jquery.com/jquery-3.7.0.js"
		integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
		crossorigin="anonymous"></script>


	<script>
        // 1. ������ ������ �Է��Ѵ�
        // 2. ��ư�� ������ �� ���� �߰� �ȴ�
        // 3. �߰��� ����� �ٽ� �� �������� �����ش�
        // 4. '�Ϸ�'��ư�� ������ ���Ͽ� ������ ����(task-done Ŭ������ ��Ÿ��)
        //  �Ϸ����� �̿Ϸ����� ���� �ʿ�
        // -> �� ���� ������ �� ���°��� �����ؾ� �Ѵ�
        // 4.1 �� �� ����(�̿Ϸ�) -> �Ϸ� Ŭ�� (�Ϸ�) -> �� Ŭ�� (�̿Ϸ�)
        //          -> ��ü ���·� ����
        // 4-2 (����) �� �� ���°� �Ϸ�(true) -> ����
        // 4-2 (����) �� �� ���°� �̿Ϸ�(false) -> ����
        // 5. ���� ��ư�� ������ �ش� �� ���� ����

        // ����ڰ� inputâ�� ���� ����
        let taskInput = document.getElementById("task-input");
        // ������ �Է��� ������ ���������� �����ϴ� �迭
        let taskList = [];
        function todoSearch() {
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("��ġ ����!");
                    taskList = res;
                    render();
                },
                error: function (e) {
                    console.log('��ġ ���Ф�');
                }
            });
        };
		todoSearch();
        // �� �� �߰� ��ư
        let addButton = document.getElementById("add-button");
		// ���� ��ü�� ��� ū div ����
        let taskBoard = document.getElementById("task-board");

        // ���� ���� �Ϸ��ư�� �ش��ϴ� ���� ����� �ϷῩ�θ� �ٲ��ִ� �Լ�
        const toggleCheck = function (i) {
            console.log('���� ������ ����', i);

            // �迭�� ���·� ����� �� ���� ����� �Լ� ����
            if (taskList[i].todo_status) {
                taskList[i].todo_status = false;
            } else {
                taskList[i].todo_status = true;
            }

            // ���������� �������� �ֽŹ迭 �����
            render();
        };

        // ���� ���� ������ư�� �ش��ϴ� ������ �����ִ� �Լ�
      //  const deleteTask = function (i) {
        //    taskList.splice(i, 1);

      //      render();
    //    }

        // �迭 ���·� ����� �� ���� ���������� ����ϴ� �Լ�
        const render = function () {
			console.log(taskList);
            let resultHTML = '';
            for (let i = 0; i < taskList.length; i++) {
                //�Ϸ� ���ο� ���� ���� ��� isComplete == true : class "task task-done"
                //�Ϸ� ���ο� ���� ���� ��� isComplete == false : class "task"
                if (taskList[i].todo_content != "") {
                    if (taskList[i].todo_status == "true") {
                        resultHTML += `
            <div class="row g-3 task task-done">
                <div class="col todo">
                    <span class="todo">${taskList[i].todo_content}</span>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">�Ϸ�</button>
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">�١�</button>
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')" title="����">��</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">����</button>
                    <button class="btn btn-outline-danger" onclick = "todoModifyOpen('${taskList[i].todo_seq}')">����</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')" title="�Ʒ���">��</button>
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
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">�Ϸ�</button>
                    <button class="btn btn-outline-success" onclick="todoDone('${taskList[i].todo_seq}','${taskList[i].todo_status}')">�١�</button>
                    <button class="btn btn-outline-success" onclick = "todoUp('${taskList[i].todo_seq}','${i}')" title="����">��</button><br>
                    <button class="btn btn-outline-danger" onclick = "todoDelete('${taskList[i].todo_seq}')">����</button>
                    <button class="btn btn-outline-danger" onclick = "todoModifyOpen('${taskList[i].todo_seq}')">����</button>
                    <button class="btn btn-outline-danger" onclick = "todoDown('${taskList[i].todo_seq}','${i}')" title="�Ʒ���">��</button>
                </div>
            </div>
            `;
                    }
                }
            }
            taskBoard.innerHTML = resultHTML;
        };

        // �߰� ��ư�� ������ �� ������ �� �� ��Ͽ� �߰��ϴ� �Լ�
        const addTask = function () {
            let task = {
                "taskContent": taskInput.value,
                "isComplete": false
            }

            // console.log(task);

            // �迭�� �� �� �߰�
            taskList.push(task)
            // console.log(taskList);

            // �Է�â ����ֱ� �뵵
            //taskInput.value = "";

            // ���������� ������Ʈ�� ���� ����� �ٽ� ����ϴ� �Լ�
            render();
        };
		
        // ����
		function todoWrite(){
			let taskInput = $("#task-input").val();
			$.ajax({
				url : "todoWrite.do",
				type : "post",
				data : {
					"taskInput" : taskInput
				},
				success : function(res){
					console.log("���� ����!");
					todoSearch();
				},
				error : function(e){
					console.log("���� ���Ф�")
				}
			});
		};

        // ����
        function todoDelete(todo_seq) {
            $.ajax({
                url: "todoDelete.do",
                type: "post",
                data: {
                    "todo_seq": todo_seq
                },
                success: function (res) {
                    console.log("���� ����!");
					todoSearch();
                },
                error: function (e) {
                    console.log("���� ���Ф�");
                }
            });
        };

        // �Ϸ�
        function todoDone(todo_seq, todo_status) {
            if (todo_status === "false") {
                $.ajax({
                    url: "todoDone.do",
                    type: "post",
                    data: {
                        "todo_seq": todo_seq
                    },
                    success: function (res) {
                        console.log("�Ϸ� ����!");
                        todoSearch();
                    },
                    error: function (e) {
                        console.log("�Ϸ� ���Ф�");
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
                        console.log("�Ϸ� ��� ����!");
                        todoSearch();
                    },
                    error: function (e) {
                        console.log("�Ϸ� ��� ���Ф�");
                    }
                });
            };
        };
        
        // ��
        function todoUp(todo_seq, i) {
        	console.log(todo_seq, i);
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("todoUpstairs ��ġ ����!");
                    taskList = res;
                    let todo_seq_1;
                    i = parseInt(i);
        			if(i-1 >= 0){
        				console.log(taskList[i].todo_seq, taskList[i-1].todo_seq);
        				todoUpstairs(taskList[i].todo_seq, taskList[i-1].todo_seq);
        			}else{
                    	console.log("todo_seq_1 is NULL");
                    	alert("�ֻ��� �Դϴ�~");
                        todoSearch();
        			};
                },
                error: function (e) {
                    console.log('todoUpstairs ��ġ ���Ф�');
                }
            });
        };

        // �� �Ϸ� 
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
                    console.log("�� ����!");
                    todoSearch();
                },
                error: function (e) {
                    console.log('�� ���Ф�');
                }
            });
        };

        // �ٿ�
        function todoDown(todo_seq, i) {
        	console.log(todo_seq, i);
            $.ajax({
                url: "todoSearch.do",
                dataType: 'json',
                success: function (res) {
                    console.log("todoUpstairs ��ġ ����!");
                    taskList = res;
                    i = parseInt(i);
        			if(i+1 < taskList.length){
        				console.log(taskList[i].todo_seq, taskList[i+1].todo_seq);
        				todoDownstairs(taskList[i].todo_seq, taskList[i+1].todo_seq);
        			}else{
                    	console.log("todo_seq_1 is NULL");
                    	alert("������ �Դϴ�~");
                        todoSearch();
        			};
                },
                error: function (e) {
                    console.log('todoUpstairs ��ġ ���Ф�');
                }
            });
        };

        // �ٿ� �Ϸ� 
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
                    console.log("�ٿ� ����!");
                    todoSearch();
                },
                error: function (e) {
                    console.log("�ٿ� ���Ф�");
                }
            });
        };

		// ���� ���� ���� 
		let todo_seq;
	    const taskModify = document.getElementById("task-modify");
	    const modifyButton = document.getElementById("modify-button");
	    const bodyClick = document.body;

	 	// ���� ����
        function todoModifyOpen(i){
	 		todo_seq = i;
	        console.log(todo_seq);
	        taskModify.style.display = "flex"
	        modifyButton.style.display = "flex"
		};
	 	
		// ���� esc �ݱ� 
        window.addEventListener("keyup", e => {
            if (taskModify.style.display === "flex" && e.key === "Escape") {
            	taskModify.style.display = "none"
                modifyButton.style.display = "none"
            };
        });

	 	// ���� Ŭ�� �ݱ�
	 	bodyClick.addEventListener("click", e => {
            const evTarget = e.target;
            if (evTarget.classList.contains("main")) {
            	taskModify.style.display = "none"
            	modifyButton.style.display = "none"
            };
        });

		// ���� Ŭ�� 
        modifyButton.addEventListener("click", e => {
            if (($("#task-modify").val().trim() == "")) {
                alert("������ To Do List �� �Է����ּ���~");
            }else{
	 			todo_seq = todo_seq;
	        	console.log(todo_seq);
	        	todoModify(todo_seq);
            }
        });

        // ���� ����
        $("#task-modify").on("keydown", function (i) {
            if (i.keyCode == 13) {
                if (($("#task-modify").val().trim() == "")) {
                    alert("������ To Do List �� �Է����ּ���~");
                } else {
        	 		todo_seq = todo_seq;
        	        console.log(todo_seq);
        	        todoModify(todo_seq);
                    $("#task-input").prop("value", "");
                }
            }
        });

        // ���� �Ϸ�
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
                    console.log("���� ����1");
                    todoSearch();
                },
                error: function (e) {
                    console.log("���� ���Ф�");
                }
            });
            taskModify.style.display = "none"
            modifyButton.style.display = "none"
            $("#task-modify").prop("value", "");
        };

		// Ŭ��
		$("#add-button").on("click", function(){
			if(($("#task-input").val().trim() == "")){
				alert("To Do List �� �Է����ּ���~");
			}else{
				todoWrite();
			}
		});

        // ����
        $("#task-input").on("keydown", function (i) {
            if (i.keyCode == 13) {
                if (($("#task-input").val().trim() == "")) {
                    alert("To Do List �� �Է����ּ���~");
                } else {
                    todoWrite();
                    $("#task-input").prop("value", "");
                }
            }
        });

	</script>
</body>
</html>