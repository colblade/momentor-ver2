<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<center>
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" align="center" style="width: 900px;">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
    <li data-target="#carousel-example-generic" data-slide-to="4"></li>
    <li data-target="#carousel-example-generic" data-slide-to="5"></li>
  </ol>
  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="${initParam.root}image/여자.jpg" alt="여자">
      <div class="carousel-caption">
	    <h3>Beautiful Body</h3>
	    <p>지금은 자기관리 시대</p>
	  </div>
    </div>
    <div class="item">
      <img src="${initParam.root}image/남자.jpg" alt="남자">
      <div class="carousel-caption">
	    <h3>Six Pack</h3>
	    <p>남자들이여 자신감을 가져라</p>
	  </div>
    </div>
    <div class="item">
      <img src="${initParam.root}image/비키니수영복여자.jpg" alt="비키니여자">
      <div class="carousel-caption">
	    <h3>Bikini</h3>
	    <p>여자들이여 당당해져라</p>
	  </div>
    </div>
    <div class="item">
      <img src="${initParam.root}image/남자수영복.jpg" alt="남자수영복">
      <div class="carousel-caption">
	    <h3>Take Off</h3>
	    <p>바닷가에서 당당히 벗어라</p>
	  </div>
    </div>
    <div class="item">
      <img src="${initParam.root}image/남녀조깅.jpg" alt="남녀조깅">
      <div class="carousel-caption">
	    <h3>With You</h3>
	    <p>연인과 즐거운 운동 데이트</p>
	  </div>
    </div>
    <div class="item">
      <img src="${initParam.root}image/단체.jpg" alt="단체">
      <div class="carousel-caption">
	    <h3>Together</h3>
	    <p>함께 운동하며 공유하며</p>
	  </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
</center>
<script>
	$(".carousel").carousel({
		interval: 2000
	});
</script>

<div class="row marketing">
	<div class="col-md-6">	
		<div class="table-responsive">
			<table class="table table-hover" >
				<thead>
				<tr><td colspan="6" ><h4 >운동 게시판 조회수 TOP5!</h4></td></tr>
					<tr>
						<th colspan="3" align="center">타이틀</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회</th>
					</tr>
				</thead>
				<tbody >
					<c:forEach items="${requestScope.exerciseTop5List }" var="list">
						<tr>
							<td>${list.ranking }</td>
							<td><a
								href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}&pageNo=${param.pageNo}">
								<c:choose>
								<c:when test="${fn:length(list.boardTitle)>6 }">
								${fn:substring(list.boardTitle,0,5)}..
								</c:when>
								<c:otherwise>
								${list.boardTitle}
								</c:otherwise>
								</c:choose>
								</a></td>
							<td>${list.exerciseVO.exerciseName }</td>
							<td>관리자</td>
							<td>${list.boardWdate }</td>
							<td style="text-align: center;">${list.exerciseHits }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<div class="col-md-6">
		
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
				<tr><td colspan="6" ><h4 >커뮤니티 게시판 추천수 TOP5!</h4></td></tr>
					<tr>

						<th colspan="2">타이틀</th>
						<th>작성자</th>
						<th>추천수</th>
						<!-- <th>비추천수</th> -->
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${requestScope.communityTop5List }" var="list" varStatus="vs">
					<c:choose>
					<c:when test="${vs.index<5 }">
					
						<tr>
							<td>${list.ranking }</td>
							
							<td>
							<c:choose>
							<c:when test="${fn:length(list.boardTitle)>6 }">
							${fn:substring(list.boardTitle,0,5)}..
							</c:when>
							<c:otherwise>
							${list.boardTitle }
							</c:otherwise>
							</c:choose>
							</td>
							<td>${list.momentorMemberVO.nickName }</td>
							<td style="text-align: center;">${list.recommend }</td>
							<%-- <td>${list.notRecommend }</td> --%>
							<td>${list.boardWdate }</td>
							<td style="text-align: center;">${list.memberHits }</td>
						</tr>
					</c:when>
					<c:otherwise></c:otherwise>
					</c:choose>

					</c:forEach>
				</tbody>
			</table>
		</div>
	
	</div>
	
	

</div>
  
</body>