<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$().ready( function() {
		$("#email").keyup( function(){
			$.post("/AdvanceBooking/member/login"
			,function(){
				$("#emailError").slideUp(100);
			})
		})
		
		$("#password").keyup( function(){
			$.post("/AdvanceBooking/member/login"
			,function(){				
				$("#passwordError").slideUp(100);
			})
		})
		
		$("#loginBtn").click( function(){
			$("#loginForm").attr({
				method:"post",
				action:"/AdvanceBooking/member/login",
				autocomplete:"false"
			}).submit()
		})
	})
</script>
<style type="text/css">
	.behindLogin {
		display:inline;
	}
	#wrapperbox {
		width: 400px;
	}
	.login {
		padding: 6px;
		margin-top: 18px;
	}
	
	#title {
		text-align: center;
		vertical-align: middle;
	}
	
	.left {
		border-right: 1px solid #ddd;
    	border-right-width: 1px;
    	border-right-style: solid;
    	border-right-color: rgb(221, 221, 221);
    	
    	padding-right: 10px;
    	
	}
	
	.right {
    	padding-left: 10px;
    	padding-right: 10px;
	}
	
	.form-control {
		margin-bottom:4px;
	}
	
	#loginBtn {
		margin-top:29px;
	}
	
	.glyphicon glyphicon-envelope {
		
	}
	
	.error {
		font-color:	#FF0000;
	}
</style>
</head>
<body>
	<div id="wrapperbox">	
		<form:form id="loginForm"
				   modelAttribute="memberVO">
			<div>
				<h2 id="title">
					회원 로그인			
				</h2>
			</div>
			<div >
				<label for="email"><span class="glyphicon glyphicon-envelope"></span>Email</label>
				<input type="email" class="form-control" id="email" name="email" placeholder="아이디(이메일)" value="${memberVO.email}"/>
				<div>
					<form:errors path="email" id="emailError" class="error"/>
				</div>
			</div>
			<div>
				<label for="pwd"><span class="glyphicon glyphicon-lock"></span>Password</label>
				<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" value="${memberVO.password}"/>
				<div>
					<form:errors path="password" id="passwordError" class="error"/>
				</div>
			</div>
			<input type="button" class="form-control login" id="loginBtn" value="Login"/>
			<div class="login">
				<div class="behindLogin left">
					<a href="/AdvanceBooking/member/regist" >회원 가입</a>
				</div>
				<div class="behindLogin right">
					<a href="/AdvanceBooking/member/findPassword">Password 찾기</a>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>