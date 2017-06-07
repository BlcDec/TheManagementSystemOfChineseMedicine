<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.*" %><%--


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
                    <h2 id="head_contain">诊断窗口</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>

                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <li class="active"><a href="start_diagnose.php">诊断</a></li>
                <%--<li class="active"><a href="select_prescription.php">开药方</a></li>--%>
                <li class="active">查看已选药方</li>
            </ol>
            <h4><span class="label label-success" id="success_info"
                      style="display: none;">${msg}</span></h4>
            <h4><span class="label label-warning" id="fail_info"
                      style="display: none;">${msg}</span></h4>

            <hr/>
            <table class="table table-striped">
                <div class="form-group">
                    <thead>
                    <tr>
                        <th>医生姓名：</th>
                        <th>患者姓名：</th>
                        <th>药方名：</th>
                        <th>药方类型：</th>
                        <th>详情：</th>
                        <th>操作：</th>
                    </tr>
                    </thead>
                </div>
                <%--加载系统库内部的药方--%>
                <%if ((Integer) request.getAttribute("code") == 0) {%>
                <%Doctor doctor = (Doctor) request.getAttribute("doctor");%>
                <%Patient patient = (Patient) request.getAttribute("patient");%>
                <%List<Medicine> medicineList = (List<Medicine>) request.getAttribute("medicine_list");%>
                <%
                    Map<String, List<Materials>> materialsMap = (Map<String, List<Materials>>) request.getAttribute("materials");%>
                <tbody>
                <%for (Medicine medicine : medicineList) {%>
                <tr>
                    <td><%=doctor.getName()%>
                    </td>
                    <td><%=patient.getName()%>
                    </td>
                    <td><%=medicine.getName()%>
                    </td>
                    <td><span class="label label-info">成方</span>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="btn " data-toggle="modal"
                           data-target="#myModal_<%=medicine.getId()%>">查看详细信息</a>
                    </td>
                    <td>
                        <button class="btn btn-danger" data-toggle="modal" style="margin-top: 0px"
                                data-target="#MyModal_<%=medicine.getId()%>">删除
                        </button>
                    </td>
                </tr>
                <%List<Materials> materialsList = materialsMap.get(medicine.getId() + "");%>
                <%--Modal--%>
                <div class="modal fade" id="myModal_<%=medicine.getId()%>" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <p><%=medicine.getName()%>由以下药材组成：</p>
                                <p><%for (Materials m : materialsList) {%>
                                    <%=m.getId() + "号：" + m.getMedicineName()  +  m.getDosage() + '克' + ",   "%>
                                    <%}%></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="MyModal_<%=medicine.getId()%>" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <p>请确认是否要删除此项药方？</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_medicine(<%=medicine.getId()%>)">确认删除
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
                </tbody>


                <%--加载医生自己配置的药方--%>
                <%List<MedicineCombine> medicineCombineList = (List<MedicineCombine>) request.getAttribute("medicine_combine_list");%>
                <%Map<String,List<MaterialsCombine>> combineMaterialsMap = (Map<String, List<MaterialsCombine>>) request.getAttribute("medicine_combine_materials");%>
                <tbody>
                <%for (MedicineCombine medicineCombine : medicineCombineList) {%>
                <tr>
                    <td><%=doctor.getName()%>
                    </td>
                    <td><%=patient.getName()%>
                    </td>
                    <td>无
                    </td>
                    <td><span class="label label-info">医生调配</span>
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="btn " data-toggle="modal"
                           data-target="#modal_<%=medicineCombine.getId()%>">查看详细信息</a>
                    </td>
                    <td>
                        <button class="btn btn-danger" data-toggle="modal" style="margin-top: 0px"
                                data-target="#Modal_<%=medicineCombine.getId()%>">删除
                        </button>
                    </td>
                </tr>

                <%List<MaterialsCombine> materialsCombines = combineMaterialsMap.get(medicineCombine.getId() + "");%>
                <%--Modal--%>
                <div class="modal fade" id="modal_<%=medicineCombine.getId()%>" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <p>此药方由以下药材组成：</p>
                                <p><%for (MaterialsCombine m : materialsCombines) {%>
                                    <%=m.getId() + "号：" + m.getMaterialName()  +  m.getMaterialDosage() + '克' + ",   "%>
                                    <%}%></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="Modal_<%=medicineCombine.getId()%>" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <p>请确认是否要删除此项药方？</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_medicine(<%=medicineCombine.getId()%>)">确认删除
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

    function delete_medicine(medicine_id) {
        if(medicine_id.length == 0){
            document.getElementById('fail_info').style.display = "";
            document.getElementById('success_info').style.display = "none";
            document.getElementById('fail_info').innerText = "请选择药方后删除";
            return ;
        }
        $.ajax({
            url: 'delete_medicine.php?medicine_id=' + medicine_id,
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
                    document.getElementById('success_info').innerText = "删除成功！";
                    document.getElementById('head_contain').innerHTML = '诊断窗口（即将自动跳转）';
                    scrollTo(0,0);
                    window.setTimeout("window.location='selected_prescription.php'",2000);
                    scrollTo(0,0);
                    return;
                }
                if (code == -1) {
                    document.getElementById('fail_info').style.display = "";
                    document.getElementById('success_info').style.display = "none";
                    document.getElementById('fail_info').innerText = "请求参数错误！";
                    document.getElementById('head_contain').innerText = '诊断窗口（即将自动跳转）';
                    scrollTo(0,0);
                    window.setTimeout("window.location='selected_prescription.php'",3000);
                    scrollTo(0,0);
                    return;
                }
            },
            fail: function (returndata) {
                document.getElementById('fail_info').innerText = "网络错误，提交失败";
                document.getElementById('fail_info').style.display = "";
                document.getElementById('head_contain').innerText = '诊断窗口（即将自动跳转）';
                scrollTo(0,0);
                window.setTimeout("window.location='selected_prescription.php'",3000);
            }
        });

    }
</script>

</body>
</html>
