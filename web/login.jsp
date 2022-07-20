<%--
  Created by IntelliJ IDEA.
  User: 11783
  Date: 2022/6/11
  Time: 20:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="css/login.css" rel="stylesheet" type="text/css">
    <style>
        * {
            margin: 0 auto;
        }

        body {
            background-color: #343a40;
        }

        .container {
            position: relative;
            top: 100px;
        }

        .news-nav {
            clear: both;
            height: 80px;
            margin-left: 10px;
            margin-right: 10px;
            width: 170px;
            margin: 0 auto;
        }

        .news-nav li {
            float: left;
            list-style-type: none;
            margin: 0 10px;
            font-size: 30px;
            display: block;
            width: 86px;
            height: 79px;
            text-align: center;
            line-height: 79px;
            font-weight: bold;
            color: #007bff;
            cursor: pointer;
        }

        .news-nav li.on {
            color: #74dcff;
            border-bottom-color: #74dcff;
            border-bottom-style: solid;
            border-bottom-width: 2px;
        }

        #index-news-list-2 {
            display: none;
        }

        .modal-dialog {
            max-width: 100% !important;
        }

        .modal-content {
            background: rgba(0, 0, 0, 0.3);
            width: 700px;
        }

        .loginForm {
            width: 400px;
        }

        .loginForm .form-group {
            margin: 30px 0;
        }

        .loginForm .form-group .form-control {
            height: 40px;
            font-size: 15px;
        }

        input[type="checkbox"] {
            position: relative;
            top: -2px;
            vertical-align: middle;
            cursor: pointer;
            zoom: 1.6;
        }

        input[type="radio"] {
            position: relative;
            top: -3px;
            vertical-align: middle;
            cursor: pointer;
            zoom: 1.6;
        }

        .btn-primary {
            background-color: #3e4963;
            border: 0px solid transparent;
            width: 400px;
            height: 50px;
            font-size: 24px;
            font-family: STKaiti;
        }

        label {
            color: #fff;
            font-size: 16px;
        }

        span {
            color: red;
            font-size: 13px;

        }

        /*验证码*/
        .drag {
            width: 300px;
            height: 40px;
            line-height: 40px;
            background-color: #e8e8e8;
            position: relative;
            margin: 0 auto;
        }

        .bg {
            width: 40px;
            height: 100%;
            position: absolute;
            background-color: #75CDF9;
        }

        .text {
            position: absolute;
            width: 100%;
            height: 100%;
            text-align: center;
            user-select: none;
        }

        .code {
            width: 40px;
            height: 38px;
            position: absolute;
            border: 1px solid #ccc;
            cursor: move;
            font-family: "宋体";
            text-align: center;
            background-color: #fff;
            user-select: none;
            color: #666;
        }

    </style>

    <script>
        function validateForm() {
            if (success === false) {
                alert("请正确输入滑块")
                return false;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="modal-dialog" id="login_form">
        <div class="modal-content">
            <div class="modal-title">
                <ul class="news-nav js-nav-title">
                    <li class="on" data="login">登录</li>
                </ul>
            </div>
            <div class="modal-body index-news-list" id="index-news-list-1">
                <form class="loginForm" id="loginForm" action="account?method=login" method="post"
                      onsubmit="return validateForm()">

                    <div class="form-group">
                        <span>${usernameError}</span>
                        <input class="form-control required" name="username" required id="name" type="text"
                               placeholder="请输入用户名或邮箱">
                    </div>

                    <div class="form-group">
                        <span>${passwordError}</span>
                        <input class="form-control required" name="password" required id="password" type="password"
                               placeholder="请输入密码">
                    </div>


                    <div class="drag">
                        <div class="bg"></div>
                        <div class="text" onselectstart="return false;">请拖动滑块解锁</div>
                        <div class="code">>></div>
                    </div>


                    <div class="form-group">
                        <label class="radio-inline">
                            <input type="radio" name="type" id="remember" checked value="systemAdmin"
                                   class="radio-inline"> 系统管理员
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="type" id="remember-2" value="dormitoryAdmin" class="radio-inline">
                            宿舍管理员
                        </label>
                    </div>

                    <div class="form-group">
                        <button class="btn btn-primary" type="submit">登录</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(".js-nav-title li").click(function () {
            $(this).attr("class", "on");
            $(this).siblings().attr("class", "");
            var index = $(".js-nav-title li").index(this);
            $(".index-news-list").css("display", "none");
            $("#index-news-list-" + (index + 1)).css("display", "block");
        });
    });

</script>

<script>
    // 验证码

    //一、定义一个获取DOM元素的方法
    var $ = function (selector) {
            return document.querySelector(selector);
        },
        box = $(".drag"),//容器
        bg = $(".bg"),//背景
        text = $(".text"),//文字
        code = $(".code"),//滑块
        success = false,//是否通过验证的标志
        distance = box.offsetWidth - code.offsetWidth;//滑动成功的宽度（距离）

    //二、给滑块注册鼠标按下事件
    code.onmousedown = function (e) {

//1.鼠标按下之前必须清除掉后面设置的过渡属性
        code.style.transition = "";
        bg.style.transition = "";

//说明：clientX 事件属性会返回当事件被触发时，鼠标指针向对于浏览器页面(或客户区)的水平坐标。

//2.当滑块位于初始位置时，得到鼠标按下时的水平位置
        var e = e || window.event;
        var downX = e.clientX;

//三、给文档注册鼠标移动事件
        document.onmousemove = function (e) {

            var e = e || window.event;
//1.获取鼠标移动后的水平位置
            var moveX = e.clientX;

//2.得到鼠标水平位置的偏移量（鼠标移动时的位置 - 鼠标按下时的位置）
            var offsetX = moveX - downX;

//3.在这里判断一下：鼠标水平移动的距离 与 滑动成功的距离 之间的关系
            if (offsetX > distance) {
                offsetX = distance;//如果滑过了终点，就将它停留在终点位置
            } else if (offsetX < 0) {
                offsetX = 0;//如果滑到了起点的左侧，就将它重置为起点位置
            }

//4.根据鼠标移动的距离来动态设置滑块的偏移量和背景颜色的宽度
            code.style.left = offsetX + "px";
            bg.style.width = offsetX + "px";

//如果鼠标的水平移动距离 = 滑动成功的宽度
            if (offsetX == distance) {

//1.设置滑动成功后的样式
                text.innerHTML = "验证通过";
                text.style.color = "#fff";
                code.innerHTML = "√";
                code.style.color = "green";
                bg.style.backgroundColor = "lightgreen";

//2.设置滑动成功后的状态
                success = true;
//成功后，清除掉鼠标按下事件和移动事件（因为移动时并不会涉及到鼠标松开事件）
                code.onmousedown = null;
                document.onmousemove = null;

//3.成功解锁后的回调函数
                setTimeout(function () {
                    console.log('解锁成功！');
                }, 100);
            }
        }

//四、给文档注册鼠标松开事件
        document.onmouseup = function (e) {

//如果鼠标松开时，滑到了终点，则验证通过
            if (success) {
                return;
            } else {
//反之，则将滑块复位（设置了1s的属性过渡效果）
                code.style.left = 0;
                bg.style.width = 0;
                code.style.transition = "left 1s ease";
                bg.style.transition = "width 1s ease";
            }
//只要鼠标松开了，说明此时不需要拖动滑块了，那么就清除鼠标移动和松开事件。
            document.onmousemove = null;
            document.onmouseup = null;
        }


    }
</script>
</body>
</html>