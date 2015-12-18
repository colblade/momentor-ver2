<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#noticeUpdateBtn").click(function(){
		if(confirm("공지사항을 수정하시겠습니까?")){
    		location.href="admin_noticeUpdateForm.do?noticeNo=${requestScope.nvo.boardNo}";			
		}
	});

	$("#noticeDeleteBtn").click(function(){
		if(confirm("공지사항을 삭제하시겠습니까?")){
    		location.href="admin_noticeDelete.do?noticeNo=${requestScope.nvo.boardNo}";			
		}
		
	}); 
});
</script>
<div class="container">
	<div class = "row">
		<div class = "col-sm-8 blog-main">
			<div class="blog-post">
				<br><br>
				<c:set value="${requestScope.nvo}" var ="notice"></c:set>
				<h2 class="blog-post-title">${notice.boardTitle }</h2>
				<hr>
				<p class="blog-post-meta">${notice.boardWdate} by <a href="#">관리자</a></p>
				<hr>	
				<pre>${notice.boardContent }</pre>
				<br><br><br>
				<hr>
				<nav>
					<ul class="pager">
						<c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">	
							<li id="noticeUpdateBtn"><a href="#">수정하기</a></li>
							<li id="noticeDeleteBtn"><a href="#">삭제하기</a></li>
						</c:if>
						<li><a href="${initParam.root}member_getAllNoticeList.do">목록보기</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
