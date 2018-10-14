<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA Update</title>
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
	    		
	    		
   		$('#updateBtn').click(function(){
   			   			
   			$('#updateForm').attr({
   				method:"post",
   				action:"/AdvanceBooking/qna/update",
   				enctype: "multipart/form-data"
   			});
   			
   			$('#updateForm').submit();
   		})
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
		<form:form id="updateForm"
				   modelAttribute="qnaVO">
			<div>
				<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}" />
				<input type="hidden" name="id" value="${qnaVO.id}" />				
			</div>
			<div class="form-group text-center">
				<h2>
					QnA Update
				</h2>
			</div>
			<div class="form-group">
				<label for="subject">Subject</label>
				<div>
					<input type="subject" class="form-control" id="subject" name="subject" placeholder="제목" value="${qnaVO.subject}"/>
					<form:errors path="subject"></form:errors>				
				</div>
			</div>
			<div class="form-group">
				<label for="content">Content</label>
				<div>
					<textarea class="form-control" id="content" name="content" placeholder="내용">${qnaVO.content}</textarea>
					<form:errors path="content"></form:errors>
				</div>
			</div>
			<div class="form-group">
				<input type="button" class="form-control" id="updateBtn" value="update"/>
			</div>
			<div class="form-group text-right">
				<a href = '/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}'>목록</a>
			</div>
		</form:form>
	</div>
	<div class="col-sm-2 sidenav">
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>