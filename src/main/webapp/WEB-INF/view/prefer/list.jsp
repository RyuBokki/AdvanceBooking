<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prefer List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/AdvanceBooking/css/bootstrap.min.css">
  <script src="/AdvanceBooking/js/jquery-3.3.1.min.js"></script>
  <script src="/AdvanceBooking/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$().ready(function() {
  		
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
  		
		
  		$('.like').closest('.likeClosest').find('.like').click(function(){
  			
  			var question = confirm("관심 목록에서 제거하시겠습니까?");
  			
  			var preferId = $(this).parent().children('input').val();
  			var token = $('#token').val();
  			var that = this;
  			var url = '/AdvanceBooking/prefer/delete/' + preferId + "?token=" + token;
  			
  			if ( question ) {  				
	  			$.post(url
	  				   , function(response) {
	  				if ( response.isDeleteSuccess ) {
	  					alert("해당 콘서트를 관심 목록에서 제거합니다.");
	  					location.href = "/AdvanceBooking/prefer/list";
	  				}
	  			});			
  			}  			
  		});
  		
  	})
  </script>
  <style type="text/css">
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #ffffff;
      margin-top: 100px;
      height: 100%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    
    #wrapperbox {
		margin-top: 100px;
		margin-bottom: 100px;
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
  </style>
<jsp:include page="/WEB-INF/view/common/navbar.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
    </div>
    <div id="wrapperbox" class="col-sm-8 text-left"> 
      <h2>AdvanceBooking List</h2>
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th>Subject</th>
	        <th>BookingDay</th>
	        <th>Go Interpark</th>
	        <th>Like</th>
	      </tr>
	    </thead>
			<c:choose>
				<c:when test="${not empty preferVOList}">
				    <c:forEach items = "${preferVOList}" var = "preferVO">
					    <tbody>
					      <tr class="likeClosest">
					        <td>
					        	<a href="/AdvanceBooking/concert/detail/${preferVO.concertId}?token=${sessionScope._CSRF_TOKEN_}">
						 			${preferVO.concertVO.subject}
						 		</a>
					        </td>
					        <td id="replace">
					        	${preferVO.concertVO.advanceBookingDay}
					        </td>
					        <td>
					        	<a href="${preferVO.concertVO.advanceBookingUrl}">사전예매</a>
					        </td>
					        <td>
					        	<input type="hidden" value="${preferVO.preferId}">
					        	<a class="like" href="/AdvanceBooking/concert/prefer/delete/${preferVO.preferId}?token=${sessionScope._CSRF_TOKEN_}"><span class="glyphicon glyphicon-heart"></span></a>
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
      <div>
		<form id="searchForm" onsubmit="javascript:movePage(0);">
			<ul class="pagination">
				<li>${pagenation}</li>			
			</ul>
			<div>
				<input type="hidden" id="token" name="token" value="${sessionScope._CSRF_TOKEN_}">
			</div>
			<div>
				<input type="text" name="searchKeyword" class="myform-control inline" value="${preferSearchVO.searchKeyword}">
				<a href="/AdvanceBooking/concert/prefer/list/init" class="btn btn-primary inline" role="button">검색초기화</a>
			</div> 
		</form>
	  </div>
    </div>
    <div class="col-sm-2 sidenav">
    </div>
  </div>
<jsp:include page="/WEB-INF/view/common/mainFooter.jsp"></jsp:include>