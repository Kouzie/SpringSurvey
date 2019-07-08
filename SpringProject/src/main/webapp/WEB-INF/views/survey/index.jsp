<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container">
  <div class="row">
    <div class="col">
      <p class="text-white mt-5 mb-5 fa-2x"><b>진행중인 설문 목록</b></p>
    </div>
  </div>
  <div class="row tm-content-row">
    <div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
      <div class="tm-bg-primary-dark tm-radius-product">
        <div class="tm-product-categories">
          <div class="media tm-notification-item-radius">
            <div class="tm-gray-circle"><img src="/resources/img/notification-01.jpg" alt="Avatar Image" class="rounded-circle">
            </div>
            <div class="media-body">
              <p class="mb-2">가장 섹시한 여배우는?</p>
              <span class="tm-small tm-text-color-secondary">고지용</span><br>
              <span class="tm-small tm-text-color-secondary">2019-07-04 ~ 2019-07-05</span>
            </div>
            <span>
              <div class="tm-status-circle moving"></div>진행중
              <br><br>
              <div>참여인원 : </div>
            </span>
          </div>
          <div class="media tm-notification-item-radius">
            <div class="tm-gray-circle"><img src="/resources/img/notification-01.jpg" alt="Avatar Image" class="rounded-circle">
            </div>
            <div class="media-body">
              <p class="mb-2">가장 섹시한 여배우는?</p>
              <span class="tm-small tm-text-color-secondary">고지용</span><br>
              <span class="tm-small tm-text-color-secondary">2019-07-04 ~ 2019-07-05</span>
            </div>
            <span>
              <div class="tm-status-circle cancelled"></div>마감
              <br><br>
              <div>참여인원 : </div>
            </span>
          </div>
        </div>
        <div class="pagination_div">
          <ul class="pagination">
            <li class="page-link"><a href="#">«</a></li>
            <li class="page-link"><a href="#">1</a></li>
            <li class="page-link"><a href="#">2</a></li>
            <li class="page-link"><a href="#">3</a></li>
            <li class="page-link"><a href="#">»</a></li>
          </ul>
        </div>
      </div>

    </div>
    <div class="col-sm-12 col-md-12 col-lg-4 col-xl-4 tm-block-col">
      <div class="tm-bg-primary-dark tm-radius-product tm-block tm-block-product-categories">
         <a href="<%=request.getContextPath() %>insertSurvey">
        <button class="btn btn-primary btn-block text-uppercase mb-3" >
         설문 등록
        </button>
         </a>
        <br><br>
        <h2 class="tm-block-title">관리자</h2>
        <div class="tm-product-table-container">
          <div class="media tm-notification-item">
            <div class="tm-gray-circle-small"><img src="/resources/img/notification-01.jpg" alt="Avatar Image"
                class="rounded-circle-small"></div>
            <div class="media-body">
              <p class="mb-2">Kouzie</p>
              <span class="tm-small tm-text-color-secondary">개발자1</span>
            </div>
          </div>
          <div class="media tm-notification-item">
            <div class="tm-gray-circle-small"><img src="/resources/img/notification-01.jpg" alt="Avatar Image"
                class="rounded-circle-small"></div>
            <div class="media-body">
              <p class="mb-2">GridLake</p>
              <span class="tm-small tm-text-color-secondary">개발자2</span>
            </div>
          </div>
          <div class="media tm-notification-item">
            <div class="tm-gray-circle-small"><img src="/resources/img/notification-01.jpg" alt="Avatar Image"
                class="rounded-circle-small"></div>
            <div class="media-body">
              <p class="mb-2">mmrileymm</p>
              <span class="tm-small tm-text-color-secondary">개발자3</span>
            </div>
          </div>
          <div class="media tm-notification-item">
            <div class="tm-gray-circle-small"><img src="/resources/img/notification-01.jpg" alt="Avatar Image"
                class="rounded-circle-small"></div>
            <div class="media-body">
              <p class="mb-2">Yea-Na</p>
              <span class="tm-small tm-text-color-secondary">개발자4</span>
            </div>
          </div>
        </div>
        <!-- table container -->
      </div>
    </div>
  </div>
</div>