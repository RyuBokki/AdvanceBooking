<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
</head>
<body>
	<form:form id="registForm"
			   modelAttribute="memberVO">
		<div>
			<h1>
				회원가입
			</h1>
		</div>
		<div>
			<input type="email" id="email" name="email" placeholder="아이디(이메일)을 입력하세요" value="${memberVO.email}"/>
			<div>
				<form:errors path="email" id="emailError"/>
			</div>
			<div id="email-duplicated" style="display:none;">
				이미 존재하는 이메일이거나 사용할 수 없는 이메일입니다.
			</div>
		</div>
		<div>
			<input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" value="${memberVO.password}"/>
			<div>
				<form:errors path="password" id="passwordError"/>
			</div>
		</div>
		<div>
			<input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 재입력하세요" value="${memberVO.passwordConfirm}"/>
			<div>
				<form:errors path="passwordConfirm" id="passwordConfirmError"/>
			</div>
			<div id="notEqualPassword" style="display:none;">
				비밀번호가 일치하지 않습니다.
			</div>
		</div>
		<div>
			<input type="text" id="name" name="name" placeholder="이름을 입력하세요" value="${memberVO.name}"/>
			<div>
				<form:errors path="name" id="nameError"/>
			</div>
		</div>
		<div>
			<input type="button" id="registBtn" value="Regist"/>
		</div>	
	</form:form>
</body>
</html>