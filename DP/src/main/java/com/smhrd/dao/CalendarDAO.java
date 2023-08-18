package com.smhrd.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;
import com.smhrd.entity.Calendar;

public class CalendarDAO {

	private SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	// 일정 추가 메소드
	public int calAdd(Calendar calendar) {
		SqlSession session = factory.openSession(true);
		
		int cnt = session.insert("calAdd", calendar);
		
		session.close();
		
		return cnt;
	}
	
	// 개별 일정 조회 메소드
	public List<Calendar> calList(String mb_id) {
		SqlSession session = factory.openSession(true);
		
		List<Calendar> list = session.selectList("calList", mb_id);
		
		session.close();
		
		return list;		
	}
	
}
