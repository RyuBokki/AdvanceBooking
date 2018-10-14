<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전예매시스템</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
  <script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
  <script src="/AdvanceBooking/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$().ready(function() {
  		
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
  		
  	})
  </script>
  <style>
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #ffffff;
      height: 100%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
    </div>
    <div class="col-sm-8 text-left"> 
      <h1>Concert page</h1>
      <p>내용들</p>
      <hr>
      <h3>Test</h3>
      <p>내용들</p>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
  </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>