<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <script type="text/javascript">
    $(document).ready(function(){
		var checkIdFlag=false;
		var checkNickNameFlag=false;
		var checkPassFlag=false;
		var checkEmailFlag=false;
		var checkNameFlag=false;
		// 로그아웃
		$("#logout").click(function(){
			if(confirm("로그아웃하시겠습니까?")){
				location.href="${initParam.root}/logout.do";
			}
		});
		// 아이디 찾기(이름과 이메일로 인증)
	    $("#findId").click(function(){
	        if($("#nameId").val() == ""){
	           alert("이름을 입력하세요!");
	           return false;
	        } else if($("#mailId").val() == ""){
	           alert("E-mail을 입력하세요!");
	           return false;
	        } else{
		    	$.ajax({
		       		type:"get",
		  			url:"check_idCheck.do?memberName=" + $("#nameId").val() + "&memberEmail=" + $("#mailId").val(),
		            success:function(data){
		            	if(data == ""){
		 					$("#showId").html("일치하는 회원정보가 없습니다!");
		 					$("#nameId").val("");
		 					$("#mailId").val("");
		 					$("#nameId").focus();
		 				} else{
		 					$("#showId").html("회원님의 아이디는 " + "<font color='red'>"+data.memberId + "</font> 입니다.");
		 				}
					}
				});
	        }
		});
		// 모달창에서 닫기 버튼을 누르면 초기화
        $("#closeId").click(function(){
           $("#nameId").val("");
           $("#mailId").val("");
           $("#showId").html("");
        });
		// 비밀번호 찾기(아이디와 이메일로 인증 -> 해당 이메일로 비밀번호 전송)
        $("#findPass").click(function(){
           if($("#idPass").val() == ""){
              alert("아이디를 입력하세요!");
              return false;
           } else if($("#mailPass").val() == ""){
              alert("E-mail을 입력하세요!");
              return false;
           } else{
              $.ajax({
            	  type:"get",
  				url:"check_passCheck.do?memberId=" + $("#idPass").val() + "&memberEmail=" + $("#mailPass").val(),
                 success:function(data){
                	 if(data == ""){
 						$("#showPass").html("일치하는 회원정보가 없습니다!");
 						$("#idPass").val("");
 						$("#mailPass").val("");
 						$("#idPass").focus();
 					} else{
 						$("#showPass").html("회원님의 비밀번호는 " + "<font color='red'>"+data.memberEmail + "</font>로 전송되었습니다.");
 					}
                 }
              });
           }
        });
		// 모달창 닫기 버튼 누르면 초기화
        $("#closeId").click(function(){
           $("#idPass").val("");
           $("#mailPass").val("");
           $("#showPass").html("");
        });
		//회원가입 달력 폼
        $(".datepicker").datepicker({
           dateFormat: 'yy-mm-dd' ,
            changeYear: true ,
           yearRange: "1910:$('#date').val($.datepicker.formatDate($.datepicker.ATOM, new Date()))" 
        });
     $("#site_set").change(function(){
        $("#join_email2").val($("#site_set option:selected").val());
           $("#join_email2").focus();
     });
     $("#back").click(function(){
        location.href="${initParam.root}home.do";
     });
     //아이디 한글 불가
     function chkId(str)
     {
      var reg_Id = /^[a-zA-Z0-9]+$/;
      if(!reg_Id.test(str))
      {
       return false;
      }
      return true;
     }
     //아이디 중복검사
     $("#id").keyup(function(){
    	   var id=$("#id").val().trim();
    	   $('#id').val($('#id').val().trim()); 
    	   if(!chkId($('#id').val().trim())&&id.length<4||id.length>10){
    	      $("#idCheckView").html("아이디는 4자이상 10자 이하에 공백이 없어야 하며 한글은 불가능 합니다.").css(
    	            "color","pink");
    	      checkIdFlag=false;
    	      checkResultId="";
    	      return;
    	   }
    	   
    	   $.ajax({
    	      type:"POST",
    	      url:"idcheck.do",            
    	      data:"idcheck="+$("#id").val(),
    	      success:function(data){                  
    	         if(data=="fail"){
    	         $("#idCheckView").html(id+" 사용불가!").css("color","red");
    	            checkResultId="";
    	            checkIdFlag=false;
    	            return false;
    	         }else{                  
    	            $("#idCheckView").html(id+" 사용가능!").css(
    	                  "color","Lime");      
    	            checkIdFlag=true;
    	            checkResultId=id;
    	      
    	         }               
    	      }      
    	   });
    	});
     	//닉네임 중복검사
    	$("#nick").keyup(function(){
    	   var nick=$("#nick").val().trim();
    	   $('#nick').val($('#nick').val().trim()); 
    	   if(nick.length<2 || nick.length>10){
    	      $("#nickCheckView").html("닉네임은 1자이상 10자 이하여야 함!").css(
    	            "color","pink");
    	      checkResultNick="";
    	      checkNickNameFlag=false;
    	      return;
    	   }
    	   
    	   $.ajax({
    	      type:"POST",
    	      url:"nickNameCheck.do",            
    	      data:"nickName="+$("#nick").val(),
    	      success:function(data){                  
    	         if(data=="fail"){
    	         $("#nickCheckView").html(nick+" 사용불가!").css("color","red");
    	            checkResultId="";
    	            checkNickNameFlag=false;
    	            return false;
    	         }else{                  
    	            $("#nickCheckView").html(nick+" 사용가능!").css(
    	                  "color","Lime");      
    	            checkNickNameFlag=true;
    	            checkResultNick=nick;
    	         
    	         }               
    	      }      
    	   });
    	});
     	//이메일 중복검사
    	$("#emailOverlapping").click(function(){
    		  var memberEmail=$("#email1").val().trim();
    		   var memberEmail2=$("#join_email2").val().trim();
    		 	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    		   if($("#join_email2").val()==""){
    		    	  $("#emailCheckView").html("이메일 주소를 선택해주세요.").css(
    		  	            "color","orange");
    		    	  checkResultEmail="";
    		    	  checkEmailFlag=false;
    			      return;
    		   }
    		  	if(regex.test(memberEmail+"@"+memberEmail2) == false) {
    	    		  $("#emailCheckView").html("잘못된 이메일 형식입니다.").css(
    		                  "color","red");      
    	    		  checkEmailFlag=false;
    	    	 return false;
    	    	} else {
    	    		  $("#emailCheckView").html("");
    	    		  checkEmailFlag=true;
    	    	}
    		   $.ajax({
    		      type:"POST",
    		      url:"emailcheck.do",            
    		      data:"memberEmail="+$("#email1").val()  + "&memberEmail2=" + $("#join_email2").val(),
    		      success:function(data){                  
    		         if(data=="fail"){
    		         $("#emailCheckView").html(memberEmail+"@"+memberEmail2+"사용불가!").css("color","red");
    		         checkResultEmail="";
    		         checkEmailFlag=false;
    		            return false;
    		         }else{                  
    		            $("#emailCheckView").html(memberEmail+"@"+memberEmail2+"사용가능!").css(
    		                  "color","Lime");      
    		            checkEmailFlag=true;
    		            checkResultEmail=memberEmail+"@"+memberemail2;
    		         
    		         }               
    		      }      
    		   });
     });
     //패스워드 영문 숫자 조합
     function chkPwd(str)
     {
      var reg_pwd = /^.*(?=.{6,12})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
      if(!reg_pwd.test(str))
      {
       return false;
      }
      return true;
     }
     // 폼 전송pass
     $("#pass").keyup(function(){
      // 확인 : 비밀번호
      $('#pass').val($('#pass').val().trim()); // javascript를 이용해서 trim() 구현하기 바로가기
      if(!chkPwd($('#pass').val().trim()))
      {
         $("#chkpwd").css("color","red").text("비밀번호를 확인하세요.(영문,숫자를 혼합하여 6~12자 이내)");
         checkPassFlag=false;
       return false;
      }else{
         $('#chkpwd').text("")
      }
     });
     $("#checkPass").keyup(function(){
    	 $('#checkPass').val($('#checkPass').val().trim()); 
    	   if($("#pass").val()!=$("#checkPass").val()&&$("#pass").val()!=""){
    	      $("#checkPassword").css("color","red").text("비밀번호가 서로 다릅니다.")
    	      checkPassFlag=false;
    	      return false;
    	   }else if($("#pass").val()==$("#checkPass").val()&&$("#pass").val()!=""){
    		   checkPassFlag=true;
    	      $("#checkPassword").css("color","Lime").text("비밀번호가 서로 일치합니다")
    	      
    	   }
    	});
    	$("#pass").keyup(function(){
    		   if($("#pass").val()!=$("#checkPass").val() && $("#checkPass").val() != ""){
    		      $("#checkPassword").css("color","red").text("비밀번호가 서로 다릅니다.")
    		          $("#checkPass").val("").focus();
    		      checkPassFlag=false;
    		      return false;
    		   }else if($("#pass").val()==$("#checkPass").val() && $("#checkPass").val() != ""&&!chkPwd($('#pass').val().trim())){
    			   checkPassFlag=true;
    		      $("#checkPassword").css("color","Lime").text("비밀번호가 서로 일치합니다")
    		      
    		   }
    		});  
    		//이름 한글 or 영어만 되도록 설정
    		 function chkName(str)
    	     {
    	      var reg_Name =/^[가-힣a-zA-Z]+$/;
    	      if(!reg_Name.test(str))
    	      {
    	       return false;
    	      }
    	      return true;
    	     }
    	$("#name").keyup(function(){
    		 $('#name').val($('#name').val().trim()); 
    		 if(!chkName($('#name').val().trim())){
    		      $("#nameCheckView").html("이름은 한글또는 영문으로 입력해주세요!").css(
    	    	            "color","red");
    		      checkNameFlag=false;
    		      return false;
    		 }else{
    			 $("#nameCheckView").html("");
    			 checkNameFlag=true;
    		 }
    	});
    	//이메일 공백 불가
    	$("#email1").keyup(function(){
    		$("#email1").val($("#email1").val().trim());
    	});
    	//이메일 공백 불가
    	$("#join_email2").keyup(function(){
    		$("#join_email2").val($("#join_email2").val().trim());
    	});
    	//키 3자제한,공백,한글 불가
    	$("#height").keyup(function(){
    		$("#height").val($("#height").val().trim());
    		if($("#height").val().length > 3){
    			alert("3자를 넘기지 마시오");
    			$(this).val($(this).val().replace(/[0-9]|[^\!-z]/gi,""));
    			return false;
    		}
    	});
    	//몸무게 3자제한,공백,한글 불가
    	$("#weight").keyup(function(){
    		$("#weight").val($("#weight").val().trim());
    		if($("#weight").val().length > 3){
    			alert("3자를 넘기지 마시오");
    			$(this).val($(this).val().replace(/[0-9]|[^\!-z]/gi,""));
    			return false;
    		}
    	});
    	//회원가입 유효성 검사
     $("#momentorRegister").submit(function(){
    	   if($("#id").val()==""){
    	      alert("아이디를 입력하세요.");
    	      $("#id").focus();
    	      return false;
    	   }
    	   if($("#pass").val()==""){
    	      alert("비밀번호를 입력하세요");
    	      $("#pass").focus();
    	      return false;
    	   }
    	   if($("#checkPass").val()==""){
    	      alert("비밀번호 확인을 입력해주세요");
    	      $("#checkPass").focus();
    	      return false;
    	   }
    	   if($("#name").val()==""){
    	      alert("이름을 입력하세요!");
    	      $("#name").focus();
    	      return false;
    	   }
    	   if($("#wdate").val()==""){
    	      alert("생년월일을 선택해주세요.");
    	      $("#wdate").focus();
    	      return false;
    	   }
    	   if($("#nick").val()==""){
    	      alert("별명을 입력하세요.");
    	      $("#nick").focus();
    	      return false;
    	   }
    	   if($("#join_email2").val()==""){
    	      alert("이메일을 입력하세요");
    	      $("#join_email2").focus();
    	      return false;
    	   }
    	   if($("input[name='gender']:checked").length == 0){
     	      alert("성별을 선택해주세요");
     	      return false;
     	   }
     	   if( $("input[name='infoPublic']:checked").length==0){
      	      alert("정보 공개 여부를 선택해주세요");
      	      return false;
      	   }
    	   if($("#address").val()==""){
    	      alert("주소를 입력해주세요");
    	      $("#address").focus();
    	      return false;
    	   }
    	   if($("#height").val()==""){
    	      alert("키를 입력하세요");
    	      $("#height").focus();
    	      return false;
    	   }
    	   if(isNaN($("#height").val())){
    	      alert("키를 숫자로 입력하세요");
    	      $("#height").focus();
    	      return false;
    	   }
    	   if($("#weight").val()==""){
    	      alert("몸무게를 입력하세요");
    	      $("#weight").focus();
    	      return false;
    	   }
    	   if(isNaN($("#weight").val())){
    	      alert("몸무게를 숫자로 입력하세요");
    	      $("#weight").focus();
    	      return false;
    	   }
    	 if(checkIdFlag!=true){
    	      alert("아이디를 확인해주세요!");
    	      return false;
    	   }
    	 if(checkPassFlag!=true){
    	     alert("비밀번호를 확인해주세요!");
    	     return false;
    	  }
    	 if(checkNickNameFlag!=true){
    	     alert("닉네임을 확인해주세요!");
    	     return false;
    	  }
    	 if(checkEmailFlag!=true){
    	     alert("이메일을 확인해주세요!");
    	     return false;
    	  }
    	 if(checkNameFlag!=true){
    		 alert("이름을 확인해주세요!");
    		 return false;
    	 }
     });
     $("#closeRegister").click(function(){
         $("#id").val("");
           $("#pass").val("");
           $("#name").val("");
           $("#wdate").val("");
           $("#nick").val("");
           $("#email1").val("");
           $("#join_email2").val("");
           $("#gender").val("");
           $("#address").val("");
           $("#weight").val("");
           $("#height").val(""); 
           $("#checkPass").val("");
           $("#join_email2").val("");
           $("#site_set").val("");
           $("#nickCheckView").html("");
           $("#registerView").html("");
           $("#checkPassword").html("");
           $("#idCheckView").html("");
      });
    });
