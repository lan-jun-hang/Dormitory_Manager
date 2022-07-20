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

                    <form action="/student?method=search" method="post">
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

                            <div class="col">
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                        data-bs-target="#addUserModal">
                                    <i class="bi bi-person-plus"></i>
                                    添加学生信息
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
                        <th>入住时间</th>
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
                            <td>${student.createDate}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-warning "
                                            data-id="${student.id}"
                                            data-dormitory-id="${student.dormitoryId}"
                                            data-number="${student.number}"
                                            data-name="${student.name}"
                                            data-gender="${student.gender}"
                                            data-create-date="${student.createDate}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#updateUserModal">
                                        <i class="bi bi-pencil-square fst-normal">修改</i>
                                    </button>

                                    <button type="button" class="btn btn-outline-danger"
                                            data-id="${student.id}"
                                            data-dormitory-id="${student.dormitoryId}"
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
                <form method="post" action="/student?method=save">
                    <div class="modal fade" id="addUserModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <!-- 模态框头部 -->
                                <div class="modal-header">
                                    <h4 class="modal-title">添加学生信息</h4>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <!-- 模态框内容 -->
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">宿舍</label>
                                            <div class="col-sm-9">
                                                <select class="form-control" name="dormitoryId">
                                                    <c:forEach items="${dormitoryList}" var="dormitory">
                                                        <option value="${dormitory.id}">${dormitory.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="user_id" class="col-sm-3 control-label">学号</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="number"
                                                       name="number" value="" placeholder="请输入学号">
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
                                                       name="gender"> 男
                                                &nbsp;&nbsp;&nbsp;<input type="radio" value="女" class="gender"
                                                                         name="gender"> 女
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
            </div>
            </form>

            <!-- update框示例（Modal） -->
            <form method="post" action="/student?method=update">
                <div class="modal fade" id="updateUserModal">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <%-- update 模态框头部--%>
                            <div class="modal-header">
                                <h4 class="modal-title">修改学生信息</h4>
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
                                            <%-- 为了取到最开始的dormitory_id--%>
                                            <input type="hidden" name="oldDormitoryId" id="oldDormitoryId"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="user_id" class="col-sm-3 control-label">宿舍</label>
                                        <div class="col-sm-9">
                                            <select class="form-control" name="dormitoryId">
                                                <c:forEach items="${dormitoryList}" var="dormitory">
                                                    <option class="dormitory"
                                                            value="${dormitory.id}">${dormitory.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="user_id" class="col-sm-3 control-label">学号</label>
                                        <div class="col-sm-9">
                                            <input type="text" readonly required class="form-control" id="number"
                                                   name="number" value="" placeholder="请输入学号">
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
                                                   name="gender"> 男
                                            &nbsp;&nbsp;&nbsp;<input type="radio" value="女" class="gender"
                                                                     name="gender"> 女
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="user_id" class="col-sm-3 control-label">入住时间</label>
                                        <div class="col-sm-9">
                                            <input type="text" readonly class="form-control" id="createDate">
                                        </div>
                                    </div>

                                </form>
                            </div>

                            <!-- update框底部 -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                                <button type="submit" class="btn btn-primary">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- 删除模态框示例（Modal） -->
            <form method="post" action="/student?method=delete">
                <div class="modal fade" id="delUserModal">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <%-- 删除框头部 --%>
                            <div class="modal-header">
                                <h4 class="modal-title">删除学生信息</h4>
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
                                            <input type="hidden" name="dormitoryId" id="dormitoryId"/>
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
        var dormitoryId = button.data('dormitory-id')
        var number = button.data('number')
        var name = button.data('name')
        var gender = button.data('gender')
        var createDate = button.data('create-date')
        var modal = $(this)

        modal.find('.modal-title').text('修改学生信息')
        modal.find('#id').val(id)
        modal.find('#number').val(number)
        modal.find('#name').val(name)
        modal.find('#createDate').val(createDate)
        modal.find('#oldDormitoryId').val(dormitoryId)
        var list = modal.find('.gender')
        for (var i = 0; i < list.length; i++) {
            if (gender == $(list.get(i)).val()) {
                $(list.get(i)).prop('checked', true)
            }
        }
        var list2 = modal.find('.dormitory') // 195行
        for (var i = 0; i < list2.length; i++) {
            if (dormitoryId == $(list2.get(i)).val()) {
                $(list2.get(i)).prop('selected', true)
            }
        }
    })

    $('#delUserModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget)
        var id = button.data('id')
        var dormitoryId = button.data('dormitory-id')
        var modal = $(this)
        modal.find('.modal-title').text('删除学生信息')
        modal.find('#deleteLabel').text('是否删除ID为  ' + id + ' 的信息')
        modal.find('#id').val(id)
        modal.find('#dormitoryId').val(dormitoryId)
    })
</script>

</body>

</html>