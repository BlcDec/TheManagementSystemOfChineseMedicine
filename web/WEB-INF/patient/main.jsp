<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
		@media(max-width:768px) {
			.navbar-default{
				color:white;
				position:fixed;
				top:100px;
				z-index: 100;
				background-color: #fdfdfe;
				width: 100%;
				text-align: center;
			}
			#main-menu{
				padding: 0;
			}
			#main-menu a:hover{
				color: #31588A;
			}
			#main-menu a:active{
				color: #31588A !important;
			}
			#main-menu a:link{
				color: #31588A;
			}
			#main-menu a:visited{
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
				<a class="navbar-brand" href="#">
					<img height="50" width="50" src="assets/img/logo.png"/>
				</a>

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
					<a href="index.php"><i class="glyphicon glyphicon-book"></i>在线预约</a>
				</li>
				<li>
					<a href="user.php"><i class="glyphicon glyphicon-user"></i>个人中心</a>
				</li>
				<li >
					<a href="add.php"><i class="glyphicon glyphicon-plus"></i>个人中心</a>
				</li>
				<li>
					<a href="search.php"><i class="glyphicon glyphicon-search"></i>药品检索</a>
				</li>
				<li>
					<a href="../"><i class="fa fa-home"></i>返回主页</a>
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
			<%--<% if ((Integer) request.getAttribute("code") == 0) {--%>
				<%--DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");--%>

				<%--List<BookCrossingBook> bookList = (List<BookCrossingBook>) request.getAttribute("bookcrossingItem");--%>
				<%--for (BookCrossingBook book : bookList) {--%>
			<%--%>--%>
			<%--<div id="<%=book.getId() %>">--%>
				<%--<div class="subject clearfix" style="float: inherit;">--%>
					<%--<div id="photo" class="" style="float: left;">--%>
						<%--<img src="<%=book.getImages()%>" title="点击看大图" alt="书籍图片缺失" rel="v:photo"--%>
							 <%--style="width: 180px;height: 240px">--%>
						<%--<br>--%>
					<%--</div>--%>
					<%--<div id="book_info" class="" style="float: inherit;margin-left: 200px;">--%>
						<%--<span class="pl">书名:</span>&nbsp;--%>
						<%--<span id="author"><%=book.getBookName()%></span>--%>
						<%--<br>--%>
						<%--<span class="pl">作者:</span>&nbsp;--%>
						<%--<span id="author"><%=book.getAuthor()%></span>--%>
						<%--<br>--%>
						<%--<span class="pl">出版社:</span> <%=book.getPublisher()%><br>--%>
						<%--<span class="pl">ISBN:</span> <%=book.getISBN()%><br>--%>
						<%--<span class="pl">定价:</span> <%=book.getPrice()%><br>--%>
						<%--<span class="pl">放漂时间:</span> <%=dateFormat.format(book.getAddTime())%><br>--%>
						<%--<span class="pl">取漂地点:</span> <%=book.getAddress()%><br>--%>
						<%--&lt;%&ndash;<%if (book.getStatus() == 0) {%>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<span class="pl">书籍状态：</span>尚未借出 <br>&ndash;%&gt;--%>
						<%--<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#myModal_<%=book.getId()%>">接受漂流</button>--%>
						<%--&lt;%&ndash;<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>&ndash;%&gt;--%>

						<%--&lt;%&ndash;<%} else if (book.getStatus() == 1) {%>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<span class="pl">书籍状态：</span>已借出 <br>&ndash;%&gt;--%>
						<%--&lt;%&ndash;&lt;%&ndash;需要么？&ndash;%&gt;&ndash;%&gt;--%>
						<%--&lt;%&ndash;<span class="pl">借书人学号：</span><%=book.getReceiveUsername()%> <br>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<span class="pl">借阅日期：</span><%=dateFormat.format(book.getReceiveTime())%> <br>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<%}%>&ndash;%&gt;--%>
					<%--</div>--%>
				<%--</div>--%>
				<%--<br/>--%>
			<%--</div>--%>
			<%--<!-- Modal -->--%>
			<%--<div class="modal fade" id="myModal_<%=book.getId()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
				<%--<div class="modal-dialog" role="document">--%>
					<%--<div class="modal-content">--%>
						<%--<div class="modal-header">--%>
							<%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
							<%--<h4 class="modal-title"  data-toggle="modal" data-target="#myModal">接受漂流</h4>--%>
						<%--</div>--%>
						<%--<div class="modal-body">--%>
							<%--<p>请确认是否要接受《<%=book.getBookName() %>》的漂流？</p>--%>
						<%--</div>--%>
						<%--<div class="modal-footer">--%>
							<%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
							<%--<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="take_book(<%=book.getId()%>)">确认接受漂流</button>--%>
						<%--</div>--%>
					<%--</div>--%>
				<%--</div>--%>
			<%--</div>--%>

			<%--<%--%>
				<%--}--%>
			<%--} else {--%>
			<%--%>--%>
			<%--<h3><span class="label label-info">${msg}</span></h3>--%>
			<%--<%--%>
				<%--}--%>
			<%--%>--%>
			<%--<%--%>
				<%--int now_page = (Integer) request.getAttribute("page");--%>
				<%--int pageCount = (Integer) request.getAttribute("pageCount");--%>
				<%--List<Integer> pageList = (List<Integer>) request.getAttribute("pageList");--%>
			<%--%>--%>

			<%--<div class="list-cell">--%>
				<%--<nav aria-label="...">--%>
					<%--<ul class="pagination">--%>
						<%--<li <%if (now_page == 1) {%>class="disabled" <%}%>><%if (now_page != 1) {%><a--%>
								<%--href="index.php?page=<%=now_page-1%>" aria-label="Previous"><%}%><span--%>
								<%--aria-hidden="true">&laquo;</span></a></li>--%>
						<%--<%for (Integer p : pageList) {%>--%>
						<%--<li <%if (now_page == p) {%> class="active"<%}%>><a href="index.php?page=<%=p%>"><%=p%>--%>
						<%--</a></li>--%>
						<%--<%}%>--%>
						<%--<li <%if (now_page == pageCount) {%> class="disabled"<%}%>><%if (now_page != pageCount) {%><a--%>
								<%--href="index.php?page=<%=now_page+1%>" aria-label="Next"><%}%><span aria-hidden="true">&raquo;</span></a>--%>
						<%--</li>--%>
					<%--</ul>--%>
				<%--</nav>--%>
			<%--</div>--%>

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
    function take_book(book_id) {
        if (book_id == null) {
            return;
        } else {
            $.ajax({
                url: 'get_crossingbook.php?book_id=' + book_id,
                type: 'GET',
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
    }
</script>

</body>
</html>
