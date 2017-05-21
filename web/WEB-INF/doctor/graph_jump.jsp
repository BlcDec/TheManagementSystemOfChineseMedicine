<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>消息提示页面</title>
    <link href="../../theme/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="../../theme/assets/css/custom.css" rel="stylesheet"/>
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

            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li>
                    <a href="#"><i class="fa fa-desktop "></i>消息提示页面</a>
                </li>
                <%--<li>--%>
                    <%--<a href="../"><i class="fa fa-home"></i>返回主页</a>--%>
                <%--</li>--%>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->

    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>消息提示页面（即将自动跳转）</h2>
                </div>
            </div>
            <!-- /. ROW  -->
            <ol class="breadcrumb">
                <li class="active">消息提示页面</li>
            </ol>
            <script>
                window.setTimeout("window.location='${ redirect_url}'",2000);
            </script>
            <h1><span class="label label-info">${msg}</span></h1>

        </div>
        <!-- /. PAGE INNER  -->
    </div>
    <!-- /. PAGE WRAPPER  -->
</div>
<%--<div class="footer">--%>
    <%--<div class="row">--%>
        <%--<div class="col-lg-12">--%>
            <%--&copy; <%=Tool.getTodayEarlyYearStr()%> <%=Tool.getCopyRightInfo() %>版权所有--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<style>
    .container{
        padding: 0;
    }
</style>
<script src="../../theme/assets/js/jquery-1.10.2.js"></script>
<script src="../../theme/assets/js/bootstrap.min.js"></script>
<script src="../../theme/assets/js/custom.js"></script>
<script type="application/javascript">

</script>
</body>
</html>
