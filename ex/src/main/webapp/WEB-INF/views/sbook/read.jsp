<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; chaarset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>도서 내용</title>
	<style>
	.header-box{
		text-align:center;
		width:100%;
		height:40px;
		background-color:#5e6b9e;
	}
	.header{
		font-size:30px;
		color: white;
	}
	.popup {
		position: absolute;
	}
    .back {
    	background-color: gray;
    	opacity:0.5;
    	width: 100%;
    	height: 300%;
    	overflow:hidden;
    	z-index:1101;
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
	
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript" src="/resources/js/upload.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    
    <script>
    	$(document).ready(function() {
    		
    		var formObj = $("form[role='form']");
    		
    		console.log(formObj);
    		
    		//수정 버튼
    		$(".btn-modify").on("click", function() {
    			formObj.attr("action", "/sbook/modify");
    			formObj.attr("method", "get");
    			formObj.submit();
    		});
    		
    		//삭제 버튼
    		$(".btn-delete").on("click", function() {
    			
    			var replyCnt = $("#replycntSmall").html().replace(/[^0~9]/g,"");
    			
    			if(replyCnt > 0) {
    				alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
    			}
    			
    			var arr = [];
    			
    			$(".uploadedList li").each(function(index) {
    				arr.push($(this).attr("data-src"));
    			})
    			
    			if(arr.length > 0){
    				$.post("/deleteAllFiles", {files:arr}, function(){
    					
    				});
    			}
    			
    			formObj.attr("action", "/sbook/remove");
    			formObj.submit();
    			
    		});
    		
    		//목록 버튼
    		$(".btn-booklist").on("click", function() {
    			formObj.attr("method", "get");
    			formObj.attr("action", "/sbook/booklist");
    			formObj.submit();
    		});
    		
    		var bno = ${bookVO.bno};
    		var template = Handlebars.compile($("#templateAttach").html());
    		
    		$.getJSON("/sbook/getImage/"+bno,function(list){
    			$(list).each(function(){
    				var fileInfo = getFileInfo(this);
    				var html = template(fileInfo);
    				$(".uploadedList").append(html);
    				
    			});
    		});
    		
    		$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
    			
    			var fileLink = $(this).attr("href");
    			
    			if(checkImageType(fileLink)){
    				
    				event.preventDefault();
    						
    				var imgTag = $("#popup_img");
    				imgTag.attr("src", fileLink);
    				
    				console.log(imgTag.attr("src"));
    						
    				$(".popup").show('slow');
    				imgTag.addClass("show");		
    			}	
    		});
    		
    		$("#popup_img").on("click", function(){
    			
    			$(".popup").hide('slow');
    			
    		});
    	});
    </script>
    
    <!-- 화면에 반복적으로 처리되는 템플릿 코드로 깔끔하게 처리 -->
    <script id="template" type="text/x-handlebars-template">
		{{#each .}}
			<li class="replyLi" data-rno={{rno}}>
 				<div class="timeline-item">

  					<span class="time">
    					<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  					</span>
  					<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>

  					<div class="timeline-body">{{replytext}} </div>

    				<div class="timeline-footer">
						{{#eqReplyer replyer}}
     						<a class="btn btn-success btn-xs" data-toggle="modal" data-target="#modifyModal">수정</a>
						{{/eqReplyer}}
    				</div>

  				</div>			
			</li>
		{{/each}}
	</script>
	
	<script id="templateAttach" type="text/x-handlebars-template">
		<li data-src='{{fullName}}'>
  			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  			<div class="mailbox-attachment-info">
				<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			</span>
  			</div>
		</li>                
	</script>
	
	<script>
	$(document).ready(function() {
		Handlebars.registerHelper("eqReplyer", function(replyer, block) {
			var accum = '';
			if(replyer == '${login.uid}') {
				accum += block.fn();
			}
			return accum;
		});
	});
	</script>
	
	<script>
	$(document).ready(function() {	
		//prettifyDate에 대한 JavaScript 처리
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;
		});
	
		var printData = function(replyArr, target, templateObject) {
	
			var template = Handlebars.compile(templateObject.html());
	
			var html = template(replyArr);
			$(".replyLi").remove();
			target.after(html);
		}
		
		var printPaging = function(pageMaker, target) {
			var str = "";
			
			if (pageMaker.prev) {
				str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
			}
	
			for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
				var strClass = pageMaker.cri.page == i ? 'class=active' : '';
				str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
			}
	
			if (pageMaker.next) {
				str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
			}

			target.html(str);
		};
		
		// 템플릿을 이용하는 페이지를 처리하는 JavaScript
		
		var bno = ${bookVO.bno};
	
		var replyPage = 1;
		
		//특정한 게시물에 대한 페이징 처리를 위해서 호출되는 함수
		function getPage(pageInfo) {
			
			$.getJSON(pageInfo, function(data) {
				printData(data.list, $("#repliesDiv"), $('#template'));
				printPaging(data.pageMaker, $(".pagination"));
				
				$("#modifyModal").modal('hide');
				$("#replycntSmall").html("[ " + data.pageMaker.totalCount +" ]");
				
			});
		}

		//댓글 페이징 처리
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();
			
			replyPage = $(this).attr("href");
			
			getPage("/replies/"+bno+"/"+replyPage);
		});
		
		// 댓글 리스트  실행
		getPage("/replies/"+bno+"/"+replyPage);
		
		//댓글의 등록 작업
		$("#replyAddBtn").on("click", function(){
		 	
		 	var replyerObj = $("#newReplyWriter");
		 	var replytextObj = $("#newReplyText");
		 	var replyer = replyerObj.val();
		 	var replytext = replytextObj.val();
		
		  	$.ajax({
				type:'post',
				url:'/replies/',
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),
				success:function(result){
					console.log("result: "+ result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/"+bno+"/"+replyPage);
						replyerObj.val("");
						replytextObj.val("");
					}
				}
			});
		});
		
		//댓글 수정 창으로 이동하는 버튼
		$(".timeline").on("click", ".replyLi", function(event){
		
			var reply = $(this);
			
			$("#replytext").val(reply.find('.timeline-body').text());
			$(".modal-title").html(reply.attr("data-rno"));
		
		});
		
		//댓글 수정 처리
		$("#replyModBtn").on("click",function(){
		  
		  var rno = $(".modal-title").html();
		  var replytext = $("#replytext").val();
		  
		  $.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers: { 
				      "Content-Type": "application/json",
				      "X-HTTP-Method-Override": "PUT" },
				data:JSON.stringify({replytext:replytext}), 
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
		});
		
		//댓글 삭제 처리
		$("#replyDelBtn").on("click",function(){
			  
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			  
			$.ajax({
				type:'delete',
				url:'/replies/'+rno,
				headers: { 
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "DELETE" },
				dataType:'text', 
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("/replies/"+bno+"/"+replyPage );
					}
			}});
		});
		
	});
	</script>
	
