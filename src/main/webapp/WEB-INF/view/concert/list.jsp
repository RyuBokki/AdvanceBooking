<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전예매시스템</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
  <script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
  <script src="/AdvanceBooking/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #ffffff;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #ffffff;
      color: white;
      padding: 15px;
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
</head>
<body>

<jsp:include page="/WEB-INF/view/common/mainHeader.jsp"></jsp:include>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      <div class="well">
      	<a href="#">사전 예매</a>
      </div>
      <div class="well">
      	<a href="#">공연 추천</a>
      </div>      
      <div class="well">
      	<a href="#">채팅</a>
      </div>      
      <div class="well">
      	<a href="/AdvanceBooking/qna/write">QnA</a>
      </div>      
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
</div>

<footer class="container-fluid text-center">
  <p>C.A.B(Concert Advance Booking)</p>
</footer>

</body>
</html>