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

                    <form action="/moveout?method=search" method="post">
                        <div class="row">

                            <div class="col input-group">
                                <span class="input-group-text">
                                    字段
                                </span>
                                <select name="key" class="form-select dropdown-toggle" aria-label="Default">
                                    <option value="number">学号</option>
                                    <option value="name">姓名</option>
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
                        <th>宿舍</th>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="student">
                        <tr>
                            <td>${student.id}</td>
                            <td>${student.dormitoryName}</td>
                            <td>${student.number}</td>
                            <td>${student.name}</td>
                            <td>${student.gender}</td>
                            <td>${student.state}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-danger"
                                            data-id="${student.id}"
                                            data-dormitory-id="${student.dormitoryId}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#delUserModal">
                                        <i class="bi bi-x-square fst-normal"> 迁出 </i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- 迁出模态框示例（Modal） -->
                <form method="post" action="/moveout?method=moveout">
                    <div class="modal fade" id="delUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%--  模态框头部--%>
                                <div class="modal-header">
                                    <h4 class="modal-title">学生迁出信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <%-- 模态框内容--%>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <h3 class="col-sm-18 control-label" id="deleteLabel">删除信息</h3>
                                                <input type="hidden" class="form-control" id="tab"
                                                       name="tab" placeholder="" value="dor_admin"> <input
                                                    type="hidden" class="form-control" id="id"
                                                    name="studentId" placeholder="">
                                                <input type="hidden" class="form-control"
                                                       name="dormitoryId" id="dormitoryId">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">迁出原因</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="reason">
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <!-- 模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                                    <button type="submit" class="btn btn-primary">迁出</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
</div>

<script>
    $('#delUserModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var id = button.data('id')
        var dormitoryId = button.data('dormitory-id')
        var modal = $(this)
        modal.find('.modal-title').text('学生迁出登记')
        modal.find('#deleteLabel').text('将迁出学号为  ' + id + ' 的学生')
        modal.find('#id').val(id)
        modal.find('#dormitoryId').val(dormitoryId)
    })
</script>

</body>

</html>