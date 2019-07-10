<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="tm-block-col tm-col-account-settings-show">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<div class="form-group col-lg-4">
					<label for="Title">Title</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="TitleEL">${ survey.title }</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="form-group col-lg-4">
					<label for="Writer">Writer</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="WriterEL">${ survey.name }</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="form-group col-lg-4">
					<label for="Period">기간</label>
				</div>
				<div class="form-group col-lg-8">
					<label for="PeriodEL">
						<fmt:formatDate value="${ survey.reg_date }" pattern="yy-MM-dd" />
						~
						<fmt:formatDate value="${ survey.end_date }" pattern="yy-MM-dd" />
					</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="col-12">
					<h2 class="tm-block-title">목록</h2>
					<div class="form-group col-lg-12">
						<!-- 동적으로 설문지 보기 생성 or 그래프 출력 -->
						<label class="tm-hide-sm">EL</label> 
						<label class="tm-hide-sm">EL</label>
						<label class="tm-hide-sm">EL</label> 
						<label class="tm-hide-sm">EL</label>
						<label class="tm-hide-sm">EL</label>
					</div>
				</div>
				<div class="form-group col-lg-3">
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show">삭제</button>
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show">마감</button>
				</div>
				<div class="form-group col-lg-3 show-right">
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show">투표하기</button>
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show">나가기</button>
				</div>
			</div>
		</div>
	</div>
</div>
