<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>${system_name}</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../../theme/css/style.css" media="all"/>
    <!--[if IE]>
    <link rel="stylesheet" href="css/ie.css" media="all"/><![endif]-->
</head>
<body class="login">
<section>
    <h1><strong>${system_name}</strong></h1>
    <form id="sign_in_form" method="post" action="signIn.php">
        <input id="name" type="text" name="name" placeholder="姓名"/>
        <input id="sex" placeholder="性别" name="sex" type="text"/>
        <input id="id_card" placeholder="身份证号" name="id_card" type="text"/>
        <input id="phone_num" placeholder="手机号" name="phone_num" type="text"/>
        <input id="password" placeholder="密码" name="password" type="password"/>
        <input id="re_password" placeholder="确认密码" name="re_password" type="password"/>
        <button class="blue" type="button" onclick="commit()">注册</button>
    </form>
    <p><a href="forgetpsw.php">忘记密码</a></p>
    </div>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript">
    function commit() {
        if (document.getElementById("password").value == null || document.getElementById("password").value == "" || document.getElementById("re_password").value == null || document.getElementById("re_password").value == "") {
            alert("请填写密码，并确认！");
        } else if (document.getElementById("password").value != document.getElementById("re_password").value) {
            alert("两次输入的密码不相同，请确认后提交");
        } else {
            document.getElementById("sign_in_form").submit();
        }
    }
</script>
</body>
</html>