</script>
<img src="${initParam.root}image/능균등.PNG"><br><br>
<c:choose>
<c:when test="${not empty sessionScope.pnvo}">      
    <font style="font-weight: bold;">${sessionScope.pnvo.momentorMemberVO.nickName} 님
    &nbsp;&nbsp;| &nbsp;&nbsp;<a href="#" id="logout">로그아웃</a></font><br><br><br>
    <div class="panel panel-default">
    <div class="panel-heading">
    <font style="font-weight: bold; font-size: large;"><center><li class="glyphicon glyphicon-user"></li> Member Info</center></font></div>
    <div class="panel-body">
	<font color="gray" style="font-weight: bold; font-size: 15px; font-style: italic;">
		<center><p style="color: #337ab7">${sessionScope.pnvo.momentorMemberVO.memberName} 님</p></center>
		<p>&nbsp;&nbsp;&nbsp;나이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.pnvo.age}세</p>
		<p>&nbsp;&nbsp;&nbsp;키&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.pnvo.memberHeight}cm</p>
		<p>&nbsp;&nbsp;&nbsp;몸무게&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.pnvo.memberWeight}kg</p>
		&nbsp;&nbsp;&nbsp;BMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:choose>
			<c:when test="${sessionScope.pnvo.bmi < 18.5}">
				<a href="#" data-html="true" data-title="저체중" data-placement="bottom">
				<font color="red" style="background-color: black;">${sessionScope.pnvo.bmi}</font><br></a>
			</c:when>
			<c:when test="${sessionScope.pnvo.bmi >= 18.5 && sessionScope.pnvo.bmi < 23}">
				<a href="#" data-html="true" data-title="정상" data-placement="bottom">
				<font color="greenyellow" style="background-color: black;">${sessionScope.pnvo.bmi}</font><br></a>
			</c:when>
			<c:when test="${sessionScope.pnvo.bmi >= 23 && sessionScope.pnvo.bmi < 25}">
				<a href="#" data-html="true" data-title="과체중" data-placement="bottom">
				<font color="yellow" style="background-color: black;">${sessionScope.pnvo.bmi}</font><br></a>
			</c:when>
			<c:when test="${sessionScope.pnvo.bmi >= 25 && sessionScope.pnvo.bmi < 30}">
				<a href="#" data-html="true" data-title="비만" data-placement="bottom">
				<font color="orange" style="background-color: black;">${sessionScope.pnvo.bmi}</font><br></a>
			</c:when>
			<c:when test="${sessionScope.pnvo.bmi >= 30}">
				<a href="#" data-html="true" data-title="고도비만" data-placement="bottom">
				<font color="red" style="background-color: black;">${sessionScope.pnvo.bmi}</font><br></a>
			</c:when>
		</c:choose>
    </font></div></div>
    <hr>
