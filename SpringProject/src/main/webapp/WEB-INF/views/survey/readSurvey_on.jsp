<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<div class="container mt-5">
	<!-- 
        <div class="row tm-content-row">
          <div class="col-12 tm-block-col">
            <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
              <h2 class="tm-block-title">List of Accounts</h2>
              <p class="text-white">Accounts</p>
              <select class="custom-select">
                <option value="0">Select account</option>
                <option value="1">Admin</option>
                <option value="2">Editor</option>
                <option value="3">Merchant</option>
                <option value="4">Customer</option>
              </select>
            </div>
          </div>
        </div>
         -->
	<!-- row -->
	<div class="row tm-content-row">
		<!-- 
          <div class="tm-block-col tm-col-avatar">
            <div class="tm-bg-primary-dark tm-block tm-block-avatar">
              <h2 class="tm-block-title">Change Avatar</h2>
              <div class="tm-avatar-container">
                <img
                  src="img/avatar.png"
                  alt="Avatar"
                  class="tm-avatar img-fluid mb-4"
                />
                <a href="#" class="tm-avatar-delete-link">
                  <i class="far fa-trash-alt tm-product-delete-icon"></i>
                </a>
              </div>
              <button class="btn btn-primary btn-block text-uppercase">
                Upload New Photo
              </button>
            </div>
          </div>
           -->
		<div class="tm-block-col tm-col-account-settings-show">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<form action="" class="tm-signup-form row">
					<div class="form-group col-lg-4">
						<label for="Title">Title</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="TitleEL">Title EL</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-4">
						<label for="Writer">Writer</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="WriterEL">Writer EL</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="form-group col-lg-4">
						<label for="Period">기간</label>
					</div>
					<div class="form-group col-lg-8">
						<label for="PeriodEL">기간 EL</label>
					</div>
					<hr class="show-hr" width="100%">
					<div class="col-12">
						<h2 class="tm-block-title">목록</h2>
						<div class="form-group col-lg-12">
							<!-- 동적으로 설문지 보기 생성 or 그래프 출력 -->
							<label class="tm-hide-sm">EL</label> <label class="tm-hide-sm">EL</label>
							<label class="tm-hide-sm">EL</label> <label class="tm-hide-sm">EL</label>
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

				</form>
			</div>
		</div>
	</div>
</div>
