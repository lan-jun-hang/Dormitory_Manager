<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022-06-15
  Time: 下午 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
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

                    <form action="/dormitoryAdmin?method=search" method="post">
                        <div class="row">

                            <div class="col input-group">
                                <span class="input-group-text">
                                    字段
                                </span>
                                <select name="key" class="form-select dropdown-toggle" aria-label="Default">
                                    <option value="username">宿管用户名</option>
                                    <option value="name">宿管姓名</option>
                                    <option value="telephone">宿管电话</option>
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
                                    添加宿管信息
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
                        <th>用户名</th>
                        <th>密码</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>联系电话</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="dormitoryAdmin">
                        <tr>
                            <td>${dormitoryAdmin.id}</td>
                            <td>${dormitoryAdmin.username}</td>
                            <td>${dormitoryAdmin.password}</td>
                            <td>${dormitoryAdmin.name}</td>
                            <td>${dormitoryAdmin.gender}</td>
                            <td>${dormitoryAdmin.telephone}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-warning "
                                            data-id="${dormitoryAdmin.id}"
                                            data-username="${dormitoryAdmin.username}"
                                            data-password="${dormitoryAdmin.password}"
                                            data-name="${dormitoryAdmin.name}"
                                            data-gender="${dormitoryAdmin.gender}"
                                            data-telephone="${dormitoryAdmin.telephone}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#updateUserModal">
                                        <i class="bi bi-pencil-square fst-normal"> 修改 </i>
                                    </button>

                                    <button type="button" class="btn btn-outline-danger "
                                            data-id="${dormitoryAdmin.id}" data-bs-toggle="modal"
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
                <form method="post" action="/dormitoryAdmin?method=save">
                    <div class="modal fade" id="addUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h4 class="modal-title">添加宿管信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <!-- 模态框内容 -->
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">用户名</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="username"
                                                       name="username" placeholder="请输入用户名">
                                            </div>
                                        </div>
                                        <br>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">密码</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="password"
                                                       name="password" value="" placeholder="请输入密码">
                                            </div>
                                        </div>
                                        <br>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">姓名</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="name"
                                                       name="name" value="" placeholder="请输入姓名">
                                            </div>
                                        </div>
                                        <br>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">性别</label>
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="男" class="gender"
                                                       name="gender"> 男
                                                &nbsp;&nbsp;&nbsp;<input type="radio" value="女" class="gender"
                                                                         name="gender"> 女
                                            </div>
                                        </div>
                                        <br>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">联系电话</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="telephone"
                                                       name="telephone" value="" placeholder="请输入联系电话">
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
                <form method="post" action="/dormitoryAdmin?method=update">
                    <div class="modal fade" id="updateUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%-- update 模态框头部--%>
                                <div class="modal-header">
                                    <h4 class="modal-title">修改宿管信息</h4>
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
                                            <label for="user_id" class="col-sm-3 control-label">用户名</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="username"
                                                       name="username" placeholder="请输入用户名">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">密码</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="password"
                                                       name="password" value="" placeholder="请输入密码">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">姓名</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="name"
                                                       name="name" value="" placeholder="请输入姓名">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">性别</label>
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="男" class="gender"
                                                       name="gender"> 男&nbsp;&nbsp;&nbsp;
                                                <input type="radio" value="女" class="gender"
                                                       name="gender"> 女
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">联系电话</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="telephone"
                                                       name="telephone" value="" placeholder="">
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

                <!-- 删除模态框示例（Modal） -->
                <form method="post" action="/dormitoryAdmin?method=delete">
                    <div class="modal fade" id="delUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <%-- 删除框头部 --%>
                                <div class="modal-header">
                                    <h4 class="modal-title">删除宿管信息</h4>
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
        var username = button.data('username')
        var password = button.data('password')
        var name = button.data('name')
        var gender = button.data('gender')
        var telephone = button.data('telephone')
        var modal = $(this)

        modal.find('.modal-title').text('修改宿管信息')
        modal.find('#id').val(id)
        modal.find('#username').val(username)
        modal.find('#password').val(password)
        modal.find('#name').val(name)
        var list = modal.find('.gender')
        for (var i = 0; i < list.length; i++) {
            if (gender == $(list.get(i)).val()) {
                $(list.get(i)).prop('checked', true)
            }
        }
        modal.find('#telephone').val(telephone)
    })

    $('#delUserModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var id = button.data('id')
        var modal = $(this)
        modal.find('.modal-title').text('删除宿管信息')
        modal.find('#deleteLabel').text('是否删除ID为  ' + id + ' 的信息')
        modal.find('#id').val(id)
    })
</script>
</body>

</html>
