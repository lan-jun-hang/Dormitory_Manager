<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/css/bootstrap.min.css">
    <script src="bootstrap-5.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="bootstrap-5.1.3/font/bootstrap-icons.css">

    <title>宿舍管理系统</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-10">

            <!-- 顶部搜索部分 -->
            <div class="card">
                <div class="card-header bg-info">搜索</div>

                <div class="card-body">
                    <form action="/moveout?method=recordSearch" method="post">
                        <div class="row">

                            <div class="col input-group">
                                <span class="input-group-text">
                                    字段
                                </span>
                                <select name="key" class="form-select dropdown-toggle" aria-label="Default">
                                    <option value="studentName">学生</option>
                                    <option value="dormitoryName">宿舍</option>
                                </select>
                            </div>
                            <div class="input-group w-25">
                                <span class="input-group-text">
                                    值
                                </span>
                                <input type="text" class="form-control" placeholder="输入具体搜索字段" name="value">
                                <button class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 列表展示-->
            <div class="table-responsive">
                <table class="table table-hover ">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>学生</th>
                        <th>宿舍</th>
                        <th>迁出原因</th>
                        <th>迁出日期</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="moveout">
                        <tr>
                            <td>${moveout.id}</td>
                            <td>${moveout.studentName}</td>
                            <td>${moveout.dormitoryName}</td>
                            <td>${moveout.reason}</td>
                            <td>${moveout.createDate}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>
</div>

</body>

</html>