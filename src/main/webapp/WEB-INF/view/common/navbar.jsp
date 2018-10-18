<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<link rel="stylesheet" href="/AdvanceBooking/css/main/main.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$().ready(function(){
		
		var token = $("#token").val();
		
		var url = '/AdvanceBooking/prefer/sendEmail' + '?token=' + token;
		
		$("#sendEmail").click(function() {
			
			$.post(url
					, function(response) {
						if ( response.isSendEmailSuccess ) {
							alert("사전예매 정보를 발송완료하였습니다.");
							location.href='/AdvanceBooking/concert/list';
						}
						else {
							alert("발송할 예매 정보가 존재하지 않습니다.");
							location.href='/AdvanceBooking/concert/list';
						}
					})
			
		});
		
	})
</script>

<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">      
      	<c:choose>
      		<c:when test="${not empty sessionScope._USER_}">
      			<li>
		        	<a href="/AdvanceBooking/concert/list">AdvanceBooking</a>
		      	</li> 
      			<li>
		        	<a href="#">Recommend</a>
		      	</li> 
      			<li>
		        	<a href="#">chatting</a>
		      	</li> 
      			<li>
		        	<a href="/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}">QnA</a>
		      	</li> 
		      	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span>(${sessionScope._USER_.name})님 <span class="caret"></span></a>
			        <ul class="dropdown-menu">
			          <li><a tabindex="-1" href="/AdvanceBooking/memberlogout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			          <li>
			          	<a class="test" tabindex="-1" href="#">MyPage <span class="caret"></a>
			          	<ul class="dropdown-menu">
			          		<input id="token" type="hidden" value="${sessionScope._CSRF_TOKEN_}">
   				            <li><a  href="/AdvanceBooking/member/update">회원정보 수정</a></li>
   				            <li><a  href="/AdvanceBooking/prefer/list"><span class="glyphicon glyphicon-thumbs-up"></span> Like</a></li>
   				            <c:if test="${sessionScope._USER_.authority eq 'ADMIN' }">
	   				            <li><a id="sendEmail"  href="/AdvanceBooking/prefer/sendEmail?token=${sessionScope._CSRF_TOKEN_}"><span class="glyphicon glyphicon-envelope"></span> Send Info</a></li>   				            
   				            </c:if>   				            
			          	</ul>
		          	  </li>
			        </ul>
		      	</li>
      		</c:when>
      		<c:otherwise>
      			<li>
		        	<a href="#" data-toggle="modal" data-target="#loginModal" id="login"><span class="glyphicon glyphicon-log-in"></span> Login</a>
		      	</li> 
		        <li>
		        	<a href="#" data-toggle="modal" data-target="#registModal" id="regist"><span class="glyphicon glyphicon-user"></span> Regist</a>
		      	</li>	
      		</c:otherwise>
      	</c:choose>
      </ul>
    </div>
  </div>
</nav>