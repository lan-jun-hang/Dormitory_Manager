package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.DormitoryDao;
import cn.edu.nnnu.dao.StudentDao;
import cn.edu.nnnu.dao.impl.DormitoryDaoImpl;
import cn.edu.nnnu.dao.impl.StudentDaoImpl;
import cn.edu.nnnu.entity.Dormitory;
import cn.edu.nnnu.service.DormitoryService;

import java.util.List;

public class DormitoryServiceImpl implements DormitoryService {

    private DormitoryDao dormitoryDao = new DormitoryDaoImpl();
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public List<Dormitory> availableList() {
        return dormitoryDao.availableList();
    }

    @Override
    public List<Dormitory> list() {
        return this.dormitoryDao.list();
    }

    @Override
    public List<Dormitory> search(String key, String value) {
        if (value.equals("")) return this.dormitoryDao.list();
        return this.dormitoryDao.search(key, value);
    }

    @Override
    public void save(Dormitory dormitory) {
        Integer save = this.dormitoryDao.save(dormitory);
        if (save != 1) throw new RuntimeException("添加宿舍信息失败");
    }

    @Override
    public void update(Dormitory dormitory) {
        Integer update = this.dormitoryDao.update(dormitory);
        if (update != 1) throw new RuntimeException("更改宿舍信息失败");
    }

    @Override
    public void delete(Integer id) {
        List<Integer> studentIdList = this.studentDao.findStudentIdByDormitoryId(id); // 再根据宿舍id找到所有学生id
        for (Integer studentId : studentIdList) {
            Integer availableId = this.dormitoryDao.availableId(); // 找到空余宿舍
            Integer updateDormitory = this.studentDao.updateDormitory(studentId, availableId); // 把学生放到空余宿舍里面
            Integer subAvailable = this.dormitoryDao.subAvailable(availableId);                // 再给所放宿舍床位-1
            if (updateDormitory != 1 || subAvailable != 1) throw new RuntimeException("学生更换宿舍失败");
        }
        Integer delete = this.dormitoryDao.deleteById(id);
        if (delete != 1) throw new RuntimeException("删除宿舍信息失败");
    }

    @Override
    public List<Dormitory> findByBuildingId(Integer buildingId) {
        return this.dormitoryDao.findByBuildingId(buildingId);
    }
}
