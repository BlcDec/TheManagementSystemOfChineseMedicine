<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.MaterialsStore" %>
<%@ page import="java.util.Map" %><%--
  添加成方
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
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>

    <script type="text/javascript" src="http://www.daimajiayuan.com/download/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.js"></script>
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.css">



    <!-- 3.0 -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

    <!-- 2.3.2
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.js"></script>
    -->
    <script type="text/javascript">
        $(window).on('load', function () {

            $('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });

            // $('.selectpicker').selectpicker('hide');
        });
    </script>
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


                <li>
                    <a href="main.php"><i class="glyphicon glyphicon-plus"></i>用户管理</a>
                </li>
                <li class="active-link">
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
    <!-- /. NAV SIDE  -->
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <h2>药方管理</h2>
                </div>
            </div>
            <ol class="breadcrumb">
                <li class="active">中医药管理系统</li>
                <li class="active"><a href="manage_medicine.php">药方管理</a></li>
                <li class="active">添加药方</li>
            </ol>


            <div class="row" align="left">
                <form method="post" action="add_medicine.php">
                    <%--<div class="input-group">--%>
                    <%--<input id="search_content" name="search_content" type="text" class="form-control"--%>
                    <%--placeholder="请输入关键字搜索你需要的药材">--%>
                    <%--<span class="input-group-btn">--%>
                    <%--<button class="btn btn-default" type="submit">搜索</button>--%>
                    <%--<button type="button" class="btn btn-default" onclick="jump()">查看已提交药方</button>--%>
                    <%--</span>--%>
                    <%--</div>--%>
                        <h2><span class="label label-info" style="margin-left: 15px">填写药方名并选择药材</span></h2>
                    <div class="form-group" align="left" style="padding-left: 15px">
                        <div class="input-group">
                            <span class="input-group-addon">药方名</span>
                            <input id="name" name="name" placeholder="药方名"
                                   class="form-control"
                                   aria-describedby="sizing-addon2">
                        </div>
                    </div>

                    <div class="row-fluid">
                        <%--<form class="form-horizontal" role="form">--%>
                        <div class="row-fluid">
                            <div class="col-lg-5">
                                <select style="margin-top: 10px" id="bs3Select"
                                        class="selectpicker show-tick form-control"
                                        data-live-search="true">
                                    <%if ((Integer) request.getAttribute("code") == 0) {%>
                                    <%Map<String, MaterialsStore> materialsStoreMap = (Map<String, MaterialsStore>) request.getAttribute("materials_store");%>
                                    <%for (String key : materialsStoreMap.keySet()) {%>
                                    <option id="<%=key%>"><%=materialsStoreMap.get(key).getMaterialName()%>
                                    </option>

                                    <%}%>
                                    <%}%>
                                </select>

                                <button style="margin-top: 10px" class="btn btn-default" type="button"
                                        onclick="do_modal()">选择剂量
                                </button>
                                <%--<button style="margin-top: 10px" type="button" class="btn btn-default" onclick="jump()">--%>
                                    <%--查看已选药方--%>
                                <%--</button>--%>
                                <!-- Modal -->
                                <div class="modal fade" id="MyModal" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel">
                                    <div style="left: 0%;" class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close"><span
                                                        aria-hidden="true">&times;</span></button>
                                            </div>
                                            <div class="modal-body" id="medicine_modal_body">
                                                <div id="medicine_msg">
                                                    <h4><span class="label label-default" style="margin-left: 15px">选择药材剂量（单位：克）</span>
                                                    </h4>
                                                    <h3><span class="label label-info" id="medicine_name"
                                                              style="margin-left: 15px">test</span></h3>
                                                    <div class="container">
                                                        <div class="input-group spinner" id="mmp">
                                                            <input type="text" class="form-control" value="0"
                                                                   id="medicine_dosage">
                                                            <div class="input-group-btn-vertical">
                                                                <button class="btn btn-default" type="button"><i
                                                                        class="fa fa-caret-up"></i></button>
                                                                <button class="btn btn-default" type="button"><i
                                                                        class="fa fa-caret-down"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <h3><span class="label label-warning" id="warning"
                                                              style="margin-left: 15px;display: none"></span></h3>
                                                    <h3><span class="label label-success" id="success"
                                                              style="margin-left: 15px;display: none"></span></h3>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary"
                                                        onclick="confirm_add()">确认添加
                                                </button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                                    关闭
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>
                </form>
            </div>
            <%//TODO  使用模态框显示搜索结果%>

            <div class="form-group" align="left">
                <div>
                    <label>药方详情：</label>
                    <div class="form-group">
                        <textarea name="summary" class="form-control" rows="5" id="summary"></textarea>
                    </div>
                    <h3><span class="label label-info" id="info">请在药材名称后的逗号后填写各药材重量，以回车隔开</span></h3>
                    <h4><span class="label label-success" id="success_info"
                              style="display: none;">${msg}</span></h4>
                    <h4><span class="label label-warning" id="fail_info"
                              style="display: none;">${msg}</span></h4>
                    <button type="button" class="btn btn-primary" onclick="commit()">提交</button>
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


<%--<script src="../../theme/assets/js/jquery-1.10.2.js"></script>--%>
<%--<script src="../../theme/assets/js/bootstrap.min.js"></script>--%>
<%--<script src="../../theme/assets/js/custom.js"></script>--%>
<script>
    var select = document.getElementById('bs3Select');
    var summary = document.getElementById('summary');
    var medicine = null;
    function do_modal() {
        var tag = false;
        if (select != null && typeof(select) != "undefined") {
            for (var i = 0; i < select.options.length && !tag; i++) {
                if (select.options[i].selected) {
                    tag = true;
                    medicine = select.options[i];
                }
            }
        }
        if (!tag) {
            alert('请选择药方后添加');
            return;
        }
        var medicine_name = document.getElementById('medicine_name');
        medicine_name.innerHTML = medicine.value;
        document.getElementById('success').style.display = 'none';
        document.getElementById('warning').style.display = 'none';
        $('#MyModal').modal('show');
    }

    function confirm_add() {
        var medicine_dosage = document.getElementById('medicine_dosage');
        var warning = document.getElementById('warning');
        if (medicine_dosage.value <= 0) {
            warning.innerHTML = '请填写正确的药剂重量！';
            warning.style.display = '';
            return;
        }
        if (medicine != null && typeof (medicine) != "undefined") {
            summary.value += medicine.value + ',' + medicine_dosage.value + '克' + '\n';
        }
        medicine_dosage.innerHTML = '0';
        document.getElementById('success').innerHTML = '添加成功';
        document.getElementById('success').style.display = '';
    }


    (function ($) {
        $('.spinner .btn:first-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
        });
        $('.spinner .btn:last-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) - 1);
        });
    })(jQuery);


    //    function add_materials() {
    //        //TODO
    //        if (summary.length != 0) {
    //            summary.value = '';
    //        }
    //        if (select != null && typeof(select) != "undefined") {
    //            for (var i = 0; i < select.options.length; i++) {
    //                if (select.options[i].selected) {
    //                    summary.value = summary.value + select.options[i].value + ',\n';
    //                }
    //            }
    //        }
    //    }
    function jump() {
        window.setTimeout("window.location='selected_prescription.php'");
    }
    function commit() {
        //TODO 需要添加药方名
        $.ajax({
            url: 'add_medicine.php',
            data: 'summary=' + summary.value,
            type: 'POST',
            async: true,
            cache: false,
            contentType: "application/x-www-form-urlencoded",
            processData: false,
            success: function (returndata) {
                var json = returndata;
                var code = json.code;
                if (code == 0) {
                    alert('添加成功！');
                    window.location.href = 'add_medicine.php';
                    return;
                }
                if (code == -1) {
                    alert('提交参数错误，请重试');
                    window.location.href = 'add_medicine.php';
                    return;
                }
            },
            fail: function (returndata) {
                alert('网络错误，请重试');
                window.location.href = 'DIY_prescription.php';
            }
        });

    }
</script>

</body>
</html>
