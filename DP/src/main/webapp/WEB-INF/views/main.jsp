<%@page import="com.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ӽ� ���� ������</title>
</head>
<body>
	<h1>�氡~ �ӽ� ���� ��������~</h1>
	<a href="goCalendar.do">Ķ���� ����</a><br>
	<a href="goTodo.do">���θ���Ʈ ����</a>
	<a href="goLogin.do">�α��� ������ ����</a>
	<a href="goJoin.do">ȸ������ ������ ����</a>
	
	<% Member member = new Member(); %>
	<h1><% String id= (String)member.getMb_id(); %></h1>
	<%=id %>	
	
	
</body>
</html>