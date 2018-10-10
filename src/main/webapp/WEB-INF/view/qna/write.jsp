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
	    		
	    		
   		$('#writeBtn').click(function(){
   			
   			alert($('#subject').val());
   			
   			$('#writeForm').attr({
   				method:"post",
   				action:"/AdvanceBooking/qna/write",
   				enctype: "multipart/form-data"
   			});
   			
   			$('#writeForm').submit();
   		})
	})
</script>
<style type="text/css">
	#wrapperbox {
	}
</style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid">
	<div id="wrapperbox" class="col-6">
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
					<input type="subject" class="form-control" id="subject" name="subject" placeholder="제목" value="${qnaVO.subject}"/>
					<form:errors path="subject"></form:errors>				
				</div>
			</div>
			<div class="form-group">
				<label for="content">Content</label>
				<div>
					<textarea class="form-control" id="content" name="content" placeholder="내용" value="${qnaVO.content}"></textarea>
					<form:errors path="content"></form:errors>
				</div>
			</div>
			<div class="form-group">
				<input type="button" class="form-control" id="writeBtn" value="write"/>
				<a href = '/AdvanceBooking/qna/list'>목록</a>
			</div>
		</form:form>
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>