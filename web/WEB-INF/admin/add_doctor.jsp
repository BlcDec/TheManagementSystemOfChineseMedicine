<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %><%--
  Created by IntelliJ IDEA.
  User: yangyang
  Date: 2017/4/7
  Time: 15:33

  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${system_name}</title>
    <link href="../../theme/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/custom.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
    <style>
        @media (max-width: 768px) {
            .navbar-default {
                color: white;
                position: fixed;
                top: 100px;
                z-index: 100;
                background-color: #fdfdfe;
                width: 100%;
                text-align: center;
            }

            #main-menu {
                padding: 0;
            }

            #main-menu a:hover {
                color: #31588A;
            }

            #main-menu a:active {
                color: #31588A !important;
            }

            #main-menu a:link {
                color: #31588A;
            }

            #main-menu a:visited {
                color: #31588A;
            }
        }
    </style>
</head>
<body>


<div id="wrapper">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="adjust-nav">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <%--<a class="navbar-brand" href="#">--%>
                <%--<img height="50" width="50" src="assets/img/logo.png"/>--%>
                <%--</a>--%>

            </div>

            <span class="logout-spn">
                  <a style="color:#fff;">欢迎你,</a>
                <a href="user.php" style="color:#fff;">${admin_name}</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li class="active-link">
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>用户管理</a>
                </li>
                <li>
                    <a href="#"><i class="glyphicon glyphicon-user"></i>药方管理</a>
                </li>
                <li>
                    <a href="#"><i class="glyphicon glyphicon-search"></i>药材管理</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-home"></i>注销登录</a>
                </li>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>用户管理</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="main.php">用户管理</a></li>
                <li class="active">添加医生</li>
            </ol>
            <form id="add_form" action="add_doctor.php" method="post" >
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">姓名</span>
                        <input type="text" name="name" id="name" placeholder="姓名" class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">性别</span>
                        <input type="text" id="sex" name="sex" placeholder="性别"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">身份证号</span>
                        <input type="text" id="id_card" name="id_card" placeholder="身份证号"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">薪水</span>
                        <input type="text" id="salary" name="salary" placeholder="薪资" class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">职位</span>
                        <input type="text" id="position" name="position" placeholder="职位"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">所在科室</span>
                        <input type="text" id="department" name="department" placeholder="所在科室（此处应该为选择？）" class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">学历</span>
                        <input type="text" id="degree" name="degree" placeholder="学历"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div>
                        <h4><span class="label label-success" id="success_info"
                                  style="display: none;">${msg}</span></h4>
                        <h4><span class="label label-warning" id="fail_info"
                                  style="display: none;">${msg}</span></h4>
                        <div>
                            <button type="button" class="btn btn-primary" onclick="add()">添加</button>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<div class="footer">
    <div class="row">
        <div class="col-lg-12">
        </div>
    </div>
</div>


<script src="../../theme/assets/js/jquery-1.10.2.js"></script>
<script src="../../theme/assets/js/bootstrap.min.js"></script>
<script src="../../theme/assets/js/custom.js"></script>
<script>
    function add() {
        var name = document.getElementById("name").value;
        var sex = document.getElementById("sex").value;
        var idCard = document.getElementById("id_card").value;
        var salary = document.getElementById("salary").value;
        var position = document.getElementById("position").value;
        var department = document.getElementById("department").value;
        var degree = document.getElementById("degree").value;
        if (document.getElementById("name").value == "" ||
            document.getElementById("sex").value == "" ||
            document.getElementById("id_card").value == "" ||
            document.getElementById("salary").value == "" ||
            document.getElementById("position").value == "" ||
            document.getElementById("department").value == "" ||
            document.getElementById("degree").value == "") {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return ;
        }
        $.ajax({
            url: 'add_doctor.php',
            type: 'POST',
            data:'name=' + name + '&sex=' + sex + '&id_card=' + idCard + '&salary=' + salary + '&position=' + position + '&department=' + department + '&degree=' + degree,
            async: true,
            cache: false,
            contentType: "application/x-www-form-urlencoded",
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    alert("添加成功！");
                    window.location.href = "main.php";
                    return ;
                }
                if(code == -1){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "请求参数错误";
                    return ;
                }
                if(code == -14){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "此用户已存在";
                    return ;
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，预约失败";
                document.getElementById('fail_info').style.display = "inline";
            }
        });
    }

</script>

</body>
</html>
