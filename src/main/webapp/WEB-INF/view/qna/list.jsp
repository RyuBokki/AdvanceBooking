<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA list</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
<script src="/AdvanceBooking/js/jquery-3.3.1.min.js" charset="utf-8"></script>
<script src="/AdvanceBooking/js/bootstrap.min.js" charset="utf-8"></script>
<script src="/AdvanceBooking/ckeditor5classic/ckeditor.js" charset="utf-8"></script>
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
		
		
		
	})
</script>
<style>
    
    .row.content {height: 450px}

    .sidenav {
      padding-top: 20px;
      background-color: #ffffff;
      height: 100%;
    }
    
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    
    #mainBox {
    	margin-bottom: 100px;
    }
    
    section {
    	margin-top: 20px;
    }
    
    .inline {
    	display:inline-block;
    	margin-right: 5px;
    }
    
    .myform-control {
    display: inline-block;
    width: 30%;
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
    
    #abs {
    	position: absolute;
    	display: inline-block;
    	top: 0px;
    	right: 0px;
    }
    
    #rel {
    	position: relative;
    }
    
  </style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div>
	<div class="col-sm-2 sidenav">      
    </div>
	<div id="mainBox" class="container col-sm-8">
	  <h2><span class="glyphicon glyphicon-question-sign"></span> QnA</h2>
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th>Subject</th>
	        <th>Writer</th>
	        <th>CreateDate</th>
	      </tr>
	    </thead>
			<c:choose>
				<c:when test="${not empty qnaVOList}">
				    <c:forEach items = "${qnaVOList}" var = "qnaVO">
					    <tbody>
					      <tr>
					        <td>
					        	<c:choose>
					        		<c:when test="${qnaVO.isDelete eq 'Y'}">
					        			<div>
					        				삭제된 게시글입니다.
					        			</div>
					        		</c:when>
					        		<c:otherwise>
							        	<a href="/AdvanceBooking/qna/detail/${qnaVO.id}?token=${sessionScope._CSRF_TOKEN_}">
								 			${qnaVO.subject}
								 		</a>
					        		</c:otherwise>
					        	</c:choose>
					        </td>
					        <td>
					        	${qnaVO.memberVO.name} (${qnaVO.email})
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
	  <div id="rel">
		<a href="/AdvanceBooking/qna/write" id="abs" class="btn btn-primary" role="button">QnA Write</a>	  
	  </div>
      <div>
		<form id="searchForm" onsubmit="javascript:movePage(0);">
			<ul class="pagination">
				<li>${pagenation}</li>			
			</ul>
			<div>
				<input type="text" name="searchKeyword" class="myform-control inline" value="${qnaSearchVO.searchKeyword}">
				<a href="/AdvanceBooking/qna/list/init" class="btn btn-primary inline" role="button">검색초기화</a>
			</div> 
		</form>
	  </div>
	</div>
	<div class="col-sm-2 sidenav">
    </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>