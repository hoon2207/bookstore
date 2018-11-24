<%@ page language="java" contentType="text/html; chaarset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<html>
<head>
	<title>도서 목록</title>
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
	.content {
		position: absolute;
		top: 100px;
		width: 100%;
	}
	.popup {
		position: absolute;
	}
	.front { 
		z-index:1110;
		opacity:1;
		boarder:1px;
		margin: auto;
	}
    .show{
		position:relative;
    	max-width: 1200px; 
    	max-height: 800px; 
    	overflow: auto;       
    } 
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resources/bootstrap/css/carousel.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/resources/js/upload.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    
    <script>
    	var result = '${msg}';
    	
    	if(result == 'SUCCESS') {
    		alert("처리 완료");
    	}
    	
		$(document).ready(function() {
			
			//새로운 검색 시도 JavaScript 처리
			$("#searchBtn").on("click", function(event) {
					self.location = "list"
						+ '${pageMaker.makeQuery(1)}' //검색 조건 없는 상황에서 사용하는 메소드
						+ "&searchType="
						+ $("select option:selected").val()
						+ "&keyword=" + encodeURIComponent($("keywordInput").val());
				});
			
			//등록 버튼
			$(".btn-primary").on("click", function() {
				self.location = "/sbook/register";
			});
			
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
    
    <script id="templateAttach" type="text/x-handlebars-template">
		<li data-src='{{fullName}}'>
  			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  			</div>
		</li>                
	</script>
		
	<script>
	function GetImage(bno) {
		
		var template = Handlebars.compile($("#templateAttach").html());
		$.getJSON("/sbook/getImage/"+bno, function(data) {
				$(data).each(function(){
					var fileInfo = getFileInfo(this);
					var html = template(fileInfo);
					$(".uploadedList"+bno).append(html);
			});
		});
	}
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
		                	<li><a href="/">Home</a></li>
		                	<li class="active"><a href="/sbook/booklist">도서</a></li>
		              	</ul>
						<form class="navbar-form navbar-right" role="search">
		            		<select class="select" name="searchType">
		            			<option value="n"
		            				<c:out value="${cri.searchType == null?'selected':''}"/>>---</option>
		            			<option value="title"
		            				<c:out value="${cri.searchType eq 'title'?'selected':''}"/>>책제목</option>
		            			<option value="author"
		            				<c:out value="${cri.searchType eq 'author'?'selected':''}"/>>저자</option>
		            			<option value="publihser"
		            				<c:out value="${cri.searchType eq 'publisher'?'selected':''}"/>>출판사</option>
		            			<option value="writer"
		            				<c:out value="${cri.searchType eq 'writer'?'selected':''}"/>>작성자</option>
		            		</select>
		
							<div class="form-group">
								<input type="text" class="form-control" name="keyword" id="keywordInput" value="${cri.keyword}">
							</div>
							
							<button class="btn btn-default" id="searchBtn">검색</button>
							<c:if test="${not empty login}">
								<button type="button" class="btn btn-primary btn-logout">로그아웃</button>
							</c:if>
							<c:if test="${empty login}">
								<button type="button" class="btn btn-primary btn-login">로그인</button>
							</c:if>
						</form>
	            	</div>
				</div>
			</nav>
		</div>
	</div>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<!-- 헤더 -->
					<div class="box-header">
						<h3 class="box-title">도서 목록</h3>
					</div>
					
					<!-- 메인 -->
					<div class="box-body">
						<table class="table table-bordered">
							<c:forEach items="${list}" var="bookVO">
								<tr>
									<td>
									<ul class="mailbox-attachments clearfix uploadedList${bookVO.bno}"></ul>
									<script>
										GetImage(${bookVO.bno});
									</script>
									</td>
									<td>
									<a href='/sbook/read${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${bookVO.bno}'>${bookVO.title}<strong>[ ${bookVO.replycnt} ]</strong></a><br>
									${bookVO.author} ${bookVO.publisher} ${bookVO.pubday}
									</td>
									<td>
									${bookVO.price}원
									</td>
									<td>
									수량 : ${bookVO.quantity}
									</td>
									<td>
									<i class="fa fa-clock-o"></i> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bookVO.regdate}" />
									</td>
									<td>
									작성자 : ${bookVO.writer}
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
					<!-- 하단부 -->
					<div class="box-footer">
						<button type="button" class="btn btn-primary">도서 등록</button>
						
						<!-- 페이지 번호 출력 -->
						<div class="text-center">
							<ul class="pagination">
								<!-- << -->
								<c:if test="${pageMaker.prev}">
									<li><a href="booklist${pageMaker.makeSearch(pageMaker.startPage - 1)}">&laquo;</a></li>
								</c:if>
								
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="booklist${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
								</c:forEach>
								
								<!-- >> -->
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a href="booklist${pageMaker.makeSearch(pageMaker.endPage + 1)}">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
						
					</div>
				</div>
				
			</div>
		</div>
	</section>
</body>
</html>