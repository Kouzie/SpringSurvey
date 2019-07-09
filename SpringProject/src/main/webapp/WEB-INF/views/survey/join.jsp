<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container mt-5">
	<!-- row -->
	<div class="row tm-content-row">
		<div class="tm-block-col tm-col-avatar">
			<div class="tm-bg-primary-dark tm-block tm-block-avatar">
				<h2 class="tm-block-title">프로필 이미지</h2>
				<div class="tm-avatar-container-join">
					<img src="/resources/img/default_profile.png" alt="Avatar" class="tm-avatar img-fluid mb-4" />
					<a href="#" class="tm-avatar-delete-link">
						<i class="far fa-trash-alt tm-product-delete-icon"></i>
					</a>
				</div>
				<button class="btn btn-primary btn-block text-uppercase upload-button">사진 업로드</button>
			</div>
		</div>
		<div class="tm-block-col tm-col-account-settings">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<h2 class="tm-block-title">회원가입</h2>
				<form action="" class="tm-signup-form row">
					<div class="form-group col-lg-12">
						<label for="username">아이디</label> <input id="name" name="name"
							type="text" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password">비밀번호</label> <input id="password"
							name="password" type="password" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password2">비밀번호 확인</label> <input id="password2"
							name="password2" type="password" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="name">이름</label> <input id="name" name="name"
							type="text" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="expire_date">생일 </label> <input name="birth"
							type='date' class="form-control validate" /><br>
					</div>
					<div class="form-group col-lg-6">
						<label for="gender">성별</label><br> <label for="gender"
							style="vertical-align: middle;">남</label> <input id="gender"
							name="gender" type="radio" class="form-control validate"
							value="남" style="display: inline-block" /> &nbsp; &nbsp; &nbsp;
						&nbsp; <label for="gender" style="vertical-align: middle;">여</label><input
							id="gender" name="gender" type="radio"
							class="form-control validate" value="여"
							style="display: inline-block" />
					</div>
					<div class="form-group col-lg-6">
						<label class="tm-hide-sm">&nbsp;</label>
						<button type="submit"
							class="btn btn-primary btn-block text-uppercase">확인</button>
						<button type="submit"
							class="btn btn-primary btn-block text-uppercase">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$("upload-button")
</script>