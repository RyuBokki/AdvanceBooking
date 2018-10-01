<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
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
</head>
<body>
	<form:form id="loginForm"
			   modelAttribute="memberVO">
		<div>
			<h1>
				회원 로그인			
			</h1>
		</div>
		<div>
			<input type="email" id="email" name="email" placeholder="아이디(이메일)" value="${memberVO.email}"/>
			<div>
				<form:errors path="email" id="emailError"/>
			</div>
		</div>
		<div>
			<input type="password" id="password" name="password" placeholder="비밀번호" value="${memberVO.password}"/>
			<div>
				<form:errors path="password" id="passwordError"/>
			</div>
		</div>
		<div>
			<input type="button" id="loginBtn" value="Login"/>
		</div>
	</form:form>
</body>
</html>