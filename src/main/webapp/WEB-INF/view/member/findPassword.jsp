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
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$().ready(function(){
		
		$("#email").keyup( function(){
			$.post("/AdvanceBooking/member/findPassword"
			,function(){				
				$("#emailError").slideUp(100);
			})
			
			$.post("/AdvanceBooking/member/check/duplicate"
					, {
						"email":$(this).val()				
					}
					, function(response) {
						if ( response.duplicated ) {
							$("#email-duplicated").hide()
						}
						else {
							$("#email-duplicated").show()
						}
					}
			)
		})
		
		$("#findPasswordBtn").click(function(){
			$("#findPasswordForm").attr({
				action:"/AdvanceBooking/member/findPassword",
				method:"post"
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
</style>
</head>
<body>
	<div id="wrapperbox">	
		<form:form id="findPasswordForm"
				   modelAttribute="memberVO">
			<h1 id="title">
				비밀번호 찾기
			</h1>
			<div>
				<label for="email"><span class="glyphicon glyphicon-envelope"></span>Email</label>
				<input type="email" name="email" id="email" class="form-control" placeholder="이메일을 입력하세요" value="${memberVO.email}"/>
				<div id="emailError">
					<form:errors path="email"></form:errors>
				</div>
				<div id="email-duplicated" style="display:none;">
					존재하지 않거나 사용할 수 없는 이메일입니다.
				</div>
			</div>
			<div>
				<input type="button" id="findPasswordBtn" class="form-control" value="비밀번호 찾기"/> 
			</div>
		</form:form>
	</div>
</body>
</html>