<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="">
<head>
	<meta charset="utf-8">
	<title>中医门诊管理系统</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="robots" content="" />
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="../../theme/css/style.css" media="all" />
	<!--[if IE]><link rel="stylesheet" href="css/ie.css" media="all" /><![endif]-->
</head>
<body class="login">
	<section>
		<h1><strong>中医门诊</strong> 管理系统</h1>
		<form method="post" action="login.php">
			<input type="text" name="username" placeholder="Email" />
			<input placeholder="Password" name="password" type="password" />
			<button class="blue">Login</button>
		</form>
		<%if((Integer)request.getAttribute("code") == 0){%>

		<%}//TODO
		else if((Integer)request.getAttribute("code") == -2) {%>
		<p><a href="#">用户名或密码错误</a></p>
		<%}%>
		<p><a href="#">Forgot your password?</a></p>
	</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript">
// Page load delay by Curtis Henson - http://curtishenson.com/articles/quick-tip-delay-page-loading-with-jquery/
$(function(){
	$('.login button').click(function(e){ 
		// Get the url of the link 
		var toLoad = $(this).attr('href');  
 
		// Do some stuff 
		$(this).addClass("loading"); 
 
			// Stop doing stuff  
			// Wait 700ms before loading the url 
			setTimeout(function(){window.location = toLoad}, 10000);	  
 
		// Don't let the link do its natural thing 
		e.preventDefault
	});
	
	$('input').each(function() {

       var default_value = this.value;

       $(this).focus(function(){
               if(this.value == default_value) {
                       this.value = '';
               }
       });

       $(this).blur(function(){
               if(this.value == '') {
                       this.value = default_value;
               }
       });

});
});
</script>
</body>
</html>