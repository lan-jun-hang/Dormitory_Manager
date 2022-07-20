<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/css/bootstrap.min.css">
    <script src="bootstrap-5.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/font/bootstrap-icons.css">
    <script>
        function change(url, index) {
            $(".list-group-item").removeClass("active");
            $(".list-group-item").eq(index).addClass("active");
            $("iframe").attr("src", url);
        }
    </script>
</head>
<body>
<%--上部分--%>
<nav class=" container-fluid navbar navbar-expand-lg navbar-light bg-light " style="margin-bottom: 10px">
    <div class="container-fluid" style="margin-bottom: 10px;margin-top: 10px">
        <a class="navbar-brand" href="#"><h1>宿舍管理系统-系统管理员</h1></a>
        <div class="collapse navbar-collapse" id="navbarText">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">一个用于管理学生宿舍的管理系统</a>
                </li>
            </ul>
            <span class="navbar-text"  >
                    <i class="bi bi-person-bounding-box fst-normal"> 欢迎回来！${systemAdmin.name}</i>
            </span>
            <span class="navbar-text" style="margin-left: 50px;margin-right: 20px">
                <i class="bi bi-box-arrow-right fst-normal"> <a href="/account?method=logout"> 安全退出 </a></i>
            </span>
        </div>
    </div>
</nav>

<%--动态显示部分--%>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-2">

            <a href="javascript:void(0)" class="list-group-item active"
               onclick="change('/dormitoryAdmin?method=list',0)">
						<span class="" aria-hidden="true">
							<i class="fa fa-user-circle-o fa-fw"></i>
						</span>宿管管理
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/student?method=list',1)">
						<span class="" aria-hidden="true">
							<i class="fa fa-user-circle fa-fw"></i>
						</span>学生管理
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/building?method=list',2)">
						<span class="" aria-hidden="true">
							<i class="fa fa-home fa-fw"></i>
						</span>楼栋管理
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/dormitory?method=list',3)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bed fa-fw"></i>
						</span>宿舍管理
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/moveout?method=list',4)">
						<span class="" aria-hidden="true">
							<i class="fa fa-address-card-o fa-fw"></i>
						</span>学生迁出登记
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/moveout?method=record',5)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bookmark fa-fw"></i>
						</span>学生迁出记录
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/absent?method=list',6)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bookmark-o fa-fw"></i>
						</span>学生缺寝记录
            </a>

        </div>
        <!--右边内容-->
        <iframe style="width: 80%; height: 800px; border: 0;" src="/dormitoryAdmin?method=list"></iframe>
    </div>
</div>

<%--底部--%>
<div class="footer">
    <p class="text-center">
        2022 © ALL REGHTS RESERVED
    </p>
</div>
</body>
</html>
