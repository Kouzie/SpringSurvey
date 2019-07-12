package org.sist.project.member;

import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

public class MemberAuthenticationToken extends UsernamePasswordAuthenticationToken{
	MemberDetails memberDetails;
	public MemberAuthenticationToken(Object principal, Object credentials,
			Collection<? extends GrantedAuthority> authorities) {
		super(principal, credentials, authorities);
		this.memberDetails = memberDetails;
	}

}
