<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$().ready( function() {
		
		$("#password").keyup( function(){
			$.post("/AdvanceBooking/member/update"
			,function(){
				$("#passwordError").slideUp(100);
			})
		})
		
		$("#passwordConfirm").keyup( function(){
			$.post("/AdvanceBooking/member/update"
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
			$.post("/AdvanceBooking/member/update"
			,function(){				
				$("#nameError").slideUp(100);
			})
		})
		
		$("#updateBtn").click(function(){
			
			$("#updateForm").attr({
				action:"/AdvanceBooking/member/update",
				method:"post"
			}).submit();
			
		})
		
	})
</script>
<style type="text/css">
	#wrapperbox {
		position: absolute;
		width: 400px;
		left: 50%;
		top: 50%;
		transform: translate(-50%, -50%);
	}
	#title {
		text-align:center;
		vertical-align:middle;
	}
	
</style>
</head>
<body>
	<div id="wrapperbox">
		<form:form id="updateForm"
			  modelAttribute="memberVO">
			<div id="title" class="inputs">
				<h1>
					회원 정보 수정
				</h1>
			</div>
			<div class="inputs">
				<label for="email"><span class="glyphicon glyphicon-envelope"></span>Email</label>
				<input type="email" id="email" class="form-control" name="email" value="${sessionScope._USER_.email}" readonly="readonly"/>
			</div>
			<div class="inputs">
				<label for="pwd"><span class="glyphicon glyphicon-lock"></span>Password</label>
				<input type="password" id="password" class="form-control" name="password" placeholder="변경할 비밀번호를 입력하세요." value="${memberVO.password}"/>
				<div>
					<form:errors path="password" id="passwordError" />
				</div>
			</div>
			<div class="inputs">
				<label for="pwdConfirm"><span class="glyphicon glyphicon-lock"></span>PasswordConfirm</label>
				<input type="password" id="passwordConfirm" class="form-control" name="passwordConfirm" placeholder="비밀번호를 재입력하세요." value="${memberVO.passwordConfirm}"/>
				<div>
					<form:errors path="passwordConfirm" id="passwordConfirmError" />
				</div>
				<div id="notEqualPassword" style="display:none;">
					비밀번호가 일치하지 않습니다.
				</div>
			</div>
			<div class="inputs">
				<label for="name"><span class="glyphicon glyphicon-user"></span>Name</label>
				<input type="name" id="name" class="form-control" name="name" placeholder="변경할 이름을 입력하세요." value="${memberVO.name}"/>
				<div>
					<form:errors path="name" id="nameError" />
				</div>
			</div>
			<div class="inputs">
				<input type="button" id="updateBtn" value="변경"/>
			</div>
		</form:form>
	</div>
</body>
</html>