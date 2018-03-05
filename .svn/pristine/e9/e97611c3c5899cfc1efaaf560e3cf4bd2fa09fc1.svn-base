<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html lang="ko">
<head>
<meta charset=UTF-8">

<title>Insert title here</title>
<script src='<c:url value="/resources/js/jquery-2.2.2.js"/>'></script>
<script src='<c:url value="/resources/js/jquery-form.js"/>'></script>
<script type="text/javascript">
$(document).ready(function(){
	var user_id_check = -2;
	
	//아이디 체크를 클릭했을 때, 아이디를 입력하지 않은 경우
	$('#id_check').click(function(){
			
		//아이디 미입력 확인
		var id = $('#user_id').val();
		if(id.trim('') === '') {
			alert('아이디를 입력하세요~');
			$('#user_id').focus();
			return
		}	
		
		//아이디 재입력 확인
		$('#user_id').change(function(){
			if($('#user_id').val()== '') {
				user_id_check = -2;
				return
			}
			user_id_check = -1;
			idCheckResult.style.color = "red";
			$('#idCheckResult').html('다시 중복확인하세요');
		});
	
		
		//아이디 중복체크
		$.post({
			url:"../user/idcheck",
			data:{
				"user_id" : id
				}
		}).done(function(data){
			/* alert(data); */
			if(data >= 1){
				idCheckResult.style.color = "red";
				$('#idCheckResult').html('이미 사용중인 아이디입니다');
				user_id_check = 1;
				$('#user_id').focus();
				return;	
			} else if(data == 0) {
				idCheckResult.style.color = "green";
				$('#idCheckResult').html('가입가능 아이디입니다');
				user_id_check = 0;				
				$('#user_pw').focus();
				return;
			}
				 			
		}).fail(function(){
			alert('시스템 오류');
		})
		
	});
	
	//폼 전송전 확인
	$('#btn').click(function(){
		var id = $('#user_id').val();	
		if(user_id_check == -2) {
			alert('아이디 입력 후 중복체크를 하세요');
			$('#idCheckResult').focus();
			return;
		} else if(user_id_check == -1) {
			alert('중복체크를 하세요');
			$('#idCheckResult').focus();
			return;

		} else if(user_id_check == 1){
			alert('중복아이디로는 가입하실 수 없습니다');
			$('user_id').focus();
			return;
		} else if(user_id_check == 0) {
								
			 if($('#user_pw').val()==""|| $('#user_nick').val()=="")   {
				alert('빈칸을 모두 작성해주세요');
					return;
			}			
			
			$('#myform').ajaxForm(); //폼 전송	
			$('#myform').submit(); 
			alert('회원 가입 완료 / 아이디 : ' + id )
			location.href="../user/login"
			
		}
				
	});
	$('#user_img_file').click(function(){
		
		var imageFile = document.querySelector('#user_img_file');

		imageFile.onchange = function () {
		    var fileList = imageFile.files ;

		    // 읽기
		    var reader = new FileReader();
		    reader.readAsDataURL(fileList [0]);

		    //로드 한 후
		    reader.onload = function  () {
		        document.querySelector('#preview').src = reader.result ;
		    };
		};
		
	});
		
});

</script>
</head>
<body>
<input type="button" value="로그인 이동" onclick="location.href='../user/login'"/>
<hr/>
	<form id="myform" action="../user/join" method="post"
		enctype="multipart/form-data">
		아이디 : <input type="text" name="user_id" id="user_id" /> <input
			type="button" id="id_check" name="id_check" value="중복확인" />
		<div id="idCheckResult"></div>
		비밀번호 : <input type="password" name="user_pw" id="user_pw" /> <br />
		성별 : 남자(<input type="radio" name="user_gender" value="1" checked>)
		여자(<input type="radio" name="user_gender" value="2" />)<br /> 닉네임 :
		<input type="text" name="user_nick" id="user_nick" /> <br /> 사진 : <input
			type="file" name="user_img_file" id="user_img_file"
			accept="image/*" /> <br />
		[프로필사진 미리보기]<br/>
		 <img id="preview" src=""/> <br/>
		<input type="button"
			id="btn" value="가입" />
	</form>

</body>
</html>