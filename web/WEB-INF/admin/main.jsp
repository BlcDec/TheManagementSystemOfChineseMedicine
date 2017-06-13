<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %><%--
  Created by IntelliJ IDEA.
  User: KAI
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
                    <a href="manage_medicine.php"><i class="glyphicon glyphicon-user"></i>药方管理</a>
                </li>
                <li>
                    <a href="manage_materials.php"><i class="glyphicon glyphicon-search"></i>药材管理</a>
                </li>
                <li>
                    <a href="logout.php"><i class="fa fa-home"></i>注销登录</a>
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
                <li class="active">用户管理</li>
            </ol>

            <a href="add_doctor.php" class="list-group-item">添加医生</a>
            <a href="delete_doctor.php" class="list-group-item">删除医生</a>
            <a href="modify_doctor_password.php" class="list-group-item">修改医生密码</a>
            <a href="modify_patient_password.php" class="list-group-item">修改患者密码</a>


        </div>
    </div>
</div>
<div class="footer">
    <div class="row">
        <div class="col-lg-12">
            <%--&copy; ${copy_right_year} ${copy_right}版权所有--%>
        </div>
    </div>
</div>


<script src="../../theme/assets/js/jquery-1.10.2.js"></script>
<script src="../../theme/assets/js/bootstrap.min.js"></script>
<script src="../../theme/assets/js/custom.js"></script>
<script>
    var _department = -1;
    function set_department(department) {
        document.getElementById('department_info').style.display = "";
        document.getElementById('department_info').innerText = "当前选择的科室：" + department;

        _department = department;
        document.getElementById('btn_set_department').innerText = _department;
        document.getElementById('department').value = department;
    }
    function do_upload() {
        var name = document.getElementById('name').value;
        var sex = document.getElementById('sex').value;
        var year = document.getElementById('year').value;
        var phoneNum = document.getElementById('phone_num').value;
        var apperaTime = document.getElementById('appear_time').value;
        if (name.length == 0 ||
            sex.length == 0 ||
            year.length == 0 ||
            phoneNum.length == 0 ||
            apperaTime.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return ;
        }
        if(_department == -1){
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请选择预约科室后提交";
            return ;
        }
        $.ajax({
            url: 'upload_appointment.php?name=' + name + '&sex=' + sex + '&year=' + year + '&phone_num=' + phoneNum + '&appear_time=' + apperaTime + '&department=' + _department,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    document.getElementById('success_info').style.display = "";
                    document.getElementById('fail_info').style.display = "none";
                    document.getElementById('success_info').innerText = "预约成功！";
                    return ;
                }
                if(code == -7){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "预约失败，每个用户只可预约一次";
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
