<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
	<% int memno = Integer.parseInt(request.getParameter("memno")); %>
	<h2>회원 탈퇴</h2>
	<form method="post" action="deleteMemberPro.jsp">
		<input type="hidden" name="memno" value="<%= memno %>">
		비밀번호 : <input type="password" name="pass">
		<input type="submit" value="탈퇴">
	</form>
</body>
</html>