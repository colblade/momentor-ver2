<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <script type="text/javascript">
       $(document).ready(function(){
             $("#writeBtn").click(function(){
                location.href="my_writeForm.do";
             });
             //커뮤니티게시판 리스트에서 회원들이 회원 목록 보는 모달 스크립트
             $(".detailedModal") .click(function(){
            	 $.ajax({
            		  type:"get",
         		      url:"getMemberInfoByNickName.do",            
         		      data:"momentorMemberVO.nickName="+$(this).text().trim(),
         		      success:function(data){                  
         		    	  var memInfoComp = data.momentorMemberVO;
         		    	  var blindMemId = "";
         		    	  blindMemId = memInfoComp.memberId.replace(memInfoComp.memberId.substring(2,(memInfoComp.memberId.length+1)),"***");
         		    	  if(memInfoComp.memberName.length == 2){
         		    		 blindName = memInfoComp.memberName.replace(memInfoComp.memberName.substring(1,(memInfoComp.memberName.length+1)),"*");
         		    	  } else{
	        		    	  blindName = memInfoComp.memberName.replace(memInfoComp.memberName.substring(1,(memInfoComp.memberName.length+1)),"**");
         		    	  }
         		    	  var memInfoView = "ID : " + blindMemId + "<br>" + 
         		    	  									"이름 : " + blindName + "<br>" +
         		    	  									" 키 : " + data.memberHeight + "<br>" + 
         		    	  									" 몸무게 : " + data.memberWeight + "<br>" +
         		    	  									" BMI : " + data.bmi + "<br>" +
         		    	  									" 나이 : " + data.age + "<br>" +
         		    	  									" 닉네임 : " + memInfoComp.nickName + "<br>";
         		    	  if(memInfoComp.infoPublic==1){
         		    	 $("#detailedView").html(memInfoView);
         		   	 $("#memberInfoView").html(memInfoComp.nickName + "님 회원정보");
         		    	  }else if(memInfoComp.infoPublic==2){
         		    		 $("#detailedView").html("이 회원은 정보가 비공개 처리되었습니다.");
         		    		 $("#memberInfoView").html(memInfoComp.nickName + "님 회원정보");
         		    	  }		    
         		      }
            	 });
            	 $("#detailedModalView").modal(); 
             });
          });
    </script>
<h2 class="sub-header">Community</h2>
<div class="table-responsive">
 <table class="table table-striped">
  <thead>
  <tr>
    <th>No</th>
    <th>타이틀</th>
    <th>글쓴이</th>
    <th>작성일</th>
    <th>조회수</th>
    <th>추천수</th>
  </tr>
  </thead>
  <tbody>
<c:forEach items="${requestScope.list.list}" var="posting"  varStatus="vs">
   <tr>
      <td>${posting.boardNo }</td>
      <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${posting.boardTitle}</td>
         </c:when>
      <c:otherwise>
         	<td>
         		<c:forEach items="${requestScope.replyCountList }" var="replyCountList">
         			<c:if test="${posting.boardNo == replyCountList.BOARDNO}">
	         			<c:choose>
		         			<c:when test="${replyCountList.REPLYCOUNT > 0}">
		         				<a href="my_getCommunityByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle} (${replyCountList.REPLYCOUNT})</a>
		         			</c:when>
		         		<c:otherwise>
		         				<a href="my_getCommunityByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle}</a>
		         		</c:otherwise>
		         		</c:choose>
	         		</c:if>
         		</c:forEach>
         	</td>
         </c:otherwise>
      </c:choose>
          <c:choose>
         <c:when test="${sessionScope.pnvo==null}">
            <td>${posting.momentorMemberVO.nickName}</td>
         </c:when>
         <c:when test="${posting.momentorMemberVO.auth==1}">
     				    <td>${posting.momentorMemberVO.nickName}</td>
         </c:when>
         <c:otherwise><td><a href="#"  class="detailedModal">${posting.momentorMemberVO.nickName}</a></td>
         <input type="hidden" id = "count" value = "${vs.count }"> 
         </c:otherwise>
      </c:choose>
      <td>${posting.boardWdate}</td>
      <td>${posting.memberHits}</td>
      <td>${posting.recommend}</td>
  	  </tr>
</c:forEach>
</tbody>
</table>
</div>
<div align="center">
<nav>
<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
     <ul class="pagination"> 
     <c:if test="${pb.previousPageGroup}">   
       <li>
         <a href="showCommunityList.do?pageNo=${pb.startPageOfPageGroup-1}"
         aria-label="Previous"><span aria-hidden="true">&laquo;</span>
         </a>   
       </li>
     </c:if>
     <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
         <c:choose>
            <c:when test="${pb.nowPage!=i}">
            <li>
               <a href="showCommunityList.do?pageNo=${i}">${i}</a>
            </li> 
            </c:when>
            <c:otherwise>
            <li class="active">
                 <span>${i}</span>
             </li>
           </c:otherwise>
         </c:choose>          
      </c:forEach>
       <c:if test="${pb.nextPageGroup}">
       <li>
         <a href="showCommunityList.do?pageNo=${pb.endPageOfPageGroup+1}"
         aria-label="Next">
         <span aria-hidden="true">&raquo;</span>
         </a>
       </li>
      </c:if>
     </ul>
   </nav>
</div><br>
<c:if test="${sessionScope.pnvo != null}"> 
<div class="clearfix">
    <span class="btn-group"></span>
    <div class="pull-right">
        <a href="${initParam.root}my_writeForm.do" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> 글쓰기</a>   
    </div>
</div>
</c:if>
<hr>
<center>
<form class="form-inline" action="member_searchByCommunityBoard.do" id="cbSeachForm">
  <div class="form-group">
        <select name="searchType" class="form-control input-sm">
		<option value="cbTitle">제목</option>
		<option value="mNickName">닉네임</option>
	</select>
  </div>
  <div class="form-group">
  	<input type="text" name="searchWord" class="form-control" placeholder="검색어를 입력하세요">
  </div>
  <button type="submit" class="btn btn-primary">검색</button>
</form>
</center>
<!-- Modal -->
<div class="modal fade" id="detailedModalView" tabindex="-1" role="dialog" aria-labelledby="idModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <div class="idFindCheck">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="idModalLabel"><span id="memberInfoView"></span></h4>
      </div>
      <div class="modal-body">
  	  <span id="detailedView"></span>
    </div>
  </div>
  </div>
  </div>
</div>