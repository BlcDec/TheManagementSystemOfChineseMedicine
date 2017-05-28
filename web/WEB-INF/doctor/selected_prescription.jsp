<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.*" %><%--
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
                <a style="color:#fff;">${name}医生</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li>
                    <a href="windows.php"><i class="glyphicon glyphicon-plus"></i>挂号窗口</a>
                </li>
                <li class="active-link">
                    <a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>
                </li>
                <%--/收款窗口是指收取药品费用的窗口--%>
                <li>
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
                    <%--<%if ((Integer) request.getAttribute("code") == -12 || (Integer) request.getAttribute("code") == -11 || (Integer) request.getAttribute("code") == -13) {%>--%>
                    <%--<h2>诊断窗口（即将自动跳转）</h2>--%>
                    <%--<%} else if ((Integer) request.getAttribute("code") == 0) {%>--%>
                    <h2>诊断窗口</h2>
                    <%--<%}%>--%>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>

                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <li class="active"><a href="start_diagnose.php">诊断</a></li>
                <li class="active"><a href="select_prescription.php">开药方</a></li>
                <li class="active">查看已选药方</li>
            </ol>

            <hr/>
            <table class="table table-striped">
                <div class="form-group">
                    <thead>
                    <tr>
                        <th>医生姓名：</th>
                        <th>患者姓名：</th>
                        <th>药方名：</th>
                        <th>详情：</th>
                        <th>操作：</th>
                    </tr>
                    </thead>
                </div>
                <%if((Integer) request.getAttribute("code") == 0){%>
                <%Doctor doctor = (Doctor) request.getAttribute("doctor");%>
                <%Patient patient = (Patient) request.getAttribute("patient");%>
                <%List<Medicine> medicineList = (List<Medicine>) request.getAttribute("medicine_list");%>
                <tbody>
                <%for(Medicine medicine : medicineList){%>
                <tr>
                    <th><%=doctor.getName()%></th>
                    <th><%=patient.getName()%></th>
                    <th><%=medicine.getName()%></th>
                    <th></th>
                    <th></th>
                </tr>
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
    function jump() {
        window.setTimeout("window.location='selected_prescription.php'",2000);
    }
    function commit(medicine_id) {
        if (medicine_id.length == 0) {
            document.getElementById('fail_info').innerText = '请选择药品后添加';
            document.getElementById('fail_info').style.display = "";
            return;
        }
        //TODO 添加药品给用户
        $.ajax({
            url: 'add_medicine.php?medicine_id=' + medicine_id,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if (code == 0) {
                    document.getElementById('success_info').style.display = "";
                    document.getElementById('fail_info').style.display = "none";
                    document.getElementById('success_info').innerText = "添加成功！";
                    return;
                }
                if (code == -1) {
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "提交参数错误！";
                    return;
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，提交失败";
                document.getElementById('fail_info').style.display = "";
            }
        });

    }

</script>

</body>
</html>
