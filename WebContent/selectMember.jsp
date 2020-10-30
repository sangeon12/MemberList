	<%@ page import="member.MemberDAO" %>
	<%@ page import="member.MemberVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 출력</title>
</head>
<body>
<%@ include file = "header.jsp" %>
	
	<%
		MemberDAO instance = MemberDAO.getInstance(); //싱글톤으로 인스턴스를 받는다
		ArrayList<MemberVO> list = instance.list;	//인스턴스로  MemberVO에 있는 리스트를 가져온다(리스트에는 회원의 정보가 담겨있다)
		int num = 0;
		
		if(instance.first){
			instance.firstMember();
		}
		
	%>
	
	<h2>회원 목록</h2>
	<table border="1">
		<tr align="center">
			<th width="100">회원번호</th>
			<th width="100">이름</th>
			<th width="100">아이디</th>
			<th width="100">비밀번호</th>
			<th width="100">생년(4자리)</th>
			<th width="50">성별</th>
			<th width="100">직업</th>
			<th width="100">도시</th>
			<th width="100">가입일자</th>
			<th width="50">탈퇴</th>
		</tr>
	<%
		while(num < list.size()){
			/*int memno = rs.getInt("MEMNO");
			String name = rs.getString("NAME");
			String id = rs.getString("ID");
			String pass = rs.getString("PASS");
			int birth = rs.getInt("BIRTH");
			String gender = rs.getString("GENDER");
			String job = rs.getString("JOB");
			String city = rs.getString("CITY");
			Date joinDate = rs.getDate("JOINDATE");*/
			String gender = null;
			if(list.get(num).getGender().equals("m")){ //남자 여자를 판별할때 받는값이 m과 f를 남자 여자로 바꾼다
				gender = "남자";
			}else{
				gender = "여자";
			}
		
	%>
	<tr>
		<td width="100"><a href="updateMember.jsp?memno=<%= list.get(num).getMemno() %>"><%= list.get(num).getMemno() %></a></td>
		<td width="100"><%= list.get(num).getName() %></td>
		<td width="100"><%= list.get(num).getId() %></td>
		<td width="100"><%= list.get(num).getPass() %></td>
		<td width="100"><%= list.get(num).getBirth() %></td>
		<td width="50"><%= gender %></td>							<%-- 유저들의 정보를 리스트에서 뽑아와서 표시한다 --%>
		<td width="100"><%= list.get(num).getJob() %></td>
		<td width="100"><%= list.get(num).getCity() %></td>
		<td width="100"><%= list.get(num).getJoinDate() %></td>	
		<td width="50"><a href="deleteMember.jsp?memno=<%= list.get(num).getMemno() %>">탈퇴</a></td> 
	</tr>
	<%
	num++;
	}
	%>
	</table>
	<%@ include file = "footer.jsp" %>
</body>
</html>