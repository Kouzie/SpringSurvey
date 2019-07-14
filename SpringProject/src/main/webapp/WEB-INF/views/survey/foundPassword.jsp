<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container tm-mt-big tm-mb-big">
	<div class="row">
		<div class="col-12 mx-auto tm-login-col">
			<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
				<div class="row">
					<div class="col-12 text-center">
						<h2 class="tm-block-title mb-4">비밀번호 찾기</h2>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col-12">
						<form action="" method="post" class="tm-login-form">
							<div class="form-group">
								<label for="username">아이디 입력</label> 
								<input name="username" type="text" class="form-control validate" id="username">
							</div>
							<div class="form-group mt-3">
								<label for="email">이메일 입력</label>
								<input name="text" type="text" class="form-control validate" id="email">
							</div>
							<div class="form-group mt-4">
								<button type="submit" class="btn btn-primary btn-block text-uppercase">확인</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$("#username").on("blur", function(event) { //id중복 체크를 위해 blur시에 ajax로 id값 전달 및 반환값 출력
	var id_input = $(this);
	if ($(id_input).val() == '') {
		noticePopupInit({
			message : "ID를 입력하세요"
		});
		$("#checkid").html("ID를 입력하세요");
		$(id_input).attr("isvalid", false).css("color","blue");
		return;
	}
	$.ajax({
		url : "checkUsername",
		dataType : "json",
		cache: false,
		data : {
			"username" : $(id_input).val()
		},
		success : function(ret) {
			noticePopupInit({
				message : ret.message
			});
			if (!ret.result) { //ture반환시 이미 ID가 있는 상황
				$(id_input).attr("isvalid", false);
				$("#checkid").html("없는 ID입니다").css("color","red");
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