package cn.edu.nnnu.controller;

import cn.edu.nnnu.entity.*;
import cn.edu.nnnu.service.AbsentService;
import cn.edu.nnnu.service.BuildingService;
import cn.edu.nnnu.service.DormitoryService;
import cn.edu.nnnu.service.StudentService;
import cn.edu.nnnu.service.impl.AbsentServiceImpl;
import cn.edu.nnnu.service.impl.BuildingServiceImpl;
import cn.edu.nnnu.service.impl.DormitoryServiceImpl;
import cn.edu.nnnu.service.impl.StudentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/absent")
public class AbsentServlet extends HttpServlet {

    private BuildingService buildingService = new BuildingServiceImpl();
    private DormitoryService dormitoryService = new DormitoryServiceImpl();
    private StudentService studentService = new StudentServiceImpl();
    private AbsentService absentService = new AbsentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String method = req.getParameter("method");
        switch (method) {
            case "init":
                List<Building> buildingList = this.buildingService.list();
                List<Dormitory> dormitoryList = this.dormitoryService.findByBuildingId(buildingList.get(0).getId());
                List<Student> studentList = this.studentService.findByDormitoryId(dormitoryList.get(0).getId());
                req.setAttribute("buildingList", buildingList);
                req.setAttribute("dormitoryList", dormitoryList);
                req.setAttribute("studentList", studentList);
                req.getRequestDispatcher("absentregister.jsp").forward(req, resp);
                break;
            case "save":
                Integer buildingId = Integer.parseInt(req.getParameter("buildingId"));
                Integer dormitoryId = Integer.parseInt(req.getParameter("dormitoryId"));
                Integer studentId = Integer.parseInt(req.getParameter("studentId"));
                String date = req.getParameter("date");
                String reason = req.getParameter("reason");
                HttpSession session = req.getSession();
                DormitoryAdmin dormitoryAdmin = (DormitoryAdmin) session.getAttribute("dormitoryAdmin");
                this.absentService.save(new Absent(buildingId, dormitoryId, studentId, dormitoryAdmin.getId(), date, reason));
                resp.sendRedirect("/absent?method=list");
                break;
            case "list":
                req.setAttribute("list", this.absentService.list());
                req.getRequestDispatcher("absentrecord.jsp").forward(req, resp);
                break;
            case "search":
                String key = req.getParameter("key");
                String value = req.getParameter("value");
                req.setAttribute("list", this.absentService.search(key, value));
                req.getRequestDispatcher("absentrecord.jsp").forward(req, resp);
                break;
        }
    }
}
