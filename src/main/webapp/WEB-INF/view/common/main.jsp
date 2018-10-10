<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/view/common/mainHeader.jsp"></jsp:include>
	<div id="image">
	</div>
		
	<!-- loginModal -->
  	<div class="modal fade" id="loginModal" role="dialog">
    	<div class="modal-dialog">
    
      	<!-- Modal content-->
	      	<div class="modal-content">
	        	<div class="modal-header">
	          		<button type="button" class="close" data-dismiss="modal">&times;</button>
	          		<h4 class="modal-title">Login</h4>
	        	</div>
	        	<div class="modal-body">
	          		<form:form id="loginForm"
				   			   modelAttribute="memberVO">
		   			    <div class="wrapperModal">
							<div>
								<label for="loginEmail">Email</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
									<input type="email" class="form-control" id="loginEmail" name="email" placeholder="아이디(이메일)" value="${loginMemberVO.email}"/>				
								</div>
								<div>
									<form:errors path="email" id="loginEmailError" class="error"/>
								</div>
							</div>
							<div>
								<label for="loginPwd">Password</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" class="form-control" id="loginPassword" name="password" placeholder="비밀번호" value="${loginMemberVO.password}"/>
								</div>
								<div>
									<form:errors path="password" id="loginPasswordError" class="error"/>
								</div>
							</div>
							<input type="button" class="form-control login" id="loginBtn" value="Login"/>
		   			    </div>
					</form:form>
	        	</div>
	        	<div class="modal-footer">
         			<div class="behindLogin left">
						<a href="/AdvanceBooking/member/regist" >회원 가입</a>
					</div>
					<div class="behindLogin right">
						<a href="/AdvanceBooking/member/findPassword">Password 찾기</a>
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
								   modelAttribute="memberVO">
							<div class="inputbox">
								<label for="registEmail">Email</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>				
									<input type="email" id="registEmail" class="form-control" name="email" placeholder="아이디(이메일)을 입력하세요" value="${registMemberVO.email}"/>
								</div>
								<div>
									<form:errors path="email" id="registEmailError"/>
								</div>
								<div id="email-duplicated" style="display:none;">
									이미 존재하는 이메일이거나 사용할 수 없는 이메일입니다.				
								</div>
							</div>
							<div class="inputbox">
								<label for="registPwd">Password</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>				
									<input type="password" id="registPassword" class="form-control" name="password" placeholder="비밀번호를 입력하세요" value="${registMemberVO.password}"/>
								</div>
								<div>
									<form:errors path="password" id="registPasswordError"/>
								</div>
							</div>
							<div class="inputbox">
								<label for="registPwdConfirm">PasswordConfirm</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>				
									<input type="password" id="registPasswordConfirm" class="form-control" name="passwordConfirm" placeholder="비밀번호를 재입력하세요" value="${registMemberVO.passwordConfirm}"/>				
								</div>
								<div>
									<form:errors path="passwordConfirm" id="registPasswordConfirmError"/>
								</div>
								<div id="notEqualPassword" style="display:none;">
									비밀번호가 일치하지 않습니다.
								</div>
							</div>
							<div class="inputbox">
								<label for="name">Name</label>
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>								
									<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" value="${registMemberVO.name}"/>
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
	        	</div>
	      	</div>
    	</div>
  	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
