<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Doctor" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: KAI
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
                <a href="user.php" style="color:#fff;">${admin_name}</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">


                <li class="active-link">
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>用户管理</a>
                </li>
                <li>
                    <a href="manage_medicine.php"><i class="glyphicon glyphicon-user"></i>药方管理</a>
                </li>
                <li>
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
                    <h2>用户管理</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="main.php">用户管理</a></li>
                <li class="active">删除医生</li>
            </ol>
            <div class="form-group" align="left">
                <div class="input-group">
                    <span class="input-group-addon">医生身份证号</span>
                    <input type="text" name="id_card" id="id_card" placeholder="医生身份证号" class="form-control"
                           aria-describedby="sizing-addon2">
                </div>
            </div>
            <!-- Modal -->
            <%Map<String,Doctor> doctorMap = (Map<String, Doctor>) request.getAttribute("doctorMap");%>
            <%for(String key : doctorMap.keySet()){%>
            <%Doctor doctor = doctorMap.get(key);%>
            <%String position = "";%>
            <%switch (doctor.getPosition()){
                case"0":
                    position = "挂号";
                    break;
                case"1":
                    position = "诊断";
                    break;
                case"2":
                    position = "收款";
                    break;
            }%>
            <div class="modal fade" id="MyModal_<%=doctor.getUsername()%>" tabindex="-1" role="dialog"
                 aria-labelledby="myModalLabel">
                <div style="left: 0%;" class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"
                                    aria-label="Close"><spanchr
                                    aria-hidden="true">&times;</spanchr></button>
                        </div>
                        <div class="modal-body" id="medicine_modal_body">
                            <div id="medicine_msg">
                                <h2>确定要删除<%=position%>窗口的<%=doctor.getName()%>医生？</h2>
                                <h3><span class="label label-warning" id="warning"
                                          style="margin-left: 15px;display: none"></span></h3>
                                <h3><span class="label label-success" id="success"
                                          style="margin-left: 15px;display: none"></span></h3>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary"
                                    onclick="confirm_delete(<%=doctor.getUsername()%>)">确认删除
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                关闭
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
            <div class="form-group" align="left">
                <div>
                    <h4><span class="label label-success" id="success_info"
                              style="display: none;">${msg}</span></h4>
                    <h4><span class="label label-warning" id="fail_info"
                              style="display: none;">${msg}</span></h4>
                    <div>
                        <button type="button" class="btn btn-primary" onclick="do_modal()" >删除</button>
                    </div>
                </div>
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
    function do_modal() {
        var idCard = document.getElementById('id_card');
        if(idCard.value.length == 0){
            document.getElementById('fail_info').style.display = "";
            document.getElementById('success_info').style.display = "none";
            document.getElementById('fail_info').innerText = "请填写完整信息后删除";
            return ;
        }
        document.getElementById('fail_info').style.display = "none";
        $('#MyModal_'+idCard.value).modal('show');
    }

    function confirm_delete() {
        var idCard = document.getElementById('id_card').value;
        if (document.getElementById('id_card').value.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return ;
        }
        $.ajax({
            url: 'delete_doctor.php?id_card=' + idCard,
            type: 'POST',
            async: true,
            cache: false,
            contentType: "application/x-www-form-urlencoded",
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if(code == 0){
                    alert("删除成功");
                    window.location.href = "main.php";
                    return ;
                }
                if(code == -7){
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "预约失败，每个用户只可预约一次";
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
