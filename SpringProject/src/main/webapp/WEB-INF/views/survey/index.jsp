<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="container">
	<div class="row">
		<div class="col">
			<p class="text-white mt-5 mb-5 fa-2x">
				<c:if test="${ param.progressing eq 1 or param.progressing eq null }"><b>진행 중인 설문 목록</b></c:if>
				<c:if test="${ param.progressing eq 0 }"><b>마감된 설문 목록</b></c:if>
			</p>
		</div>
	</div>
	<div class="row tm-content-row">
		<div class="col-sm-12 col-md-12 col-lg-8 col-xl-8 tm-block-col">
			<div class="tm-bg-primary-dark tm-radius-product">
				<div class="tm-product-categories">
				<c:set var="progressing" value="${empty param.progressing or param.progressing eq 1 ? 1 : 0 }"/>
					<c:forEach items="${ surveyList }" var="survey">
						<div class="media tm-notification-item-radius">
							<a href="/survey/readSurvey?survey_seq=${ survey.survey_seq }&progressing=${ progressing }">
								<div class="tm-gray-circle">
									<img src="/resources/img/${ survey.image ne null ? survey.image : 'default_survey.png'}" alt="Avatar Image"
										class="rounded-circle">
								</div>
							</a>
							<div class="media-body">
								<a href="/survey/readSurvey?survey_seq=${ survey.survey_seq }&progressing=<c:out value='${ progressing }'/>">
									<h2 class="tm-block-title">${ survey.title }</h2>
								</a>
								<span class="tm-small tm-text-color-secondary">${ survey.name }</span><br>
								<span class="tm-small tm-text-color-secondary">
									<fmt:formatDate value="${ survey.reg_date }" pattern="yy-MM-dd" />
									~
									<fmt:formatDate value="${ survey.end_date }" pattern="yy-MM-dd" />
								</span>
							</div>
							<span>
								<div class="tm-status-circle ${ survey.progressing == 1 ? 'moving' : 'cancelled' }"></div>${ survey.progressing == 1 ? '진행중' : '마감' } <br>
							<br>
								<div><i class="fa fa-fw fa-users"></i> :${ survey.participantCnt }</div>
							</span>
						</div>
					</c:forEach>
				</div>
				<div class="pagination_div">
					<ul class="pagination">
						<!-- <li class="page-link"><a href="#">«</a></li>
						<li class="page-link"><a href="#">1</a></li>
						<li class="page-link"><a href="#">2</a></li>
						<li class="page-link"><a href="#">3</a></li>
						<li class="page-link"><a href="#">»</a></li> -->
					</ul>
				</div>
				<script type="text/javascript">
					createPagination();
					function createPagination() {
						var location = "${ cri.makeSearch() }";
						var page_ul = $(".pagination");
						var curPage = ${ cri.page };
						var totalPage = ${ pageMaker.totalPage };
						var displayPageNum = ${ pageMaker.displayPageNum };
						
						var startPage = (curPage - 1) / displayPageNum * displayPageNum + 1;
						var endPage = (curPage - 1) / displayPageNum * displayPageNum + displayPageNum;
						if (endPage > totalPage) {
							endPage = totalPage;
						}
						var li = $("<li>", {class:'page-link'});
						var a = $("<a>", {href: location + "&page="+(startPage-1), html: "«"});
						li.append(a);
						page_ul.append(li);
						if (startPage == 1) {
							li.addClass("disabled");
							a.attr("href", "#")
						}
						
						for (var i = startPage; i <= endPage; i++) {
							var li = $("<li>", {class:'page-link'});
							var a = $("<a>", {href: location + "&page="+i, html: i});
							li.append(a);
							page_ul.append(li);
						}
						
						var li = $("<li>", {class:'page-link'});
						var a = $("<a>", {href: location + "&page="+(endPage+1), html: "»"});
						li.append(a);
						page_ul.append(li);
						if (endPage >= totalPage) {
							li.addClass("disabled");
							a.attr("href", "#")
						}
					}
				</script>
			</div>

		</div>
		<div class="col-sm-12 col-md-12 col-lg-4 col-xl-4 tm-block-col">
			<div style="padding-top: 20px;"
				class="tm-bg-primary-dark tm-radius-product tm-block tm-block-product-categories">
				
				<button onclick="location.href='<%=request.getContextPath() %>addSurvey'" class="btn btn-primary btn-block text-uppercase mb-3" >설문 등록</button>
				<br>
				<h2 class="tm-block-title" style="margin-bottom: 0px;">관리자</h2>
				<div class="tm-product-table-container">
					<c:forEach items="${ adminList }" var="admin">
						<div class="media tm-notification-item">
							<div class="tm-gray-circle-small">
								<img
									src="/resources/img/${ admin.image ne null ? admin.image : 'default_profile.png'}"
									alt="Avatar Image" class="rounded-circle-small">
							</div>
							<div class="media-body">
								<p class="mb-2">${ admin.username }</p>
								<span class="tm-small tm-text-color-secondary">${ admin.name }</span>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- table container -->
			</div>
		</div>
	</div>
</div>