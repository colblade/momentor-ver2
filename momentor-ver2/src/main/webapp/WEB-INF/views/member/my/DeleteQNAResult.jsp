<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		alert("QNA 글이 삭제되었습니다");
		location.href="${initParam.root}member_getAllQNAList.do";
	});
</script>