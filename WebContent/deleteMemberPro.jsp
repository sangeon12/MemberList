<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.sql.*" %>
<%
	/*request.setCharacterEncoding("utf-8");
	int memno = Integer.parseInt(request.getParameter("memno"));
	String pass = request.getParameter("pass");
	MemberDAO instance = MemberDAO.getInstance();
	Connection conn = instance.getConnection();
	
	String selectSql = "SELECT ID, PASS FROM MEMBER_TBL WHERE MEMNO = ?";
	String deleteSql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?";
	int cnt = 0;     
	String msg = null;
	PreparedStatement pstmt = conn.prepareStatement(selectSql);
	pstmt.setInt(1, memno);
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		String dbPass = rs.getString("pass");
		if(pass.equals(dbPass)){
			pstmt = conn.prepareStatement(deleteSql);
			pstmt.setInt(1, memno);
			cnt = pstmt.executeUpdate();
			if(cnt > 0){
				msg = "회원 탈퇴 완료";
			}else{
				msg = "비밀번호 오류";
			}
		}
	}
	instance.close(rs, pstmt, conn);*/
	
	request.setCharacterEncoding("utf-8");
	MemberDAO instance = MemberDAO.getInstance(); //MemberDAO인스턴스를 받아옴
	
	MemberVO vo = instance.getAMember(Integer.parseInt(request.getParameter("memno")));  //생성자를 만드는 동시에 회원번호를 MemberDAO함수로 보내
	String pass = request.getParameter("pass");	//사용자가 입력한 비밀번호를 받아온다			  	//동일한 번호를 가진 회원의 정보를 가져온다
	String msg = null; 
	
	if(vo.getPass().equals(pass)){  //가져온 회원의 비밀번호와 사용자가 입력한 비밀번호가 맞는지 확인하다
		if(instance.deleteMember(vo.getMemno()) > 0){ //비밀번호가 맞다면 테이블과 리스트에서 회원의 정보를 삭제한다.
			msg = "회원 탈퇴 완료";
		}else{						//성공 여부에 따라 msg에 넣는 문자열이 달라짐
			msg = "회원 탈퇴 실패";
		}
	}else{
		msg = "비밀번호 오류";  //회원의 비밀번호와 사용자가 입력한 비밀번호가 맞지 않다면 msg에 비밀번호 오류라고 넣어준다
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%= msg %>');
		//history.go(-1);
		location.href('selectMember.jsp');  //경고창으로 msg를 띄어줌
	</script>
</body>
</html>