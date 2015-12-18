<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script src="${initParam.root}dist/js/jquery.easy-pie-chart.js"></script>
<link href="${initParam.root}dist/css/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">

<script type="text/javascript">
	$(document).ready(function(){
		// Easy pie charts
        $('.chart').easyPieChart({animate: 1000});
		
		// 플래너에 달성치 등록하기
		// select로 선택된 value(1~targetSet)를 achievement 에 담아야 한다.
		// 실시 button 클릭시 로그인한 사용자의 memberId, 해당 plannerDate, achievement, exerciseName를 담아 보내주어야 한다.
		$("#plannerListTable").on("click", ".achiveBtn", function(){
			var updateAchiveEx = $(this).parent().siblings().next().eq(0).text().trim();
			var achievementValue = $(this).parent().siblings().next().next().find(".exSelect").val();
			if(confirm("등록 후에는 수정/삭제가 불가능합니다.\n등록하시겠습니까?") == false){
				return;
			}
			$.ajax({
				type:"post",
				url:"my_updateAchievementInPlanner.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&exerciseVO.exerciseName="+updateAchiveEx+"&achievement="+achievementValue,
				success:function(result){
					plannerListFunc(result);
				}
			});
		});
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 플래너에 등록된 운동 목표세트 수정하기
		var targetSetVal = "";
		$("#plannerListTable").on("click", ".updateBtn", function(){
			// 버튼이 '수정' 일때 클릭하면, 목표세트를 text 상자로 만들어 준 후 버튼을 '저장'으로 바꿔준다.
			if($(this).text() == "수정"){
				targetSetVal = $(this).parent().prev().text().trim();
				var updateInput = "<input type='text' class='updateTargetVal' size='2' style='text-align: right' value=" + targetSetVal + ">";
				$(this).parent().prev().html(updateInput);
				$(this).removeClass("btn-default").addClass("btn-primary");
				$(this).html("<font style='font-weight: bold;''>저장</font>");
			} else if($(this).text() == "저장") {
				// 버튼이 '저장' 일때 클릭하면, text 상자의 값으로 update 해준 후 버튼을 '수정'으로 바꿔준다.
				var updateTargetVal = $(this).parent().prev().find(".updateTargetVal").val();
				var updateTargetEx = $(this).parent().siblings().eq(1).text().trim();
				if(updateTargetVal == "" || updateTargetVal == 0){
					alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
					$(this).parent().prev().find(".updateTargetVal").val("");
					$(this).parent().prev().find(".updateTargetVal").focus();
					return;
				}
				// 기존의 목표세트에서 값이 수정되었을때만 업데이트 해준다.
				if(targetSetVal != updateTargetVal){
					$.ajax({
						type:"post",
						url:"my_updateTargetSetInPlanner.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&exerciseVO.exerciseName="+updateTargetEx+"&targetSet="+updateTargetVal,
						success:function(result){
							plannerListFunc(result);
						}
					});
					alert("수정되었습니다.");
				} else {
					$(this).parent().prev().html(targetSetVal);
				}
				$(this).removeClass("btn-primary").addClass("btn-default");
				$(this).html("<font style='font-weight: bold;''>수정</font>");
			}
		});
		// 목표세트 수정에서 숫자외의 문자를 입력시 공백으로 초기화
		$("#plannerListTable").on("keyup", ".updateTargetVal", function(){
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
			// 목표 set 입력이 0 으로 시작되지 못하도록
			if($(this).val().substring(0, 1) == 0){
				$(this).val($(this).val().replace(0, ""));
			}
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 플래너에 등록된 운동 리스트에서 삭제하기
		$("#plannerListTable").on("click", "#deleteBtn", function(){
			var deleteCheckComp = $("#listBody :input[name='deleteCheck']:checked");
			if(deleteCheckComp.length == 0){
				alert("삭제할 운동을 선택하세요.");
				return;
			}
			if(confirm("삭제하시겠습니까?") == false){
				return;
			}
			if(parseInt($(".panel-heading").text().substring(0, 10).replace(/-/g, "")) < parseInt(todayVal.replace(/-/g, ""))){
				alert("지나간 날의 운동은 삭제할 수 없습니다.");
				return;
			}
			var deleteCheckCompArray = "";
			for(var i=0; i<deleteCheckComp.length; i++){
				deleteCheckCompArray += "&exerciseVO.exerciseName="+$(deleteCheckComp[i]).val();
			}
			$.ajax({
				type:"post",
				url:"my_deleteExerciseInPlanner.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}"+deleteCheckCompArray,
				success:function(result){
					plannerListFunc(result);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 임시 목표 set에 숫자외의 문자를 입력시 공백으로 초기화
		$("#cartListTable").on("keyup", "#tempTargetSet", function(){
				$(this).val($(this).val().replace(/[^0-9]/gi, ""));
				// 임시 목표 set 입력이 0 으로 시작되지 못하도록
				if($(this).val().substring(0, 1) == 0){
					$(this).val($(this).val().replace(0, ""));
				}
		});
		// 선택 열(tr) 클릭시 radio checked
		$("#cartListTable").on("click", "#cartListBody tr", function(){
			var selectExName = $(this).children().eq(3).text();
			$("input:radio[name=tempExerciseName]:radio[value='" + selectExName + "']").prop("checked", true);
		});
		// 찜 리스트에서 임시 등록란으로 올리기
		$("#cartListTable").on("click", "#selectExerciseBtn", function(){
			var selectExercise = $(":input[name=tempExerciseName]:checked").val();
			var targetSet = $("#tempTargetSet");
			if(selectExercise == undefined){
				alert("운동을 선택하세요.");
				return;
			}
			if(targetSet.val() == "" || targetSet.val() == 0){
				alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
				targetSet.val("");
				targetSet.focus();
				return;
			}
			$("#exerciseName").val(selectExercise);
			$("#targetSet").val(targetSet.val());
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 찜 카트 내 운동 삭제하기
		$("#cartListTable").on("click", ".deleteInCartBtn", function(){
			var deleteExcerciseName = $(this).parent().siblings().eq(3).text().trim();
			if(confirm("삭제하시겠습니까?") == false){
				return;
			}
			$.ajax({
				type:"get",
				url:"my_deleteExcerciseInCart.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&exerciseBoardVO.exerciseVO.exerciseName="+deleteExcerciseName,
				dataType:"json",
				success:function(cartListResult){
					// 찜 카트가 비어있지 않을때만 table의 틀 출력
					var cartTableFrame = "<div class='panel panel-primary'>" + 
													"<div class='panel-heading'><h4>찜 바구니</h4></div>" + 
													"<div class='panel-body'>찜 된 운동이 없습니다.</div></div>";
					if(cartListResult.cartList.length != 0){
						cartTableFrame = "<div class='panel panel-primary'>" + 
												"<div class='panel-heading'><h4>찜 바구니&nbsp;&nbsp;" + 
												"<a id='collapseBtn' data-toggle='collapse' href='#collapse1'><i class='glyphicon glyphicon-chevron-up' style='color: white'></i></a></h4></div>" + 
												"<div id='collapse1' class='panel-collapse collapse in'>" + 
												"<div class='panel-body'>" +
												"<table class='table table-hover cartTable'>" + 
												"<thead><tr><th>선택</th><th>번호</th><th colspan='2'>운동명</th><th>삭제</th></tr></thead>" + 
												"<tbody id='cartListBody'>";	
						 $.each(cartListResult.cartList, function(index1, list){
							var exName = list.exerciseBoardVO.exerciseVO.exerciseName;
							var exImg = "";
							$.each(cartListResult.imgCartList, function(index2, imgMap){
								$.map(imgMap, function(value, key){
									if(key == exName){
										// 운동 이미지를 한장만 불러오기 위해 0번째 index의 이미지만 지정
										exImg += "<img src = '${initParam.root}exerciseimg/" + value[0].EXERCISENAME + "_" + value[0].IMGNAME + "' style='width: 50px; height: 50px;'>";
									}
								});
							});
							cartTableFrame += "<tr><td><input type='radio' name='tempExerciseName' value=" + exName + "></td>" + 
																"<td>" + (index1+1) + "</td>" + 
																"<td>" + exImg + "</td>" + 
																"<td>" + exName + "</td>" + 
																"<td><button type='button' class='deleteInCartBtn btn btn-warning btn-sm'><i class='glyphicon glyphicon-trash' aria-hidden='true'></i><font style='font-weight: bold;'> 삭제</font></button></td></tr>";
						});
						cartTableFrame += "<tr><td colspan='5'>목표 세트 <input type='text' name='tempTargetSet' id='tempTargetSet' style='text-align: right'>" + 
													" <input type='button' id='selectExerciseBtn' value='선택'></td></tr>" + 
													"</tbody></table></div></div></div>";
					}
					$("#cartListTable").html(cartTableFrame);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 목표 set에 숫자외의 문자를 입력시 공백으로 초기화
		$("#targetSet").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
			// 목표 set 입력이 0 으로 시작되지 못하도록
			if($(this).val().substring(0, 1) == 0){
				$(this).val($(this).val().replace(0, ""));
			}
		});
		// 임시등록란에서 플래너로 등록하기
		// 플래너에 이미 등록되어 있는지 여부는 DB를 거치지 않고 jQuery로 판단.
		$("#regPlannerBtn").click(function(){
			var regExName = $("#exerciseName").val();
			// 임시등록란이 비어있는지 확인
			if(regExName == ""){
				alert("임시등록된 운동이 없습니다.");
				return;
			}
			if($("#targetSet").val() == "" || $("#targetSet").val() == 0){
				alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
				$("#targetSet").val("");
				$("#targetSet").focus();
				return;
			}
			// 선택일이 오늘보다 이전일 경우 플래너에 등록이 불가능하도록 한다.
			if(parseInt($(".panel-heading").text().substring(0, 10).replace(/-/g, "")) < parseInt(todayVal.replace(/-/g, ""))){
				alert("지나간 날은 등록할 수 없습니다.");
				$("#exerciseName").val("");
				$("#targetSet").val("");
				return;
			}
			// listBody의 자식(td)에 등록하려는 운동이 이미 있는지 확인한다.
			// 두번째 td에 선택한 운동이 포함되어 있는지 확인
			var checkExName = $("#listBody tr td:nth-child(2)").filter(":contains('"+regExName+"')");
			if(checkExName.length == 1){
				alert("이미 등록된 운동입니다.");
				$("#exerciseName").val("");
				$("#targetSet").val("");
				return;
			}
			$.ajax({
				type:"post",
				url:"my_registerInPlanner.do",
				// data로 memberId, exerciseName, plannerDate, targetSet 를 보내주어야 함.
				data:"exerciseVO.exerciseName=" + $("#exerciseName").val() + "&targetSet=" + $("#targetSet").val() + "&momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}",
				success:function(result){
					$("#exerciseName").val("");
					$("#targetSet").val("");
					plannerListFunc(result);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 코멘트 textarea 영역 보이기/감추기 제어
		var compareComment = "";
		$("#commentView").hide();
		$("#commentBtn").click(function(){
			$("#commentView").toggle(function(){
				if(($("#commentView").css("display")=="none")){ // textarea가 보이지 않을때(닫힐때)
					$("#commentBtn").html("<font style='font-weight: bold;'>코멘트 </font><i class='glyphicon glyphicon-resize-full' aria-hidden='true'></i>");
					$("#commentIcon").html("<i class='glyphicon glyphicon-resize-full' aria-hidden='true'></i>");
					// 특수문자도 입력이 가능하도록 encoding 한다.
					var commentComp = encodeURIComponent($("#commentArea").val());
					// 코멘트 내용이 변경되지 않았을 경우에는 그냥 닫아준다.
					if($("#commentArea").val() == compareComment){
						return;
					}
					// 저장버튼 클릭시 코멘트 등록/수정
					$.ajax({
						type:"post",
						url:"my_updateCommentInPlanner.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&plannerContent="+commentComp,
						success:function(){
							alert("코멘트가 등록되었습니다.");
						}
					});
				} else { // textarea가 보일때(열릴때)
					$("#commentBtn").html("<font style='font-weight: bold;'>저장</font> <i class='glyphicon glyphicon-resize-small' aria-hidden='true'></i>");
					// 코멘트버튼 클릭시 등록되어있는 코멘트 보여주기
					$.ajax({
						type:"post",
						url:"my_getPlannerContentByDate.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}",
						success:function(result){
							var Ca = /\+/g;
							// jquery ajax 에서 controller로 부터 받을때 디코딩 처리
							var plannerContent = decodeURIComponent(result.replace(Ca, " ")); // 공백문자(" ")가 "+"로 출력되므로 replace를 통해 변환
							$("#commentArea").val(plannerContent);
							compareComment = plannerContent;
						}
					});
				}
			});
		});
		
		// 플래너 리스트의 전체선택 체크박스
		$("#plannerListTable").on("change", ":input[name=allCheck]", function(){
			var flag = $(this).prop("checked");
			$(":input[name=deleteCheck]").prop("checked", flag);
		});
		
		// 운동 상세보기 modal
		$("#plannerListTable").on("click", ".exViewModal", function(){
			$.ajax({
				type:"post",
				url:"my_getExerciseInfoByExName.do",
				data:"exerciseVO.exerciseName=" + $(this).text().trim(),
				success:function(result){
					var showExeciseInfoComp = "<h2>" + result.exerciseInfo.exerciseVO.exerciseName + "</h2><hr>";
					$.each(result.nameList, function(index, fileName){
						showExeciseInfoComp += "<img src='${initParam.root}exerciseimg/" + fileName.EXERCISENAME + "_" + fileName.IMGNAME + "' title='" + fileName.IMGNAME + "' style='width: 70%; height: 70%;'>"
					});
					if(result.URLVideo != null){
						showExeciseInfoComp += "<br><br><dd class='url'>" + 
															"<iframe src='" + result.URLVideo.URLPATH + "' type='application/x-shockwave-flash' width='570' height='356'></iframe>" + 
															"</dd>";
					}
					showExeciseInfoComp += "<h3>" + result.exerciseInfo.boardTitle + "</h3>" + 
														"<br><pre>" + result.exerciseInfo.boardContent + "</pre><br>";
					$("#showExeciseInfo").html(showExeciseInfoComp);
				}
			});
			$("#exView").modal();
		});
		
		// 찜 바구니 접기/펴기 시 아이콘 변경
        $("#cartListTable").on("click", "#collapseBtn", function(){
			if($(this).parent().parent().next().children().is(":visible")){
				$('i', $(this)).removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
			}else{
				$('i', $(this)).removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
			}
		});
		
	});
		
	// 임시등록 되어있는 운동이 있는데 페이지를 벗어나려 할 때 사용자에게 알림
	$(window).on("beforeunload", function(){
		if($("#exerciseName").val() != ""){
			return "임시등록 되어있는 운동이 있습니다.";
		}
	});
	
	// 오늘의 년월일 구하기
	var now = new Date();
	var year= now.getFullYear();
	var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	var todayVal = year + '-' + mon + '-' + day;
	
	// 플래너에 등록, 플래너에서 삭제, 달성 시 플래너 리스트를 출력하는 공통 function
	function plannerListFunc(result){
		var listTableFrame = "<div class='panel panel-primary'>" + 
										"<div class='panel-heading'><h4>" + result.selectDate + "</h4></div>" + 
										"<div class='panel-body'>등록된 운동이 없습니다.</div></div>";
		if(result.plannerList.length != 0){
			listTableFrame = "<div class='panel panel-primary'>" + 
									"<div class='panel-heading'><h4>" + result.selectDate + "</h4></div>" + 
									"<div class='panel-body'>" + 
									"<table class='table table-bordered plannerTable'>" + 
									"<thead><tr><th><input type='checkbox' name='allCheck'></th><th>운동명</th><th>달성세트</th><th colspan='2'>목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>" + 
									"</tr></thead><tbody id='listBody'>";
				$.each(result.plannerList, function(index, list){
					listTableFrame += "<tr>";
					listTableFrame += "<td><input type='checkbox' name='deleteCheck' value=" + list.exerciseVO.exerciseName + "></td>" + 
												"<td><a href='#' class='exViewModal'>" + list.exerciseVO.exerciseName + "</a></td>";
					if(list.achievement != 0){
						listTableFrame += "<td>" + list.achievement + "</td>";
					} else {
						// 선택한 날짜와 오늘을 비교하여 오늘일때만 달성버튼 활성화
						if(todayVal == list.plannerDate){
							var selectTable = "";
							for(var i=1; i<list.targetSet+1; i++){
								selectTable += "<option value=" + i + ">" + i + "</option>";
							}
							listTableFrame += "<td><select class='exSelect'>" + selectTable + "</select> " + 
														"<button type='button' class='achiveBtn btn btn-primary btn-xs'><font style='font-weight: bold;'>달성</font></button></td>";
						} else {
							listTableFrame += "<td>" + list.achievement + "</td>";
						}
					}
					// 선택한 날짜와 오늘을 비교하여 오늘보다 이후일때만 수정버튼 활성화
					// 기존 yyyy-MM-dd 형태의 날짜에서 '-' 를 제거한 후 숫자형으로 변환
					if(parseInt(list.plannerDate.replace(/-/g, "")) > parseInt(todayVal.replace(/-/g, ""))){
						listTableFrame += "<td>" + list.targetSet + "</td><td><button type='button' class='updateBtn btn btn-default btn-xs'><font style='font-weight: bold;'>수정</font></button></td>";
					} else {
						listTableFrame += "<td colspan='2'>" + list.targetSet + "</td>";
					}
					listTableFrame += "<td><center><div class='chart' data-percent='" + list.achievementPercent + "'>" + list.achievementPercent + "%</div></center></td>";
					if(index == 0){
						listTableFrame += "<td style='vertical-align: middle' rowspan=" + result.plannerList.length + ">" + "<center><div class='chart' data-percent='" + list.achievementPercentDay + "'>" + list.achievementPercentDay + "%</div></center></td>" + 
													"<td style='vertical-align: middle' rowspan=" + result.plannerList.length + ">" + "<center><div class='chart' data-percent='" + list.achievementPercentMonth +  "'>" + list.achievementPercentMonth + "%</div></center></td>";
					}
					listTableFrame += "</tr>";
				});
				listTableFrame += "</tbody></table></div></div>" + 
											"<button type='button' id='deleteBtn' class='btn btn-warning btn-sm'><i class='glyphicon glyphicon-trash' aria-hidden='true'></i><font style='font-weight: bold;'> 선택 삭제</font></button>";
		}
		$("#plannerListTable").html(listTableFrame);
		
		// Easy pie charts
        $('.chart').easyPieChart({animate: 1000});
		
	}
	
</script>


<!-- 플래너에 등록된 운동 목록 -->
<span id="plannerListTable">
<c:choose>
	<c:when test="${requestScope.plannerListByDate.size() != 0}">
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>${requestScope.selectDate}</h4></div>
	<div class="panel-body">
		<table class="table table-bordered plannerTable">
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck"></th>
					<th>운동명</th><th>달성세트</th><th colspan="2">목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>
				</tr>
			</thead>
			<tbody id="listBody">
			<c:forEach items="${requestScope.plannerListByDate}" var="plist" varStatus="status1">
				<tr>
					<td><input type="checkbox" name="deleteCheck" value="${plist.exerciseVO.exerciseName}"></td>
					<td><a href="#" class="exViewModal">${plist.exerciseVO.exerciseName}</a></td>
					<td>
					<c:choose>
						<c:when test="${plist.achievement != 0}">
							${plist.achievement}
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${requestScope.today == requestScope.selectDate}">
									<select class="exSelect">
										<c:forEach begin="1" end="${plist.targetSet}" varStatus="status2">
											<option value="${status2.count}">${status2.count}</option>
										</c:forEach>
									</select>
									<button type="button" class="achiveBtn btn btn-primary btn-xs"><font style="font-weight: bold;">달성</font></button>
								</c:when>
								<c:otherwise>
									${plist.achievement}
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					</td>
					<c:choose>
						<c:when test="${requestScope.intTypeSelectDate > requestScope.intTypeToday}">
							<td>${plist.targetSet}</td><td><button type="button" class="updateBtn btn btn-default btn-xs"><font style="font-weight: bold;">수정</font></button></td>
						</c:when>
						<c:otherwise>
							<td colspan="2">${plist.targetSet}</td>
						</c:otherwise>
					</c:choose>
					<td><center><div class="chart" data-percent="${plist.achievementPercent}">${plist.achievementPercent}%</div></center></td>
					<c:if test="${status1.count == 1}">
						<td style="vertical-align: middle" rowspan="${requestScope.plannerListByDate.size()}"><center><div class="chart" data-percent="${plist.achievementPercentDay}">${plist.achievementPercentDay}%</div></center></td>
						<td style="vertical-align: middle" rowspan="${requestScope.plannerListByDate.size()}"><center><div class="chart" data-percent="${plist.achievementPercentMonth}">${plist.achievementPercentMonth}%</div></center></td>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table></div></div>
		<button type="button" id="deleteBtn" class="btn btn-warning btn-sm"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i><font style="font-weight: bold;"> 선택 삭제</font></button>
	</c:when>
	<c:otherwise>
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>${requestScope.selectDate}</h4></div>
	<div class="panel-body">
		등록된 운동이 없습니다.
	</div></div>
	</c:otherwise>
</c:choose>
</span>

<button type="button" id="commentBtn" class="btn btn-success btn-sm"><font style="font-weight: bold;">코멘트 </font><i class="glyphicon glyphicon-resize-full" aria-hidden="true"></i></button>
<br>
<span id="commentView">
	<textarea cols='100' rows='10' name='commentArea' id='commentArea'></textarea>
</span>
<hr>


<!-- 임시등록란 -->
<div class="panel panel-primary">
<div class="panel-heading"><h4>선택 확인 / 등록</h4></div>
<div class="panel-body">
	목표운동 <input type="text" name="exerciseVO.exerciseName" id="exerciseName" style="text-align: right" size="22" readonly ><br>
	목표세트 <input type="text" name="targetSet" id="targetSet" style="text-align: right" size="12"> set
	<button type="button" id="regPlannerBtn" class="btn btn-primary btn-sm">등록</button>
</div></div> 
<hr>


<!-- 찜한 운동 리스트 -->
<span id="cartListTable">
<c:choose>
	<c:when test="${requestScope.cartList.size() != 0}">
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>찜 바구니&nbsp;&nbsp;<a id="collapseBtn" data-toggle="collapse" href="#collapse1"><i class="glyphicon glyphicon-chevron-down" style="color: white"></i></a></h4></div>
	<div id="collapse1" class="panel-collapse collapse">
	<div class="panel-body">
		<table class="table table-hover cartTable">
			<thead>
				<tr>
					<th>선택</th><th>번호</th><th colspan="2">운동명</th><th>삭제</th>
				</tr>
			</thead>
			<tbody id='cartListBody'>
				<c:forEach items="${requestScope.cartList}" var="clist" varStatus="status1">
				<tr>
					<td><input type="radio" name="tempExerciseName" value="${clist.exerciseBoardVO.exerciseVO.exerciseName}"></td>
					<td>${status1.count }</td>
					<td>
						<c:forEach items="${requestScope.imgCartList}" var ="imgList">
							<c:forEach items="${imgList.get(clist.exerciseBoardVO.exerciseVO.exerciseName) }" var = "map" varStatus="status2">
								<c:if test="${status2.index < 1}">
									<img src = "${initParam.root}exerciseimg/${map.EXERCISENAME}_${map.IMGNAME}" style="width: 50px; height: 50px;">
								</c:if>
							</c:forEach>
						</c:forEach>
					</td>
					<td>${clist.exerciseBoardVO.exerciseVO.exerciseName}</td>
					<td><button type="button" class="deleteInCartBtn btn btn-warning btn-sm"><i class="glyphicon glyphicon-trash" aria-hidden="true"></i><font style="font-weight: bold;"> 삭제</font></button></td>
				</tr>	
				</c:forEach>
			</tbody>
		</table><hr>
			<center>
				<input type="text" name="tempTargetSet" id="tempTargetSet" placeholder="목표세트를 입력하세요" style="text-align: right;">
				<input type="button" id="selectExerciseBtn" class="btn btn-primary btn-sm" value="선택">
			</center>
		</div></div></div>
	</c:when>
	<c:otherwise>
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>찜 바구니</h4></div>
			<div class="panel-body">찜 된 운동이 없습니다.</div>
		</div>
	</c:otherwise>
</c:choose>
</span>


<!-- Modal -->
<div class="modal fade" id="exView" tabindex="-1" role="dialog" aria-labelledby="exViewModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exViewModalLabel">상세보기</h4>
      </div>
      <div class="modal-body">
          <span id="showExeciseInfo"></span>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal" id="closePass">Close</button>
      </div>
    </div>
  </div>
</div>