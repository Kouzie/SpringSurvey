<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container mt-5 searchBox">
    <!--   <div class="row tm-content-row">
          <div class="col-12 tm-block-col"> -->
    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
        <h2 class="tm-block-title" style="display: inline;">회원관리</h2>
        <br> <select id="searchoption_m" class="custom-select" name="searchoption_m">
            <option selected="selected" disabled="disabled">검색 및 조회조건</option>
            <!--    <option value="authority">Admin등급</option> -->
            <option value="member_seq">회원번호</option>
            <option value="username">회원아이디</option>
            <option value="name">회원이름</option>
            <option value="email">회원이메일</option>
            <option value="enabled">활동여부</option>

        </select> <br> <br> <input id="searchword_m" name="searchword_m" type="text" class="form-control validate" />
        <br>
        <div style="font-size: 10px; color: white;">
            * 아무것도 검색하지 않을 시, 전체회원 출력됩니다.<br> * 카테고리는 반드시 선택해야합니다.<br>
            * 활동중 회원은 1, 활동중지회원은 0을 입력하세요.<br>
        </div>
        <br>
        <button id="btn_searchMember" type="button" class="btn btn-primary btn-block text-uppercase">검색하기</button>
        <br>
    </div>
    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
        <h2 class="tm-block-title" style="display: inline;">게시물 관리</h2>
        <br /> <select id="searchoption_s" class="custom-select" name="searchoption_s">
            <option selected="selected" disabled="disabled">검색 및 조회조건</option>
            <!-- <option value="1">최다 참여 게시물</option>
                <option value="2">24시간이내 중복게시물</option>
                <option value="3">선정적,폭력적 게시물</option> -->
            <option value="name">작성자</option>
            <option value="title">게시물 이름</option>
            <option value="progressing">진행여부</option>
        </select> <br> <br> <input id="searchword_s" name="searchword_s" type="text" class="form-control validate" />
        <br>
        <div style="font-size: 10px; color: white;">
            * 아무것도 검색하지 않을 시, 전체게시물 출력됩니다.<br> * 카테고리는 반드시 선택해야합니다.<br>
            * 진행중인 설문은 1, 마감된 설문은 0을 입력하세요.<br>
        </div>
        <br>
        <button id="btn_searchSurvey" type="button" class="btn btn-primary btn-block text-uppercase">검색하기</button>
        <br>
    </div>
</div>


<form id="f">
    <div id="xxx" class="container mt-5 bigdiv">
        <div  id="memberdiv" class="tm-bg-primary-dark tm-block tm-block-h-auto" style="display:none;">
            <h5 style="color:white;">검색결과</h5>
            <table  id="membertable" class="table table-hover tm-table-small tm-product-table">
                <thead>
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원이름</th>
                        <th scope="col">회원이메일</th>
                        <th scope="col">생일</th>
                        <th scope="col">활동상태</th>
                    </tr>
                </thead>
                <tbody id="membertbody">
                 
                </tbody>
            </table><button id="btn_unabledmem" class="btn btn-primary btn-block text-uppercase">선택한 회원 활동금지시키기</button>
        </div>
        <div id="bigsurveydiv" class="tm-bg-primary-dark tm-block tm-block-h-auto" style="display:none;" >
            <table id="surveytable" class="table table-hover tm-table-small tm-product-table">
                <thead style="text-align: center">
                    <tr>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">작성회원번호</th>
                        <th scope="col">게시물번호</th>
                        <th scope="col">제 목</th>
                        <th scope="col">등록일</th>
                        <th scope="col">마감일</th>
                        <th scope="col">진행상태</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody id="suveytbody">
                  
                </tbody>
            </table><button id="btn_delsurvey" class="btn btn-primary btn-block text-uppercase">선택 게시물 모두 삭제</button>
        </div>
    </div>
