package cn.edu.nnnu.controller;

import cn.edu.nnnu.dao.StudentDao;
import cn.edu.nnnu.dao.impl.StudentDaoImpl;
import cn.edu.nnnu.entity.MoveOut;
import cn.edu.nnnu.service.MoveOutService;
import cn.edu.nnnu.service.impl.MoveOutServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/moveout")
public class MoveOutServlet extends HttpServlet {

    private StudentDao studentDao = new StudentDaoImpl();
    private MoveOutService moveOutService = new MoveOutServiceImpl();

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
                req.setAttribute("list", this.studentDao.moveOutList());
                req.getRequestDispatcher("moveoutregister.jsp").forward(req, resp);
                break;
            case "search":
                String key = req.getParameter("key");
                String value = req.getParameter("value");
                req.setAttribute("list", this.studentDao.searchForMoveOut(key, value));
                req.getRequestDispatcher("moveoutregister.jsp").forward(req, resp);
                break;
            case "moveout":
                Integer studentId = Integer.parseInt(req.getParameter("studentId"));
                Integer dormitoryId = Integer.parseInt(req.getParameter("dormitoryId"));
                String reason = req.getParameter("reason");
                this.moveOutService.save(new MoveOut(studentId, dormitoryId, reason));
                resp.sendRedirect("/moveout?method=list");
                break;
            case "record":
                req.setAttribute("list", this.moveOutService.list());
                req.getRequestDispatcher("moveoutrecord.jsp").forward(req, resp);
                break;
            case "recordSearch":
                key = req.getParameter("key");
                value = req.getParameter("value");
                req.setAttribute("list", this.moveOutService.search(key, value));
                req.getRequestDispatcher("moveoutrecord.jsp").forward(req, resp);
                break;
        }
    }
}
