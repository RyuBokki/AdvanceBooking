<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
  <script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
  <script src="/AdvanceBooking/js/bootstrap.min.js"></script>

<style>
	.navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
</style>

<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="/AdvanceBooking/concert/list">Home</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">      
        <li class="dropdown">
        	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
	        	<span class="glyphicon glyphicon-user"></span>
	        	${sessionScope._USER_.name} 
	        	<span class="caret"></span>
        	</a>
	        <ul class="dropdown-menu">
	          <li><a href="/AdvanceBooking/member/myPage"><span class="glyphicon glyphicon-log-in"></span>MyPage</a></li>
	          <li role="presentation" class="divider"></li>
	          <li><a href="/AdvanceBooking/member/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
	        </ul>
      	</li>
      	<li class="dropdown">
        	<a class="dropdown-toggle" data-toggle="dropdown" href="#">
	        	menu 
	        	<span class="caret"></span>
        	</a>
	        <ul class="dropdown-menu">
	          <li>1</li>
	          <li role="presentation" class="divider"></li>
	          <li>2</li>
	        </ul>
      	</li>        
      </ul>
    </div>
  </div>
</nav>