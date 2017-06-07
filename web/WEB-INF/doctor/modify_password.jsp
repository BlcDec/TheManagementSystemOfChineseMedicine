<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Doctor" %><%--

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
        @media(max-width:768px) {
            .navbar-default{
                color:white;
                position:fixed;
                top:100px;
                z-index: 100;
                background-color: #fdfdfe;
                width: 100%;
                text-align: center;
            }
            #main-menu{
                padding: 0;
            }
            #main-menu a:hover{
                color: #31588A;
            }
            #main-menu a:active{
                color: #31588A !important;
            }
            #main-menu a:link{
                color: #31588A;
            }
            #main-menu a:visited{
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
                <a href="user.php" style="color:#fff;">${name}</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">

                <%Doctor doctor = (Doctor) request.getAttribute("doctor");%>
                <%if(doctor.getPosition().equals("0")){%>
                <li class="active-link">
                        <%} else {%>
                <li>
                    <%}%>
                    <a href="windows.php"><i class="glyphicon glyphicon-plus"></i>挂号窗口</a>
                </li>
                <%if(doctor.getPosition().equals("1")){%>
                <li class="active-link">
                        <%} else {%>
                <li>
                    <%}%>
                    <a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>
                </li>
                <%--/收款窗口是指收取药品费用的窗口--%>
                <%if(doctor.getPosition().equals("2")){%>
                <li class="active-link">
                        <%} else {%>
                <li>
                    <%}%>
                    <a href="collection.php"><i class="glyphicon glyphicon-search"></i>收款窗口</a>
                </li>
                <li>
                    <a href="logout.php"><i class="fa fa-home"></i>注销登录</a>
                </li>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>修改密码</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <%if(doctor.getPosition().equals("0")){%>
                <li class="active"><a href="windows.php">挂号窗口</a></li>
                <%} else if(doctor.getPosition().equals("1")){%>
                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <%} else if(doctor.getPosition().equals("2")){%>
                <li class="active"><a href="collection.php">收费窗口</a></li>
                <%}%>
                <li class="active">修改密码</li>
            </ol>

            <hr/>
            <h1><span class="label label-info">尚未开发，敬请期待...</span></h1>
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
    function take_book(book_id) {
        if (book_id == null) {
            return;
        } else {
            $.ajax({
                url: 'get_crossingbook.php?book_id=' + book_id,
                type: 'POST',
                async: true,
                cache: false,
                contentType: false,
                processData: false,
                success: function (returndata) {

                },
                fail: function (returndata) {

                }
            });
        }
    }
</script>

</body>
</html>
