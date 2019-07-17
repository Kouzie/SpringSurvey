<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="" class="noticePopup">
	<div class="noticeMessage"></div>
</div>
<footer class="tm-footer row tm-mt-small">
<div class="col-12 font-weight-light">
	<p class="text-center text-white mb-0 px-4 small">
		Copyright &copy; <b>2018</b> All rights reserved. Design: <a
			rel="nofollow noopener" href="https://templatemo.com"
			class="tm-footer-link">Template Mo</a>
	</p>
</div>
</footer>
<!-- footer -->
<script type="text/javascript">
if(getParameterByName("login_error")=="true") {
	noticePopupInit({
		message:"로그인에 실패하였습니다. "
	});
} else if(getParameterByName("quit")=="success") {
	noticePopupInit({
		message: "회원탈퇴가 완료되었습니다."
	});
} else if(getParameterByName("surveyclose")=="success") {
	noticePopupInit({
		message: "설문조사가 마감되었습니다. 마감된 설문조사에서 확인해주세요"
	});
} else if(getParameterByName("surveyremove")) {
	noticePopupInit({
		message: "설문조사 삭제가 완료되었습니다."
	});
}
</script>