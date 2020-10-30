<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.sql.*" %>
<%
	/*request.setCharacterEncoding("utf-8");
	int memno = Integer.parseInt(request.getParameter("memno"));
	String pass = request.getParameter("pass");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String gender = request.getParameter("gender");
	String job = request.getParameter("job");
	String city = request.getParameter("city");
	MemberDAO instance = MemberDAO.getInstance();
	Connection conn = instance.getConnection();
	
	String updateSql = "UPDATE MEMBER_TBL SET PASS=?, BIRTH=?, JOB=?, CITY=?, WHERE MEMNO = ?";
	int cnt = 0;
	String msg = null;
	PreparedStatement pstmt = conn.prepareStatement(updateSql);
	pstmt.setString(1, pass);
	pstmt.setInt(2, birth);
	pstmt.setString(3, gender);
	pstmt.setString(4, job);
	pstmt.setString(5, city);
	pstmt.setInt(6, memno);
	cnt = pstmt.executeUpdate();
	if(cnt > 0){
		msg = "회원 정보 수정 성공";
	}else{
		msg = "회원 정보 수정 실패";
	}
	instance.close(null, pstmt, conn);*/
	
	request.setCharacterEncoding("utf-8");
	MemberDAO instance = MemberDAO.getInstance();   //MemberDAO, MemberVO 인스턴와 생성자를 만든다.
	MemberVO vo = new MemberVO();
	
	vo.setMemno(Integer.parseInt(request.getParameter("memno")));
	vo.setName(request.getParameter("name"));
	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setBirth(Integer.parseInt(request.getParameter("birth")));   //수정할 정보를 MemberVO생성자에 set으로 다 넣어준다
	vo.setGender(request.getParameter("gender"));
	vo.setJob(request.getParameter("job"));
	vo.setCity(request.getParameter("city"));

	int update = instance.updateMember(vo);
	
	String msg = null;
	if(update > 0){
		msg = "회원 정보 수정 성공";    //MemberDAO의 함수로 정보를 업데이트 시켜준다
	}else{							//잘됐으면 msg에 회원정보 수정성공이라고 넣어주고
		msg = "회원 정보 수정 실패";		//아니라면 회원 정보 수정 실패를 넣어준다	
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 수정</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%= msg %>');    
		location.href('selectMember.jsp');  //경고창으로 msg출력하면서 종료
	</script>
</body>
</html>