<%@page import="member.MemberVO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String name = request.getParameter("userId");
String pw = request.getParameter("password");

MemberDAO memDAO  = new MemberDAO();
MemberVO memVO = new MemberVO();


%>


</body>
</html>