package org.sist.project.member;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public class MemberAuthenticationProvider implements AuthenticationProvider  {
	private static final Logger logger = LoggerFactory.getLogger(MemberAuthenticationProvider.class); 

	@Autowired
	UserDetailsService userService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();
		String password = (String) authentication.getCredentials(); 
		UserDetails user = userService.loadUserByUsername(username);
		logger.info("username : " + user.getUsername() + " / password : " + user.getPassword()); 

		Collection<? extends GrantedAuthority> authorities = 
				user.getAuthorities();
		
		return new UsernamePasswordAuthenticationToken(user, password, authorities);

	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return false;
	}

}
