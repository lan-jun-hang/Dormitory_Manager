package cn.edu.nnnu.controller;

import cn.edu.nnnu.entity.Building;
import cn.edu.nnnu.service.BuildingService;
import cn.edu.nnnu.service.DormitoryAdminService;
import cn.edu.nnnu.service.impl.BuildingServiceImpl;
import cn.edu.nnnu.service.impl.DormitoryAdminServiceImpl;

import javax.print.attribute.standard.MediaSize;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/building")
public class BuildingServlet extends HttpServlet {

    private BuildingService buildingService = new BuildingServiceImpl();
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
                req.setAttribute("list", this.buildingService.list());
                req.setAttribute("adminList", this.dormitoryAdminService.list());
                req.getRequestDispatcher("buildingmanager.jsp").forward(req, resp);
                break;
            case "search":
                String key = req.getParameter("key");
                String value = req.getParameter("value");
                req.setAttribute("list", this.buildingService.search(key, value));
                req.setAttribute("adminList", this.dormitoryAdminService.list());
                req.getRequestDispatcher("buildingmanager.jsp").forward(req, resp);
                break;
            case "save":
                String name = req.getParameter("name");
                String introduction = req.getParameter("introduction");
                Integer adminId = Integer.parseInt(req.getParameter("adminId"));
                this.buildingService.save(new Building(name, introduction, adminId));
                resp.sendRedirect("/building?method=list");
                break;
            case "update":
                Integer id = Integer.parseInt(req.getParameter("id"));
                name = req.getParameter("name");
                introduction = req.getParameter("introduction");
                adminId = Integer.parseInt(req.getParameter("adminId"));
                this.buildingService.update(new Building(id, name, introduction, adminId));
                resp.sendRedirect("/building?method=list");
                break;
            case "delete":
                id = Integer.parseInt(req.getParameter("id"));
                this.buildingService.delete(id);
                resp.sendRedirect("/building?method=list");
                break;
        }
    }
}
