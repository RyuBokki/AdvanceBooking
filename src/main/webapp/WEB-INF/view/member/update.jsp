<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$().ready( function() {
		
		$('.dropdown a.dropdown-toggle').on("click", function(e){
  		    $(this).next('ul').toggle();
  		    e.stopPropagation();
  		    e.preventDefault();
  	    });
  		
  		$('a.test').click(function(e) {
  			$(this).next('ul').toggle();
  		    e.stopPropagation();
  		    e.preventDefault();
  		});
		
		$("#password").keyup( function(){
			$.post("/AdvanceBooking/member/update"
			,function(){
				var password = document.getElementById("password");
			    if ( password.validity.valueMissing ) {
			        document.getElementById("passwordError2").innerHTML = "비밀번호는 필수 입력값입니다.";
			    } else {
			        if ( password.validity.patternMismatch ) {
			        	document.getElementById("passwordError2").innerHTML = "숫자 영대소문자 특수 문자를 포함한 8~20자를 입력하세요.";
			        }
			        else {
				        document.getElementById("passwordError2").innerHTML = "";
			        }
			    }
			})
		})
		
		$("#passwordConfirm").keyup( function(){
			$.post("/AdvanceBooking/member/update"
			,function(){				
				var passwordConfirm = document.getElementById("passwordConfirm");
			    if (!passwordConfirm.checkValidity()) {
			        document.getElementById("passwordConfirmError2").innerHTML = "비밀번호 재입력은 필수 입력값입니다.";
			    } else {
			        document.getElementById("passwordConfirmError2").innerHTML = "";
			    }
				
				if( $("#password").val() != $("#passwordConfirm").val() ) {
					$("#notEqualPassword").show();
					$("#passwordConfirm").focus();
				}
				else {					
					$("#notEqualPassword").hide();
				}
				
			})
		})

		
		$("#name").keyup( function(){
			$.post("/AdvanceBooking/member/update"
			,function(){				
				var name = document.getElementById("name");
			    if (!name.checkValidity()) {
			        document.getElementById("nameError2").innerHTML = "이름은 필수 입력값입니다.";
			    } else {
			        document.getElementById("nameError2").innerHTML = "";
			    }
			})
		})
		
		$("#updateBtn").click(function(){
			
			if ( !password.validity.valueMissing && !password.validity.patternMismatch
					&& passwordConfirm.checkValidity() && name.checkValidity()) {
				$("#updateForm").attr({
					action:"/AdvanceBooking/member/update",
					method:"post"
				}).submit();
			}
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
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
	<div id="wrapperbox">
		<form:form id="updateForm"
			  modelAttribute="memberVO">
			<div id="title" class="inputs">
				<h1>
					회원 정보 수정
				</h1>
			</div>
			<div class="form-group">
				<label for="email">Email</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input type="email" id="email" class="form-control" name="email" value="${sessionScope._USER_.email}" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label for="pwd">Password</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input type="password" id="password" class="form-control" name="password" placeholder="변경할 비밀번호를 입력하세요." value="${memberVO.password}" pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()]).{8,20}" min="8" max="20" required/>
				</div>
				<div>
					<form:errors style="display:none;" path="password" id="passwordError" />
				</div>
				<div id="passwordError2" style="color:red;">
				</div>
			</div>
			<div class="form-group">
				<label for="pwdConfirm">PasswordConfirm</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input type="password" id="passwordConfirm" class="form-control" name="passwordConfirm" placeholder="비밀번호를 재입력하세요." value="${memberVO.passwordConfirm}" required/>
				</div>
				<div>
					<form:errors style="display:none;" path="passwordConfirm" id="passwordConfirmError" />
				</div>
				<div id="passwordConfirmError2" style="color:red;">
				</div>
				<div id="notEqualPassword" style="display:none; color:red;">
					비밀번호가 일치하지 않습니다.
				</div>
			</div>
			<div class="form-group">
				<label for="name">Name</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input type="text" id="name" class="form-control" name="name" placeholder="변경할 이름을 입력하세요." value="${memberVO.name}" required/>
				</div>
				<div>
					<form:errors style="display:none;" path="name" id="nameError" />
				</div>
				<div style="color:red;" id="nameError2">
				</div>
			</div>
			<div>
				<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}">
			</div>
			<div class="form-group">
				<input type="button" class="form-control" id="updateBtn" value="변경"/>
			</div>
		</form:form>
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>