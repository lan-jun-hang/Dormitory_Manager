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

                    <form action="/building?method=search" method="post">
                        <div class="row">

                            <div class="col input-group">
                                <span class="input-group-text">
                                    字段
                                </span>
                                <select name="key" class="form-select dropdown-toggle" aria-label="Default">
                                    <option value="name">名称</option>
                                    <option value="introduction">介绍</option>
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

                            <div class="col">
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                        data-bs-target="#addUserModal">
                                    <i class="bi bi-person-plus"></i>
                                    添加楼栋信息
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
                        <th>名称</th>
                        <th>介绍</th>
                        <th>管理员</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="building">
                        <tr>
                            <td>${building.id}</td>
                            <td>${building.name}</td>
                            <td>${building.introduction}</td>
                            <td>${building.adminName}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-warning "
                                            data-id="${building.id}"
                                            data-name="${building.name}"
                                            data-introduction="${building.introduction}"
                                            data-admin-id="${building.adminId}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#updateUserModal">
                                        <i class="bi bi-pencil-square fst-normal">修改</i>
                                    </button>

                                    <button type="button" class="btn btn-outline-danger  "
                                            data-id="${building.id}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#delUserModal">
                                        <i class="bi bi-trash3 fst-normal">删除</i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- add框示例（Modal） -->
                <form method="post" action="/building?method=save">
                    <div class="modal fade" id="addUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h4 class="modal-title">添加楼栋信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <!-- 模态框内容 -->
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">名称</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="name"
                                                       name="name" value="" placeholder="请输入名称">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">介绍</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="introduction"
                                                       name="introduction" value="" placeholder="请输入介绍">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">管理员</label>
                                            <div class="col-sm-9">
                                                <select class="form-control" name="adminId">
                                                    <c:forEach items="${adminList}" var="admin">
                                                        <option class="adminId"
                                                                value="${admin.id}">${admin.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                    </form>
                                </div>

                                <!-- 模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- update框示例（Modal） -->
                <form method="post" action="/building?method=update">
                    <div class="modal fade" id="updateUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%-- update 模态框头部--%>
                                <div class="modal-header">
                                    <h4 class="modal-title">修改楼栋信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <!-- update 模态框内容 -->
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">ID</label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly required class="form-control" id="id"
                                                       name="id">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">名称</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="name"
                                                       name="name" value="" placeholder="请输入名称">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">介绍</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="introduction"
                                                       name="introduction" value="" placeholder="请输入介绍">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">管理员</label>
                                            <div class="col-sm-9">
                                                <select class="form-control" name="adminId">
                                                    <c:forEach items="${adminList}" var="admin">
                                                        <option class="adminId"
                                                                value="${admin.id}">${admin.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                    </form>
                                </div>

                                <!-- 删除模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- 删除模态框示例（Modal） -->
                <form method="post" action="/building?method=delete">
                    <div class="modal fade" id="delUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%-- 删除框头部 --%>
                                <div class="modal-header">
                                    <h4 class="modal-title">删除楼栋信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <!-- 删除 框内容 -->
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <h3 class="col-sm-18 control-label" id="deleteLabel">删除信息</h3>
                                                <input type="hidden" class="form-control" id="tab"
                                                       name="tab" placeholder="" value="dor_admin"> <input
                                                    type="hidden" class="form-control" id="id"
                                                    name="id" placeholder="">
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <!-- 删除模态框底部 -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $('#updateUserModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var id = button.data('id')
        var adminId = button.data('admin-id')
        var name = button.data('name')
        var introduction = button.data('introduction')
        var modal = $(this)

        modal.find('.modal-title').text('修改楼栋信息')
        modal.find('#id').val(id)
        var list = modal.find('.adminId')
        for (var i = 0; i < list.length; i++) {
            var obj = $(list.get(i));
            if (adminId == obj.val()) {
                obj.prop("selected", "selected");
            }
        }
        modal.find('#introduction').val(introduction)
        modal.find('#name').val(name)
    })

    $('#delUserModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var id = button.data('id')
        var modal = $(this)
        modal.find('.modal-title').text('删除楼宇信息')
        modal.find('#deleteLabel').text('是否删除ID为  ' + id + ' 的信息')
        modal.find('#id').val(id)
    })
</script>

</body>

</html>