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
                <a href="user.php" style="color:#fff;">${name}</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li class="active-link">
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>在线预约</a>
                </li>
                <li>
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
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>在线预约</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active">在线预约</li>
            </ol>

            <form id="add_form" action="add.php" method="post" enctype="multipart/form-data">
                <%--<div class="form-group" align="left">--%>
                <%--<div class="input-group">--%>
                <%--<span class="input-group-addon">症状描述</span>--%>
                <%--<input type="text" name="isbn" id="isbn" placeholder="请简单描述您的症状" class="form-control"--%>
                <%--aria-describedby="sizing-addon2">--%>
                <%--&lt;%&ndash;<span class="input-group-btn">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<button class="btn btn-default" type="button" onclick="get_book_info()">获取信息</button>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</span>&ndash;%&gt;--%>
                <%--</div>--%>
                <%--</div>--%>
                <% Patient patient = (Patient) request.getAttribute("patient");%>
                <%if (patient != null) {%>
                <span class="label label-warning" id="get_book_info" style="display: none;">书籍信息获取失败，请手动输入</span>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">姓名</span>
                        <input type="text" id="name" name="name" value="<%=patient.getName()%>" placeholder="请确认姓名"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">性别</span>
                        <input type="text" id="sex" name="sex" value="<%=patient.getSex()%>" placeholder="请输入性别"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">年龄</span>
                        <input type="text" id="year" name="year" value="<%=request.getAttribute("year")%>"
                               placeholder="输入年龄让我们能够提高对您病情的判断"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">手机号</span>
                        <input type="text" id="phone_num" name="phone_num" placeholder="输入您家人或者您的手机号"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>

                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">症状出现时间</span>
                        <input type="text" id="appear_time" name="appear_time" placeholder="症状出现时间，如：2017/01/01"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">预约科室</span>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                选择预约科室
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li><a href="javascript:set_department('呼吸内科')">呼吸内科</a></li>
                                <li><a href="javascript:set_department('内分泌科')">内分泌科</a></li>
                                <li><a href="javascript:set_department('神经内科')">神经内科</a></li>
                                <li><a href="javascript:set_department('老年科')">老年科</a></li>
                                <li><a href="javascript:set_department('儿童科')">儿童科</a></li>
                                <li><a href="javascript:set_department('牙科')">牙科</a></li>
                            </ul>
                            <input name="department" id="department" type="hidden">
                            <span class="label label-info" style="display: none;margin-left: 10px" id="department_info">info</span>
                        </div>
                    </div>
                    <%--<div class="btn-group" >--%>
                    <%--<span class="input-group-addon">预约科室</span>--%>
                    <%--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"--%>
                    <%--aria-haspopup="true" aria-expanded="false">--%>
                    <%--内科<span class="caret"></span>--%>
                    <%--</button>--%>
                    <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="#">呼吸内科</a></li>--%>
                    <%--<li><a href="#">内分泌科</a></li>--%>
                    <%--<li><a href="#">神经内科</a></li>--%>
                    <%--<li role="separator" class="divider"></li>--%>
                    <%--<li><a href="#">老年科</a></li>--%>
                    <%--<li><a href="#">儿童科</a></li>--%>
                    <%--<li><a href="#">牙科</a></li>--%>
                    <%--</ul>--%>
                    <%--</div>--%>
                </div>
                <div class="form-group" align="left">
                    <div>
                        <h4><span class="label label-warning" id="submit_info"
                                  style="display: none;">请检查个人信息，完善预约信息后提交</span></h4>
                        <div>
                            <button type="button" class="btn btn-primary" onclick="do_upload()">提交</button>
                        </div>
                    </div>
                </div>
                <%}%>
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
    var _department = -1;
    function set_department(department) {
        document.getElementById('department_info').style.display = "";
        document.getElementById('department_info').innerText = "当前选择的科室：" + department;
        _department = department;
        document.getElementById('department').value = department;
    }
    function do_upload() {
        var name = document.getElementById('name');
        var sex = document.getElementById('sex');
        var year = document.getElementById('year');
        var phoneNum = document.getElementById('phone_num');
        var apperaTime = document.getElementById('appear_time');
        if (name.value.length == 0 ||
            sex.value.length == 0 ||
            year.value.length == 0 ||
            phoneNum.value.length == 0 ||
            apperaTime.value.length == 0) {
            document.getElementById('submit_info').style.display = "";
            document.getElementById('submit_info').innerText = "请完善信息后提交";
            return ;
        }
        if(_department == -1){
            document.getElementById('submit_info').style.display = "";
            document.getElementById('submit_info').innerText = "请选择预约科室后提交";
            return ;
        }
        //TODO 发送请求
        var form = new FormData();
        form.append("name",name);
        form.append("sex",sex);
        form.append("year",year);
        form.append("phone_num",phoneNum);
        form.append("appear_time",apperaTime);
        form.append("department",_department);
        $.ajax({
            url: 'main.php',
            type: 'POST',
            //data:;
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

</script>

</body>
</html>
