<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.Patient" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration" %>
<%@ page import="com.imudges.web.manager_medicine_system.bean.MaterialsStore" %>
<%@ page import="java.util.Map" %><%--
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

    <script type="text/javascript" src="http://www.daimajiayuan.com/download/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript"
            src="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.js"></script>
    <link rel="stylesheet" type="text/css"
          href="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.css">


    <!-- 3.0 -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
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

            .modal-dialog {
                left: 0%;
            }
        }

        .spinner {
            width: 100px;
        }

        .spinner input {
            text-align: right;
        }

        .input-group-btn-vertical {
            position: relative;
            white-space: nowrap;
            width: 1%;
            vertical-align: middle;
            display: table-cell;
        }

        .input-group-btn-vertical > .btn {
            display: block;
            float: none;
            width: 100%;
            max-width: 100%;
            padding: 8px;
            margin-left: -1px;
            position: relative;
            border-radius: 0;
        }

        .input-group-btn-vertical > .btn:first-child {
            border-top-right-radius: 4px;
        }

        .input-group-btn-vertical > .btn:last-child {
            margin-top: -2px;
            border-bottom-right-radius: 4px;
        }

        .input-group-btn-vertical i {
            position: absolute;
            top: 0;
            left: 4px;
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


                <li>
                    <a href="windows.php"><i class="glyphicon glyphicon-plus"></i>挂号窗口</a>
                </li>
                <li class="active-link">
                    <a href="diagnose.php"><i class="glyphicon glyphicon-user"></i>诊断窗口</a>
                </li>
                <%--/收款窗口是指收取药品费用的窗口--%>
                <li>
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
            <%--<select>--%>
            <%--<option value="jQuery插件库">jQuery插件库</option>--%>
            <%--<option value="BlackBerry">BlackBerry</option>--%>
            <%--<option value="device">device</option>--%>
            <%--<option value="with">with</option>--%>
            <%--<option value="entertainment">entertainment</option>--%>
            <%--<option value="and">and</option>--%>
            <%--<option value="social">social</option>--%>
            <%--<option value="networking">networking</option>--%>
            <%--<option value="apps">apps</option>--%>
            <%--<option value="or">or</option>--%>
            <%--<option value="apps">apps</option>--%>
            <%--<option value="that">that</option>--%>
            <%--<option value="will">will</option>--%>
            <%--<option value="boost">boost</option>--%>
            <%--<option value="your">your</option>--%>
            <%--<option value="productivity">productivity</option>--%>
            <%--<option value="Download">Download</option>--%>
            <%--<option value="or">or</option>--%>
            <%--<option value="buy">buy</option>--%>
            <%--<option value="apps">apps</option>--%>
            <%--<option value="from">from</option>--%>
            <%--<option value="Afbb">Afbb</option>--%>
            <%--<option value="Akademie">Akademie</option>--%>
            <%--<option value="Berlin">Berlin</option>--%>
            <%--<option value="reviews">reviews</option>--%>
            <%--<option value="by">by</option>--%>
            <%--<option value="real">real</option>--%>
            <%--</select>--%>
            <div class="row">
                <div class="col-lg-12">
                    <%--<%if ((Integer) request.getAttribute("code") == -12 || (Integer) request.getAttribute("code") == -11 || (Integer) request.getAttribute("code") == -13) {%>--%>
                    <%--<h2>诊断窗口（即将自动跳转）</h2>--%>
                    <%--<%} else if ((Integer) request.getAttribute("code") == 0) {%>--%>
                    <h2>诊断窗口</h2>
                    <%--<%}%>--%>
                </div>
            </div>
            <ol class="breadcrumb" style="margin-bottom: 0px">
                <li class="active">中医药管理系统</li>

                <li class="active"><a href="diagnose.php">诊断窗口</a></li>
                <li class="active"><a href="start_diagnose.php">诊断</a></li>
                <li class="active">调配药方</li>
            </ol>
            <hr>
            <div class="row" align="left">
                <form method="post" action="search_content.php">
                    <%--<div class="input-group">--%>
                    <%--<input id="search_content" name="search_content" type="text" class="form-control"--%>
                    <%--placeholder="请输入关键字搜索你需要的药材">--%>
                    <%--<span class="input-group-btn">--%>
                    <%--<button class="btn btn-default" type="submit">搜索</button>--%>
                    <%--<button type="button" class="btn btn-default" onclick="jump()">查看已提交药方</button>--%>
                    <%--</span>--%>
                    <%--</div>--%>
                    <div class="row-fluid">
                        <%--<form class="form-horizontal" role="form">--%>
                        <h4><span class="label label-info" style="margin-left: 15px">选择药材</span></h4>
                        <div class="row-fluid">
                            <div class="col-lg-5">
                                <select style="margin-top: 10px" id="bs3Select"
                                        class="selectpicker show-tick form-control" multiple
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
                                        onclick="do_modal()">添加
                                </button>
                                <!-- Modal -->
                                <div class="modal fade" id="MyModal" tabindex="-1" role="dialog"
                                     aria-labelledby="myModalLabel">
                                    <div style="left: 0%;" class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close"><span
                                                        aria-hidden="true">&times;</span></button>
                                                <div id="medicine_msg" style="display: none">
                                                    <h4><span class="label label-default" style="margin-left: 15px">选择药材剂量（单位：克）</span></h4>
                                                    <h3><span class="label label-info" id="medicine_name" style="margin-left: 15px">test</span></h3>
                                                    <div class="container" id="medicine_dosage">
                                                        <div class="input-group spinner" id="mmp">
                                                            <input type="text" class="form-control" value="0" id="654164165">
                                                            <div class="input-group-btn-vertical">
                                                                <button class="btn btn-default" type="button"><i
                                                                        class="fa fa-caret-up"></i></button>
                                                                <button class="btn btn-default" type="button"><i
                                                                        class="fa fa-caret-down"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body" id="medicine_modal_body">

                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-dismiss="modal"
                                                        onclick="">确认添加
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
                    <button type="button" class="btn btn-primary">提交</button>
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
    function do_modal() {
        var tag = false;
        var arr = [];
        var idArr = [];
        if (select != null && typeof(select) != "undefined") {
            for (var i = 0, j = 0; i < select.options.length; i++) {
                if (select.options[i].selected) {
                    tag = true;
                    idArr[j] = select.options[i].id;
                    arr[j] = select.options[i].value;
                    j++;
                }
            }
        }
        if (!tag) {
            alert('请选择药品后添加');
            return;
        }
        //移除Modal内部的元素
        var medicineModalBody = document.getElementById('medicine_modal_body');
        while(medicineModalBody.hasChildNodes()){
            medicineModalBody.removeChild(medicineModalBody.firstChild);
        }

        //动态加载相应数量的元素
        for(var j = 0;j<arr.length;j++){
            var temp = document.getElementById('medicine_msg');
            var asd = document.getElementById('654164165');
            temp.style.display = "";
            var a = temp.cloneNode(true);
            a.setAttribute('id',idArr[j]);
            asd.id = idArr[j] + 'yy';

            a.firstChild.nextSibling.nextSibling.nextSibling.firstChild.textContent = arr[j];
            temp.style.display = "none";
            var fa = document.getElementById('medicine_modal_body');
            fa.appendChild(a);
        }
        $('#MyModal').modal('show');
    }


    (function ($) {
        $('.spinner .btn:first-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
        });
        $('.spinner .btn:last-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) - 1);
        });
    })(jQuery);


    function add_materials() {
        //TODO
        if (summary.length != 0) {
            summary.value = '';
        }
        if (select != null && typeof(select) != "undefined") {
            for (var i = 0; i < select.options.length; i++) {
                if (select.options[i].selected) {
                    summary.value = summary.value + select.options[i].value + ',\n';
                }
            }
        }
    }
    function jump() {
        window.setTimeout("window.location='selected_prescription.php'");
    }
    function commit() {
        var search_content = document.getElementById('search_content').value;
        if (search_content.length == 0) {
            document.getElementById('fail_info').innerText = '请填写搜索内容后点击搜索';
            document.getElementById('fail_info').style.display = "";
            return;
        }
        $.ajax({
            url: 'search_prescription.php?search_content=' + search_content,
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
