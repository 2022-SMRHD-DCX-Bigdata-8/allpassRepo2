package com.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Todo {

	private int todo_seq;			// 할일 순번
	private String todo_content;	// 할일 내용
	private String todo_status;		// 할일 상태
	private String todo_color;		// 할일 색깔
	
}
