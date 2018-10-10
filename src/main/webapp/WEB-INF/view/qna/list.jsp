<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA list</title>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
	<c:choose>
		<c:when test="${not empty qnaVOList}">
			<!-- items는 list로 전달받은 EL -->
			<c:forEach items = "${qnaVOList}" var = "qnaVO">
			<div class = "contentWrapper">
				<div class = "number  box">
					${qnaVO.id} 
					<div class = "subject  box">
				 		<a href="/AdvanceBooking/qna/detail/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">
				 			${qnaVO.subject}
				 		</a>
				 	</div> 
				 <div class = "writer  box">${qnaVO.memberVO.name}</div> 
				 <div class = "create-date  box">${qnaVO.crtDate}</div>
			</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div id = "no-articles">
			등록된 게시글이 없습니다.
			</div>
		</c:otherwise>
	</c:choose>
	<div>
		<form id="searchForm" onsubmit="javascript:movePage(0);">
			${pagenation}
			<div>
				<input type="text" name="searchKeyword" value="${qnaSearchVO.searchKeyword}">
				<a href="/AdvanceBooking/qna/list/init">검색초기화</a>
			</div> 
		</form>
	</div>
	<div>
		<a href="/AdvanceBooking/qna/write">qna작성</a>
	</div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>