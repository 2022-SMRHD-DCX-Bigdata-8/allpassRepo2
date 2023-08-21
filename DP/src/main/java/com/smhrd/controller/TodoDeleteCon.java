package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.dao.TodoListDAO;
import com.smhrd.entity.Todo;

public class TodoDeleteCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int todo_seq = Integer.parseInt(request.getParameter("todo_seq"));
		Todo todo = new Todo();
		todo.setTodo_seq(todo_seq);
		
		TodoListDAO dao = new TodoListDAO();
		dao.todoDelete(todo);
		
		return null;
	}

}
