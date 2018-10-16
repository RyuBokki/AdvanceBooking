<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdvanceBooking</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
  <script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
  <script src="/AdvanceBooking/js/bootstrap.min.js"></script>
  <script type="text/javascript">
	  $().ready(function() {
			
		  	$("#registMove").click(function(){
		  		
		  		$("#loginModal").modal("hide");
		  		$("#registModal").modal("show");
		  		
		  	});
		  
			$("#loginEmail").keyup( function(){
				$.get("/AdvanceBooking/member/loginSuccess"
				,function(){				
					var loginEmail = document.getElementById("loginEmail");
				    if ( loginEmail.validity.valueMissing ) {
				        document.getElementById("loginEmailError2").innerHTML = "이메일은 필수 입력값입니다.";
				        
				    } else {
				        if ( loginEmail.validity.typeMismatch ) {
				        	document.getElementById("loginEmailError2").innerHTML = "이메일 형식으로 입력해 주세요.";
				        }
				        else {
					        document.getElementById("loginEmailError2").innerHTML = "";
				        }
				    } 
				})
			})
				
			$("#loginPassword").keyup( function(){
				$.get("/AdvanceBooking/member/loginSuccess"
				,function(){
					var loginPassword = document.getElementById("loginPassword");
				    if ( loginPassword.validity.valueMissing ) {
				        document.getElementById("loginPasswordError2").innerHTML = "비밀번호는 필수 입력값입니다.";
				    } else {
				        if ( loginPassword.validity.patternMismatch ) {
				        	document.getElementById("loginPasswordError2").innerHTML = "숫자 영대소문자 특수 문자를 포함한 8~20자를 입력하세요.";
				        }
				        else {
					        document.getElementById("loginPasswordError2").innerHTML = "";
				        }
				    } 
				})
			})
			
			$("#loginBtn").click( function() {
				var loginEmail = document.getElementById("loginEmail");
				var loginPassword = document.getElementById("loginPassword");
				
				if ( !loginEmail.validity.valueMissing && !loginEmail.validity.typeMismatch
						&& !loginPassword.validity.valueMissing && !loginPassword.validity.patternMismatch 
						&& !loginPassword.validity.rangeOverflow && !loginPassword.validity.rangeUnderflow ) {
					
					$("#loginForm").attr({
						method:"post",
						action:"/AdvanceBooking/memberlogin"
					});
					
					$("#loginForm").submit();
					
					var isBlockAccount = $("#isBlockAccount").val();
					var isLoginFail = $("#isLoginFail").val();
					
					if ( isBlockAccount ) {
						alert("계정이 잠겼습니다. 1시간 뒤에 로그인해주세요.");
						/* $.ajax({
							    type: "POST",
							    url: "/AdvanceBooking/member/loginFail",
							    complete: function(){$("#loginModal").modal();}
						}); */
					}
					else {						
						if ( isLoginFail ) {
							alert("비밀번호 또는 아이디가 일치하지 않습니다.");
							/* $.ajax({
								    type: "POST",
								    url: "/AdvanceBooking/member/loginFail",
								    complete: function(){$("#loginModal").modal();}
							}); */
						}
					}
				}
				else {
					alert("로그인 실패");
				}
			})
			
			
			
	//		regist javascript 처리
	
			$("#registEmail").keyup( function(){
					$.post("/AdvanceBooking/member/regist"
					,function(){				
						var registEmail = document.getElementById("registEmail");
					    if ( registEmail.validity.valueMissing ) {
					        document.getElementById("registEmailError2").innerHTML = "이메일은 필수 입력값입니다.";
					        
					    } else {
					        if ( registEmail.validity.typeMismatch ) {
					        	document.getElementById("registEmailError2").innerHTML = "이메일 형식으로 입력해 주세요.";
					        }
					        else {
						        document.getElementById("registEmailError2").innerHTML = "";
					        }
					    } 
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
				
			$("#registPassword").keyup( function(){
				$.post("/AdvanceBooking/member/regist"
				,function(){
					var registPassword = document.getElementById("registPassword");
				    if ( registPassword.validity.valueMissing ) {
				        document.getElementById("registPasswordError2").innerHTML = "비밀번호는 필수 입력값입니다.";
				    } else {
				        if ( registPassword.validity.patternMismatch ) {
				        	document.getElementById("registPasswordError2").innerHTML = "숫자 영대소문자 특수 문자를 포함한 8~20자를 입력하세요.";
				        }
				        else {
					        document.getElementById("registPasswordError2").innerHTML = "";
				        }
				    } 
				})
			})
				
			$("#registPasswordConfirm").keyup( function(){
				$.post("/AdvanceBooking/member/regist"
				,function(){				
					var registPasswordConfirm = document.getElementById("registPasswordConfirm");
				    if (!registPasswordConfirm.checkValidity()) {
				        document.getElementById("registPasswordConfirmError2").innerHTML = "비밀번호 재입력은 필수 입력값입니다.";
				    } else {
				        document.getElementById("registPasswordConfirmError2").innerHTML = "";
				    }
					
					if( $("#registPassword").val() != $("#registPasswordConfirm").val() ) {
						$("#notEqualPassword").show();
						$("#registPasswordConfirm").focus();
					}
					else {					
						$("#notEqualPassword").hide();
					}
					
				})
			})
	
			$("#name").keyup( function(){
				$.post("/AdvanceBooking/member/regist"
				,function(){
					var name = document.getElementById("name");
				    if (!name.checkValidity()) {
				        document.getElementById("nameError2").innerHTML = "이름은 필수 입력값입니다.";
				    } else {
				        document.getElementById("nameError2").innerHTML = "";
				    }
				})
			})
	
			$("#registBtn").click( function() {
									
				$.ajax({
						url: "/AdvanceBooking/member/regist"
						, type: "POST"
						, data: $('#registForm').serialize()
						, dataType: "json"
						, success:function(response) {
							if ( response.success ) {
								alert("회원가입 성공");
								$("#registModal").modal("hide");
								location.href = '/AdvanceBooking/main';
							}
							else {
								alert("회원가입 실패");
							}
						}
				})
			})
			
			$('.dropdown a.test').on("click", function(e){
			    $(this).next('ul').toggle();
			    e.stopPropagation();
			    e.preventDefault();
		    });
			
		})
  </script>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
	<div id="image">
	</div>
		
	<!-- loginModal -->
  	<div class="modal fade" id="loginModal" role="dialog">
    	<div class="modal-dialog">
    
      	<!-- Modal content-->
	      	<div class="modal-content">
	        	<div class="modal-header">
	          		<button type="button" class="close" id="" data-dismiss="modal">&times;</button>
	          		<h4 class="modal-title">Login</h4>
	        	</div>
	        	<div class="modal-body">
	          		<form:form id="loginForm"
				   			   modelAttribute="memberVO">
		   			    <div class="wrapperModal">
		   			    	<div>
		   			    		<input type="hidden" id="isLoginFail" value="${isLoginFail}" />
		   			    		<input type="hidden" id="isBlockAccount" value="${isBlockAccount}" />
		   			    	</div>
							<div class="form-group">
								<label for="loginEmail">Email</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input type="email" class="form-control" id="loginEmail" name="email" placeholder="아이디(이메일)" value="${loginMemberVO.email}" required/>				
								</div>
								<div>
									<form:errors path="email" id="loginEmailError" class="error"/>
								</div>
								<div id="loginEmailError2">
								</div>
							</div>
							<div class="form-group">
								<label for="loginPwd">Password</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" class="form-control" id="loginPassword" name="password" placeholder="비밀번호" value="${loginMemberVO.password}" pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()]).{8,20}" min="8" max="20" required/>
								</div>
								<div>
									<form:errors path="password" id="loginPasswordError" class="error"/>
								</div>
								<div id="loginPasswordError2">
								</div>
							</div>
							<div class="form-group">
								<input type="button" class="form-control login" id="loginBtn" value="Login"/>							
							</div>
		   			    </div>
					</form:form>
	        	</div>
	        	<div class="modal-footer">
         			<div class="behindLogin left">
						<a id="registMove" href="#" >회원 가입</a>
					</div>
					<div class="behindLogin right">
						<a href="/AdvanceBooking/member/findPassword" >Password 찾기</a>
					</div>
        		</div>
	      	</div>
    	</div>
  	</div>
  	
  	<!-- RegistModal -->
  	<div class="modal fade" id="registModal" role="dialog">
    	<div class="modal-dialog">
    
      	<!-- Modal content-->
	      	<div class="modal-content">
	        	<div class="modal-header">
	          		<button type="button" class="close" data-dismiss="modal">&times;</button>
	          		<h4 class="modal-title">Regist</h4>
	        	</div>
	        	<div class="modal-body">
	          		<div id="wrapperbox">	
						<form:form id="registForm"
								   modelAttribute="memberVO" >
							<div class="inputbox form-group">
								<label for="registEmail">Email</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>				
									<input type="email" id="registEmail" class="form-control" name="email" placeholder="아이디(이메일)을 입력하세요" value="${registMemberVO.email}" required/>
								</div>
								<div>
									<form:errors path="email" id="registEmailError"/>
								</div>
								<div id="registEmailError2">
								</div>
								<div id="email-duplicated" style="display:none;">
									이미 존재하는 이메일이거나 사용할 수 없는 이메일입니다.				
								</div>
							</div>
							<div class="inputbox form-group">
								<label for="registPwd">Password</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>				
									<input type="password" id="registPassword" class="form-control" name="password" placeholder="비밀번호를 입력하세요" value="${registMemberVO.password}" pattern="(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()]).{8,20}" min="8" max="20" required/>
								</div>
								<div>
									<form:errors path="password" id="registPasswordError"/>
								</div>
								<div id="registPasswordError2">
								</div>
							</div>
							<div class="inputbox form-group">
								<label for="registPwdConfirm">PasswordConfirm</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>				
									<input type="password" id="registPasswordConfirm" class="form-control" name="passwordConfirm" placeholder="비밀번호를 재입력하세요" value="${registMemberVO.passwordConfirm}" required/>				
								</div>
								<div>
									<form:errors path="passwordConfirm" id="registPasswordConfirmError"/>
								</div>
								<div id="registPasswordConfirmError2">
								</div>
								<div id="notEqualPassword" style="display:none;">
									비밀번호가 일치하지 않습니다.
								</div>
							</div>
							<div class="inputbox form-group">
								<label for="name">Name</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>								
									<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" value="${registMemberVO.name}" required/>
								</div>
								<div>
									<form:errors path="name" id="nameError"/>
								</div>
								<div id="nameError2">
								</div>
							</div>
							<div>
								<input type="button" id="registBtn" class="form-control" value="Regist"/>
							</div>	
						</form:form>
					</div>
	        	</div>
	      	</div>
    	</div>
  	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
