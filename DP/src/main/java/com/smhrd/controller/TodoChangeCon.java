package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.dao.TodoListDAO;
import com.smhrd.entity.Todo;

public class TodoChangeCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		int todo_seq = Integer.parseInt(request.getParameter("todo_seq"));
		int todo_seq_1 = Integer.parseInt(request.getParameter("todo_seq_1"));
		
		Todo todo = new Todo();
		todo.setTodo_seq(todo_seq);
		todo.setTodo_seq_1(todo_seq_1);
		
		TodoListDAO dao = new TodoListDAO();
		dao.todoChange(todo);
		
		return null;
	}

}
