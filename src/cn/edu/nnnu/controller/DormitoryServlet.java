package cn.edu.nnnu.controller;

import cn.edu.nnnu.entity.Dormitory;
import cn.edu.nnnu.entity.Student;
import cn.edu.nnnu.service.BuildingService;
import cn.edu.nnnu.service.DormitoryService;
import cn.edu.nnnu.service.StudentService;
import cn.edu.nnnu.service.impl.BuildingServiceImpl;
import cn.edu.nnnu.service.impl.DormitoryServiceImpl;
import cn.edu.nnnu.service.impl.StudentServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dormitory")
public class DormitoryServlet extends HttpServlet {

    private DormitoryService dormitoryService = new DormitoryServiceImpl();
    private BuildingService buildingService = new BuildingServiceImpl();
    private StudentService studentService = new StudentServiceImpl();

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
                req.setAttribute("list", this.dormitoryService.list());
                req.setAttribute("buildingList", this.buildingService.list());
                req.getRequestDispatcher("dormitorymanager.jsp").forward(req, resp);
                break;
            case "search":
                String key = req.getParameter("key");
                String value = req.getParameter("value");
                req.setAttribute("list", this.dormitoryService.search(key, value));
                req.setAttribute("buildingList", this.buildingService.list());
                req.getRequestDispatcher("dormitorymanager.jsp").forward(req, resp);
                break;
            case "save":
                Integer buildingId = Integer.parseInt(req.getParameter("buildingId"));
                String name = req.getParameter("name");
                Integer type = Integer.parseInt(req.getParameter("type"));
                String telephone = req.getParameter("telephone");
                // 因为宿舍开始初始化的时候剩余床位(available)和类型(type)一样值，所以这里只获取type，且把available值设置为type
                this.dormitoryService.save(new Dormitory(buildingId, name, type, type, telephone));
                resp.sendRedirect("/dormitory?method=list");
                break;
            case "update":
                Integer id = Integer.parseInt(req.getParameter("id"));
                name = req.getParameter("name");
                telephone = req.getParameter("telephone");
                this.dormitoryService.update(new Dormitory(id, name, telephone));
                resp.sendRedirect("/dormitory?method=list");
                break;
            case "delete":
                id = Integer.parseInt(req.getParameter("id"));
                this.dormitoryService.delete(id);
                resp.sendRedirect("/dormitory?method=list");
                break;
            case "findByBuildingId":
                buildingId = Integer.parseInt(req.getParameter("buildingId"));
                List<Dormitory> dormitoryList = this.dormitoryService.findByBuildingId(buildingId);
                List<Student> studentList = this.studentService.findByDormitoryId(dormitoryList.get(0).getId());

                Map<String,List>map=new HashMap<>();
                map.put("dormitoryList",dormitoryList);
                map.put("studentList",studentList);

                JSONArray jsonArray = JSONArray.fromObject(map);
                resp.setContentType("text/json;charset=UTF-8");
                resp.getWriter().write(jsonArray.toString());
                break;
        }
    }
}
