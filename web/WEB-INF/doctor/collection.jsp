<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %><%--


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
                <a style="color:#fff;">${name}医生</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <%--<li>--%>
                    <%--<a href="windows.php"><i class="glyphicon glyphicon-plus"></i>挂号窗口</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>--%>
                <%--</li>--%>
                <%--/收款窗口是指收取药品费用的窗口--%>
                <li class="active-link">
                    <a href="collection.php"><i class="glyphicon glyphicon-search"></i>收款窗口</a>
                </li>
                <li>
                    <a href="logout.php"><i class="fa fa-home"></i>注销登录</a>
                </li>
            </ul>
        </div>

    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>收款窗口</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active">收款窗口</li>
            </ol>
            <hr>
            <div class="row">
                <form id="form" >
                    <div class="col-lg-6">
                        <div class="input-group">
                            <input id="patient_num" name="patient_num" type="text" class="form-control"
                                   placeholder="请输入患者挂号的号">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button" onclick="commit()">搜索</button>
                                <%--<button type="button" class="btn btn-default" onclick="create_prescription()">生成病历</button>--%>
                                <button type="button" class="btn btn-default" onclick="find_history()">查看历史</button>
                        </span>
                        </div>
                    </div>
                </form>
                <h4><span class="label label-success" id="success_info"
                          style="display: none;">${msg}</span></h4>
                <h4><span class="label label-warning" id="fail_info"
                          style="display: none;">${msg}</span></h4>
            </div>


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
    //缴费
    function commit() {
        var patientNum = document.getElementById('patient_num').value;
        if (patientNum.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请填写完整患者号后缴费";
            return ;
        }
        $.ajax({
            url: 'close_account.php?patient_num=' + patientNum,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    window.location.href='close_prescription.php';
                }
                if(code == -1 || code == -11){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "患者信息错误";
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，缴纳失败";
                document.getElementById('fail_info').style.display = "";
            }
        });
    }

    //TODO 生成病历
    function create_prescription() {
        var patientNum = document.getElementById('patient_num').value;
        if (patientNum.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请填写完整患者号后生成";
            return ;
        }
        $.ajax({
            url: 'create_prescription.php?patient_num=' + patientNum,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    window.location.href='create_prescription.php';
                }
                if(code == -1 || code == -11){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "患者信息错误";
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，生成失败";
                document.getElementById('fail_info').style.display = "";
            }
        });
    }

    //查看历史
    function find_history() {
        var patientNum = document.getElementById('patient_num').value;
        if (patientNum.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请填写完整患者号后查看历史";
            return ;
        }
        $.ajax({
            url: 'find_history_logic.php?patient_num=' + patientNum,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    console.log("111112")
                    window.location.href='find_history.php';
                }
                if(code == -1 || code == -11){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "患者信息错误";
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，失败";
                document.getElementById('fail_info').style.display = "";
            }
        });
    }

</script>

</body>
</html>
