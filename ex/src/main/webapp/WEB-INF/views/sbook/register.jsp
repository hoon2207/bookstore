<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; chaarset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>도서 등록</title>
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
	.fileDrop{
		width: 80%;
		height: 100px;
		border: 1px dotted gray;
		background-color: lightslategrey;
		margin: auto;
	}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    
    
    <script>
    	$(document).ready(function() {
    		
			var formObj = $("form[role='form']");
			console.log(formObj);
			
			//취소 버튼
			$(".btn-danger").on("click", function() {
				self.location = "/sbook/booklist";
			});
				
    	});
    </script>
    
    <script id="template" type="text/x-handlebars-template">
	<li>
  		<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  		<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
  		</div>
	</li>                
	</script>
	
	<script>
		$(document).ready(function() {
			var template = Handlebars.compile($("#template").html());

			$(".fileDrop").on("dragenter dragover", function(event){
				event.preventDefault();
			});


			$(".fileDrop").on("drop", function(event){
				event.preventDefault();
				
				var files = event.originalEvent.dataTransfer.files;
				
				var file = files[0];

				var formData = new FormData();
				
				formData.append("file", file);	
				
				
				$.ajax({
					url: '/uploadAjax',
					data: formData,
					dataType:'text',
					processData: false,
					contentType: false,
					type: 'POST',
					success: function(data){
						  
						var fileInfo = getFileInfo(data);
						  
						var html = template(fileInfo);
						  
						$(".uploadedList").append(html);
					}
				});	
			});
			
			//등록 버튼
			$("#registerForm").submit(function(event){
				event.preventDefault();
				
				var that = $(this);
				
				var str ="";
				$(".delbtn").each(function(index){
					 str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href") +"'> ";
				});
				
				that.append(str);

				that.get(0).submit();
			});
			
			// 첨부파일 x버튼
			$(".uploadedList").on("click", ".fa-remove", function(event){
				
				event.preventDefault();
				var that = $(this).closest("a");
				
				$.ajax({
					url:"/deleteFile",
					type:"post",
					data: {fileName:that.attr("href")},
					dataType:"text",
					success:function(result) {
						that.closest("li").remove();
					}
				});
			});
		});
	</script>
</head>
<body>
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">도서 등록</h3>
					</div>

					<form id='registerForm' role="form" method="post">
						<input type="hidden" name="writer" value='${login.uid}'>
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail1">책이름</label>&nbsp;&nbsp;<label style="color:red">필수</label> 
								<input type="text" name='title' class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">저자</label> 
								<input type="text" name="author" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">출판사</label> 
								<input type="text" name="publisher" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">출판일</label>&nbsp;&nbsp;<label>ex)2018년 08월</label>
								<input type="text" name="pubday" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">책 내용</label>
								<textarea name="content" class="form-control" rows="10"></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">책 가격</label>&nbsp;&nbsp;<label style="color:red">필수 ex)10000</label> 
								<input type="text" name="price" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">책 수량</label>&nbsp;&nbsp;<label style="color:red">필수 ex)2</label> 
								<input type="text" name="quantity" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">책 이미지</label>&nbsp;&nbsp;<label style="color:red">드래그 하세요</label>
								<div class="fileDrop"></div>
							</div>
						</div>
						
						<div class="box-footer">
							<div>
								<hr>
							</div>
							
							<ul class="mailbox-attachments clearfix uploadedList"></ul>
							
							<button type="submit" class="btn btn-success">등록</button>
							<button type="button" class="btn btn-danger">취소</button>
							
						</div>
					</form>
							
				</div>
			</div>
		</div>
	</section>
	
	<script type="text/javascript" src="/resources/js/upload.js"></script>
	
</body>
</html>