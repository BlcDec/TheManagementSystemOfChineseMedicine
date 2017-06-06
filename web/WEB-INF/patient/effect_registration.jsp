<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration" %>
<%@ page import="java.util.Date" %><%--
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
                <a href="user.php" style="color:#fff;">${name}</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li>
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
                <li class="active"><a href="user.php">个人中心</a></li>
                <li class="active">已生效的挂号信息</li>
            </ol>

            <div class="list-group">
                <a class="list-group-item disabled">
                    已生效的挂号信息
                </a>
                <table class="table table-striped">
                    <%if ((Integer) request.getAttribute("code") == 0 && request.getAttribute("msg").equals("pageOk")) {%>
                    <div class="form-group">
                        <thead>
                        <tr>
                            <th>挂号号码：</th>
                            <th>添加时间：</th>
                            <th>挂号科室：</th>
                            <th>症状出现时间：</th>
                            <th>缴纳挂号费时间：</th>
                        </tr>
                        </thead>
                    </div>
                    <tbody>
                    <%List<AppointmentOrRegistration> lists = (List<AppointmentOrRegistration>) request.getAttribute("effect_registration");%>
                    <%DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");%>
                    <%for (int i = 0; i < lists.size(); i++) {%>
                    <%AppointmentOrRegistration a = lists.get(i);%>
                    <tr>
                        <th scope="row"><%=a.getId()%>
                        </th>
                        <td><%=dateFormat.format(a.getAddTime())%>
                        </td>
                        <td><%=a.getDepartment()%>
                        </td>
                        <td><%=a.getAppearTime()%>
                        </td>
                        <td><%=dateFormat.format(a.getPayForTime())%></td>
                    </tr>
                    <!-- Modal -->
                    <div class="modal fade" id="myModal_<%=a.getId()%>" tabindex="-1" role="dialog"
                         aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body">
                                    <p>请确认是否要缴纳此次预约的费用？</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <button type="button" class="btn btn-primary" data-dismiss="modal"
                                            onclick="pay_for(<%=a.getId()%>)">确认缴纳
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                    </tbody>
                    <%}%>
                </table>
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
    function pay_for(appointment_id) {
        if (appointment_id == null) {
            alert("页面错误！");
            return;
        } else {
            $.ajax({
                //TODO 此处需要添加支付的一个key，因此可以使用GET请求
                url: 'pay_for_appointment.php?appointment_id=' + appointment_id,
                type: 'GET',
                async: true,
                cache: false,
                contentType: false,
                processData: false,
                success: function (returndata) {
                    var json = returndata;
                    var code = json.code;
                    if(code == 0){
                        alert("缴纳成功，点击后跳转！");
                    } else if(code == -8){
                        alert("缴纳失败，点击后跳转！");
                    }
                    window.location.href='user.php';
                },
                fail: function (returndata) {

                }
            });
        }
    }
</script>

</body>
</html>
