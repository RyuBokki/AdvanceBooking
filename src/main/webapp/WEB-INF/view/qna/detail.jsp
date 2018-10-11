<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" charset="utf-8" ></script>
<script type="text/javascript">
	$().ready(function(){
		
		$('#replyEvent').click(function(){
			$('#clickReply').show();
		})
		
		$('#replEvent').click(function(){
			$('#replyHidden').show();
		})		
		
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
	#mainBox {
		margin-bottom: 100px;
	}
</style>
</head>
<body>
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
      	<a href="/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}">QnA</a>
      </div>      
    </div>
    <div id="mainBox" class="col-sm-8">
		<h1>
			${qnaVO.subject}
		</h1>
		<h2>
			${qnaVO.content}
		</h2>
		<div>
			작성자 : ${qnaVO.memberVO.name}
		</div>
		<div>
			<div>
				<a href="/AdvanceBooking/qna/list?token=${sessionScope._CSRF_TOKEN_}">목록</a>
				<c:if test="${qnaVO.email eq sessionScope._USER_.email}">
					<a href="/AdvanceBooking/qna/update/${qnaVO.id}">수정</a>
					<a href="/AdvanceBooking/qna/delete/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">삭제</a>		
				</c:if>
			</div>
			<div>
				<c:forEach items="${qnaVO.replyList}" var="reply">
					<div id="replies" style="margin-left: ${(reply.level - 1 ) * 30}px;">
						<div>${reply.memberVO.name}</div>
						<div>${reply.crtDate}</div>
						<div id="replyEvent">${reply.content}</div>
						<div id="clickReply" style="display:none;">						
							<a id="replEvent" href="#">답글</a>
							<div id="replyHidden" style="display:none;">
								<form:form id="replyForm"
										   modelAttribute="qnaReplyVO"
										   method="post"
										   action="/AdvanceBooking/reply/repl/${reply.replyId}">
									<div>
										<textarea name="content" placeholder="대댓글을 입력하세요">${qnaReplVO.content}</textarea>
										<form:errors path="content"></form:errors>
									</div>
									<div>
										<input type="submit" id="replyBtn" value="Reply">
									</div>
								</form:form>
							</div>
							<c:if test="${reply.email eq sessionScope._USER_.email}">
								<a href="/AdvanceBooking/reply/delete/${reply.replyId}">삭제</a>
								<a id="updateEvent" href="#">수정</a>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
			<div>
			<form:form id="replyWriteForm"
					   modelAttribute="replyVO" >
				<input type="hidden" name="qnaId" value="${qnaVO.id}"/>
				<input type="hidden" name="parentReplyId" value="0"/>
				<div>
					<textarea name="content">${qnaReplyVO.content}</textarea>
					<form:errors id="contentError" path="content"></form:errors>
				</div>
				<input type="button" id="writeBtn" value="write" />
			</form:form>
			</div>
		</div>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
