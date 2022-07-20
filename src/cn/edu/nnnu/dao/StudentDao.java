package cn.edu.nnnu.dao;

import cn.edu.nnnu.entity.Student;

import java.util.List;

public interface StudentDao {
    public List<Student> list();

    public List<Student> search(String key, String value);

    public Integer save(Student student);

    public Integer update(Student student);

    public Integer delete(Integer id);

    public List<Integer> findStudentIdByDormitoryId(Integer id);

    public Integer updateDormitory(Integer studentId, Integer dormitoryId);

    public List<Student> moveOutList();

    public List<Student> searchForMoveOut(String key,String value);

    public Integer updateStateByStudentId(Integer id);

    public List<Student> findByDormitoryId(Integer id);
}
