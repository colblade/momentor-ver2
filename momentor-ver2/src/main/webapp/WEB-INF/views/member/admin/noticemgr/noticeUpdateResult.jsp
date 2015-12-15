<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <div class="container">
<div class = "row">
<div class = "col-sm-8 blog-main"><div class="blog-post">
 <br><br>
<c:set value="${requestScope.nvo}" var ="notice"></c:set>


<h2 class="blog-post-title">${notice.boardTitle }</h2>
            <hr>
            <p class="blog-post-meta">${notice.boardWdate}
               by <a href="#">관리자</a>  
            </p>
	<hr>	
            <pre>${notice.boardContent }</pre>
            <br><br><br>
            <hr>
</div>

</div>

</div>
</div>
<nav>
<ul class = "pager">


	<li><a href="${initParam.root}login_home.do">홈으로</a></li>
	<li><a href="${initParam.root}member_getAllNoticeList.do">목록으로</a></li>
</ul>
</nav>