</head>
<body>
	<div class='popup back' style="display:none;"></div>
    	<div id="popup_front" class='popup front' style="display:none;">
     	<img id="popup_img">
    </div>
    
	<form role="form" action="modify" method="post">
		<input type="hidden" name="page" value="${cri.page}">
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
		<input type="hidden" name="bno" value="${bookVO.bno}">
		<input type="hidden" name="searchType" value="${cri.searchType}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>
	
	<section class="content">
		<!-- 여기서부터 도서 목록 -->
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<!-- 헤더 -->
					<div class="box-header">
						<h3 class="box-title">도서 내용</h3>
					</div>
					
					

					<!-- 메인 -->
					<div class="box-body">
						<label for="exampleInputEmail1">책 이미지</label>
						<ul class="mailbox-attachments clearfix uploadedList"></ul>
						<div class="form-group">
							<label for="exampleInputEmail1">책이름</label>
							<input type="text" name='title' class="form-control" value="${bookVO.title}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">저자</label> 
							<input type="text" name="author" class="form-control" value="${bookVO.author}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">출판사</label> 
							<input type="text" name="publisher" class="form-control" value="${bookVO.publisher}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">출판일</label>
							<input type="text" name="pubday" class="form-control" value="${bookVO.pubday}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">책 내용</label>
							<textarea name="content" class="form-control" rows="10" readonly="readonly">${bookVO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">책 가격</label>
							<input type="text" name="price" class="form-control" value="${bookVO.price}" readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">책 수량</label>
							<input type="text" name="quantity" class="form-control" value="${bookVO.quantity}" readonly="readonly">
						</div>
					</div>
					
					<!-- 하단 -->
					
					<div class="box-footer">
						
						<c:if test="${login.uid == bookVO.writer}">
							<button type="submit" class="btn btn-success btn-modify">수정</button>
							<button type="submit" class="btn btn-danger btn-delete">삭제</button>
						</c:if>
						<button type="submit" class="btn btn-primary btn-booklist">목록으로</button>
					</div>		
							
				</div>
			</div>
		</div>
		
		<!-- 여기서부터 댓글 부분 -->
		<div class="row">
			<div class="col-md-12">
			
				<div class="box box-success">
				
					<div class="box-header">
						<h3 class="box-title">댓글 리스트</h3>
					</div>
					
					<div class="box-body">
						<ul class="timeline">
							<li class="time-label" id="repliesDiv"></li>	
						</ul>
				
						<div class="text-center">
							<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
						</div>
					</div>
					
					<c:if test="${not empty login}">
						<div class="box-footer">
							<h4 class="box-title">댓글 등록</h4><br>
							<label for="exampleInputEmail1">작성자</label>
							<input class="form-control" type="text" id="newReplyWriter" value="${login.uid}" readonly="readonly">
							<label for="exampleInputEmail1">댓글 내용</label>
							<input class="form-control" type="text" id="newReplyText"><br>
							<button class="btn btn-success" id="replyAddBtn">등록</button>
						</div>
					</c:if>
					
					<c:if test="${empty login}">
						<div class="box-footer">
							로그인을 해야 댓글을 달수 있습니다.
						</div>
					</c:if>
					
				</div>
				
			</div>
		</div>
		
		<!-- 댓글 수정 삭제 (별도의 Modal 창) -->
		<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		  	<div class="modal-dialog">
			    <div class="modal-content">
			    	
			      	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        	<h4 class="modal-title">댓글 수정 창</h4>
			      	</div>
			      	
			      	<div class="modal-body" data-rno>
			        	<p><input type="text" id="replytext" class="form-control"></p>
			      	</div>
			      		
			     	<div class="modal-footer">
				        <button type="button" class="btn btn-success" id="replyModBtn">수정</button>
				        <button type="button" class="btn btn-danger" id="replyDelBtn">삭제</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			      	</div>
			      	
			    </div>
		  	</div>
		</div>
	</section>
	<%@include file="../include/footer.jsp"%>
</body>
</html>
