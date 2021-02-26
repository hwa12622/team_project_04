<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<head>
<script src="/resources/js/jquery-3.5.1.js"></script>
<!-------------타이틀 (페이지 제목)------------->
<title>FreeBoard</title>
<!------------- css 영역------------->  
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>	
/*한글 폰트 적용 (사용법 id="font_1")*/
	#font_1{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>
<script type="text/javascript">
	var request = new XMLHttpRequest();
	function searchFunction(a){

		if (a != '0' && a != '1'){
			console.log(a);
			a = 0;
		}
		console.log(a);
		$.ajax({
			url:"/customer/service/practice",
			data: {'isQnA': a},
			type:"post",
			success:function(result){/* result는 정상적으로 .ajax가 완료 됐을 때 return value*/
				$("#ajaxTable").html(result);
			}
		})
	}
	window.onload = function(){
		searchFunction(0);
	}
</script>
</head>
<body>
<!-------------navbar 네비바------------->
<jsp:include page="../include/navbar.jsp"></jsp:include>

<section class="ftco-section" id="contents-section">
	<div class="container">
		<div class="comment-form-wrap pt-5">
			<!---- 제목 부분 ---->
			<div class="row justify-content-center pb-5">
				<div class="col-md-12 heading-section text-center ftco-animate">
					<!--대분류-->
					<span class="subheading">contents</span>
					<!--소분류 영어-->
					<h2 class="mb-4">FreeBoard</h2>
					<!--소분류 한글 -->
					<p id="font_1">자유게시판</p>
					<!-- 버튼 -->						
					<a id="font_1" href="index#" class="btn btn-primary px-5 py-8 mt-1"> New Post</a>				
				</div>
			</div>	
										
			<!-- 자유게시판 테이블-->
			<div class="board_list_wrap">			
				<!-- category 카테고리 -->	
				<h3 class="heading-sidebar">Select Category</h3>
				<div class="tagcloud">
					<a id="font_1" onclick="searchFunction(0);" class="tag-cloud-link">Q&A</a>
					<a id="font_1" onclick="searchFunction(1);" class="tag-cloud-link">F&A</a>
				</div>
				<!-- 테이블 -->
				<table class="board_list">
					<thead>
						<tr>
							<th>No.</th>
							<th>Title</th>
							<th>Writer</th>
							<th>Date</th>
						</tr>
					</thead>
					<tbody style="font-weight:bold; color: black;">
						<tr>
							<td style="color: purple;">Notice</td>
							<td><a href="/customer/service/detail">공지제목</a></td>
							<td>admin</td>
							<td>날짜</td>
						</tr>
					</tbody>					
					<tbody id="ajaxTable">

					</tbody>
				</table>
			</div>
					
			<!-- 페이징 처리 -->
			<div class="row mt-5">	
				<div class="col text-center">
					<div class="block-27">
						<ul>
							<c:choose>
								<c:when test="${startPageNum ne 1 }">
									<li>
										<a href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">&lt;</a>
									</li>
								</c:when>
							<c:otherwise>
								<li>
									<a href="javascript:">&lt;</a>
								</li>
							</c:otherwise>
							</c:choose>
							
							<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
								<c:choose>
									<c:when test="${i eq pageNum }">
										<li class="active">
											<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
										</li>
									</c:when>
									<c:otherwise>
										<li>
											<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:choose>
								<c:when test="${endPageNum lt totalPageCount }">						
									<li>
										<a href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">&gt;</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="javascript:">&gt;</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
			</div><!-- 페이징처리 -->
			<br>
			<!--검색 Search -->
			<div class="form-group">
				<form action="list.do" method="get" class="search-form">				
					<input id="font_1" class="form-control" type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
					<button class="btn btn-primary px-5 py-8 mt-1" type="submit">Search</button>		
				</form>
			</div>
			<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
			<c:if test="${not empty keyword }">
				<div class="alert alert-success">
					<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
				</div>
			</c:if>
		</div>
	</div><!-- container -->
</section>
<!------------- footer ------------->    
<jsp:include page="../include/footer.jsp"></jsp:include>   
 
<!-------------script 스크립트------------->
<jsp:include page="../include/resource_script.jsp"></jsp:include>
</body>
</html>