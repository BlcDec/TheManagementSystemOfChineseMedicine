<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %><%--
  Created by IntelliJ IDEA.
  User: KAI
  Date: 2017/4/7
  Time: 15:10
  //添加store的药材
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


                <li >
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>用户管理</a>
                </li>
                <li >
                    <a href="manage_medicine.php"><i class="glyphicon glyphicon-user"></i>药方管理</a>
                </li>
                <li class="active-link">
                    <a href="manage_materials.php"><i class="glyphicon glyphicon-search"></i>药材管理</a>
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
                    <h2>药材管理</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="manage_materials.php">药材管理</a></li>
                <li class="active">添加药材</li>
            </ol>
            <form id="add_form" action="add_materials.php" method="post" >
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">药材名</span>
                        <input type="text" name="materialName" id="materialName" placeholder="药材名"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">余量(单位：g)</span>
                        <input type="number" id="materialRemain" name="materialRemain" placeholder="药材余量"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">药材价格(元/g)</span>
                        <input type="number" id="price" name="price" placeholder="药材价格"
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
            <%--&copy; ${copy_right_year} ${copy_right}版权所有--%>
        </div>
    </div>
</div>


<script src="../../theme/assets/js/jquery-1.10.2.js"></script>
<script src="../../theme/assets/js/bootstrap.min.js"></script>
<script src="../../theme/assets/js/custom.js"></script>
<script>
    function add() {
        var materialName = document.getElementById("materialName").value;
        var materialRemain = document.getElementById("materialRemain").value;
        var price = document.getElementById("price").value;

        if (document.getElementById("materialName").value == "" ||
            document.getElementById("materialRemain").value == "" ||
            document.getElementById("price").value == ""){
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return ;
        }
        $.ajax({
            url: 'add_materials.php',
            type: 'POST',
            data:'materialName=' + materialName + '&materialRemain=' + materialRemain + '&price=' + price ,
            async: true,
            cache: false,
            contentType: "application/x-www-form-urlencoded",
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    alert("添加成功！");
                    window.location.href = "add_materials.php";
                    return ;
                }
                if(code == -1){
                    document.getElementById('fail_info').style.display = "";//是否显示
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "请求参数错误";
                    return ;
                }
                if(code == -14){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "此药品已存在";
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
