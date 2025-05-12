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
	MemberVO memVO = memDAO.login(name);
	
	String movePage = "/login.me";
	//만약에 가져온게 달라, 그러면 login.me 로 보내고, 같으면 list.co 로 보내
	if(memVO != null && memVO.getPassword().equals(pw)){
		movePage = "/list.co";
	}
	
	response.sendRedirect(movePage);
%>


</body>
</html>