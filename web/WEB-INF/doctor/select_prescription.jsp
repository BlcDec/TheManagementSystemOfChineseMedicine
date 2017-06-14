<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Medicine" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Materials" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--


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
                <li class="active">开药方</li>
            </ol>

            <hr/>
            <div class="row">
                <form method="post" action="select_prescription.php">
                    <div class="col-lg-6">
                        <div class="input-group">
                            <input id="search_content" name="search_content" type="text" class="form-control"
                                   placeholder="请输入关键字搜索你需要的药方">
                            <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">搜索</button>
                                <button type="button" class="btn btn-default" onclick="jump()">查看已选药方</button>
                        </span>
                        </div>
                    </div>
                </form>
                <h4><span class="label label-success" id="success_info"
                          style="display: none;">${msg}</span></h4>
                <h4><span class="label label-warning" id="fail_info"
                          style="display: none;">${msg}</span></h4>
            </div>
            <div class="row-fluid">
                <%if ((Integer) request.getAttribute("code") == 0) {%>
                <%List<Medicine> medicines = (List<Medicine>) request.getAttribute("medicineList");%>
                <%Map<String,List<Materials>> materialsMap = (Map<String, List<Materials>>) request.getAttribute("materials");%>
                <table class="table table-striped">
                    <div class="form-group">
                        <thead>
                        <tr>
                            <th>药名：</th>
                            <th>价格：</th>
                            <th>操作：</th>
                            <th>　详情：</th>
                        </tr>
                        </thead>
                    </div>
                    <%for (Medicine medicine : medicines) {%>
                    <%List<Materials> materialsList = materialsMap.get(medicine.getId() + "");%>
                    <tbody>
                    <tr>

                        <td><%=medicine.getName()%>
                        </td>
                        <td><%=medicine.getPrice()%>元
                        </td>
                        <td>
                            <button class="btn btn-primary" type="button" data-toggle="modal"
                                    data-target="#MyModal_<%=medicine.getId()%>">添加药品
                            </button>
                        </td>
                        <td>
                            <a href="javascript:void(0);" class="btn " data-toggle="modal"
                               data-target="#myModal_<%=medicine.getId()%>">查看详细信息</a>
                        </td>
                        <%--<td><span class="label label-success">已缴纳</span></td>--%>
                    </tr>
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
                                    <p>确认要为该患者添加 <%=medicine.getName()%>吗?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="commit(<%=medicine.getId()%>)">确认添加</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                    <p><%for(Materials m : materialsList){%>
                                        <%=m.getId() + " " + m.getMedicineName()%>
                                        <%}%></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
            <%
                int now_page = (Integer) request.getAttribute("page");
                int pageCount = (Integer) request.getAttribute("pageCount");
                String searchContent = (String) request.getAttribute("search_content");
                List<Integer> pageList = (List<Integer>) request.getAttribute("pageList");
            %>

            <div class="list-cell">
                <nav aria-label="...">
                    <ul class="pagination">
                        <li <%if (now_page == 1) {%>class="disabled" <%}%>><%if (now_page != 1) {%><a
                                href="select_prescription.php?page=<%=now_page-1%>&search_content=<%=searchContent%>"
                                aria-label="Previous"><%}%><span
                                aria-hidden="true">&laquo;</span></a></li>
                        <%for (Integer p : pageList) {%>
                        <li <%if (now_page == p) {%> class="active"<%}%>
                        ><a href="select_prescription.php?page=<%=p%>&search_content=<%=searchContent%>"><%=p%>
                        </a></li>
                        <%}%>
                        <li <%if (now_page == pageCount) {%> class="disabled"<%}%>><%if (now_page != pageCount) {%><a
                                href="select_prescription.php?page=<%=now_page+1%>&search_content=<%=searchContent%>"
                                aria-label="Next"><%}%><span
                                aria-hidden="true">&raquo;</span></a>
                        </li>
                    </ul>
                </nav>
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
        window.setTimeout("window.location='selected_prescription.php'");
    }
    function commit(medicine_id) {
        if (medicine_id.length == 0) {
            document.getElementById('fail_info').innerText = '请选择药品后添加';
            document.getElementById('fail_info').style.display = "";
            return;
        }
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
                    scrollTo(0,0)
                    alert('添加成功，点击跳转');
                    window.location.href = 'start_diagnose.php';
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
