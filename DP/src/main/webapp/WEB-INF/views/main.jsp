<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>임시 메인 페이지</title>
</head>
<body>
	<h1>방가~ 임시 메인 페이지야~</h1>
	<a href="goCalendar.do">캘린더 가기</a><br>
	<a href="goTodo.do">투두리스트 가기</a>
	<a href="goLogin.do">로그인 페이지 가기</a>
	<a href="goJoin.do">회원가입 페이지 가기</a>
	
	<% Member member = new Member(); %>
	<h1><% String id= (String)member.getMb_id(); %></h1>
	<%=id %>	
	
	
</body>
</html>