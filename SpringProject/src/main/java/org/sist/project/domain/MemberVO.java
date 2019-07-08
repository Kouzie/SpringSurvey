package org.sist.project.domain;

import java.util.Date;

public class MemberVO {
	private int member_seq;
	private String username;
	private String password;
	private int enabled;
	private String name;
	private Date birth;
	private int gender;
	private String image;
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "MemberVO [member_seq=" + member_seq + ", username=" + username + ", password=" + password + ", enabled="
				+ enabled + ", name=" + name + ", birth=" + birth + ", gender=" + gender + ", image=" + image + "]";
	}
	
	
}
