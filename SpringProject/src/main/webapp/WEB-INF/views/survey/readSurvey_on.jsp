<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col tm-col-account-settings-show">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<form id="voteform" method="post" class="tm-signup-form row"> <!-- action 추가 ?? 생략 ??-->
					<input type="hidden" id="survey_seq" name="survey_seq" value="${survey.survey_seq}">
					<div class="form-group col-lg-2 fa-2x">
						<label class="tm-block-title" for="Title">Title</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="TitleEL">${ survey.title }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-2">
						<label class="tm-block-title" for="Writer">Writer</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="WriterEL">${ survey.name }</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-2">
						<label class="tm-block-title" for="Period">기간</label>
					</div>
					<div class="form-group col-lg-10">
						<label for="PeriodEL"> 
						<fmt:formatDate value="${ survey.reg_date }" pattern="yy-MM-dd" /> 
						~ <fmt:formatDate value="${ survey.end_date }" pattern="yy-MM-dd" />
						</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="col-12">
						<h2 class="tm-block-title">목록</h2>
						<div class="form-group col-lg-12">
							<!-- 동적으로 설문지 보기 생성 or 그래프 출력 -->
							<c:forEach items="${ survey.surveyItemList }" var="item" varStatus="status">
								<label class="tm-hide-sm">
									<span style="vertical-align: super;">${ status.count } - ${ item.content }</span>
									&nbsp;&nbsp;
									<input name=itemSeq type="radio"
									class="form-control validate" value="${ item.survey_item_seq }"
									style="display: inline-block">
								</label><br>
							</c:forEach>
						</div>
					</div>
					<div class="form-group col-lg-12">
						<c:choose>
							<c:when test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq }">
								<button type="submit" id="surveyClose" class="btn btn-primary text-uppercase btn-show" style="float:left; margin-right: 4px;">마감</button>
							</c:when>
							<c:otherwise>
							<s:authorize ifAllGranted="ROLE_ADMIN">
								<button type="button" id="surveyClose" class="btn btn-primary text-uppercase btn-show" style="float:left; margin-right: 4px;">마감</button>
							</s:authorize>
							</c:otherwise>
						</c:choose>	
						<c:if test="${ survey.member_seq eq pageContext.request.userPrincipal.principal.member_seq}">
							<button type="button" id="surveyRemove" class="btn btn-primary text-uppercase btn-show">삭제</button>
						</c:if>
						<button type="button" id="surveyVote" class="btn btn-primary text-uppercase btn-show" style="float:right;">투표</button>
						<button type="button" id="surveyHome" class="btn btn-primary text-uppercase btn-show" style="float:right; margin-right: 4px">홈</button>
					</div> 
				</form>
				
			</div>
			
		</div>
		
	</div>
</div>
</div>
<script>
	
	$("surveyHome").on("click", function() {
		event.preventDefault();
		location.href="/survey/main";
	});
	
	 $("#surveyVote").on("click", function(event) {
			event.preventDefault();
		 		
			var form = $("#voteform")[0];
			var formData = new FormData(form);
			
			$.ajax({
				url : '',
				processData: false,
             	contentType: false,
				data : formData,
				type : "POST",
				cache: false,
				success : function(ret) {
					if (!ret.result) { 
						noticePopupInit({
							message: ret.message,
						});
					}
					else {
						noticePopupInit({
				            message : ret.message,
				            complete : setTimeout(function() {
				            	location.href = "/survey/main";
				               }, 3000)
				        });
						
					}
				},
				error: function () {
					noticePopupInit({
						message : "서버 에러. 잠시후에 시도하세요"
					});
				}
			});
	 });	
	
	$("#surveyClose").on("click", function() {
		event.preventDefault();
		var result = confirm("설문을 마감하시겠습니까?");
		
		if(result) {
			var form = $("#voteform")[0];
			$(form).attr("action", "closeSurvey");
			$(form).submit();
		}
	});
	
	$("#surveyRemove").on("click", function() {
		event.preventDefault();
		
		var result = confirm("설문을 삭제하시겠습니까?");
		
		if(result) {
			var form = $("#voteform")[0];
			$(form).attr("action", "removeSurvey");
			$(form).submit();
		}
	});
</script>
