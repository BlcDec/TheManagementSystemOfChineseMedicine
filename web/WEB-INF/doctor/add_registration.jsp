<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %><%--

//添加挂号
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
                <a href="user.php" style="color:#fff;">${name}医生</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li class="active-link">
                    <a href="windows.php"><i class="glyphicon glyphicon-plus"></i>挂号窗口</a>
                </li>
                <%--<li>--%>
                    <%--<a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>--%>
                <%--</li>--%>
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
    <!-- /. NAV SIDE  -->
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>添加挂号</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="windows.php">挂号窗口</a></li>
                <li class="active">添加挂号</li>
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
                <%--<% Patient patient = (Patient) request.getAttribute("patient");%>--%>
                <%--<%if (patient != null) {%>--%>
                <%--<span class="label label-warning" id="get_book_info" style="display: none;">书籍信息获取失败，请手动输入</span>--%>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">姓名</span>
                        <input type="text" id="name" name="name"  placeholder="输入患者姓名"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">性别</span>
                        <input type="text" id="sex" name="sex"  placeholder="输入患者性别"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">年龄</span>
                        <input type="text" id="year" name="year"
                               placeholder="输入患者年龄"
                               class="form-control"
                               aria-describedby="sizing-addon2">
                    </div>
                </div>
                    <div class="form-group" align="left">
                        <div class="input-group">
                            <span class="input-group-addon">身份证号</span>
                            <input type="text" id="id_card" name="id_card" placeholder="输入患者身份证号"
                                   class="form-control"
                                   aria-describedby="sizing-addon2">
                        </div>
                    </div>
                <div class="form-group" align="left">
                    <div class="input-group">
                        <span class="input-group-addon">患者手机号</span>
                        <input type="text" id="phone_num" name="phone_num" placeholder="输入患者家人或者患者本人手机号"
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
                        <span class="input-group-addon">挂号科室</span>
                        <div class="btn-group">
                            <button id="btn_set_department" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                选择挂号科室 <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li><a href="javascript:set_department('呼吸内科')">呼吸内科</a></li>
                                <li><a href="javascript:set_department('内分泌科')">内分泌科</a></li>
                                <li><a href="javascript:set_department('精神科')">精神科</a></li>
                                <li><a href="javascript:set_department('老年科')">老年科</a></li>
                                <li><a href="javascript:set_department('儿童科')">儿童科</a></li>
                                <li><a href="javascript:set_department('牙科')">牙科</a></li>
                            </ul>
                            <input name="department" id="department" type="hidden">
                            <span class="label label-info" style="display: none;margin-left: 10px" id="department_info">info</span>
                        </div>
                    </div>
                </div>
                <div class="form-group" align="left">
                    <div>
                        <h4><span class="label label-success" id="success_info"
                                  style="display: none;">${msg}</span></h4>
                        <h4><span class="label label-warning" id="fail_info"
                                  style="display: none;">${msg}</span></h4>
                        <div>
                            <button type="button" class="btn btn-primary" onclick="do_upload()">提交</button>
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
        var idCard = document.getElementById('id_card').value;
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
            document.getElementById('fail_info').innerText = "请选择挂号科室后提交";
            return ;
        }
        $.ajax({
            url: 'add_registration_msg.php?name=' + name + '&sex=' + sex + '&year=' + year + '&phone_num=' + phoneNum + '&appear_time=' + apperaTime + '&department=' + _department + '&id_card=' + idCard,
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
                    document.getElementById('success_info').innerText = "挂号成功！";
                    return ;
                }
                if(code == -7){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "挂号失败，每个挂号只可预约一次";
                    return ;
                }
                if(code == -9){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "已经预约，但是未缴纳挂号费，因此不能挂号";
                    return ;
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，挂号失败";
                document.getElementById('fail_info').style.display = "inline";
            }
        });
    }

</script>

</body>
</html>