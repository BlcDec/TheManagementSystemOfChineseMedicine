<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.*" %>
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
                <%--<li>--%>
                <%--<a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>--%>
                <%--</li>--%>
                <%--/收款窗口是指收取药品费用的窗口--%>
                <li class="active-link">
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
                    <h2>收款窗口</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="collection.php">收款窗口</a></li>
                <li class="active">查看历史详情</li>
            </ol>
            <hr>
            <div class="row">
                <%--<form id="form" method="post" action="close_account.php">--%>
                <%--<div class="col-lg-6">--%>
                <%--<div class="input-group">--%>
                <%--<input id="patient_num" name="patient_num" type="text" class="form-control"--%>
                <%--placeholder="请输入患者挂号的号">--%>
                <%--<span class="input-group-btn">--%>
                <%--<button class="btn btn-default" onclick="commit()">搜索</button>--%>
                <%--<button type="button" class="btn btn-default" onclick="create_prescription()">生成病历</button>--%>
                <%--</span>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</form>--%>
                <h4><span class="label label-success" id="success_info"
                          style="display: none;">${msg}</span></h4>
                <h4><span class="label label-warning" id="fail_info"
                          style="display: none;">${msg}</span></h4>
            </div>
            <div class="list-group">
                <a class="list-group-item disabled">
                    患者药品详情
                </a>
                <table class="table table-striped">
                    <div class="form-group">
                        <thead>
                        <tr>
                            <th>患者身份证号：</th>
                            <th>预约科室：</th>
                            <th>药方名：</th>
                            <th>药方类型：</th>
                            <th>应缴费用：</th>
                            <th>是否缴费：</th>
                        </tr>
                        </thead>
                    </div>
                    <tbody>
                    <%List<Prescription> prescriptionList = (List<Prescription>) request.getAttribute("prescription");%>
                    <%if(prescriptionList.size()!=0){%>
                    <%Patient patient = (Patient) request.getAttribute("patient");%>
                    <%AppointmentOrRegistration appointmentOrRegistration = (AppointmentOrRegistration) request.getAttribute("appointmentOrRegistration");%>
                    <%Diagnosis diagnosis = (Diagnosis) request.getAttribute("diagnosis");%>
                    <%Map<String,Medicine> medicineMap = (Map<String, Medicine>) request.getAttribute("medicineMap");%>
                    <%Map<String,MedicineCombine> medicineCombineMap = (Map<String, MedicineCombine>) request.getAttribute("medicineCombineMap");%>
                    <%for(Prescription p : prescriptionList){%>
                    <tr>
                        <td><%=patient.getIdCard()%></td>
                        <td><%=appointmentOrRegistration.getDepartment()%></td>
                        <td><%if(p.isCombine()){%>无<%}else{%><%=medicineMap.get(p.getId() + "").getName()%><%}%></td>
                        <td><%if(p.isCombine()){%>医生自配<%}else{%>系统提供<%}%></td>
                        <td><%if(p.isCombine()){%><%=medicineCombineMap.get(p.getId() + "").getPrice()%><%}else{%><%=medicineMap.get(p.getId() + "").getPrice()%><%}%>元</td>
                        <%if(!p.isPay()){%>
                        <td>
                            <span class="label label-danger">未缴纳</span>
                        </td>
                        <%} else {%>
                        <td><span class="label label-success">已缴纳</span></td>
                        <%}%>
                        <!-- Modal -->
                        <%--<div class="modal fade" id="myModal_<%=p.getId()%>" tabindex="-1" role="dialog"--%>
                             <%--aria-labelledby="myModalLabel">--%>
                            <%--<div class="modal-dialog" role="document">--%>
                                <%--<div class="modal-content">--%>
                                    <%--<div class="modal-header">--%>
                                        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span--%>
                                                <%--aria-hidden="true">&times;</span></button>--%>
                                    <%--</div>--%>
                                    <%--<div class="modal-body">--%>
                                        <%--<p>请确认是否要缴纳<%if(p.isCombine()){%>“医生自配药方”<%}else{%>“<%=medicineMap.get(p.getId() + "").getName()%>”<%}%>的费用？</p>--%>
                                    <%--</div>--%>
                                    <%--<div class="modal-footer">--%>
                                        <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                                        <%--<button type="button" class="btn btn-primary" data-dismiss="modal"--%>
                                                <%--onclick="pay_for(<%=appointmentOrRegistration.getId()%>,<%=p.getId()%>)">确认缴纳--%>
                                        <%--</button>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </tr>
                    <%}%>



                    <%} else {%>
                    <%}%>
                    </tbody>
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
</script>

</body>
</html>
