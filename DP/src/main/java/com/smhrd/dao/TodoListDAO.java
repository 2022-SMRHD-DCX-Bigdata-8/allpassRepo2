package com.smhrd.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.database.SqlSessionManager;
import com.smhrd.entity.Todo;

public class TodoListDAO {

	private SqlSessionFactory factory = SqlSessionManager.getSqlSessionFactory();

	public List<Todo> todoSelect() {

		SqlSession session = factory.openSession(true);
		List<Todo> list = session.selectList("todoSelect");
		session.close();
		return list;
	}
	
	public void todoInsert(Todo todo) {
		
		SqlSession session = factory.openSession(true);
		session.insert("todoInsert", todo);
		session.close();
	}

	public void todoDelete(Todo todo) {

		SqlSession session = factory.openSession(true);
		session.delete("todoDelete", todo);
		session.close();
	}

	public void todoDone(Todo todo) {

		SqlSession session = factory.openSession(true);
		session.update("todoDone", todo);
		session.close();
	}

	public void todoDoneCencel(Todo todo) {

		SqlSession session = factory.openSession(true);
		session.update("todoDoneCencel", todo);
		session.close();
	}

	public void todoChange(Todo todo) {

		SqlSession session = factory.openSession(true);
		session.update("todoChange_0", todo);
		try {
			session.update("todoChange_1", todo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.update("todoChange_2", todo);
			session.close();
		}
	}
	
}
