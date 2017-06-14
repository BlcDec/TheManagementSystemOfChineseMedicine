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


                <li class="active-link">
                    <a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>
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
                <%List<MedicineHistory> medicineHistories = (List<MedicineHistory>) request.getAttribute("medicineHistories");%>
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
                            <button class="btn btn-info" onclick="show_detail('<%=medicineHistory.getPatientIdCard()%>')" style="margin-top: 0px">点击查看药方详细信息</button>
                        </td>
                    </tr>
                    <input type="text" id="<%=medicineHistory.getPatientIdCard()%>" value="<%=medicineHistory.getPatientIdCard()%>"  style="display: none"/>

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
            <form action="medicine_history_detail.php" method="GET" id="form" style="display: none;">
                <input type="text" name="patient_id_card" id="patient_id_card">
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
    function show_detail(patientIdCard) {
        if (patientIdCard.length === 0) {
            document.getElementById('fail_info').style.display = "";
            document.getElementById('fail_info').innerText = "请完善信息后提交";
            return;
        }
        document.getElementById('patient_id_card').value = patientIdCard;
        document.getElementById('form').submit();
    }

</script>

</body>
</html>
