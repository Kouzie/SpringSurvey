package org.sist.project.member;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class MemberDetails implements UserDetails{
	private int member_seq;
	private String username;
	private String password;
	private String authority;
	private boolean enabled;
	private String name;
	private Date birth;
	private int gender;
	private String image;
	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority(authority));
        return auth;
    }


	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return enabled;
	}


	public int getMember_seq() {
		return member_seq;
	}


	public String getAuthority() {
		return authority;
	}


	public String getName() {
		return name;
	}


	public Date getBirth() {
		return birth;
	}


	public int getGender() {
		return gender;
	}


	public String getImage() {
		return image;
	}
}
