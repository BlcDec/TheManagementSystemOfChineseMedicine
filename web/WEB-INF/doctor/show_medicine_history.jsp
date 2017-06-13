<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.*" %>
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


                <%--<li >--%>
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
                    <h2>诊断窗口</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <li class="active">查看已开出的病历</li>
            </ol>

            <div class="list-group">
                <a class="list-group-item disabled">
                    已开出的病历
                </a>
                <%if ((Integer) request.getAttribute("code") == 0) {%>
                <%Map<String, String> patientNameMap = (Map<String, String>) request.getAttribute("patientNameMap");%>
                <%
                    List<MedicineHistory> medicineHistories = (List<MedicineHistory>) request.getAttribute("medicineHistories");%>
                <%DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");%>
                <table class="table table-striped">
                    <div class="form-group">
                        <thead>
                        <tr>
                            <th>患者姓名：</th>
                            <th>医生身份证号：</th>
                            <th>主诉：</th>
                            <th>诊疗信息：</th>
                            <th>诊断时间：</th>
                            <th>所开药方：</th>
                        </tr>
                        </thead>
                    </div>
                    <tbody>
                    <tr>
                        <%for (MedicineHistory medicineHistory : medicineHistories) {%>
                        <td><%=patientNameMap.get(medicineHistory.getPatientIdCard())%>
                        </td>
                        <td><%=medicineHistory.getDoctorIdCard()%>
                        </td>
                        <td><%=medicineHistory.getPatientSummary()%>
                        </td>
                        <td><%=medicineHistory.getDoctorSummary()%>
                        </td>
                        <td><%=dateFormat.format(medicineHistory.getCreateTime())%>
                        </td>
                        <td>
                            <button class="btn btn-info" data-toggle="modal" style="margin-top: 0px"
                                    data-target="#MyModal_<%=medicineHistory.getPatientIdCard()%>">点击查看药方详细信息
                            </button>
                        </td>
                    </tr>
                    <!-- Modal -->
                    <div class="modal fade" id="MyModal_<%=medicineHistory.getPatientIdCard()%>" tabindex="-1"
                         aria-labelledby="myLargeModalLabel"
                         role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                </div>

                                <div class="modal-body">
                                    <%--<h1>test</h1>--%>
                                    <%//TODO%>
                                    <%--<table class="table table-responsive">--%>
                                        <%--<div class="form-group">--%>
                                            <%--<thead>--%>
                                            <%--<tr>--%>
                                                <%--&lt;%&ndash;<th>医生姓名：</th>&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;<th>患者姓名：</th>&ndash;%&gt;--%>
                                                <%--<th>药方名：</th>--%>
                                                <%--<th>药方类型：</th>--%>
                                                <%--<th>详情：</th>--%>
                                            <%--</tr>--%>
                                            <%--</thead>--%>
                                        <%--</div>--%>

                                        <%--<tbody class="table table-striped">--%>
                                        <%--&lt;%&ndash;加载系统库内部的药方&ndash;%&gt;--%>
                                            <%--<%Doctor doctor = (Doctor) request.getAttribute("doctor");%>--%>
                                        <%--&lt;%&ndash;<%Patient patient = (Patient) request.getAttribute("patient");%>&ndash;%&gt;--%>
                                            <%--<%--%>
                                            <%--List<Medicine> medicineList = (List<Medicine>) request.getAttribute("medicine_list");%>--%>
                                            <%--<%--%>
                                            <%--Map<String, List<Materials>> materialsMap = (Map<String, List<Materials>>) request.getAttribute("materials");%>--%>
                                        <%--<tbody>--%>
                                        <%--<%for (Medicine medicine : medicineList) {%>--%>
                                        <%--<tr>--%>
                                            <%--&lt;%&ndash;<td><%=doctor.getName()%>&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;<td><%=patientNameMap.get(medicineHistory.getPatientIdCard())%>&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;</td>&ndash;%&gt;--%>
                                            <%--<td><%=medicine.getName()%>--%>
                                            <%--</td>--%>
                                            <%--<td><span class="label label-info">成方</span>--%>
                                            <%--</td>--%>
                                            <%--<td>--%>
                                                <%--<a href="javascript:void(0);" class="btn " data-toggle="modal"--%>
                                                   <%--data-target="#myModal_<%=medicine.getId()%>">查看详细信息</a>--%>
                                            <%--</td>--%>
                                        <%--</tr>--%>
                                        <%--</tbody>--%>
                                        <%--<%List<Materials> materialsList = materialsMap.get(medicine.getId() + "");%>--%>
                                        <%--&lt;%&ndash;Modal&ndash;%&gt;--%>
                                        <%--<div class="modal fade" id="myModal_<%=medicine.getId()%>" tabindex="-1"--%>
                                             <%--role="dialog"--%>
                                             <%--aria-labelledby="myModalLabel">--%>
                                            <%--<div class="modal-dialog" role="document">--%>
                                                <%--<div class="modal-content">--%>
                                                    <%--<div class="modal-header">--%>
                                                        <%--<button type="button" class="close" data-dismiss="modal"--%>
                                                                <%--aria-label="Close"><span--%>
                                                                <%--aria-hidden="true">&times;</span></button>--%>
                                                    <%--</div>--%>
                                                    <%--<div class="modal-body">--%>
                                                        <%--<p><%=medicine.getName()%>由以下药材组成：</p>--%>
                                                        <%--<p><%for (Materials m : materialsList) {%>--%>
                                                            <%--<%=m.getId() + "号：" + m.getMedicineName() + m.getDosage() + '克' + ",   "%>--%>
                                                            <%--<%}%></p>--%>
                                                    <%--</div>--%>
                                                    <%--<div class="modal-footer">--%>
                                                        <%--<button type="button" class="btn btn-default"--%>
                                                                <%--data-dismiss="modal">关闭--%>
                                                        <%--</button>--%>
                                                    <%--</div>--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                        <%--<%}%>--%>
                                    <%--</table>--%>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                    </button>
                                    <%--<button type="button" class="btn btn-primary" data-dismiss="modal"--%>
                                    <%--onclick="pay_for(<%=a.getId()%>)">确认缴纳--%>
                                    <%--</button>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%}%>


                    </tbody>
                </table>
                <%
                    } else {
                    }
                %>
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
        if (name.length == 0 ||
            sex.length == 0 ||
            year.length == 0 ||
            phoneNum.length == 0 ||
            apperaTime.length == 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return;
        }
        if (_department == -1) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请选择预约科室后提交";
            return;
        }
        $.ajax({
            url: 'upload_appointment.php?name=' + name + '&sex=' + sex + '&year=' + year + '&phone_num=' + phoneNum + '&appear_time=' + apperaTime + '&department=' + _department,
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
                    document.getElementById('success_info').innerText = "预约成功！";
                    return;
                }
                if (code == -7) {
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "预约失败，每个用户只可预约一次";
                    return;
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
