<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container mt-5">
	<div class="row tm-content-row"></div>
	<!-- row -->
	<div class="row tm-content-row">
		<div class="tm-block-col tm-col-avatar">
			<div class="tm-bg-primary-dark tm-block tm-block-avatar">
				<h2 class="tm-block-title">프로필 이미지</h2>
				<div class="tm-avatar-container">
						<img src="/resources/img/default_profile.png" alt="Avatar" class="tm-avatar img-fluid mb-4" />
					<a href="#" class="tm-avatar-delete-link">
					<i class="far fa-trash-alt tm-product-delete-icon"></i>
					</a>
				</div>
				<button class="btn btn-primary btn-block text-uppercase">사진 변경</button>
			</div>
		</div>
		<div class="tm-block-col tm-col-account-settings">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<h2 class="tm-block-title">내 정보</h2>
				<form action="" class="tm-signup-form row">
					<div class="form-group col-lg-6">
						<label for="name">성명</label> <input id="name" name="name"
							type="text" class="form-control validate" value="${ pageContext.request.userPrincipal.principal.name}" />
					</div>
					<div class="form-group col-lg-6">
						<label for="email">생년월일</label>
						<input name="birth" value="<fmt:formatDate value="${ pageContext.request.userPrincipal.principal.birth}" pattern="yyyy-MM-dd" />"
							type='date' class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password">현재 비밀번호</label> 
						<input id="password" name="password" type="password" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password2">바꿀 비밀번호</label> 
						<input id="password" name="changePassword" type="password" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="phone">성별</label><br>  
						<label for="gender" style="vertical-align: middle;">남</label> 
						<input id="gender" name="gender" type="radio" checked="${ pageContext.request.userPrincipal.principal.gender eq 1 ? 'checked' : '' }"
							class="form-control validate"	value="male" style="display: inline-block" />
						&nbsp; &nbsp; &nbsp; &nbsp; 
						<label for="gender" style="vertical-align: middle;">여</label>
						<input id="gender" name="gender" type="radio" checked="${ pageContext.request.userPrincipal.principal.gender eq 0 ? 'checked' : '' }"
							class="form-control validate" value="female" style="display: inline-block" />
					</div>
					<div class="form-group col-lg-6">
						<label class="tm-hide-sm">&nbsp;</label>

					</div>
					<div class="form-group col-lg-6">
						<label class="tm-hide-sm">&nbsp;</label>
						<button type="submit"
							class="btn btn-primary btn-block text-uppercase">
							프로필 적용</button>
					</div>
					<div class="form-group col-lg-6">
						<label class="tm-hide-sm">&nbsp;</label>
						<button onclick="location.href='exit'" class="btn btn-primary btn-block text-uppercase">
							회원탈퇴</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>