package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.DormitoryDao;
import cn.edu.nnnu.dao.StudentDao;
import cn.edu.nnnu.dao.impl.DormitoryDaoImpl;
import cn.edu.nnnu.dao.impl.StudentDaoImpl;
import cn.edu.nnnu.entity.Student;
import cn.edu.nnnu.service.StudentService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class StudentServiceImpl implements StudentService {

    private StudentDao studentDao = new StudentDaoImpl();
    private DormitoryDao dormitoryDao = new DormitoryDaoImpl();

    @Override
    public List<Student> list() {
        return this.studentDao.list();
    }

    @Override
    public List<Student> search(String key, String value) {
        if (value.equals("")) return this.studentDao.list();
        return this.studentDao.search(key, value);
    }

    @Override
    public void save(Student student) {
        student.setState("入住");
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        student.setCreateDate(simpleDateFormat.format(date));
        Integer save = this.studentDao.save(student);
        Integer sub = this.dormitoryDao.subAvailable(student.getDormitoryId());
        if (save != 1 || sub != 1) throw new RuntimeException("添加学生信息失败");
    }


    @Override
    public void update(Student student, Integer oldDormitoryId) {
        Integer update = this.studentDao.update(student);
        // 更新完成需要把宿舍剩余床位更改：原宿舍床位+1(subAvailable)，新宿舍床位-1
        Integer oldDormitory = this.dormitoryDao.addAvailable(oldDormitoryId);  // 原来宿舍的床位+1
        Integer newDormitory = this.dormitoryDao.subAvailable(student.getDormitoryId()); // 新的宿舍的床位-1
        if (update != 1 || newDormitory != 1 || oldDormitory != 1) throw new RuntimeException("更新学生信息失败");
    }

    @Override
    public void delete(Integer id, Integer dormitoryId) {
        Integer delete = this.studentDao.delete(id);
        Integer available = this.dormitoryDao.addAvailable(dormitoryId);
        if (delete != 1 || available != 1) throw new RuntimeException("删除学生信息失败");
    }

    @Override
    public List<Student> moveOutList() {
        return this.studentDao.moveOutList();
    }

    @Override
    public List<Student> searchForMoveOut(String key, String value) {
        if (value.equals("")) return this.studentDao.list();
        return this.studentDao.searchForMoveOut(key, value);
    }

    @Override
    public List<Student> findByDormitoryId(Integer dormitoryId) {
        return this.studentDao.findByDormitoryId(dormitoryId);
    }
}