</c:when>
<c:otherwise>
<div class="loginForm">
	<form class="form-signin" action="${initParam.root}login_login.do" method="post">
		<label for="inputID" class="sr-only">ID</label>
		<input type="text" id="inputId" name="memberId" class="form-control" placeholder="ID" required autofocus>
		<label for="inputPassword" class="sr-only">Password</label>
		<input type="password" id="inputPassword" name="memberPassword" class="form-control" placeholder="Password" required>
		<button class="btn btn-sm btn-primary btn-block" type="submit">Login</button>
	</form>   
	<!-- Button trigger modal -->
	<a data-toggle="modal" href="#registerModal"class="btn btn-sm btn-primary btn-block">회원가입</a>
	<div><h6><a data-toggle="modal" href="#myModal">아이디찾기</a>
	| <a data-toggle="modal" href="#passModal">비밀번호찾기</a></h6></div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="idModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	  <div class="idFindCheck">
	    <div class="modal-content">   
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="idModalLabel">아이디찾기</h4>
	      </div>
	      <div class="modal-body">          
	          이름 : <input type="text" class="form-control" name="memberName" id="nameId"><br>
	          mail : <input type="text" class="form-control" name="memberEmail" id="mailId"><br>
	          <span id="showId"></span>               
	      <div class="modal-footer">
	         <button type="button" class="btn btn-default" data-dismiss="modal" id="closeId">Close</button>
	         <button type="button" class="btn btn-primary" id="findId">아이디찾기</button>
	      </div>
	      </div>
	    </div>
	    </div>
	  </div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="passModal" tabindex="-1" role="dialog" aria-labelledby="idModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	  <div class="idFindCheck">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="idModalLabel">비밀번호찾기</h4>
	      </div>
	      <div class="modal-body">
	          ID : <input type="text" class="form-control"  name="memberId" id="idPass"><br>
	          mail : <input type="text" class="form-control"  name="memberEmail" id="mailPass"><br>
	          <span id="showPass"></span>
	      </div>
	      <div class="modal-footer">
	         <button type="button" class="btn btn-default" data-dismiss="modal" id="closePass">Close</button>
	         <button type="button" class="btn btn-primary" id="findPass">비밀번호찾기</button>
	      </div>
	    </div>
	  </div>
	  </div>
	</div>
