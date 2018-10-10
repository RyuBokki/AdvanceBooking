<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
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
		<a href="/AdvanceBooking/qna/list">목록</a>
		<c:if test="${qnaVO.email eq sessionScope._USER_.email}">
			<a href="/AdvanceBooking/qna/update/${qnaVO.id}">수정</a>
			<a href="/AdvanceBooking/qna/delete/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">삭제</a>		
		</c:if>
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>
