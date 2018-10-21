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
		
  		$('.for-travelsing').closest('.reply-rel').mouseenter(function(){
  			
			$(this).find('.reply-right').show(function(){
				
			});  				
			
		});
		
		$('.for-travelsing').closest('.reply-rel').mouseleave(function(){
			$(this).find('.reply-right').hide();
		});
				
		$('.update-click').closest('.dropdown-menu').find('.update-click').click(function(){
			$(this).closest('.for-travelsing').find('.replies').hide();
			$(this).closest('.for-travelsing').find('.replyUpdateDiv').show();
		});
		
		$('.updateBtn').closest('.replyUpdateDiv').find('.updateBtn').closest('.replyUpdateDiv').mouseenter(function(event){
			
			event.stopImmediatePropagation();
			
		});
	
		$('.updateBtn').closest('.replyUpdateDiv').find('.updateBtn').parent().children().mouseenter(function(event){
			
			event.stopImmediatePropagation();
			
		});
	
		$('.updateBtn').closest('.replyUpdateDiv').find('.updateBtn').click(function() {
			
			$(this).closest('.replyUpdateDiv').hide();
			
			$(this).closest('.replyUpdateForm').submit();
			
		});
				
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
			
			$('#replyWriteForm').submit();
			
		});
		
		$('.repl-click').closest('.dropdown-menu').find('.repl-click').click(function(){
			$(this).closest('.reply-rel').find('.replyReplDiv').show();
		});
		
		$('.replBtn').closest('.replyReplDiv').find('.replBtn').click(function(){
			
			$(this).closest('.replyReplDiv').hide();
			$(this).closest('.replyReplForm').submit();
			
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
		height: 60px;
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
		height: 60px;
	}
	
	contents {
		margin-top: 50px;
	}
	
	.reply-rel {
		height:40px;
		margin-top:10px;
		width:100%;
	}
	
	.for-travelsing {
		position: relative;	
		height: 40px;
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
	
	.replyReplDiv {
		margin-top: 10px;
	}
</style>
</head>
<body>
<div class="container-fluid">
	<div class="col-sm-2 sidenav">      
    </div>
    <div id="wrapperbox" class="col-sm-8">
    	<div id="rel" class="form-group">
			<h3 id="left">
				${concertVO.subject}
			</h3>
			<div id="right">
				<div class="dropup">
				    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
				    	<span class="glyphicon glyphicon-option-vertical"></span>
				    </button>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/concert/list">사전예매 목록</a></li>
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="${concertVO.advanceBookingUrl}">Go Interpark</a></li>
				    </ul>
				</div>
			</div>
    	</div>
		<div class="contents form-group">
			${concertVO.contents}
		</div>
		<div class="form-group">
			<form:form id="replyWriteForm"
					   modelAttribute="concertReplyVO" 
					   method="post"
					   action="/AdvanceBooking/concert/reply/write">
				<input type="hidden" name="concertId" value="${concertVO.concertId}"/>
				<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}"/>
				<div>
					<div>
						<input type="text" name="content" class="myform-control" value="${concertReplyVO.content}" required/>
						<input type="button" id="writeBtn" class="mybtn btn-primary" value="write" />
					</div>
					<form:errors id="contentError" path="content"></form:errors>
				</div>
			</form:form>
		</div>
		<div class="form-group">
			<c:forEach items="${concertVO.replyList}" var="reply">
				<div class="reply-rel">
					<div class="for-travelsing">
						<div class="replies reply-left" style="margin-left: ${(reply.level - 1 ) * 30}px;">
							<c:choose>
								<c:when test="${reply.isDelete eq 'Y'}">
									<div>
										삭제된 댓글입니다.
									</div>
								</c:when>
								<c:otherwise>
									<div>
										<div class="inline">${reply.memberVO.name}</div>
										<div class="inline">${reply.crtDate}</div>
									</div>
									<div class="replyEvent">${reply.content}</div>
								</c:otherwise>
							</c:choose>
						</div>	
						<div class="replyUpdateDiv form-group" style="display:none;">
							<c:if test="${reply.email eq sessionScope._USER_.email || sessionScope._USER_.authority eq 'ADMIN'}">
								<form:form class="replyUpdateForm"
										   modelAttribute="replyVO" 
										   method="post"
										   action="/AdvanceBooking/concert/reply/update/${reply.replyId}">
									<input type="hidden" name="concertId" value="${concertVO.concertId}"/>
									<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}"/>
									<input type="hidden" name="replyId" value="${reply.replyId}"/>
									<div>
										<div>
											<input type="text" name="content" class="myform-control" value="${reply.content}" required/>
											<input type="button" class="updateBtn mybtn btn-primary" value="write" />
										</div>
										<form:errors class="updateContentError" path="content"></form:errors>
									</div>
								</form:form>
							</c:if>
						</div>
				    	<c:if test="${reply.isDelete eq 'N'}">
							<div class="reply-right" style="display:none;">
								<div class="dropup">
								    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
								    	<span class="glyphicon glyphicon-option-vertical"></span>
								    </button>
								    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
									      <li role="presentation"><a class="repl-click" role="menuitem" tabindex="-1" href="#">답글 작성</a></li>							
									<c:if test="${reply.email eq sessionScope._USER_.email || sessionScope._USER_.authority eq 'ADMIN'}">
									      <li role="presentation"><a class="update-click" role="menuitem" tabindex="-1" href="#">댓글 수정</a></li>							
									      <li role="presentation"><a role="menuitem" tabindex="-1" href="/AdvanceBooking/concert/reply/delete/${reply.replyId}?token=${sessionScope._CSRF_TOKEN_}">댓글 삭제</a></li>
								    </c:if>					
								    </ul>
								</div>
							</div>
				    	</c:if>
					</div>
					<div class="replyReplDiv form-group" style="display:none;">
						<c:if test="${reply.isDelete eq 'N'}">
							<form:form class="replyReplForm"
									   modelAttribute="replyVO" 
									   method="post"
									   action="/AdvanceBooking/concert/reply/repl/${reply.replyId}">
								<input type="hidden" name="concertId" value="${concertVO.concertId}"/>
								<input type="hidden" name="token" value="${sessionScope._CSRF_TOKEN_}"/>
								<input type="hidden" name="email" value="${sessionScope._USER_.email}"/>
								<div>
									<div>
										<input type="text" name="content" class="myform-control" value="${replConcertReplyVO.content}" required/>
										<input type="button" class="replBtn mybtn btn-primary" value="write" />
									</div>
									<form:errors class="replContentError" path="content"></form:errors>
								</div>
							</form:form>
						</c:if>
					</div>
				</div>	
			</c:forEach>
		</div>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
