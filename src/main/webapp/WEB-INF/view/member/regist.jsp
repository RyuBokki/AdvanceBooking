<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$().ready( function() {
		$("#email").keyup( function(){
			$.post("/AdvanceBooking/member/regist"
			,function(){				
				$("#emailError").slideUp(100);
			})
			
			$.post("/AdvanceBooking/member/check/duplicate"
					, {
						"email":$(this).val()				
					}
					, function(response) {
						if ( response.duplicated ) {
							$("#email-duplicated").show()
						}
						else {
							$("#email-duplicated").hide()
						}
					}
			)
		})
		
		$("#password").keyup( function(){
			$.post("/AdvanceBooking/member/regist"
			,function(){
				$("#passwordError").slideUp(100);
			})
		})
		
		$("#passwordConfirm").keyup( function(){
			$.post("/AdvanceBooking/member/regist"
			,function(){				
				$("#passwordConfirmError").slideUp(100);
				
				if( $("#password").val() != $("#passwordConfirm").val() ) {
					$("#notEqualPassword").show();
				}
				else {					
					$("#notEqualPassword").hide();
				}
				
			})
		})

		
		$("#name").keyup( function(){
			$.post("/AdvanceBooking/member/regist"
			,function(){				
				$("#nameError").slideUp(100);
			})
		})
		
		$("#registBtn").click( function() {
			$("#registForm").attr({
				action:"/AdvanceBooking/member/regist",
				method:"post",
				autocomplete:"false"
			}).submit()
			
		})
		
	})
</script>
<style type="text/css">
	#wrapperbox {
		width: 400px;
	}
	
	#title {
		text-align:center;
		vertical-align:middle;
	}
	
	.form-control {
		margin-bottom:4px;
	}
	
	#registBtn {
		margin-top:24px;
	}
</style>
</head>
<body>
	<div id="wrapperbox">	
		<form:form id="registForm"
				   modelAttribute="memberVO">
			<div id="title">
				<h1>
					회원가입
				</h1>
			</div>
			<div>
				<label for="email"><span class="glyphicon glyphicon-envelope"></span>Email</label>
				<div>
					<input type="email" id="email" class="form-control" name="email" placeholder="아이디(이메일)을 입력하세요" value="${memberVO.email}"/>
				</div>
				<div>
					<form:errors path="email" id="emailError"/>
				</div>
				<div id="email-duplicated" style="display:none;">
					이미 존재하는 이메일이거나 사용할 수 없는 이메일입니다.				</div>
			</div>
			<div>
				<label for="pwd"><span class="glyphicon glyphicon-lock"></span>Password</label>
				<div>										
					<input type="password" id="password" class="form-control" name="password" placeholder="비밀번호를 입력하세요" value="${memberVO.password}"/>
				</div>
				<div>
					<form:errors path="password" id="passwordError"/>
				</div>
			</div>
			<div>
				<label for="pwdConfirm"><span class="glyphicon glyphicon-lock"></span>PasswordConfirm</label>
				<div>
					<input type="password" id="passwordConfirm" class="form-control" name="passwordConfirm" placeholder="비밀번호를 재입력하세요" value="${memberVO.passwordConfirm}"/>				
				</div>
				<div>
					<form:errors path="passwordConfirm" id="passwordConfirmError"/>
				</div>
				<div id="notEqualPassword" style="display:none;">
					비밀번호가 일치하지 않습니다.
				</div>
			</div>
			<div>
				<label for="name"><span class="glyphicon glyphicon-user"></span>Name</label>
				<div>
					<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" value="${memberVO.name}"/>				
				</div>
				<div>
					<form:errors path="name" id="nameError"/>
				</div>
			</div>
			<div>
				<input type="button" id="registBtn" class="form-control" value="Regist"/>
			</div>	
		</form:form>
	</div>
</body>
</html>