</div>
<!-- Modal -->
<form method="post"  id="momentorRegister" action="register_result.do">
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="idModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <div class="momentorRegister">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="idModalLabel">회원가입</h4>
      </div>
      <div class="modal-body">
            <div class="form-group">
	            <label for="">아이디</label>
	            <input type="text" name="memberId" id="id" class="form-control" placeholder="아이디"><span id="idCheckView"></span>
            </div>
            <div class="form-group">
	      		<label for="">비밀번호</label>
			    <input type="password" name="memberPassword" id="pass" class="form-control"placeholder="비밀번호">   <span id="chkpwd"></span>
		    </div>
            <div class="form-group">
			    <label for="">비밀번호확인</label>
			    <input type="password" name="checkPassword" id="checkPass"class="form-control"placeholder="비밀번호확인" ><span id="checkPassword"></span>
      		</div>
            <div class="form-group">
         <label for="">이름</label>
        <input type="text" name="memberName" id="name" class="form-control"placeholder="이름"><span id="nameCheckView"></span>
         </div>
         <div class="form-group">
            <label for="">생년월일</label>
         <input type="text" class="datepicker" name="date" id="wdate"class="form-control"placeholder="생년월일">
         </div>
      <div class="form-group">
         <label for="">별명</label>
      <input type="text" name="nickName"  id="nick"class="form-control"placeholder="닉네임"><span id="nickCheckView"></span>
         </div>
      <div class="form-group">
      <label for="">이메일</label>
   <input type="text"  name="memberEmail"class="form-control"placeholder="이메일" id="email1">   <label for="">@</label>
          <input type="text"  name="memberEmail2" id="join_email2"class="form-control"placeholder="선택해주세요">
         <select name="memberEmail3" id="site_set">
               <option value="" >선택해주세요</option>
               <option value="naver.com" >naver.com</option>
               <option value="daum.net" >daum.net</option>
               <option value="nate.com" >nate.com</option>
               <option value="gmail.com" >gmail.com</option>
               <option value="" selected>직접입력</option>
         </select>   
            <input type="button" value="이메일중복검사" class="btn btn-primary" id="emailOverlapping" >   
         <span id="emailCheckView"></span>
         </div>
              <label for="">『성별』</label>
   		<label for="">남자</label><input type="radio" value="남자" name="gender">
  	  <label for="">여자</label><input type="radio" value="여자" name="gender">
          <div class="form-group">
            <label for="">주소</label>
         <input type="text" name="memberAddress" id="address"  size="35"class="form-control"placeholder="주소">
         </div>
            <div class="form-group">
            <label for="">키</label>
         <input type="text" name="memberHeight"  id="height" size="1"class="form-control"placeholder="키">   <label for="">cm</label>
         </div>
            <div class="form-group">
            <label for="">몸무게</label>
         <input type="text" name="memberWeight"  id="weight" size="1"class="form-control"placeholder="몸무게">   <label for="">kg</label>
         </div>
             <div class="form-group">
            <label for="">『정보 공개 여부』</label>
      		<label for="">공개</label><input type="radio" value="1" name="infoPublic">
      		<label for="">비공개</label><input type="radio" value="2" name="infoPublic">
         </div>
          <span id="showRegister"></span>
      </div>
      <div class="modal-footer">
       <span id="registerView"></span><br>
         <button type="button" class="btn btn-default" data-dismiss="modal" id="closeRegister">Close</button>
         <input type="submit" value="회원가입" class="btn btn-primary" >   
      </div>
    </div>
  </div>
  </div>
</div>
</form>
</c:otherwise>
</c:choose>
