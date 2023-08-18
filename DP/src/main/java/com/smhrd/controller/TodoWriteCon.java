package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.dao.TodoListDAO;
import com.smhrd.entity.Todo;

public class TodoWriteCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		String todo_content = request.getParameter("taskInput");
		
		Todo todo = new Todo();
		todo.setTodo_content(todo_content);
		todo.setTodo_status("false");
		todo.setTodo_color("white");
		
		TodoListDAO dao = new TodoListDAO();
		dao.todoInsert(todo);

		return null;

	}

}
