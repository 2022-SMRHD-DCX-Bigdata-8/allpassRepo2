package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.dao.TodoListDAO;
import com.smhrd.entity.Member;
import com.smhrd.entity.Todo;

public class TodoDoneCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("user");
		String id = m.getMb_id();

		request.setCharacterEncoding("UTF-8");
		int todo_seq = Integer.parseInt(request.getParameter("todo_seq"));
		
		Todo todo = new Todo();
		todo.setTodo_id(id);
		todo.setTodo_seq(todo_seq);
		
		TodoListDAO dao = new TodoListDAO();
		int cnt = dao.todoDone(todo);

		if (cnt > 0) {
			System.out.println("TodoDone Complete!");
		} else {
			System.out.println("TodoDone Faild!");
		}
		
		return null;
	}

}
