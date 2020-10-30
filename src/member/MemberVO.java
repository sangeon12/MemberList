package member;

import java.sql.Date;

public class MemberVO {
	int memno;
	String name;
	String id;
	String pass;
	int birth;
	String gender;
	String job;
	String city;
	Date joinDate;
	
	public MemberVO() {}
	
	
	public MemberVO(int memno, String name, String id, String pass, int birth, String gender, String job, String city,
			Date joinDate) {
		this.memno = memno;
		this.name = name;
		this.id = id;
		this.pass = pass;
		this.birth = birth;
		this.gender = gender;
		this.job = job;
		this.city = city;
		this.joinDate = joinDate;
	}


	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}


	public int getMemno() {
		return memno;
	}


	public void setMemno(int memno) {
		this.memno = memno;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPass() {
		return pass;
	}


	public void setPass(String pass) {
		this.pass = pass;
	}


	public int getBirth() {
		return birth;
	}


	public void setBirth(int birth) {
		this.birth = birth;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getJob() {
		return job;
	}


	public void setJob(String job) {
		this.job = job;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public Date getJoinDate() {
		return joinDate;
	}


	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
	
}
