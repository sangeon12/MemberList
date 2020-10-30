<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.sql.*" %>
<%
	/*request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String gender = request.getParameter("gender");
	String job = request.getParameter("job");
	String city = request.getParameter("city");
	
	MemberDAO instance = MemberDAO.getInstance();
	Connection conn = instance.getConnection();
	String getNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
	int memno = 0;
	PreparedStatement pstmt = conn.prepareStatement(getNoSql);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		memno = rs.getInt(1) + 1;
	}
	String insertSql = "INSERT INTO MEMBER_TBL(memno, name, id, pass, birth, gender, job, city, joindate)"
			+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
	pstmt = conn.prepareStatement(insertSql);
	String msg = null;
	int cnt = 0;
	pstmt.setInt(1, memno);
	pstmt.setString(2, name);
	pstmt.setString(3, id);
	pstmt.setString(4, pass);
	pstmt.setInt(5, birth);
	pstmt.setString(6, gender);
	pstmt.setString(7, job);
	pstmt.setString(8, city);
	cnt = pstmt.executeUpdate();
	if(cnt > 0){
		msg = "회원 가입 성공";
	}else{
		msg = "회원 가입 실패";
	}
	instance.close(rs,pstmt, conn);*/
	
	request.setCharacterEncoding("utf-8");
	MemberDAO instance = MemberDAO.getInstance();  //MemberDAO에서 인스턴스를 가져오고 MemberVO생성자를 만든다
	MemberVO vo = new MemberVO();
	
	vo.setMemno(instance.getMaxNo());
	vo.setName(request.getParameter("name"));
	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setBirth(Integer.parseInt(request.getParameter("birth")));   //MemberVO생성자에 회원의 정보를 전무 set으로 넣어준다
	vo.setGender(request.getParameter("gender"));
	vo.setJob(request.getParameter("job"));
	vo.setCity(request.getParameter("city"));
	
	String msg = null;
	if(instance.insertMember(vo) > 0){   //인스턴스로 MemberDAO의 함수로 테이블과 리스트에 회원을 추가시켜 준다.
		msg = "회원 가입 성공";				//그리고 정삭적으로 회원 정보가 입력되었다면 msg에데가 회원 가입 성공
	}else{								//아니면 회원 가입 실패라고 넣어준다
		msg = "회원 가입 실패";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%= msg %>');
		location.href('selectMember.jsp');  //경고창이 뜨면서 아까 넣은 msg가 출력된다.
	</script>
</body>
</html>