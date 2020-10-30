package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {
		return instance;
	}
	
	public ArrayList<MemberVO> list = new ArrayList<>(); //회원 정보 리스트
	public boolean first = true;
	
	public Connection getConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr";
		String password = "hr";
		Connection conn = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("오라클 접속 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public Connection getMysqlConnection() {
		String url = "jdbc:mysql://localhost:3306/mysqldb";
		String user = "root";
		String pw = "root";
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");//mysql 드라이버 로딩
			conn = DriverManager.getConnection(url, user, pw);
			System.out.println("mysql 접속성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if(rs != null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch (Exception e) {e.printStackTrace();}
	}
	
	public int getMaxNo() { //회원 번호를 증가시키는 함수
		int memno = 0;
		try {
			
			Connection conn = getConnection();
			String getNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
			PreparedStatement pstmt = conn.prepareStatement(getNoSql);
			ResultSet rs = pstmt.executeQuery();
				
			if(rs.next()){
				memno = rs.getInt(1) + 1;
			}
			close(rs, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return memno;
	}
	
	public boolean idAvailableChk(String id) { //아이디 중복 확인하는 함수
		try {
			Connection conn = getConnection();
			String checkSql = "SELECT * FROM MEMBER_TBL WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(checkSql);
			pstmt.setString(1, id);
				
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				close(rs, pstmt, conn);
				System.out.println("중복됨");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("중복안됨"+id);
		return true;
	}
	
	public int insertMember(MemberVO vo) throws SQLException { //회원 추가시키는 함수
			int cnt = 0;
		try {
			String insertSql = "INSERT INTO MEMBER_TBL(memno, name, id, pass, birth, gender, job, city, joindate)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(insertSql);
			
			pstmt.setInt(1, vo.memno);
			pstmt.setString(2, vo.name);
			pstmt.setString(3, vo.id);
			pstmt.setString(4, vo.pass);
			pstmt.setInt(5, vo.birth);
			pstmt.setString(6, vo.gender);
			pstmt.setString(7, vo.job);
			pstmt.setString(8, vo.city);
			cnt = pstmt.executeUpdate();
			
			list.add(selectMembers(vo));
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
			return cnt;
	}
	
	public MemberVO selectMembers(MemberVO vo) { //리스트에 넣을 회원 정보를 정리하는 함수
		MemberVO vo2 = null;
		try {
			Connection conn = getConnection();
			String selectSql = "SELECT JOINDATE FROM MEMBER_TBL WHERE MEMNO = ?";
			PreparedStatement pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, vo.memno);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo2 = new MemberVO(vo.memno, vo.name, vo.id, vo.pass, vo.birth, vo.gender, vo.job, vo.city , rs.getDate("JOINDATE"));
				close(rs, pstmt, conn);
				return vo2;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo2;
	}
	
	public int updateMember(MemberVO vo) { //회원 정보를 수정하는 함수
		list.set(checkMemno(vo.memno), selectMembers(vo));
		
		
		int cnt = 0;
		try {
			Connection conn = getConnection();
			
			String updateSql = "UPDATE MEMBER_TBL SET PASS=?, BIRTH=?, JOB=?, CITY=?, GENDER=? WHERE MEMNO = ?";
			PreparedStatement pstmt = conn.prepareStatement(updateSql);
			pstmt.setString(1, vo.pass);
			pstmt.setInt(2, vo.birth);
			pstmt.setString(3, vo.job);
			pstmt.setString(4, vo.city);
			pstmt.setString(5, vo.gender);
			pstmt.setInt(6, vo.memno);
			cnt = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	public int deleteMember(int memno) { //회원 정보를 삭제하는 함수(회원 탈퇴)
		list.remove(checkMemno(memno));
		int cnt = 0;
		
		try {
			Connection conn = getConnection();
			String deleteSql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?";
			PreparedStatement pstmt = conn.prepareStatement(deleteSql);
			pstmt.setInt(1, memno);
			cnt = pstmt.executeUpdate();
			
			close(null, pstmt, conn);
			
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public MemberVO getAMember(int memno) { //회원 정보를 select문으로 가져오기
		MemberVO vo = null;
		try {
			Connection conn = getConnection();
			String selectSql = "SELECT * FROM MEMBER_TBL WHERE MEMNO = ?";
			PreparedStatement pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, memno);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new MemberVO(memno, rs.getString("name"),rs.getString("id"),
						rs.getString("pass"),rs.getInt("birth"),rs.getString("gender"), rs.getString("job"),
						rs.getString("city"), rs.getDate("joinDate"));
				close(rs, pstmt, conn);
				return vo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public int checkMemno(int memno) { //회원 번호를 검사하여 회원 정보 보내는 함수
		for(int i = 0; i <= list.size(); i++) {
			if(list.get(i).memno == memno) {
				return i;
			}
		}
		return 0;
	}
	
	public void firstMember() { //테이블의 남은 데이터를 리스트에 추가해줌
		try {
			Connection conn = getConnection();
			String selectSql = "SELECT * FROM MEMBER_TBL ORDER BY MEMNO";
			PreparedStatement pstmt = conn.prepareStatement(selectSql);
			ResultSet rs = pstmt.executeQuery();
			
			MemberVO vo = null;
			while(rs.next()){
				vo = new MemberVO(rs.getInt("memno"), rs.getString("name"),rs.getString("id"),
						rs.getString("pass"),rs.getInt("birth"),rs.getString("gender"), rs.getString("job"),
						rs.getString("city"), rs.getDate("joinDate"));
				list.add(vo);
			}
			instance.close(rs, pstmt, conn);
			instance.first = false;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}