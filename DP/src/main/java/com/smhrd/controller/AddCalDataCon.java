package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.dao.CalendarDAO;
import com.smhrd.entity.Calendar;

public class AddCalDataCon implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ajax.do의 요청이 넘어오는 controller
		System.out.println("캘린더 일정 추가 요청이 들어왔습니다.");
		
		// 수집
		request.setCharacterEncoding("utf-8");
		
		String title = request.getParameter("title");
		String startstr = request.getParameter("start");
		String endstr = request.getParameter("end");
		String color = request.getParameter("color");
		String mb_id = "test";
		String status = "test2";
		
		// 문자열을 date 타입으로 바꿔주기 위한 포맷
//		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		// 위 포맷을 사용하여 문자열을 date 타입으로 바꿈
//		Date start = null;
//		try {
//			start = format.parse(startstr);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		
//		Date end = null;
//		try {
//			end = format.parse(endstr);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
		
		// 수집된 데이터들을 하나로 묶어줌
		Calendar cal = new Calendar();
		cal.setCal_title(title);
		cal.setStarted_at(startstr);
		cal.setEnded_at(endstr);
		cal.setCal_color(color);
		cal.setMb_id(mb_id);
		cal.setCal_status(status);
		
		// 기능
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		
		CalendarDAO dao = new CalendarDAO();
		int cnt = dao.calAdd(cal);
		
		// 결과에 따른 처리
		if(cnt > 0) {
			out.print(cnt);
			System.out.println("일정 추가 성공!");
		}		
		
		return null;
	}

}
