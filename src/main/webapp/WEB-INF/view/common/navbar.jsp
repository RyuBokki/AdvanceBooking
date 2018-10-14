<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<link rel="stylesheet" href="/AdvanceBooking/css/main/main.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js"></script>

<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">      
      	<c:choose>
      		<c:when test="${not empty sessionScope._USER_}">
		      	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span>(${sessionScope._USER_.name})님 <span class="caret"></span></a>
			        <ul class="dropdown-menu">
			          <li><a tabindex="-1" href="/AdvanceBooking/memberlogout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			          <li>
			          	<a class="test" tabindex="-1" href="#">MyPage <span class="caret"></a>
			          	<ul class="dropdown-menu">
   				            <li><a  href="/AdvanceBooking/member/update">회원정보 수정</a></li>
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