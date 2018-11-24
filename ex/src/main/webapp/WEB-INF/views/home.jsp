<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; chaarset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>중고 장터</title>
	<style>
	.select {
		height: 34px;
		padding: 4px 12px;
		font-size: 13px;
		line-height: 1.42857143;
		text-align: center;
		color: #555;
		background-color: #fff;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	</style>
	<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/resources/bootstrap/css/carousel.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/js/docs.min.js"></script>
	<script>
		$(document).ready(function() {
			
			//로그인 버튼
			$(".btn-login").on("click", function() {
				self.location ="/user/login";
			});
			
			//로그아웃 버튼
			$(".btn-logout").on("click", function() {
				self.location ="/user/logout";
			});
			
		});
	</script>
</head>
<body>
	<div class="navbar-wrapper">
      	<div class="container">
        	<nav class="navbar navbar-default navbar-static-top">
          		<div class="container">
          			<!-- 브랜드 -->
            		<div class="navbar-header">
              			<a class="navbar-brand">중고 장터</a>
            		</div>
			
					<!-- 네비게이션 바 -->
            		<div id="navbar" class="navbar-collapse collapse">
              		<ul class="nav navbar-nav">
                		<li class="active"><a href="#">Home</a></li>
                		<li><a href="/sbook/booklist">도서</a></li>
              		</ul>
              
						<div class="navbar-form navbar-right">
	            			
							<c:if test="${not empty login}">
								<button type="button" class="btn btn-primary btn-logout">로그아웃</button>
							</c:if>
							<c:if test="${empty login}">
								<button type="button" class="btn btn-primary btn-login">로그인</button>
							</c:if>
						</div>
			
            		</div>
          		</div>
        	</nav>
      	</div>
    </div>
    
    <!-- Carousel -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">

      	<ol class="carousel-indicators">
        	<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        	<li data-target="#myCarousel" data-slide-to="1"></li>
      	</ol>

		<div class="carousel-inner" role="listbox">
        	<div class="item active">
          		<img src="/resources/images/book1.jpg" alt="First slide">
          		<div class="container">
            		<div class="carousel-caption">
              			<h1>중고서적 간편하게 거래해보세요</h1>
              			<br>
              			<br>
              			<br>
              			<br>
              			<br>
              			<p><a class="btn btn-lg btn-primary" href="/user/register" role="button">회원가입 하러 가기</a></p>
            		</div>
          		</div>
        	</div>
        	
        	<div class="item">
          		<img src="/resources/images/book2.jpg" alt="Second slide">
         		<div class="container">
	            	<div class="carousel-caption">
	              		<h1>간편한 회원가입으로 이용해보세요</h1>
	             		<br>
	             		<br>
	             		<br>
	             		<br>
	             		<br>
	              		<p><a class="btn btn-lg btn-primary" href="/user/register" role="button">회원가입 하러 가기</a></p>
	            	</div>
          		</div>
        	</div>

      	</div>
		
		<!--  <버튼 -->
      	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
      	</a>

		<!-- >버튼 -->
      	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
     	</a>

    </div>
    
    <hr class="featurette-divider">
	<!-- START THE FEATURETTES -->
	<div class="container marketing">
		

		<div class="row featurette">
		<div class="col-md-7">
        	<h4 class="featurette-heading">중고책을 등록하세요</h4>
        	<p class="lead">간단한 회원가입으로 책을 등록,수정 및 삭제를 하실수 있으며 댓글기능도 있는 사이트 입니다.</p>
        </div>
        <div class="col-md-5">
        	<img class="featurette-image img-responsive" src="/resources/images/book3.jpg" alt="Generic placeholder image">
        </div>
        
    </div>
	<hr class="featurette-divider">
      	
	</div>
</body>
</html>
