<%@ page import="java.sql.*" %>
<%@ page import="member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	MemberDAO instance = MemberDAO.getInstance();
	Connection conn = instance.getConnection();
	String checkSql = "SELECT * FROM MEMBER_TBL WHERE id = ?";
	boolean result = false;
	PreparedStatement pstmt = conn.prepareStatement(checkSql);
	pstmt.setString(1, id);
	
	ResultSet rs = pstmt.executeQuery();
	if(!rs.next()) result = true; */
	
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	 													//전달받은 아이디를 변수안에 넣어준다		
	MemberDAO instance = MemberDAO.getInstance();  		//그리고 MemberDAO함수로 중복이 되는지 검사한다
	boolean result = instance.idAvailableChk(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 확인</title>
</head>
<body bgcolor="UTF-8">
	<div align="center">
		<b><%= id %></b>는
		<%
			if(result){
		%>
			<font color="blue">사용가능</font>합니다.	
		<%		
			}else{
		%>
			<font color="red">사용 불가능</font>합니다.    	
		<%												//아까 함수로 검사한 결과를 가지고 중복인지 아닌지를 출력한다
			}
		%>
		<hr>
		<a href="javascript:self.close()">창 닫기</a>
	</div>
</body>
</html>