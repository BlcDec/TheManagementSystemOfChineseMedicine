<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>中医药管理系统（管理员）</title>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <%--<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->--%>
    <%--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">--%>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
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
    <h1><strong>中医药管理系统（管理员）</strong></h1>
    <form method="post" action="admin_login.php">
        <input type="text" name="username" placeholder="身份证号" value="admin"/>
        <input placeholder="密码" name="password" type="password" value="admin"/>
        <button class="blue">登录</button>
    </form>
    <%if ((Integer) request.getAttribute("code") == 0) {%>

    <%} else if ((Integer) request.getAttribute("code") == -2) {%>
    <alert><%=request.getAttribute("code")%>
    </alert>
    <p style="color: red;">用户名或密码错误</p>
    <%} else if ((Integer) request.getAttribute("code") == -1) {%>
    <p style="color: red;">请求参数错误</p>
    <%}%>
    <%--<div>--%>
        <%--<p><a href="signIn.php" style="display: none">注册</a></p>--%>
        <%--<p><a href="forgetpsw.php">忘记密码</a></p>--%>
    <%--</div>--%>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
</body>
</html>