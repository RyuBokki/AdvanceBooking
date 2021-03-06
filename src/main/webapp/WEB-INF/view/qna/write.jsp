<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdvanceBooking</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" charset="utf-8"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js" charset="utf-8"></script>
<script src="/AdvanceBooking/ckeditor5classic/ckeditor.js" charset="utf-8"></script>
<script type="text/javascript">
	$().ready(function(){
		
   		ClassicEditor.create(
   			document.querySelector("#content"), {
   				
   				ckfinder: {
   					uploadUrl: 'http://localhost:8080/AdvanceBooking/qna/imageUpload'
   				}
   			}		
   		
   		)
   		
	    		
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
	    		
  		$('#subject').keyup(function(){
  			var subject = document.getElementById("subject");
  			if ( subject.validity.valueMissing ) {
  				document.getElementById("subjectError2").innerHTML = "제목은 필수 입력값입니다.";
  			}
  			else {
  				document.getElementById("subjectError2").innerHTML = "";
  			}
  		});
  		
	    		
   		$('#writeBtn').click(function(){
   			
   			var content = $('#content').parent().children('div');
			var subject = document.getElementById("subject");
			
			if ( !subject.validity.valueMissing && !content.text() == ""  ) {
   			
	   			$('#writeForm').attr({
	   				method:"post",
	   				action:"/AdvanceBooking/qna/write",
	   				enctype: "multipart/form-data"
	   			});
	   			
	   			$('#writeForm').submit();			
   			}
   		});
	})
</script>
<style type="text/css">
	.sidenav {
		margin-top: 100px;
	}
	
	#wrapperbox {
		margin-top: 100px;
		margin-bottom: 100px;
	}
</style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid">
	<div class="col-sm-2 sidenav">
	</div>
	<div id="wrapperbox" class="col-sm-8">
		<form:form id="writeForm"
				   modelAttribute="qnaVO"
				   enctype="multipart/form-data">
			<div class="form-group">
				<h2 id="title">
					qna 작성		
				</h2>
			</div>
			<div>
				<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}" />
			</div>
			<div class="form-group">
				<label for="subject">Subject</label>
				<div>
					<input type="subject" class="form-control" id="subject" name="subject" placeholder="제목" value="${qnaVO.subject}" required/>
				</div>
				<div>
					<form:errors path="subject"></form:errors>				
				</div>
				<div id="subjectError2">
				</div>
			</div>
			<div class="form-group">
				<label for="content">Content</label>
				<div>
					<textarea class="form-control" id="content" name="content" placeholder="내용" required>${qnaVO.content}</textarea>
				</div>
				<div>
					<form:errors path="content"></form:errors>
				</div>
				<div id="contentError2">
				</div>
			</div>
			<div class="form-group">
				<input type="button" class="form-control" id="writeBtn" value="write"/>
			</div>
			<div class="form-group text-right">
				<a href='/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}'>목록</a>
			</div>
		</form:form>
	</div>
	<div class="col-sm-2 sidenav">
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>