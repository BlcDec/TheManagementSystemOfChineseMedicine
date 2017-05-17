<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>${system_name}</title>
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
    <%if((Integer) request.getAttribute("code") <0 ){%>
    <p style="color: red"><%=request.getAttribute("msg")%></p>
    <%}%>
</section>
<% if ((Integer) request.getAttribute("code") == 0 && request.getAttribute("username") != null) {%>


<button class="btn btn-primary" type="button" data-toggle="modal"
        data-target="#myModal_<%=request.getAttribute("username")%>">点击查看您的用户名
</button>
<!-- Modal -->
<div class="modal fade" id="myModal_<%=request.getAttribute("username")%>" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" data-toggle="modal" data-target="#myModal">用户信息</h4>
            </div>
            <div class="modal-body">
                <p>您的用户名为：<strong><%=request.getAttribute("username")%>
                </strong>请牢记您的用户名，如果忘记，请及时联系管理员</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="take_book()">跳转到登陆页面
                </button>
            </div>
        </div>
    </div>
</div>

<%}%>
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