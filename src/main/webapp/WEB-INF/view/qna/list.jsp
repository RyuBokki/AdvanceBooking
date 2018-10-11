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
	<div class="container">
	  <h2><span class="glyphicon glyphicon-question-sign"></span>QnA</h2>
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th>subject</th>
	        <th>name</th>
	        <th>CreateDate</th>
	      </tr>
	    </thead>
			<c:choose>
				<c:when test="${not empty qnaVOList}">
				    <c:forEach items = "${qnaVOList}" var = "qnaVO">
					    <tbody>
					      <tr>
					        <td>
					        	<a href="/AdvanceBooking/qna/detail/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">
						 			${qnaVO.subject}
						 		</a>
					        </td>
					        <td>
					        	${qnaVO.memberVO.name}
					        </td>
					        <td>
					        	${qnaVO.crtDate}
					        </td>
					      </tr>
					    </tbody>
				    </c:forEach>
				</c:when>
				<c:otherwise>
					<tbody>
				      	등록된 게시글이 없습니다.
				    </tbody>
				</c:otherwise>
			</c:choose>
	  </table>
	</div>
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