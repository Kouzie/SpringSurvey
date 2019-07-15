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
					<input type="file" id="profile-image-input" name="image" style="display: none">
					<div class="form-group col-lg-6">
						<label for="name">성명</label>&nbsp;&nbsp;<span id="checkname"></span> <input id="name" name="name"
							type="text" class="form-control validate" isvalid="false" value="${ pageContext.request.userPrincipal.principal.name}" />
					</div>
					<div class="form-group col-lg-6">
						<label for="email">생년월일</label>&nbsp;&nbsp;<span id="checkdate"></span>
						<input id="birth" name="birth" isvalid="false" value="<fmt:formatDate value="${ pageContext.request.userPrincipal.principal.birth}" pattern="yyyy-MM-dd" />"
							type='date' class="form-control validate" />
					</div>
					<div class="form-group col-lg-6">
						<label for="password">현재 비밀번호</label>&nbsp;&nbsp;<span id="checkpw"></span> 
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
						<button type="" id="submit"
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
	 $("#submit").on("click", function(event) { //id중복 체크를 위해 blur시에 ajax로 id값 전달 및 반환값 출력
			event.preventDefault();
		 	var pw_input = $("#password").val();
			var name_input = $("#name").val();
			// var date_input = $("#birth").val();
	 		var chpw_input = $("#changePassword").val();	
	 		// var gender_input = $("#gender").val();
	 		
	 		// 폼객체를 불러와서
			var form = $('form')[0];
			// FormData parameter에 담아줌
			var formData = new FormData(form);
	 		
	 		if (pw_input == '') {
				noticePopupInit({
					message : "비밀번호를 입력하세요"
				});
				$("#checkpw").html("비밀번호를 입력하세요");
				$(pw_input).attr("isvalid", false).css("color","blue");
				return;
			}
			
	 		if(name_input == '') {
	 			noticePopupInit({
					message : "닉네임을 입력하세요"
				});
	 			$("#checkname").html("비밀번호를 입력하세요");
				$(name_input).attr("isvalid", false).css("color","blue");
				return;
	 		}
				 		
	 		if(chpw_input = '') {
	 			chpw_input = pw_input;
	 		}
			$.ajax({
				url : "editProfile",
				method : "POST",
				dataType : "json",
				cache: false,
				data : formData, 
				/* 
				{
					"password" : pw_input,
					"changePassword" : chpw_input,
					"name" : name_input,
					"birth" : date_input,
					"gender" : gender_input,
					"image" : 
				}
				 */
				success : function(ret) {
					noticePopupInit({
						message : ret.message
					});
					if (!ret.result) { 
						console.log("회원 정보 수정을 실패하였습니다. 입력값을 확인하세요");
					}
					else {
						console.log(message);
						location.href = "/survey/main";
					}
				},
				
				error: function () {
					noticePopupInit({
						message : "서버 에러. 잠시후에 시도하세요"
					});
					$("#checkid").html("서버 에러... 잠시후에 시도하세요").css("color","red");
				}
			});
		});	
	 
</script>
<script>
$(".tm-avatar-delete-link").on("click", function() {
	$(".tm-avatar").attr("src", "/resources/img/default_profile.png");
	/* document.getElementById("profile-image-input").select();
	document.selection.clear(); */
	var input = document.getElementById("profile-image-input");
	input.value = ''
	if(!/safari/i.test(navigator.userAgent)){
	  input.type = '';
	  input.type = 'file';
	}
});
</script>
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