<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/css/bootstrap.min.css">
    <script src="bootstrap-5.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/font/bootstrap-icons.css">

    <script type="application/javascript">
        function change(url, index) {
            $(".list-group-item").removeClass("active");
            $(".list-group-item").eq(index).addClass("active");
            $("iframe").attr("src", url);
        }
    </script>
</head>
<body>

<nav class=" container-fluid navbar navbar-expand-lg navbar-light bg-light " style="margin-bottom: 10px">
    <div class="container-fluid" style="margin-bottom: 10px;margin-top: 10px">

        <a class="navbar-brand" href="#"><h1>宿舍管理系统-宿舍管理员</h1></a>

        <div class="collapse navbar-collapse" id="navbarText">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">一个用于管理学生宿舍的管理系统</a>
                </li>
            </ul>

            <span class="navbar-text"  >
                    <i class="bi bi-person-bounding-box fst-normal"> 欢迎回来！${dormitoryAdmin.name}</i>
            </span>
            <span class="navbar-text" style="margin-left: 50px;margin-right: 20px">
                <i class="bi bi-box-arrow-right fst-normal"> <a href="/account?method=logout"> 安全退出 </a></i>
            </span>

        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-2">

            <a href="javascript:void(0)" class="list-group-item active" onclick="change('/absent?method=init',0)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bookmark fa-fw"></i>
						</span>学生缺寝登记
            </a>
            <a href="javascript:void(0)" class="list-group-item" onclick="change('/absent?method=list',1)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bookmark-o fa-fw"></i>
						</span>学生缺寝记录
            </a>

        </div>
        <!--右边内容-->
        <iframe style="width: 81%; height: 800px; border: 0;" src="/absent?method=init"></iframe>
    </div>
</div>
<div class="footer">
    <p class="text-center">
        2022 © ALL REGHTS RESERVED
    </p>
</div>
</body>
</html>
