<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		alert("QNA 작성이 완료되었습니다.");
		location.href="${initParam.root}member_getAllQNAList.do";
	});
</script>
