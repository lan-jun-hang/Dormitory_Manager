package cn.edu.nnnu.controller;

import cn.edu.nnnu.entity.DormitoryAdmin;
import cn.edu.nnnu.service.DormitoryAdminService;
import cn.edu.nnnu.service.impl.DormitoryAdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.Key;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dormitoryAdmin")
public class DormitoryAdminServlet extends HttpServlet {

    private DormitoryAdminService dormitoryAdminService = new DormitoryAdminServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String method = req.getParameter("method");
        switch (method) {
            case "list":
                req.setAttribute("list", this.dormitoryAdminService.list());
                req.getRequestDispatcher("adminmanager.jsp").forward(req, resp);
                break;
            case "search":
                String key = req.getParameter("key");
                String value = req.getParameter("value");
                List<DormitoryAdmin> search = null;
                search = this.dormitoryAdminService.search(key, value);
                System.out.println(search.size());
                req.setAttribute("list", search);
                req.getRequestDispatcher("adminmanager.jsp").forward(req, resp);
                break;
            case "save":
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String name = req.getParameter("name");
                String gender = req.getParameter("gender");
                String telephone = req.getParameter("telephone");
                this.dormitoryAdminService.save(new DormitoryAdmin(username, password, name, gender, telephone));
                resp.sendRedirect("/dormitoryAdmin?method=list");
                break;
            case "update":
                Integer id = Integer.parseInt(req.getParameter("id"));
                username = req.getParameter("username");
                password = req.getParameter("password");
                name = req.getParameter("name");
                gender = req.getParameter("gender");
                telephone = req.getParameter("telephone");
                this.dormitoryAdminService.update(new DormitoryAdmin(id, username, password, name, gender, telephone));
                resp.sendRedirect("/dormitoryAdmin?method=list");
                break;
            case "delete":
                id = Integer.parseInt(req.getParameter("id"));
                this.dormitoryAdminService.delete(id);
                resp.sendRedirect("/dormitoryAdmin?method=list");
                break;
        }

    }
}
