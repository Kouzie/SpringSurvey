<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container mt-5 searchBox">
	<!--   <div class="row tm-content-row">
          <div class="col-12 tm-block-col"> -->
	<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
		<h2 class="tm-block-title" style="display: inline;">회원관리</h2>
		<br> <select id="searchoption_m" class="custom-select"
			name="searchoption_m">
			<option selected="selected" disabled="disabled">검색 및 조회조건</option>
			<!--    <option value="authority">Admin등급</option> -->
			<option value="member_seq">회원번호</option>
			<option value="username">회원아이디</option>
			<option value="name">회원이름</option>
			<option value="email">회원이메일</option>
		</select> <br> <br> <input id="searchword_m" name="searchword_m"
			type="text" class="form-control validate" /> <br>
		<button id="btn_searchMember" type="button"
			class="btn btn-primary btn-block text-uppercase">
			검색하기</button>
	</div>
	<div class="tm-bg-primary-dark tm-block tm-block-h-auto">
		<h2 class="tm-block-title" style="display: inline;">게시물 관리</h2>
		<br /> <select id="searchoption_s" class="custom-select"
			name="searchoption_s">
			<option selected="selected" disabled="disabled">검색 및 조회조건</option>
			<!--                 <option value="1">최다 참여 게시물</option>
                <option value="2">24시간이내 중복게시물</option>
                <option value="3">선정적,폭력적 게시물</option> -->
			<option value="name">작성자</option>
			<option value="title">게시물 이름</option>
		</select> <br> <br> <input id="searchword_s" name="searchword_s"
			type="text" class="form-control validate" /> <br>
		<button id="btn_searchSurvey" type="button"
			class="btn btn-primary btn-block text-uppercase">
			검색하기</button>
	</div>
</div>




<!-- row -->

<button id="yyy">xptmxm 삭제</button>
<script type="text/javascript">
<!--
//-->
             $("#yyy").click(function (){
            	 $("#xxx").empty();
             });
		   
</script>
<div id="xxx" class="container mt-5 bigdiv"></div>

<!-- 
     <div class="tm-bg-primary-dark tm-block tm-block-h-auto ">
            <div class="tm-product-table-container boardBox">
            <h5 style="color:white;">게시물 검색 결과</h5>
            <br>
          
              <table class="table table-hover tm-table-small tm-product-table">
                
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">작성자</th>
                    <th scope="col">게시글번호</th>
                    <th scope="col">게시글제목</th>
                    <th scope="col">등록일</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td>김호호</td>
                    <td>10293</td>
                    <td>류준열이 못생겼다고 생각하시나요?</td>
                    <td>2019 07 01</td>
                    <td>
                      <a href="#" class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a>
                    </td>
                  </tr>
     		 </tbody>
           </table>
         </div>

          <button class="btn btn-primary btn-block text-uppercase">
              선택 게시물 모두 삭제
            </button>
          </div>  -->
