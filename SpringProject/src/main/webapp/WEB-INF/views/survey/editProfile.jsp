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
						<input id="password" name="password" type="password" isvalid="false" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password2">바꿀 비밀번호</label> 
						<input id="password" name="changePassword" type="password" isvalid="false" class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="genderType">성별</label><br>  
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
<script>
	$(".upload-button").on("click", function () {
		upload.click();
	});

	var upload = document.getElementById("profile-image-input");
	var img = document.getElementById("profile-image");
	upload.onchange = function (e) {
		e.preventDefault();
		var file = upload.files[0];
		var reader = new FileReader();
		reader.onload = function (event) {
			img.src = event.target.result;
		};
		reader.readAsDataURL(file);
		return false;
	}
</script>
<script>
	/* 
	$("#btn_cancle").one("click", function (event) {
		event.preventDefault();
		location.href = "/survey/main"
	});
	 */
		
	$("#password2").on("blur", function(event) {
		var password = $("#password").val();
		var password2 = $(this).val();
		
		if (password != password2) {
			noticePopupInit({
				message : "비밀번호가 일치하지 않습니다."
			});
			$("#checkpw").html("비밀번호가 일치하지 않습니다.").css("color","red");
			$(this).attr("isvalid", false);
		}
		else {
			$("#checkpw").html("비밀번호가 일치합니다.").css("color","blue");
			$(this).attr("isvalid", true);
		}
	});
	 
	$("#submit").on("click", function (event) {
		event.preventDefault();
		var inputs = $("input[type='text'], input[type='password'], input[type='date']"); //유효성 체크할 성명, pw, date를 가져옴
		var result = false;
		$.each($(inputs), function( index, value ) {
			if ($(value).val() == '' ) {
				noticePopupInit({ 
					message:'모든 값을 입력해주세요.' 
				});
				$(value).focus();
				result = false;
				return false;
			}
			result = true;
			return;
		}); //만약 해당 input태그에 값이 없을 경우 focus하고 빠져나옴
		if (!result) {
			return;
		}
		/* 
		$.each($("input[isvalid]"), function( index, value ) {
			if (!$(value).attr("isvalid")) {
				noticePopupInit({
					message:'정확한 값을 입력해주세요.' 
				});
				$(value).focus();
				result = false;
				return false;
			}
			result = true;
			return;
		}); //값이 있는 대신 id가 중복된 아이디거나 pw가 일치하지 않으면 focus하고 빠져나옴
		 */
		if (result) { //모든 유효성을 통과했다면 submit
			var formtag = $(".tm-signup-form"); 
			$(formtag).submit();
		}
	}); 
</script>