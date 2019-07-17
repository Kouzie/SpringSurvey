<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="navbar navbar-expand-xl">
<div class="container h-100">
	<a class="navbar-brand" href="main">
		<img src="/resources/logo/mini_logo.png" alt="logo" class="title-logo" style="height: 80px"/>
	</a>
	<button class="navbar-toggler ml-auto mr-0" type="button"
		data-toggle="collapse" data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<i class="fas fa-bars tm-nav-icon"></i>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mx-auto h-100">
			<li class="nav-item"><a class="nav-link" href="main?progressing=1">
					<i class="fas fa-file-alt"></i> 진행중 설문
			</a></li>
			<li class="nav-item"><a class="nav-link" href="main?progressing=0">
					<i class="fas fa-chart-pie"></i> 마감된 설문
			</a></li>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link" href="editProfile">
						<i class="far fa-user"></i> 개인정보변경
				</a></li>
				<s:authorize ifAllGranted="ROLE_ADMIN">
					<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath() %>admin">
							<i class="far fa-eye"></i> 관리자페이지
					</a></li>
				</s:authorize>
			</c:if>
		</ul>
		<ul class="navbar-nav">
			<c:if test="${ empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link d-block"
					href="login"> <i class="fas fa-sign-in-alt"></i> 로그인</a></li>
				<li class="nav-item"><a class="nav-link d-block"
					href="join"> <i class="fas fa-check"></i> 회원가입
				</a></li>
			</c:if>
			<c:if test="${ not empty pageContext.request.userPrincipal }">
				<li class="nav-item"><a class="nav-link" href="logout">
					<i class="fas fa-sign-out-alt"></i> 로그아웃
					</a>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link" id="dLabel" role="button" data-toggle="dropdown" data-target="#"
						href="/page.html"> 
						<i class="fas fa-bell"></i>알림
						<span class="label label-warning" style="color:white">0</span>
					</a>
					<ul class="dropdown-menu notifications" role="menu"
						aria-labelledby="dLabel" style="left: -200px; position: absolute;">

						<div class="notification-heading">
							<h2 class="tm-block-title" style="margin-bottom: 0px;">알림</h2>
						</div>
						<li class="divider"></li>

						<div id="notifications-current" class="notifications-wrapper">
							<a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png"
											alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png"
											alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a>
						</div>


						<div id="notifications-past" class="notifications-wrapper" style="display: none">
							<a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> <a class="content" href="#">
								<div class="media notification-item">
									<div class="tm-gray-circle-small">
										<img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small">
									</div>
									<div class="media-body">
										<p class="mb-2">kouzie - past</p>
										<span class="tm-small tm-text-color-secondary">고지용</span>
									</div>
								</div>
							</a> 
						</div>
						
						<li class="divider"></li>
						<div class="notification-footer">
							<p id="change-notice" class="notice-current" style="float: right; cursor: pointer; margin: 0">지난 알림보기</p>
						</div>
					</ul>

				</li>
			</c:if>
		</ul>
	</div>
</div>
</nav>
<c:if test="${ not empty pageContext.request.userPrincipal }">
	<link rel="stylesheet" href="/resources/css/nav_notice.css"/>
	<script src="/resources/js/nav_notice.js"></script>
	<script>
		getNoticeCount(${ pageContext.request.userPrincipal.principal.member_seq });
		setInterval(function() {
			getNoticeCount(${ pageContext.request.userPrincipal.principal.member_seq })
		}, 10000)
	</script>
</c:if>
