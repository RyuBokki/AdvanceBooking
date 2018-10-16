<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>concert detail</title>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" charset="utf-8" ></script>
<script type="text/javascript">
	$().ready(function(){
		
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
		
		$('#replyEvent').click(function(){
			$('#clickReply').show();
		})
				
		$('#content').keyup(function(){
			
			$.post('/AdvanceBooking/concert/reply/write'
					, function(){
				if ( $(this).val() == '' ) {
					$('#contentError').show();	
				}
				else {
					$('#contentError').hide();	
				}
			})
			
		})
		
		$('#writeBtn').click(function(){
			
			$('#replyWriteForm').attr({
				method:'post',
				action:'/AdvanceBooking/concert/reply/write'
			})
			
			$('#replyWriteForm').submit();
			
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
	
	.inline {
		display:inline-block;
		margin-right: 10px;
	}
</style>
</head>
<body>
<div class="container-fluid">
	<div class="col-sm-2 sidenav">      
    </div>
    <div id="wrapperbox" class="col-sm-8">
		<h1 class="form-group">
			${concertVO.subject}
		</h1>
		<h2 class="form-group">
			${concertVO.contents}
		</h2>
		<div class="form-group text-right">
			<a href="/AdvanceBooking/concert/list">목록</a>
			<a href="${concertVO.advanceBookingUrl}">go Interpark</a>
			<c:if test="${sessionScope._USER_.authority eq 'ADMIN'}">
				<a href="/AdvanceBooking/qna/update/${concertVO.concertId}">수정</a>
				<a href="/AdvanceBooking/qna/delete/${concertVO.concertId}?token=${sessionScope._CSRF_TOKEN_}">삭제</a>		
			</c:if>
		</div>
		<div class="form-group">
			<c:forEach items="${concertVO.replyList}" var="reply">
				<div id="replies">
					<div>
						<div class="inline">${reply.memberVO.name}</div>
						<div class="inline">${reply.crtDate}</div>
					</div>						
					<div id="replyEvent">${reply.content}</div>
					<div id="clickReply" style="display:none;">						
						<c:if test="${reply.email eq sessionScope._USER_.email || sessionScope._USER_.authority eq 'ADMIN'}">
							<a href="/AdvanceBooking/concert/reply/delete/${reply.replyId}?token=${sessionScope._CSRF_TOKEN_}">삭제</a>
							<a id="updateEvent" href="#">수정</a>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="form-group">
			<form:form id="replyWriteForm"
					   modelAttribute="concertReplyVO" >
				<input type="hidden" name="concertId" value="${concertVO.concertId}"/>
				<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}"/>
				<div>
					<textarea name="content">${concertReplyVO.content}</textarea>
					<form:errors id="contentError" path="content"></form:errors>
				</div>
				<input type="button" id="writeBtn" value="write" />
			</form:form>
		</div>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
