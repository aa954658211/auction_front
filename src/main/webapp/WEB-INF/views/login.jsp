<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	session.setAttribute("APP_PATH",request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>欢迎登录</title>
	<link rel="stylesheet" href="${APP_PATH}/static/css/auth.css"/>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap-validator/js/bootstrapValidator.min.js"></script>
	<link href="${APP_PATH}/static/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet" />
	<link rel="shutcut icon" href="${APP_PATH}/static/img/page_white_freehand.png" type="image/x-icon">
</head>
<body>
	<div class="lowin lowin-blue">
		<div class="lowin-brand">
			<img src="${APP_PATH}/static/img/kodinger.jpg" alt="logo">
		</div>
		<div class="lowin-wrapper">
			<div class="lowin-box lowin-login">
				<div class="lowin-box-inner">
					<form id="loginForm" onsubmit="return false;" data-form='ajax'>
						<p>Sign in to continue</p>
						<div class="lowin-group">
							<label>用户名 <a href="#" class="login-back-link">Sign in?</a></label>
							<input type="text" autocomplete="username" name="username" class="lowin-input" data-required="用户名不能为空">
						</div>
						<div class="lowin-group password-group">
							<label>密码 <a href="#" class="forgot-link">Forgot Password?</a></label>
							<input type="password" name="password" autocomplete="current-password" class="lowin-input" data-required="密码不能为空">
						</div>
						<button class="lowin-btn login-btn" id="login_btn">
							登录
						</button>

						<div class="text-foot">
							还没有账号？ <a href="" class="register-link">点击注册</a>
						</div>
					</form>
				</div>
			</div>

			<div class="lowin-box lowin-register">
				<div class="lowin-box-inner">
					<form id="registerForm" onsubmit="return false;" data-form='ajax'>
						<p>注册账号</p>
						<div class="lowin-group">
							<label>用户名</label>
							<input type="text" name="username" autocomplete="name" data-required="用户名不能为空" data-minlength="5" data-maxlength="12" class="lowin-input">
						</div>
						<div class="lowin-group">
							<label>密码</label>
							<input type="password" name="password" autocomplete="current-password" id="password" data-required="密码不能为空" data-minlength="6" data-maxlength="12" class="lowin-input">
						</div>
						<div class="lowin-group">
							<label>确认密码</label>
							<input type="password" name="comfirmPassword" autocomplete="current-password" class="lowin-input" data-equal="#password" data-required="确认密码不能为空">
						</div>
						<div class="lowin-group">
							<label>邮件</label>
							<input type="email" autocomplete="email" data-email="true" name="email" class="lowin-input">
						</div>
						<button class="lowin-btn" id="register_btn">
							注册
						</button>
						<div class="text-foot">
							已经有账号了？ <a href="" class="login-link">点击登录</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	
		<footer class="lowin-footer">

		</footer>
	</div>
	<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
	<script src="${APP_PATH}/static/js/jquery.form.min.js"></script>
	<script src="${APP_PATH}/static/js/auth.js"></script>
	<script src="${APP_PATH}/static/js/verJs.js"></script>
	<script>
		$(function () {
			Auth.init({
				login_url: '#login',
				forgot_url: '#forgot'
			});
			let url = window.location.href;
			let index = url.indexOf("#register");
			if(index!=-1){
				Auth.vars.register_link.click();
			}
			let loginValid = new VerJs({
				form:"#loginForm",
				success:function (d) {
					alert(1)
				},
				fail:function (d) {
					alert(2)
				}
			});
			let registerValid = new VerJs({
				form:"#registerForm",
				success:function (d) {
					alert(1)
				},
				fail:function (d) {
					alert(2)
				}
			});
			//登录
			$("#login_btn").click(function () {
			    $("#loginForm").on("submit",function () {
			        $(this).ajaxSubmit({
			            type:'POST',
			            dataType:'json',
			            url:"${APP_PATH}/login",
			            data:$("#loginForm").serialize(),
			            success:function (result) {
			                if (result.code == 100){
			                    layer.msg("登录成功", {icon: 1, time: 5000, offset: '0px'});
			                    window.location.href = '${APP_PATH}/index';
			                }else{
			                    layer.alert(result.message, {icon: 5, offset: '0px'});
			                }
			            }
			        });
			    });
			});
			$("#register_btn").click(function () {
				$("#registerForm").on("submit",function () {
					$(this).ajaxSubmit({
						type:'post',
						dataType:'json',
						url:"${APP_PATH}/user/save",
						data:$("#registerForm").serialize(),
						success:function (result) {
							if (result.code == 100){
								layer.msg("注册成功", {icon: 1, time: 10000, offset: '0px'});
								window.history.go(-1);
							}else{
								layer.alert(result.message, {icon: 5, offset: '0px'});
							}
						}
					});
				});
			});

		});
	</script>
</body>
</html>