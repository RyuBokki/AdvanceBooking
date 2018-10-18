<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna detail</title>
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
		
  		
  		
  		$('.for-travelsing').closest('.reply-rel').mouseenter(function(){
			$(this).find('.reply-right').show();
		});
		
		$('.for-travelsing').closest('.reply-rel').mouseleave(function(){
			$(this).find('.reply-right').hide();
		});
				
		$('#content').keyup(function(){
			
			$.post('/AdvanceBooking/reply/write'
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
				action:'/AdvanceBooking/reply/write'
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
	
	.myform-control {
	    display:inline-block;
	    width: 88%;
	    height: 34px;
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
	    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
	    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
	    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
	}
	
	img {
	    border: 0;
	    width: 100%;
	}
	
	#writeBtn {
		display: inline-block;
		width: 11%
	}
	
	.mybtn {
	    display: inline-block;
	    padding: 6px 12px;
	    margin-bottom: 0;
	    font-size: 14px;
	    font-weight: 400;
	    line-height: 1.42857143;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: middle;
	    -ms-touch-action: manipulation;
	    touch-action: manipulation;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    background-image: none;
	    border: 1px solid transparent;
	    border-radius: 4px;
	}
	
	#rel {
		position: relative;
		height: 30px;
	}
	
	#left {
		position:absolute;
		display: inline-block;
		top:0px;
		left:0px;
		height: 100%;
		margin-top:0px;
	}
	
	#right {
		position:absolute;
		display: inline-block;
		top:0px;
		right:0px;
		height:100%;
	}
	
	h3 {
		margin-top: 30px;
	
	}
	
	.reply-rel {
		height:40px;
		margin-top:10px;
		width:100%;
	}
	
	.for-travelsing {
		position: relative;	
	}
	
	.reply-left {
		position: absolute;
		display: inline-block;
		top:0px;
		left:0px;
		height: 100%;
		margin-top:0px;
	
	}
	
	.reply-right {
		position: absolute;
		top:0px;
		right:0px;
		display: inline-block;
		height:100%;
	}
</style>
</head>
<body>
<div class="container-fluid">
	<div class="col-sm-2 sidenav">      
    </div>
    <div id="wrapperbox" class="col-sm-8">
		<div id="rel" class="form-group">
			<h2 id="left">
				${qnaVO.subject}
			</h2>
			<div id="right">
				<div class="dropup">
				    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
				    	<span class="glyphicon glyphicon-option-vertical"></span>
				    </button>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}">QnA목록</a></li>
				      <c:if test="${qnaVO.email eq sessionScope._USER_.email}">
					      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/qna/update/${qnaVO.id}">QnA수정</a></li>
					      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/qna/delete/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">QnA삭제</a></li>							
					  </c:if>
				    </ul>
				</div>
			</div>
		</div>
		<h3 class="form-group">
			${qnaVO.content}
		</h3>
		<div class="form-group text-right">
			작성자 : ${qnaVO.memberVO.name}
		</div>
		<div class="form-group">
			<c:if test="${qnaVO.email eq sessionScope._USER_.email || sessionScope._USER_.authority eq 'ADMIN'}">
				<form:form id="replyWriteForm"
						   modelAttribute="replyVO" >
					<input type="hidden" name="qnaId" value="${qnaVO.id}"/>
					<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}"/>
					<div>
						<div>
							<input type="text" name="content" class="myform-control" value="${qnaReplyVO.content}" required/>
							<input type="button" id="writeBtn" class="mybtn btn-primary" value="write" />
						</div>
						<form:errors id="contentError" path="content"></form:errors>
					</div>
				</form:form>
			</c:if>
		</div>
		<div class="form-group">
			<c:forEach items="${qnaVO.replyList}" var="reply">
				<div class="reply-rel">
					<div class="for-travelsing"> 
						<div class="replies reply-left">
							<div>
								<div class="inline">${reply.memberVO.name}</div>
								<div class="inline">${reply.crtDate}</div>
							</div>						
							<div class="replyEvent">${reply.content}</div>
						</div>
				        <c:if test="${qnaVO.email eq sessionScope._USER_.email}">
							<div class="reply-right" style="display:none;">
								<div class="dropup">
								    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
								    	<span class="glyphicon glyphicon-option-vertical"></span>
								    </button>
								    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
									      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">댓글 수정</a></li>							
									      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/reply/delete/${reply.replyId}?token=${sessionScope._CSRF_TOKEN_}">댓글 삭제</a></li>
								    </ul>
								</div>
							</div>
					    </c:if>
					</div>
				</div>
			</c:forEach>
		</div>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
