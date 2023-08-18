package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.smhrd.dao.CalendarDAO;
import com.smhrd.entity.Calendar;

public class CalListCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("요청은 들어오나?");
		
		// 수집
		request.setCharacterEncoding("utf-8");		
		String mb_id = request.getParameter("mb_id");
		
		// 기능
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		
		CalendarDAO dao = new CalendarDAO();
		List<Calendar> list = dao.calList(mb_id);
		
		// list 데이터의 형태를 JSON으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(list);
		
		System.out.println("json : " + json);
		
		// 응답되는 데이터
		out.print(json);
		
		return null;
	}

}
