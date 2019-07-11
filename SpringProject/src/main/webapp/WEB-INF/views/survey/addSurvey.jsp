<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="en">
<head>
<script  type="text/javascript"  src="resources/js/jquery-3.3.1.min.js"></script>
<script  type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script  type="text/javascript" src="resources/js/Chart.min.js"></script>
<script  type="text/javascript" src="resources/js/moment.min.js"></script>
<script  type="text/javascript" src="resources/js/tooplate-scripts.js"></script>
<script  type="text/javascript" src="resources/jquery-ui-datepicker/jquery-ui.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Add Product - Dashboard HTML Template</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700">
<!-- https://fonts.google.com/specimen/Roboto -->
<link rel="stylesheet" href="css/fontawesome.min.css">
<!-- https://fontawesome.com/ -->
<link rel="stylesheet" href="jquery-ui-datepicker/jquery-ui.min.css"
	type="text/css">
<!-- http://api.jqueryui.com/datepicker/ -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet" href="css/templatemo-style.css">
<!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
</head>
<style>
.bigbox{
flex:100%;
max-width: 100%;
}
.surveybox {
	border: solid 1px gray;
}

.deleteblock {
	float: right;
}

.del_btn {
	background-color: transparent;
	border-color: transparent;
	color: #fff;
}
.del_btn:hover{
	background-color: transparent;
	border-color: transparent;
	color: red;
}
.addsurveybox{
/* border: solid 1px pink; */
}

.addq_btn{
	background-color: transparent;
	border-color: transparent;
	color: #fff;
}
.addq_btn:hover{
	background-color:#54657d;
	border-color: transparent;
	border-radius:53%;
	color: #fff;
}
.minusq_btn{
	background-color: transparent;
	border-color: transparent;
	color: #fff;
}

.warning {
	color: #fff;
}

.littleq {
	padding: 19px 18px;
	border-radius: 0;
	height: 16px;
	background-color: #54657d;
	color: #fff;
	border-bottom: solid 0.8px gray;
	display: inline;
	width: 60%;
	/*     height: calc(2.25rem); */
	/*     padding: .375rem .75rem; */
	font-size: 0.8rem;
}

.q {
	color: #fff
}

.q_num {
	color: #f5a623;
	display: inline;
}
</style>
<body>

	<div class="container tm-mt-big tm-mb-big">
		<div class="row">
			<div class="col-xl-9 col-lg-10 col-md-12 col-sm-12 mx-auto">
				<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
					<div class="row">
						<div class="col-12">
							<h2 class="tm-block-title d-inline-block">설문지 등록하기</h2>
						</div>
					</div>
					<div class="row tm-edit-product-row">
						<div class="col-xl-6 col-lg-6 col-md-12 bigbox">
							<form action="" class="tm-edit-product-form">
								<div class="form-group mb-3">
									<label for="name">설문지 제목</label> <input id="name" name="name"
										type="text" class="form-control validate" >
								</div>
								<div class="form-group mb-3">
									<label for="description">설문 목적 또는 기타 주의사항</label>
									<textarea class="form-control validate" rows="3" ></textarea>
								</div>
							</form>
						
									<br>
									
								</div>
         				<div class="form-group mb-3 col-xs-12 col-sm-6">
         				<label for="expire_date">마감 기한</label>
                          <input
                            id="expire_date"
                            name="expire_date"
                            type="text"
                            value="22 Jul 2019"
                            class="form-control validate"
                            data-large-mode="true"
                          />
                        </div>
    <script>
      $(function() {
        $("#expire_date").datepicker({
          defaultDate: "7/22/2019"
        });
      });
    </script>
						<div class="col-xl-6 col-lg-6 col-md-12 bigbox">
							<br> <br> <br>
							<div class="warning">
								* 다음항목에 해당되는 설문항목이 포함되어있을 시 경고조치없이 삭제될수있습니다.<br /> 1.폭력적이거나,
								선정적인 문항.<br /> 2.타인의 권리를 침해하거나, 명예를 훼손하는 문항<br /> 3.개인정보를 직접적으로
								묻는 문항<br /> <br /> * 같은 설문지를 24시간내에 중복해서 올릴 시, 경고조치와 함께 삭제됩니다. <br />
								<br /> <br />
							</div>
							<div class="col-xl-6 col-lg-6 col-md-12 bigbox surveybox">
								<div id="addsurveybox_1" class="form-group mb-3 addsurveybox">
									
									<br>
									<h3 class="q_num">질문</h3>

									<input id="qno" name="title" type="text"
										class="form-control validate qno"> <br>
									<div class="qbox" >
										 <div class="q">　<span>1</span>　<input id="name" name="content" type="text" class="form-control littleq"></div>
										 <div class="q">　<span>2</span>　<input id="name" name="content" type="text" class="form-control littleq"></div>
									</div>
									
									　<button class="addq_btn"><b> +</b></button>
									
									</div>
								</div>
							</div>

							<div class="col-12">
							
									<br/>
									<br/>
									<br/>
								<button type="submit"
									class="btn btn-primary btn-block text-uppercase">설문지등록하기</button>
							</div>
							
			
						</div>
				</div>
			</div>
		</div>
	</div>

				<script type="text/javascript">
							$(document).ready(function() {
				
						       		$(document).on('click','.addq_btn',function() { 
							            var q=$("<div class='q'>　<span></span>　<input id='name' name='content' type='text' class='form-control littleq'><button class='minusq_btn'><b> x</b></button></div>");
							        	$(this).parent().find('.qbox').append(q);
						            });
						       		
						           $(document).on('click','.minusq_btn' , function() {
						            	 $(this).parent().remove();
						            });
						           
						           $(document).on('click','button', function() {
						         	
						         
						           $(".addsurveybox").each(function(i){
								
						                	$(this).find('.q').each(function(i){
											  	$(this).find('span').text(i+1);
										  });
					                });
					      
		
						    });
						        	
						    });
							
							</script>

</body>
</html>