<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>임시 메인 페이지</title>
</head>
<body>
	<%
		Member m = (Member)session.getAttribute("user");
	%>
	<h1><%=m.getMb_nick() %>님의 임시 메인 페이지입니다~</h1>
	<a href="goCalendar.do">캘린더 가기</a><br>
	<a href="goTodo.do">투두리스트 가기</a><br>
	<a href="#">로그아웃</a><br>
</body>
</html>