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
<script type="text/javascript" src="/AdvanceBooking/ckeditor5classic/ckeditor.js"></script>
<script type="text/javascript">
	$(function(){
	    
	    CKEDITOR.create(
	    	document.querySelector('#content'), {
	    		
	    		ckfinder: {
	    			uploadurl: 'http://localhost:8080/AdvanceBooking/'
	    		}
	    		
	    	}		
	    )
	});
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
		<form:form id="writeForm"
				   modelAttribute="qnaVO">
			<div>
				<h2 id="title">
					qna 작성		
				</h2>
			</div>
			<div>
				<label for="subject">Subject</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input type="subject" class="form-control" id="subject" name="subject" placeholder="제목" value="${qnaVO.subject}"/>				
				</div>
				<div>
					<form:errors path="subject" id="subjectError" class="error"/>
				</div>
			</div>
			<div>
				<label for="content">Content</label>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<textarea type="content" class="form-control" id="ckeditor" name="ckeditor" placeholder="내용" value="${qnaVO.content}"/>
				</div>
				<div>
					<form:errors path="content" id="contentError" class="error"/>
				</div>
			</div>
			<input type="button" class="form-control" id="writeBtn" value="write"/>
		</form:form>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>