<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</script>
<style type="text/css">
	.navbar {
      	margin-bottom: 0;
      	border-radius: 0;
      	border-bottom: 1px solid #e8e8e8;
    }
    
    footer {
      	background-color: #ffffff;
      	padding: 15px;
	  	border-top: 1px solid #e8e8e8;
	  	text-align: center;
	  	position: absolute;
	  	left:0px;
	  	right:0px;
	  	bottom:0px;
    }
    
    #image {
   		background-image: url(http://localhost:8080/AdvanceBooking/img/main.jpg);
   		background-repeat: no-repeat;
   		background-position: center center;
	    background-size: 1000px;
	  	text-align: center;
	  	
	  	position: absolute;
	  	width: 1000px;
	  	height: 600px;
		left: 50%;
		top: 50%;
		transform: translate(-50%, -50%);
    }
    
</style>
<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">      
        <li>
        	<a href="#" data-toggle="modal" data-target="#loginModal"><span class="glyphicon glyphicon-log-in"></span> Login</a>
      	</li> 
        <li>
        	<a href="#" data-toggle="modal" data-target="#registModal"><span class="glyphicon glyphicon-user"></span> Regist</a>
      	</li>
      </ul>
    </div>
  </div>
</nav>
</head>
<body>
	<div id="wrapperbox">