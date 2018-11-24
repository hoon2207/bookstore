<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 창</title>
	<style>
		.row1 {
			padding-left: 20px;
			padding-bottom: 15px;
		}
	</style>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="/resources/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			
			//회원가입 버튼
			$(".btn-register").on("click", function() {
				self.location ="/user/register";
			});
			
			//메인으로 버튼
			$(".btn-main").on("click", function() {
				self.location ="/";
			});
			
		});
	</script>
</head>
<body class="login-page">
	<div class="login-box">
		<div class="login-logo">
			<a>중고 장터</a>
		</div>
		<div class="login-box-body">
			<form id='loginForm' action="/user/loginPost" method="post">
			
				<div class="form-group has-feedback">
					<input type="text" name="uid" class="form-control" placeholder="아이디"/>
    				<span class="glyphicon glyphicon-user form-control-feedback"></span>
    			</div>
    			
    			<div class="form-group has-feedback">
				    <input type="password" name="upw" class="form-control" placeholder="비밀번호"/>
				    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
  				</div>
  				
  				<div class="row row1">
  					<div class="col-xs-8">
  						<div class="checkbox icheck">
  							<label>
  								<input type="checkbox" name="useCookie">로그인유지
  							</label>
  						</div>
  					</div>
  					
  					<div class="col-xs-4">
  						<button type="submit" class="btn btn-success btn-block btn-flat">로그인</button>
  					</div>
  				</div>
  				
  				<div class="row">
  					<div class="col-xs-2">
  					</div>
  					<div class="col-xs-4">
  						<button type="button" class="btn btn-primary btn-block btn-register">회원가입</button>
  					</div>
  					<div class="col-xs-4">
  						<button type="button" class="btn btn-primary btn-block btn-main">메인으로</button>
  					</div>
  					<div class="col-xs-2">
  					</div>
  				</div>
  				
  			</form>
  		</div>
	</div>
</body>
</html>