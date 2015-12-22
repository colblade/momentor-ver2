<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {

//이름 중복검사
$("#exerciseName").keyup(function(){
if ($.trim($(this).val()) == "") {
	$("#result").html("운동을 입력하세요")
			.css("background", "pink");
	return false;
}
	$.ajax({
		type : "get",
		url : "checkExerciseName.do?exerciseName="+ $.trim($("#exerciseName").val()),
		success : function(data) {
			if (data == "false") {
				$("#result").html(data).css("background","pink");
				return false;
			} else {
				$("#result").html(data).css("background","yellow");
			}
		}//success
	});//ajax
})//keyup

//유효성 검사
$("input[name=boardTitle]").keyup(function(){
    var maxTitleLength=50;
    	if($("input[name=boardTitle]").val().length>=maxTitleLength){
    		alert("제목은 한글 기준 "+maxTitleLength+"자 까지만 가능합니다");
    		$("input[name=boardTitle]").val($("input[name=boardTitle]").val().substring(0,maxTitleLength));
    	return false;
    	} 
});
$("#exerciseForm").submit(function() {
	if ($("#exerciseBody").val == null|| $("#exerciseBody").val() == "") {
		alert("운동 부위를 선택하세요!");
		$(this).focus();
		return false;
	}
	if ($("#result").text() == "false") {
		return false;
	}
})//submit

//목록보기
$("#getExerciseBoardList").click(function() {
	location.href = "${initParam.root}member_exerciseBoard.do?pageNo=1"
});//click

//input file 폼의 갯수+1
var count = 1;

//파일 폼을 추가해준다.
$("#addFileBtn").click(function() {
	if (count > 4) {

		alert("사진은 5개까지 추가할 수 있습니다.");
		$(this).attr("readonly", "readonly");
		return;
	}
	$("#fileSpan").append(
			"<input type = 'file' name = 'file["+count+"]'>");
	count++;
})//click
})//ready
</script>

<div class="col-md-6">
	<form id="exerciseForm" method="post" action="${initParam.root }admin_postingExerciseByAdmin.do" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId }">
		<div class="form-group">
			<label for="boardTitle" class="col-sm-2 control-label"> 제목 : </label>
			<div class="col-sm-10">
				<input type="text" name="boardTitle" placeholder="제목을 입력하세요." required="required" size="40" class="form-control">
			</div>
		</div>

		<div class="form-group">
			<label for="exerciseName" class="col-sm-2 control-label"> 운동명 : </label>
			<div class="col-sm-10">
				<input type="text" id="exerciseName" name="exerciseName" placeholder="운동이름을 입력하세요." required="required" size="40" class="form-control">
				<span id="result"></span>
			</div>
		</div>
		
		<div class="form-group">
			<label for="urlPath" class="col-sm-2 control-label"> URL : </label>
			<div class="col-sm-10">
				<input type="text" id="urlPath" name="urlPath" placeholder="운동 영상 주소를 넣어주세요(있을시만)" size="40" class="form-control">
			</div>
		</div>
		
		<div class="form-group">
			<label for="exerciseContent" class="col-sm-2 control-label"></label>
			<div class="col-sm-10">
				<input type="file" name="file[0]"><span id="fileSpan"></span><br>
				<input type="button" value="사진추가하기" id="addFileBtn" class="btn btn-primary"><br><br>
				<select name="exerciseBody"
					id="exerciseBody" class="form-control">
					<option value="">운동부위를 선택하세요</option>
					<option value="상체">상체</option>
					<option value="하체">하체</option>
					<option value="전신">전신</option>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="boardContent" class="col-sm-2 control-label">내용 :</label>
			<div class="col-sm-10">
				<textarea style="width: 500px; font-size: 15px; resize:none" rows="20" wrap="hard" placeholder="내용을 입력하세요." required="required" name="boardContent" class="form-control"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<div class="clearfix">
				    <span class="btn-group"></span>
				    <div class="pull-right">
				    	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
						<input type="button" value="되돌아가기" id="getExerciseBoardList" class="btn btn-primary">
				    </div>
				</div>
			</div>
		</div>
	</form>
</div>