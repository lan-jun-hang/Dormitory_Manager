package cn.edu.nnnu.service;

import cn.edu.nnnu.entity.Student;

import java.util.List;

public interface StudentService {
    public List<Student> list();

    public List<Student> search(String key, String value);

    public void save(Student student);

    public void update(Student student, Integer oldDormitoryId);

    public void delete(Integer id, Integer dormitoryId);

    public List<Student> moveOutList();

    public List<Student> searchForMoveOut(String key, String value);

    public List<Student> findByDormitoryId(Integer dormitoryId);
}
