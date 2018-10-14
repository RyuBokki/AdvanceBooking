<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		
		$("#findPasswordEmail").keyup( function(){
			$.post("/AdvanceBooking/member/findPassword"
			,function(){				
				var findPasswordEmail = document.getElementById("findPasswordEmail");
			    if ( findPasswordEmail.validity.valueMissing ) {
			        document.getElementById("findPasswordEmailError2").innerHTML = "이메일은 필수 입력값입니다.";
			        
			    } else {
			        if ( findPasswordEmail.validity.typeMismatch ) {
			        	document.getElementById("findPasswordEmailError2").innerHTML = "이메일 형식으로 입력해 주세요.";
			        }
			        else {
				        document.getElementById("findPasswordEmailError2").innerHTML = "";
			        }
			    }
			    
			$.post("/AdvanceBooking/member/check/duplicate"
					, {
						"email":$("#findPasswordEmail").val()			
					}
					, function(response) {
						if ( response.duplicated ) {
							$("#findPasswordEmail-duplicated").hide();
						}
						else {
							$("#findPasswordEmail-duplicated").show();
						}
					}
				)
			})
		})
			
		
		$("#findPasswordBtn").click(function(){
			$("#findPasswordForm").attr({
				action:"/AdvanceBooking/member/findPassword",
				method:"post"
			})
			
			$("#findPasswordForm").submit();
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
	
	#inputBox {
		margin-top: 15.4px;
		margin-bottom: 15.4px;
	}
</style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
	<div id="wrapperbox">	
		<form:form id="findPasswordForm"
				   modelAttribute="memberVO">
			<h1 id="title">
				Find Password
			</h1>
			<div id="inputBox">
				<label for="email">Email</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
					<input type="email" name="email" id="findPasswordEmail" class="form-control" placeholder="이메일을 입력하세요" value="${memberVO.email}" required/>
				</div>
				<div id="emailError">
					<form:errors path="email"></form:errors>
				</div>
				<div id="findPasswordEmail-duplicated" style="display:none;">
					존재하지 않거나 사용할 수 없는 이메일입니다.
				</div>
				<div id="findPasswordEmailError2">
				</div>
			</div>
			<div>
				<input type="button" id="findPasswordBtn" class="form-control" value="Find"/> 
			</div>
		</form:form>
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>