</form>
<script>
    $(document).ready(function () {
    	 /* resultTitle = '검색결과';

        div1 = $(' <div  class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>');
        h = $(' <h5 style="color:white;">검색결과</h5>');
        table = $('<table class="table table-hover tm-table-small tm-product-table"></table>');



        div2 = $('<thead><tr>' +
            '<th scope="col">&nbsp;</th>' +
            '<th scope="col">회원아이디</th>' +
            '<th scope="col">회원이름</th>' +
            '<th scope="col">회원이메일</th>' +
            '<th scope="col">생일</th>' +
            '<th scope="col">활동상태</th>'+
            '</tr>' +
            '</thead>');
        
        div3 = $('<thead style="text-align: center" ><tr>' +
            '<th scope="col">&nbsp;</th>' +
            '<th scope="col">작성회원번호</th>' +
            '<th scope="col">게시물번호</th>' +
            '<th scope="col">제          목</th>' +
            '<th scope="col">등록일</th>' +
            '<th scope="col">마감일</th>' +
            '<th scope="col">진행상태</th>' +
            '<th scope="col"></th>' +
            '</tr>' +
            '</thead>');



*/
        $('#btn_searchMember').on("click", function () {
         /*    div1 = $(' <div class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>');

            h = $(' <h5 style="color:white;">' + resultTitle + '</h5>');
            table = $('<table class="table table-hover tm-table-small tm-product-table"></table>'); */
            $("#xxx").empty();
            $.ajax({
                url: "getSearchMember",
                dataType: "json",
                cache: false,
                data: {
                    "searchword_m": $("#searchword_m").val(),
                    "searchoption_m": $("#searchoption_m").val()
                },
                success: function (ret) {



        	$("#memberdiv").attr("style","display:show;");
                /*    $(".bigdiv").append(div1);
                    div1.append(h);

                    var tbody = $('<tbody></tbody>'); */
                    for (var i = 0; i < ret.length; i++) {
                        var e;
                        if (ret[i].enabled == 0) {
                            var e = "활동중지";
                        } else {
                            var e = "활동중"
                        }
                        var tr = $('<tr></tr>');
                        //	var th=$("th",{"scope":"row"});
                        tr.append(
                            ' <th scope="row"><input type="checkbox" name="mem" value=' +
                            ret[i].member_seq + '></th>');
                        tr.append("<td> " + ret[i].member_seq + "</td>");
                        tr.append("<td> " + ret[i].username + "</td>");
                        tr.append("<td> " + ret[i].name + "</td>");
                        tr.append("<td> " + ret[i].email + "</td>");
                        var date = new Date(ret[i].birth).format("yyyy-MM-dd");
                        tr.append("<td> " + date + "</td>");
                        tr.append("<td> " + e + "</td>");
                    	
                        $("#membertbody").append(tr);
                       
                    }
                    var btn = $(
                        '<button id="btn_unabledmem" class="btn btn-primary btn-block text-uppercase">' +
                        '선택한 회원 활동금지시키기' +
                        '</button>');
                    $("#membertable").after(btn);
         /*            table.append(div2);
                    table.append(tbody);
                    div1.append(table);
                    div1.append(btn); */
		
                }
            });
        });


        $('#btn_searchSurvey').on("click", function () {
            $(".bigdiv").empty();
            div1 = $(' <div class="tm-bg-primary-dark tm-block tm-block-h-auto"></div>');
            h = $(' <h5 style="color:white;">' + resultTitle + '</h5>');
            table = $('<table class="table table-hover tm-table-small tm-product-table"></table>');


            $.ajax({
                url: "getSearchSurvey",
                dataType: "json",
                cache: false,

                data: {
                    "searchword_s": $("#searchword_s").val(),
                    "searchoption_s": $("#searchoption_s").val()
                },
                success: function (ret) {


                    $(".bigdiv").append(div1);

                    var tbody = $('<tbody></tbody>');
                    for (var i = 0; i < ret.length; i++) {
                        var p;
                        if (ret[i].progressing == 0) {
                            var p = "마감됨";
                        } else {
                            var p = "진행중";
                        }

                        var tr = $('<tr></tr>');
                        //	var th=$("th",{"scope":"row"});
                        tr.append(
                            ' <th scope="row"><input type="checkbox" name="surseq" value=' +
                            ret[i].survey_seq + '></th>');
                        tr.append("<td> " + ret[i].member_seq + "</td>");
                        tr.append("<td> " + ret[i].survey_seq + "</td>");
                        tr.append("<td> " + ret[i].title + "</td>");

                        var reg_date = new Date(ret[i].reg_date).format("yyyy-MM-dd");
                        var end_date = new Date(ret[i].end_date).format("yyyy-MM-dd");

                        tr.append("<td> " + reg_date + "</td>");
                        tr.append("<td> " + end_date + "</td>");
                        tr.append("<td>" + p + "</td>");
                        var ai = $(
                            ' <a href="delSearchMemberList" class="tm-product-delete-link">' +
                            ' <i class="far fa-trash-alt tm-product-delete-icon"></i>' +
                            ' </a>'
                        );
                        var tdai = $('<td></td>');
                        tdai.append(ai);
                        tr.append(tdai);

                        tbody.append(tr);
                    }
                    var btn = $(
                        '<button id="btn_delsurvey" class="btn btn-primary btn-block text-uppercase">' +
                        '선택 게시물 모두 삭제' +
                        '</button>');
                    table.append(div3);
                    table.append(tbody);
                    div1.append(table);
                    div1.append(btn);



                }
            });
        });


        $(document).on('click', '#btn_unabledmem', function () {

            var str = $("form").serialize();
            //alert(str);	 
            console.log(str);


            $.ajax({
                url: "modifyMemberUnabled",
                dataType: "json",
                cache: false,
                data: str,
                success: function (ret) {
                    console.log(ret.message);
                    $("input[name=mem]:checked").each(function (i) {
                        $(this).parent().remove();
                    });
                }
            });
        });


        $(document).on('click', '#btn_delsurvey', function () {

            var str = $("form").serialize();
            //alert(str);	 
            console.log(str);


            $.ajax({
                url: "deleteSurveyUnabled",
                dataType: "json",
                cache: false,
                data: str,
                success: function (ret) {
                    console.log(ret.message);
                    $("input[name=surseq]:checked").each(function (i) {
                        $(this).parent().remove();
                    });
                }
            });
        });

    });
</script>
