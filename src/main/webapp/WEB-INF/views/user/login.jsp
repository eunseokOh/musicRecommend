<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>Insert title here</title>
<script src='<c:url value="/resources/js/jquery-2.2.2.js"/>'></script>
<script src='<c:url value="/resources/js/jquery-form.js"/>'></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#loginBtn').click(function() {
			$('#login_form').submit(function() {
				$('#login_form').ajaxForm(); //폼 전송
			});
			$('#login_form').submit();
			/* alert('아이디 : ' +$('#user_id').val()
					+ '비번 : ' + $('#user_pw').val());	 */
		});

	});
</script>

</head>
<body>
	<form id="login_form" action="../user/login" method="post">
		[일반 로그인] <br /> I D : <input type="text" id="user_id" name="user_id"
			required="required" /> 비번 : <input type="password" id="user_pw"
			name="user_pw" required="required" /> <input type="button"
			value="로그인 시도" id="loginBtn" /><br /> <input type="button"
			value="회원가입" onclick="location.href='../user/join'" />
	</form>
	<hr />
	<form id="cacaoLogin_form" method="post">
		[카카오 로그인] <br /> <a id="kakao-login-btn"></a>
		<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
		<script type='text/javascript'>
			Kakao.init('f97bdc30adee08866d0525f4038875d7');
			Kakao.Auth.logout();

			Kakao.Auth.createLoginButton({
				container : '#kakao-login-btn',
				success : function(authObj) {
					Kakao.API.request({
						url : '/v1/user/me',
						success : function(res) {
							var cacaoID = res.id
							var cacaoNICK = res.properties.nickname
							var cacaoPROFILE = res.properties.profile_image
						
							alert(' NoID : ' + cacaoID + '\n닉네임 : ' + cacaoNICK
									+ '\n프로필 주소 :' + cacaoPROFILE
									+ '\n비밀번호는 수집하지 않습니다.');

							location.href = "../user/login?user_id=" + cacaoID
									+ "&user_nick=" + cacaoNICK + "&user_img="
									+ cacaoPROFILE;

						},
						fail : function(error) {
							alert(JSON.stringify(error));
						}
					});
				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}
			});
		</script>

	</form>
</body>
</html>