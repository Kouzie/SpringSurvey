<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="navbar navbar-expand-xl">
<div class="container h-100">
	<a class="navbar-brand" href="main">
		<h1 class="tm-site-title mb-0">유종의미조</h1>
	</a>
	<button class="navbar-toggler ml-auto mr-0" type="button"
		data-toggle="collapse" data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<i class="fas fa-bars tm-nav-icon"></i>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mx-auto h-100">
			<li class="nav-item"><a class="nav-link" href="products.html">
					<i class="fas fa-file-alt"></i> 진행중 설문
			</a></li>
			<li class="nav-item"><a class="nav-link" href="products.html">
					<i class="fas fa-chart-pie"></i> 마감된 설문
			</a></li>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link" href="accounts.html">
						<i class="far fa-user"></i> 개인정보변경
				</a></li>
			</c:if>
			<s:authorize  ifAllGranted="ROLE_ADMIN">
				<li class="nav-item"><a class="nav-link" href="accounts.html">
						<i class="far fa-eye"></i> 관리자페이지
				</a></li>
			</s:authorize>
		</ul>
		<ul class="navbar-nav">
			<c:if test="${ empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link d-block"
					href="login"> <i class="fas fa-sign-in-alt"></i> 로그인
				</a></li>
				<li class="nav-item"><a class="nav-link d-block"
					href="join"> <i class="fas fa-check"></i> 회원가입
				</a></li>
			</c:if>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link d-block"
					href="logout"> <i class="fas fa-sign-out-alt"></i> 로그아웃
				</a></li>
			</c:if>
		</ul>
	</div>
</div>
</nav>
