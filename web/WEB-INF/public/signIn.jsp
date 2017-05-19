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

    <link rel="stylesheet" href="../../theme/css/ie.css" media="all"/>
    <link href="../../theme/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/custom.css" rel="stylesheet"/>

</head>
<body class="login">
<section>
    <h1><strong>${system_name}</strong></h1>
    <form id="sign_in_form" method="post" action="signIn.php">
        <div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">姓名</span>
                    <input id="name" name="name" type="text" class="form-control" placeholder="请输入姓名"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">性别</span>
                    <input id="sex" name="sex" type="text"
                           class="form-control" placeholder="请输入性别"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">手机号</span>
                    <input id="phone_num" name="phone_num" type="text"
                           class="form-control" placeholder="请输入手机号"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <input id="check_code" name="check_code" type="text"
                           class="form-control" placeholder="请输入短信验证码"
                           aria-describedby="sizing-addon2">
                    <span class="input-group-btn">
                        <%//TODO 使用图片验证码通过后才能获取验证码%>
                            <button id="check-code-button" class="btn btn-info" type="button"
                                    onclick="get_check_code()" >获取验证码</button>
                    </span>
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">输入密码</span>
                    <input id="password" name="password" type="password"
                           class="form-control" placeholder="请输入密码"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">确认密码</span>
                    <input type="password" id="re_password" name="re_password"
                           class="form-control" placeholder="请再次输入密码"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">身份证号</span>
                    <input id="id_card" name="id_card" type="text" class="form-control"
                           placeholder="请输入身份证号"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
        </div>
        <button class="btn btn-primary" type="button" onclick="commit()" style="margin-top: 20px">注册</button>
    </form>
    <%if ((Integer) request.getAttribute("code") < 0) {%>
    <p style="color: red"><%=request.getAttribute("msg")%>
    </p>
    <%}%>

    <% if ((Integer) request.getAttribute("code") == 0 && request.getAttribute("username") != null) {%>
    <button class="btn btn-primary" data-toggle="modal" style="margin-top: 10px"
            data-target="#myModal_<%=request.getAttribute("username")%>">点击查看您的用户名
    </button>
    <!-- Modal -->
    <div class="modal fade" id="myModal_<%=request.getAttribute("username")%>" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" data-toggle="modal" data-target="#myModal">用户信息</h4>
                </div>
                <div class="modal-body">
                    <p>您的用户名为：<strong><%=request.getAttribute("username")%>
                    </strong>
                        <br>请牢记您的用户名，如果忘记，请联系管理员</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="goHome()"
                            style="margin-left: 5px;margin-right: 5px">跳转到登陆页面
                    </button>
                    <hr/>
                    <button type="button" class="btn btn-default" data-dismiss="modal"
                            style="margin-top: 10px; margin-right: 5px">关闭
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%}%>
</section>
<script src="../../theme/assets/js/jquery-1.10.2.js"></script>
<script src="../../theme/assets/js/custom.js"></script>
<script src="../../theme/assets/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function goHome() {
        window.location.href = '${ redirect_url}';
    }
    function commit() {
        if (document.getElementById("password").value == null || document.getElementById("password").value == "" || document.getElementById("re_password").value == null || document.getElementById("re_password").value == "") {
            alert("请填写密码，并确认！");
        } else if (document.getElementById("password").value != document.getElementById("re_password").value) {
            alert("两次输入的密码不相同，请确认后提交");
        } else {
            //TODO 添加验证码
            document.getElementById("sign_in_form").submit();
        }
    }
    function get_check_code() {
        var phoneNum = document.getElementById('phone_num').value;
        var idCard = document.getElementById('id_card').value;
        if(phoneNum == null || phoneNum == "" || idCard == null || idCard == ""){
            alert('请填写手机号码和身份证号后获取验证码');
            return ;
        }
        var arr = Object.keys(phoneNum);
        var count = 0;
        for(var temp in arr){
            count ++;
        }
        if(count<11) {
            alert('请填写正确的手机号码');
            return ;
        }
        var button = document.getElementById('check-code-button');
        button.disabled = "disabled";
        var times = 60;
        var timer = setInterval(function () {
            //console.log(times)
            //TODO ajax请求验证码
            if (times--) {
                button.innerHTML = times + "秒后可获取验证码"
            } else {
                clearInterval(timer)
                times = 10
                button.removeAttribute('disabled')
                button.innerHTML = '获取验证码'
            }
        }, 1000);
    }
</script>
</body>
</html>