<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
        <script src="js/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="js/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Accounts - Product Admin Template</title>
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Roboto:400,700"
    />
    <!-- https://fonts.google.com/specimen/Roboto -->
    <link rel="stylesheet" href="resources/css/fontawesome.min.css" />
    <!-- https://fontawesome.com/ -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css" />
    <!-- https://getbootstrap.com/ -->
    <link rel="stylesheet" href="resources/css/templatemo-style.css">
    <!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
<style>
.blind{
width:100%;
}
#search_btn{
border-color: transparent;
background: transparent;
color: white;
float:right;
}
.big{
max-width: 96%;
column-count: 2;
}
</style>
  </head>

  <body id="reportsPage">

      <div class="container mt-5 big">
      <!--   <div class="row tm-content-row">
          <div class="col-12 tm-block-col"> -->
            <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
              <h2 class="tm-block-title" style="display:inline;">회원관리</h2>
              <select class="custom-select">
                <option value="0">검색 및 조회조건</option>
                <option value="1">Admin등급</option>
                <option value="2">Member등급</option>
                <option value="5">회원이메일</option>
                <option value="6">회원이름</option>
              </select>
<br>
<br>
                  <input
                    id="searchword"
                    name="searchword"
                    type="text"
                    class="form-control validate"
                  />
 <br>                 
   				   <button
                    type="submit"
                    class="btn btn-primary btn-block text-uppercase"
                  >
                    검색하기
                  </button>
            </div>
            <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
              <h2 class="tm-block-title" style="display:inline;">게시물 관리</h2>
              <br />
              <select class="custom-select">
                <option selected="selected">검색 및 조회조건</option>
                <option value="1">최다 참여 게시물</option>
                <option value="2">24시간이내 중복게시물</option>
                <option value="3">선정적,폭력적 게시물</option>
				 </select>
<br>
<br>
                  <input
                    id="searchword"
                    name="searchword"
                    type="text"
                    class="form-control validate"
                  />
 <br>                 
   				   <button
                    type="submit"
                    class="btn btn-primary btn-block text-uppercase"
                  >
                    검색하기
                  </button>
            </div>
          </div>

        
        
        
        <!-- row -->
        
        
        
        <div class="container mt-5 big">
        
     <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
            <div class="tm-product-table-container blind">
            <h5 style="color:white;">회원 검색 결과</h5>
            <br>
            <br>
              <table class="table table-hover tm-table-small tm-product-table">
                
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">회원이름</th>
                    <th scope="col">이메일</th>
                    <th scope="col">등록게시물갯수</th>
                    <th scope="col">회원가입일</th>
                    <th scope="col">활동여부</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">김호호</td>
                    <td>hoho@gmail.com</td>
                    <td>3개</td>
                    <td>2019 07 01</td>
                    <td>중지됨</td>
                    <td>
                      <a href="#" class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a>
                    </td>
                  </tr>
                  
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">박하하</td>
                    <td>hahapark@gmail.com</td>
                    <td>10개</td>
                    <td>2019 01 01</td>
                    <td>활동중</td>
                    <td>
                      <a href="#" class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a>
                    </td>
                  </tr>
                  
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">이하이</td>
                    <td>hihi@gmail.com</td>
                    <td>8개</td>
                    <td>2019 06 01</td>
                    <td>중지됨</td>
                    <td>
                      <a href="#" class="tm-product-delete-link">
                        <i class="far fa-trash-alt tm-product-delete-icon"></i>
                      </a>
                    </td>
                  </tr>
              
                  
                  
                </tbody>
              </table>
            </div>
            
            <!-- table container -->
           <button class="btn btn-primary btn-block text-uppercase">
              선택 회원 모두 삭제
            </button>
          </div>
        
        
        
        
     <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
            <div class="tm-product-table-container">
            <h5 style="color:white;">게시물 검색 결과</h5>
            <br>
          
              <table class="table table-hover tm-table-small tm-product-table">
                
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">죄 항목</th>
                    <th scope="col">올린회원</th>
                    <th scope="col">설문번호</th>
                    <th scope="col">문제의 단어</th>
                    <th scope="col">올린시간</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">타인비방</td>
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
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">타인비방</td>
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
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">타인비방</td>
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
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">타인비방</td>
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
                  <tr>
                    <th scope="row"><input type="checkbox" /></th>
                    <td class="tm-product-name">타인비방</td>
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
            
            <!-- table container -->
          <button class="btn btn-primary btn-block text-uppercase">
              선택 게시물 모두 삭제
            </button>
          </div>
          
          
</div>

    
    


  </body>
</html>
