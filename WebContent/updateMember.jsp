<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
	<%
		/*request.setCharacterEncoding("utf-8");
		int memno = Integer.parseInt(request.getParameter("memno"));
		MemberDAO instance = MemberDAO.getInstance();
		Connection conn = instance.getConnection();
		String selectSql = "SELECT * FROM MEMBER_TBL WHERE MEMNO = ?";
		PreparedStatement pstmt = conn.prepareStatement(selectSql);
		pstmt.setInt(1, memno);
		ResultSet rs = pstmt.executeQuery();*/
		
		request.setCharacterEncoding("utf-8");
		int memno = Integer.parseInt(request.getParameter("memno"));
		MemberDAO instance = MemberDAO.getInstance();
		MemberVO vo = instance.getAMember(memno);
	%>
			<form action="updateMemberPro.jsp" method="post">
				<table border="1" style="width: 400">
					<tr><td colspan="2" align="center"><b>회원 수정 정보 입력</b></td></tr>
					<tr><th>회원번호</th><td><input type="text" name="memno" value="<%= vo.getMemno() %>" readonly></td></tr>
					<tr><th>이름</th><td><input type="text" name="name" value="<%= vo.getName() %>" readonly></td></tr>
					<tr><th>아이디</th> <td><input type="text" name="id" value="<%= vo.getId() %>" readonly></td></tr> <%-- disabled --%>
					<tr><th>비밀번호</th> <td><input type="password" name="pass" value="<%= vo.getPass() %>"></td></tr>
					
					<tr>
						<th>생년(4자리)</th>
							<td><select name="birth">
	<%
								for(int i = 2001; i <= 2010; i++){
									if(vo.getBirth() == i){
	%>
										<option value="<%= i %>" selected><%= i %></option>
	<%								
									}else{
	%>
										<option value="<%= i %>"><%= i %></option>
	<%								
									}
								}
	%>						
							</select></td>
						</tr>
						
						<tr>
							<th>성별</th>
							<td>
	<%
		         				if(vo.getGender().equals("m")){
	%>
									<input type="radio" name="gender" value="m" checked>남자
									<input type="radio" name="gender" value="f">여자
	<%	         					
		         				}else{
	%>
									<input type="radio" name="gender" value="m">남자
									<input type="radio" name="gender" value="f" checked>여자
	<%	         					
		         				}
	%>
							</td>
						</tr>
						
						<tr>
							<th>직업</th>
							<td><input type="text" name="job" value="<%= vo.getJob() %>"></td>
						</tr>
						
						<tr>
							<th>도시</th>
							<td><input type="text" name="city" value="<%= vo.getCity() %>"></td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<input type="submit" value="확인"> <input type="reset" value="취소">
						</tr>
				</table>
			</form>
</body>
</html>