<script id="reply-template-member" type="text/x-handlebars-template">
		{{#each .}}
	
     <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
            <div class="tm-product-table-container boardBox">
            <h5 style="color:white;">{{resultTitle}}</h5>
            <br>
          
              <table class="table table-hover tm-table-small tm-product-table">
                
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">작성자</th>
                    <th scope="col">게시글번호</th>
                    <th scope="col">게시글제목</th>
                    <th scope="col">등록일</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  
     		 </tbody>
           </table>
         </div>
            
            table container
          <button class="btn btn-primary btn-block text-uppercase">
              선택 게시물 모두 삭제
            </button>
          </div>
		{{/each}}
	</script>


<script>
$(document).ready(function(){
	resultTitle='검색결과';

	 div1=$(' <div class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>' );
	 h=$(' <h5 style="color:white;">'+resultTitle+'</h5>');
	 table=$('<table class="table table-hover tm-table-small tm-product-table"></table>');
	
	
	
	 div2=$('<thead><tr>'
            +'<th scope="col">&nbsp;</th>'
           +'<th scope="col">회원아이디</th>'
           +'<th scope="col">회원이름</th>'
           +'<th scope="col">회원이메일</th>'
           +'<th scope="col">생일</th>'
           +'<th scope="col">활동상태</th>'

          +'</tr>'
        +'</thead>');
	 div3=$('<thead style="text-align: center" ><tr>'
            +'<th scope="col">&nbsp;</th>'
           +'<th scope="col">작성회원번호</th>'
           +'<th scope="col">게시물번호</th>'
           +'<th scope="col">제          목</th>'
           +'<th scope="col">등록일</th>'
           +'<th scope="col">마감일</th>'
           +'<th scope="col">진행상태</th>'
           +'<th scope="col"></th>'
          +'</tr>'
        +'</thead>');
	


	
			$('#btn_searchMember').on("click",function(){
				div1=$(' <div class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>' );
				
				 h=$(' <h5 style="color:white;">'+resultTitle+'</h5>');
				 table=$('<table class="table table-hover tm-table-small tm-product-table"></table>');
				
				$("#xxx").empty();
				
				$.ajax({
					url : "searchMember",
					dataType : "json",
					cache: false,
					data : {
						"searchword_m" : $("#searchword_m").val(),
						"searchoption_m": $("#searchoption_m").val()
					},
					success : function(ret) {
						
						 
						
						$(".bigdiv").append(div1);
						div1.append(h);
						
						var tbody= $('<tbody></tbody>');
						for (var i = 0; i < ret.length; i++) {
							var e;
							if (ret[i].enabled==0){var e = "활동중지";}
							else{var e="활동중"}
						var tr= $('<tr></tr>');
					//	var th=$("th",{"scope":"row"});
						tr.append(' <th scope="row"><input type="checkbox" name="mem" value='+ret[i].member_seq + '></th>');
						tr.append("<td> " + ret[i].member_seq + "</td>");
						tr.append("<td> " + ret[i].username + "</td>");
						tr.append("<td> " + ret[i].name + "</td>");
						tr.append("<td> " + ret[i].email + "</td>");
						var date = new Date(ret[i].birth).format("yyyy-MM-dd"); 
						tr.append("<td> " + date + "</td>");
						tr.append("<td> " + e + "</td>");
						tbody.append(tr);
						}
						var btn = $('<button id="del_unabled" class="btn btn-primary btn-block text-uppercase">'
								              +'선택한 회원 활동금지시키기'                                            
								              +'</button>');
						table.append(div2);
						table.append(tbody);
						div1.append(table);
						div1.append(btn);
					}	
				});
			});
			
	
			$('#btn_searchSurvey').on("click",function(){
				$(".bigdiv").empty();
				div1=$(' <div class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>' );
				 h=$(' <h5 style="color:white;">'+resultTitle+'</h5>');
				 table=$('<table class="table table-hover tm-table-small tm-product-table"></table>');
				
				
				$.ajax({
					url : "searchSurvey",
					dataType : "json",
					cache: false,
					
					data : {
						"searchword_s" : $("#searchword_s").val(),
						"searchoption_s": $("#searchoption_s").val()
					},
					success : function(ret) {
						
					
						$(".bigdiv").append(div1);
						
						var tbody= $('<tbody></tbody>');
						for (var i = 0; i < ret.length; i++) {
							var p;
							if (ret[i].progressing==0){var p = "마감됨";}
							else								 {var p="진행중";}
									
								var tr= $('<tr></tr>');
							//	var th=$("th",{"scope":"row"});
								tr.append(' <th scope="row"><input type="checkbox" value='+ret[i].survey_seq +'></th>');
								
								
								tr.append("<td> " + ret[i].member_seq + "</td>");
								tr.append("<td> " + ret[i].survey_seq + "</td>");
								tr.append("<td> " + ret[i].title + "</td>");
								
								var reg_date = new Date(ret[i].reg_date).format("yyyy-MM-dd"); 
								var end_date = new Date(ret[i].end_date).format("yyyy-MM-dd"); 
								
								tr.append("<td> " + reg_date + "</td>");
								tr.append("<td> " + end_date + "</td>");
								tr.append("<td>"+p+"</td>");
								var ai=$(' <a href="delSearchMemberList" class="tm-product-delete-link">'
					                     +' <i class="far fa-trash-alt tm-product-delete-icon"></i>'
					                     +' </a>'
										);
								var tdai=$('<td></td>');
								tdai.append(ai);
								tr.append(tdai);
								
								tbody.append(tr);
						}
						var btn = $('<button class="btn btn-primary btn-block text-uppercase">'
								              +'선택 게시물 모두 삭제'                                            
								              +'</button>');
						table.append(div3);
						table.append(tbody);
						div1.append(table);
						div1.append(btn);
						
				
						
					}	
				});
			});
			
			
		$(document).on('click','#del_unabled',function(){	
			memlist  = new Array() ;
			$("input[name=mem]:checked").each(function(i) {
				 memlist[i]= $(this).val();
				 $(this).parent().parent().remove();
				});
				 
			console.log(memlist);

			$.ajax({
				url : "updateMemberUnabled",
				dataType : "json",
				cache: false,
				data : {
					"memlist" : memlist
				},
				success : function(ret) {
					
					alert('성공하고 돌아옴');
					
					
				}
			});
		});
			
		});


</script>
