<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration" %><%--

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
                <li class="active-link">
                    <a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>
                </li>
                <%--&lt;%&ndash;/收款窗口是指收取药品费用的窗口&ndash;%&gt;--%>
                <%--<li>--%>
                    <%--<a href="collection.php"><i class="glyphicon glyphicon-search"></i>收款窗口</a>--%>
                <%--</li>--%>
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
                    <%if ((Integer) request.getAttribute("code") == -12 || (Integer) request.getAttribute("code") == -11 || (Integer) request.getAttribute("code") == -13) {%>
                    <h2>诊断窗口（即将自动跳转）</h2>
                    <%} else if ((Integer) request.getAttribute("code") == 0) {%>
                    <h2>诊断窗口</h2>
                    <%}%>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>

                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <li class="active">诊断</li>
            </ol>
            <%if ((Integer) request.getAttribute("code") == 0) {%>
            <%Patient patient = (Patient) request.getAttribute("patient");%>
            <%
                AppointmentOrRegistration appointmentOrRegistration = (AppointmentOrRegistration) request.getAttribute("appointment_or_registration");%>

            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">患者姓名</span>
                    <input type="text" id="name" name="name" value="<%=patient.getName()%>" placeholder="请确认姓名"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">患者性别</span>
                    <input type="text" id="sex" name="sex" value="<%=patient.getSex()%>" placeholder="请输入性别"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">患者年龄</span>
                    <input type="text" id="year" name="year" value="<%=request.getAttribute("year")%>"
                           placeholder="输入年龄让我们能够提高对您病情的判断"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">患者身份证</span>
                    <input type="text" id="id_card" name="id_card" value="<%=patient.getIdCard()%>" placeholder="请确认姓名"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">主诉症状</span>
                    <input type="text" id="patient_msg" name="patient_msg" placeholder="请医生填写"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">症状出现时间</span>
                    <input type="text" id="appear_time" name="appear_time" placeholder="症状出现时间，如：2017/01/01"
                           value="<%=appointmentOrRegistration.getAppearTime()%>"
                           class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <div class="form-group" align="left">
                <div>
                    <label>初步诊断：</label>
                    <div class="form-group">
                        <textarea name="summary" class="form-control" rows="5" id="summary"></textarea>
                    </div>
                    <h4><span class="label label-info" id="info" <%if((Boolean) request.getAttribute("is_commit_diagnose")){%>style="display: none"<%}else{%>
                            <%}%>>提交诊断书后为患者开药</span></h4>
                    <h4><span class="label label-success" id="success_info"
                              style="display: none;">${msg}</span></h4>
                    <h4><span class="label label-warning" id="fail_info"
                              style="display: none;">${msg}</span></h4>
                    <button type="button" class="btn btn-primary" onclick="upload_diagnosis()">提交诊断书</button>

                    <button id="select_medicine" type="button" class="btn btn-primary" data-toggle="modal"<%if((Boolean) request.getAttribute("is_commit_diagnose")){%> <%}else{%>style="display: none"
                            <%}%>
                            data-target="#MyModal_<%=patient.getIdCard()%>">开药
                    </button>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="MyModal_<%=patient.getIdCard()%>" tabindex="-1" role="dialog"
             aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" data-toggle="modal" data-target="#myModal">请选择开药方式：</h4>
                    </div>
                    <div class="modal-body">
                        <button type="button" class="btn btn-primary" onclick="select_prescription()">选择已有药方</button>
                        <button type="button" class="btn btn-primary" onclick="DIY()">自己调配</button>
                    </div>
                </div>
            </div>
        </div>

        <%--<!-- Modal -->--%>
        <%--<div class="modal fade" id="selectedMedicine_<%=patient.getIdCard()%>" tabindex="-1" role="dialog"--%>
             <%--aria-labelledby="myModalLabel">--%>
            <%--<div class="modal-dialog" role="document">--%>
                <%--<div class="modal-content">--%>
                    <%--<div class="modal-header">--%>
                        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span--%>
                                <%--aria-hidden="true">&times;</span></button>--%>
                        <%--<h4 class="modal-title" data-toggle="modal" data-target="#myModal">查看已选药方/药材：</h4>--%>
                    <%--</div>--%>
                    <%--<div class="modal-body">--%>
                        <%--此处有一个Table--%>
                    <%--</div>--%>
                    <%--<div class="modal-footer">--%>
                        <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>

        <!-- Modal -->
        <%--<div class="modal fade" id="myModal_select" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
        <%--<div class="modal-dialog" role="document">--%>
        <%--<div class="modal-content">--%>
        <%--<div class="modal-header">--%>
        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span--%>
        <%--aria-hidden="true">&times;</span></button>--%>
        <%--<h4 class="modal-title" data-toggle="modal" data-target="#myModal">选择已有药方：</h4>--%>
        <%--</div>--%>
        <%--<div class="modal-body">--%>
        <%--<div class="input-group">--%>
        <%--<input id="search" name="search" type="text" class="form-control"--%>
        <%--placeholder="请输入关键字搜索你需要的药方名">--%>
        <%--<h4><span class="label label-warning" id="fail_search"--%>
        <%--style="display: none;">${msg}</span></h4>--%>
        <%--<span class="input-group-btn">--%>
        <%--<button class="btn btn-default" type="button"--%>
        <%--onclick="search_medicine()">搜索</button>--%>
        <%--</span>--%>

        <%--</div>--%>


        <%--</div>--%>


        <%--<div class="modal-footer">--%>
        <%--<button type="button" class="btn btn-primary">--%>
        <%--确定--%>
        <%--</button>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>


        <%
        } else if ((Integer) request.getAttribute("code") == -12 ||
                (Integer) request.getAttribute("code") == -11 ||
                (Integer) request.getAttribute("code") == -1 ||
                (Integer) request.getAttribute("code") == -13) {
        %>
        <script>
            window.setTimeout("window.location='${ redirect_url}'", 2000);
        </script>
        <h1><span class="label label-warning">${msg}</span></h1>
        <%}%>
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
    function DIY() {
        window.setTimeout("window.location='DIY_prescription.php'");
    }
    function select_prescription() {
        window.setTimeout("window.location='select_prescription.php'");
    }
    function search_medicine() {
        var search = document.getElementById('search').value;
        var div = document.getElementById('search_content');
        if (search.length == 0) {
            alert('请填写完整后搜索！');
            return;
        }
        $.ajax({
            url: 'search_medicine.php?search=' + search,
            type: 'GET',
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if (code == 0) {
                    div.style.display = "";
                    return;
                }
                if (code == -1) {
                    document.getElementById('fail_search').style.display = "";
                    document.getElementById('fail_search').innerText = "提交参数错误！";
                    return;
                }

            },
            fail: function (returndata) {
                document.getElementById('fail_search').innerText = "网络错误，提交失败";
                document.getElementById('fail_search').style.display = "";
            }
        });

    }
    var _department = -1;
    function set_department(department) {
        document.getElementById('department_info').style.display = "";
        document.getElementById('department_info').innerText = "当前选择的科室：" + department;

        _department = department;
        document.getElementById('btn_set_department').innerText = _department;
        document.getElementById('department').value = department;
    }
    function upload_prescription() {


    }

    function upload_diagnosis() {
        var name = document.getElementById('name').value;
        var sex = document.getElementById('sex').value;
        var year = document.getElementById('year').value;
        var patientMsg = document.getElementById('patient_msg').value;
        var appearTime = document.getElementById('appear_time').value;
        var idCard = document.getElementById('id_card').value;
        var summary = document.getElementById('summary').value;
        if (name.length == 0 ||
            sex.length == 0 ||
            year.length == 0 ||
            patientMsg.length == 0 ||
            appearTime.length == 0 ||
            summary.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return;
        }
        $.ajax({
            url: 'upload_diagnosis.php?name=' + name + '&sex=' + sex + '&year=' + year + '&patient_msg=' + patientMsg + '&appear_time=' + appearTime + '&id_card=' + idCard + '&summary=' + summary,
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
                    document.getElementById('success_info').innerText = "提交成功！";
                    document.getElementById('select_medicine').style.display= "";
                    document.getElementById('info').style.display = "none";
                    return;
                }
                if (code == -1) {
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "提交参数错误！";
                    return;
                }
                if (code == -5) {
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "身份证号不正确";
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
