<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		alert("공지사항 글 작성이 완료되었습니다.");
		location.href="${initParam.root}member_getAllNoticeList.do";
	});
</script>
