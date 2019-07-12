<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container mt-5">
	<div class="row tm-content-row">
		<div class="col-xl-6 tm-block-col ">
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
					<label for="PeriodEL"> <fmt:formatDate
							value="${ survey.reg_date }" pattern="yy-MM-dd" /> ~ <fmt:formatDate
							value="${ survey.end_date }" pattern="yy-MM-dd" />
					</label>
				</div>
				<hr class="show-hr" width="100%">
				<div class="col-12">
					<div class="tm-bg-primary-dark tm-block tm-block"
						style="padding: 0; height: 300px">
						<h2 class="tm-block-title" style="padding: 0">
						투표 결과
						</h2>
						<canvas id="pieChart" class="chartjs-render-monitor" width="200"
							height="200"></canvas>
					</div>
					<h2 class="tm-block-title">목록</h2>
					<div class="form-group col-lg-12">
						<c:forEach items="${ survey.surveyItemList }" var="item" varStatus="status">
							<label class="tm-hide-sm"><span>${ status.count } - ${ item.content }</span></label><br>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-6 tm-block-col ">
			<div class="tm-bg-primary-dark tm-block tm-block-settings">
				<div>
					<h2 class="tm-block-title">성별 투표결과</h2>
					<canvas id="lineChart"></canvas>
				</div>
				<div style="padding-top: 40px">
					<h2 class="tm-block-title">나이별 투표결과</h2>
					<canvas id="barChart"></canvas>
				</div>
				<div style="padding: 30px"></div>
				<div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-overflow" style="padding:10px">
                        <h2 class="tm-block-title">Reply board</h2>
                        <div id="mydiv" class="tm-notification-items">
                            <div class="media tm-notification-item">
                                <div style="width:100%">
                                	<textarea class="reply-text" type="text" style="width: 100%;height: 100px;word-wrap: break-word;"></textarea>
                                	<br>
                                	<button type="button" class="btn-reply" style="width: 100%; color: #fff; background-color: #f5a623; border: 2px solid #f5a623;" >댓글입력</button>
                                </div>
                            </div>
                            
                            <c:forEach items="${ reply }" var="dto" varStatus="status">
							
	                            <div class="media tm-notification-item">
    	                            <c:if test="${empty dto.image}">
    	                            <img src="/resources/img/default_profile.png" alt="Avatar Image" class="rounded-circle-small" style="margin-right: 10px;">
    	                            </c:if>
    	                            <c:if test="${not empty dto.image}">
    	                            <img src="${reply.image}" alt="Avatar Image" class="rounded-circle-small" style="margin-right: 10px;">
    	                            </c:if>
        	                        <div class="media-body">
            	                        <p class="mb-2"><h4>${dto.username}</h4><b>${dto.reply_msg}</b> </p>
                	                    <span class="tm-small tm-text-color-secondary">${dto.writedate}  </span><button id="editReply" type="button">수정</button><button id="delReply" type="button">삭제</button>
                    	            </div>
                        	    </div>
                        	    
							</c:forEach>
                        </div>
                    </div>
				<span class="form-group col-lg-3" style="padding: 10px">
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show">삭제</button>
					<button type="submit"
						class="btn btn-primary text-uppercase btn-show"
						style="float: right">목록</button>
				</span>
			</div>
		</div>
	</div>
</div>
<script src="/resources/js/Chart.min.js"></script>
<script src="/resources/js/tooplate-scripts.js"></script>
<script>
	Chart.defaults.global.defaultFontColor = 'white';
	let ctxLine, ctxBar, ctxPie, optionsLine, optionsBar, optionsPie, configLine, configBar, configPie, lineChart;
	barChart, pieChart;
	// DOM is ready
	var dataset = ${ dataset };
	var itemList = ${ itemList };
	$(function() {
		drawLineChart(dataset, itemList); // Line Chart
		drawBarChart(dataset, itemList); // Bar Chart
		drawPieChart(dataset, itemList); // Pie Chart

		$(window).resize(function() {
			updateLineChart();
			updateBarChart();
			updatePieChart();
		});
	})
	var count = getTotalCountList(dataset, itemList);
	$.each($("label.tm-hide-sm"), function(index) {
		$(this)
		.append(" [ <i class='fa fa-fw fa-tags'></i>&nbsp;" + count[index] + "표 ] ")
	});
	
	//댓글 ajax
	$(".btn-reply").click(function(event) {

		var username = '${pageContext.request.userPrincipal.name}';
		var reply_msg = $(".reply-text").val();
		var survey_seq = ${param.survey_seq};
		
		var posting = $.post("replyInsert", {
			username : username,
			reply_msg : reply_msg,
			survey_seq : survey_seq
		});
		
		$("#mydiv").load(" #mydiv");
		
	});
</script>