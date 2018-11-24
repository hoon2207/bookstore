<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; chaarset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>회원 가입</title>
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
			
			//회원 가입 버튼
			$(".btn-success").on("click", function() {
				formObj.submit();
			});
			
			//취소 버튼
			$(".btn-danger").on("click", function() {
				self.location = "/";
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
						<h3 class="box-title">회원 가입</h3>
					</div>

					<form id='registerForm' role="form" method="post">
						
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail1">아이디</label>&nbsp;&nbsp;<label style="color:red">필수</label> 
								<input type="text" name="uid" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">비밀번호</label>&nbsp;&nbsp;<label style="color:red">필수</label>
								<input type="text" name="upw" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">이름</label>&nbsp;&nbsp;<label style="color:red">필수</label>
								<input type="text" name="uname" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">핸드폰번호</label>&nbsp;&nbsp;<label>ex)010-0000-0000</label>
								<input type="text" name="uphone" class="form-control">
							</div>
						</div>
						
						<div class="box-footer">
							<button type="submit" class="btn btn-success">등록</button>
							<button type="button" class="btn btn-danger">취소</button>
							
						</div>
					</form>
							
				</div>
			</div>
		</div>
	</section>
	
</body>
</html>