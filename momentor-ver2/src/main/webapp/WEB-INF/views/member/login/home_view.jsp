<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- DatePicker(jQuery UI) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">

<!-- FullCalendar(jQuery API) -->
<link href='${initParam.root}fullcalendar/fullcalendar.css' rel='stylesheet' />
<script src='${initParam.root}fullcalendar/fullcalendar.js'></script>
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

<script>
   // FullCalnedar
   $(document).ready(function() {
      $('#calendar').fullCalendar({
    	  height: 600,
         dayClick: function(date) { // 날짜 클릭시 알럿.
        	$('#planModal').modal();   
        	var calendarDay = "";				
            if(date.getDate() < 10){
            	calendarDay = "0" + date.getDate()
            } else{
            	calendarDay = date.getDate();
            }
            $("#selectDay").val(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + calendarDay);
         },
         events: function(date){
        	$('#planModal').on('shown.bs.modal', function(){
        		$.ajax({
               		type:"get",
        			url:"my_getPlannerListByDate.do?momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=" + $("#selectDay").val(),
        			success:function(data){
        				var txt = "";
        				$("#showList").html("");
        				for(var i = 0; i < data.length; i++){
        					txt += "<br>" + data[i].exerciseVO.exerciseName;
	        				$("#showList").html(txt);
        					$("#closePlan").click(function(){
            					$("#showList").html("");        						
        					});
        				}
        				if($("#showList").html() == ""){
        					$("#showList").html("등록된 운동이 없습니다!");
    					}
        				if($("#showList").html() == "등록된 운동이 없습니다!"){
        					$("#detailPlan").val("플래너");
        				} else{
        					$("#detailPlan").val("상세보기");
        				}
        			}
               	}); 
        	});   
        	$.ajax({
           		type:"get",
    			url:"my_getPlannerList.do?momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}",
    			success:function(data){	    
    				var d = $('#calendar').fullCalendar("getDate"); 
    	        	var calDay = "";     
    				for(var j = 0; j < 42; j++){
    					var str = "";
    					for(var i = 0; i < data.length; i++){
    						if($("td").children().children().siblings().eq(2*j).text() < 10){
    	    					calDay = "0" + $("td").children().children().siblings().eq(2*j).text();
    	    				} else{
    	    					calDay = $("td").children().children().siblings().eq(2*j).text();
    	    				}
							if(parseInt(calDay) < 15 && parseInt(calDay) >= 1 && j > 28){								
	    						$("td").children().children().children().eq(j).html("");
	    					} else if(parseInt(calDay) <= 31 && parseInt(calDay) > 20 && j < 6){
	    						$("td").children().children().children().eq(j).html("");
	    					}
        					if(d.getFullYear() == data[i].plannerDate.substring(0,4)
        					&& (d.getMonth()+1) == data[i].plannerDate.substring(5,7)
        					&& calDay == data[i].plannerDate.substring(8,10)){
        						str += data[i].exerciseVO.exerciseName + "<br>";
        						$("td").children().children().children().eq(j).html(str);
        					}
        				}
    				}
    			}
           	}); 
         }
      });    
      $("#detailPlanForm").submit(function(){
    	  if($("#detailPlan").val() == "플래너"){
    		  if(confirm("플래너로 이동하시겠습니까?") == false){
    			  return false;
       		  }
    	  } else if($("#detailPlan").val() == "상세보기"){
    		  if(confirm("상세보기로 넘어가시겠습니까?") == false){
        		  return false;
        	  }
    	  }    	  
      });
   });
</script>
<style type="text/css">
#wrap{margin: 0 auto; padding: 20px;}
.calendar_body{width: 700px; float: center; margin-left: 150px;}
</style>
<body>
<div class="row marketing">
	<div class="col-md-6">
		
		<div class="table-responsive">
			<table class="table table-hover">
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
				<tr><td colspan="6" ><h4>커뮤니티 게시판 추천수 TOP5!</h4></td></tr>
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
							
							<td><a href="${initParam.root }my_getCommunityByNo.do?boardNo=${list.boardNo}">
							<c:choose>
							<c:when test="${fn:length(list.boardTitle)>6 }">
							${fn:substring(list.boardTitle,0,5)}..
							</c:when>
							<c:otherwise>
							${list.boardTitle }
							</c:otherwise>
							</c:choose></a>
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
   <div id="wrap">
      <!-- FullCalendar body -->
      <div class="calendar_body">
         <div id="calendar"></div>
      </div>
      
      <!-- Input/Output Form -->
      <div class="cal_input_table">
         <form action="./CalendarAdd.cl" method="post">
            <table border="1">
            </table>

         </form>
         <form action="./CalendarDel.cl" method="post">
            <table border="1">
            
            </table>
         </form>
      </div>   
   </div>
   <!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="planModal" tabindex="-1" role="dialog" aria-labelledby="planModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <div class="idFindCheck">
    <div class="modal-content">   
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="planModalLabel">플래너</h4>
      </div>
      <form action="my_planner.do" id="detailPlanForm">
		   <div class="modal-body">	 
		       <input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId}">
		       선택날짜 : <input type="text" class="form-control" name="plannerDate" id="selectDay" readonly><br>
		       <span id="compareExercise">운동목록</span> : <span id="showList"></span>     	   
		   <div class="modal-footer">
		      <button type="button" class="btn btn-default" data-dismiss="modal" id="closePlan">Close</button>
		      <input type="submit" class="btn btn-primary" id="detailPlan">
		   </div>
	      </div>
      </form>
    </div>
    </div>
  </div>
</div>
</body>