<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
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


                <li >
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>在线预约</a>
                </li>
                <li class="active-link">
                    <a href="user.php"><i class="glyphicon glyphicon-user"></i>个人中心</a>
                </li>
                <li>
                    <a href="search.php"><i class="glyphicon glyphicon-search"></i>药品检索</a>
                </li>
                <li>
                    <a href="../public/logout.php"><i class="fa fa-home"></i>注销登录</a>
                </li>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>个人中心</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active">个人中心</li>
            </ol>

            <div class="list-group">
                <a href="#" class="list-group-item disabled">
                    用户基本信息
                </a>

                <a href="javascript:void(0);" class="list-group-item">用户名：${user.username}</a>
                <a href="javascript:void(0);" class="list-group-item">姓名：${patient.name}</a>
                <a href="javascript:void(0);" class="list-group-item">身份证号：${patient.idCard}</a>
                <a href="effect_appointment.php" class="list-group-item">已生效预约：${effective_appointment}条</a>
                <a href="effect_registration.php" class="list-group-item">已生效挂号：${effective_registration}条</a>
                <a href="underway_appointment.php" class="list-group-item">正在进行中的预约：${underway_appointment}条</a>
                <%--<a href="system_message.php" class="list-group-item">系统提醒--%>
                    <%--<%if((Integer)request.getAttribute("system_remind_number") != 0) {%>--%>
                    <%--<span class="badge" style="background-color: #67b168;">--%>
                        <%--<%=request.getAttribute("system_remind_number")%></span>--%>
                    <%--<%} else {%>--%>
                    <%--<%if((Integer)request.getAttribute("already_read_message") != 0) {%>--%>
                    <%--<span class="badge">--%>
                            <%--<%=request.getAttribute("already_read_message")%></span>--%>
                    <%--<%}%>--%>
                    <%--<%}%>--%>
                <%--</a>--%>
                <%--<a href="remind_me.php" class="list-group-item">帮我留意</a>--%>
                <%--<a href="cancel_remind.php" class="list-group-item">我的留意<span class="badge"><%=request.getAttribute("remind_count")%></span></a>--%>
                <%--<a href="user_books.php" class="list-group-item">我的书籍</a>--%>
                <%--<a href="user_my_book_by_drift.php" class="list-group-item">已经接受的漂流<%if((Integer) request.getAttribute("code_record") == 0){%>--%>
                    <%--<%List<BookCrossingBookRecord> bookCrossingBookRecords = (List<BookCrossingBookRecord>) request.getAttribute("book_list_record");%>--%>
                    <%--<span class="badge"><%=bookCrossingBookRecords.size()%></span>--%>
                    <%--<%} else {%>--%>
                    <%--<span class="badge"><%=0%></span>--%>
                    <%--<%}%></a>--%>
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
    function take_book(book_id) {
        if (book_id == null) {
            return;
        } else {
            $.ajax({
                url: 'get_crossingbook.php?book_id=' + book_id,
                type: 'GET',
                async: true,
                cache: false,
                contentType: false,
                processData: false,
                success: function (returndata) {
                    document.getElementById(book_id).style.display = "none";
                },
                fail: function (returndata) {

                }
            });
        }
    }
</script>

</body>
</html>
