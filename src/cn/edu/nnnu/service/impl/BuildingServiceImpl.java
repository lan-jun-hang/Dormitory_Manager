package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.BuildingDao;
import cn.edu.nnnu.dao.DormitoryDao;
import cn.edu.nnnu.dao.StudentDao;
import cn.edu.nnnu.dao.impl.BuildingDaoImpl;
import cn.edu.nnnu.dao.impl.DormitoryDaoImpl;
import cn.edu.nnnu.dao.impl.StudentDaoImpl;
import cn.edu.nnnu.entity.Building;
import cn.edu.nnnu.entity.Dormitory;
import cn.edu.nnnu.entity.Student;
import cn.edu.nnnu.service.BuildingService;

import java.util.List;

public class BuildingServiceImpl implements BuildingService {

    private BuildingDao buildingDao = new BuildingDaoImpl();
    private DormitoryDao dormitoryDao = new DormitoryDaoImpl();
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public List<Building> list() {
        return this.buildingDao.list();
    }

    @Override
    public List<Building> search(String key, String value) {
        if (value.equals("")) return this.buildingDao.list();
        return this.buildingDao.search(key, value);
    }

    @Override
    public void save(Building building) {
        Integer save = this.buildingDao.save(building);
        if (save != 1) throw new RuntimeException("添加楼栋信息失败");
    }

    @Override
    public void update(Building building) {
        Integer update = this.buildingDao.update(building);
        if (update != 1) throw new RuntimeException("更新楼栋信息失败");
    }

    @Override
    public void delete(Integer id) {
        // 先给学生换宿舍
        List<Integer> dormitoryIdList = this.dormitoryDao.findDormitoryIdByBuildingId(id); // 根据楼的id找到所有宿舍id
        for (Integer dormitoryId : dormitoryIdList) {
            List<Integer> studentIdList = this.studentDao.findStudentIdByDormitoryId(dormitoryId); // 再根据宿舍id找到所有学生id
            for (Integer studentId : studentIdList) {
                Integer availableId = this.dormitoryDao.availableId(); // 找到空余宿舍
                Integer updateDormitory = this.studentDao.updateDormitory(studentId, availableId); // 把学生放到空余宿舍里面
                Integer subAvailable = this.dormitoryDao.subAvailable(availableId);                // 再给所放宿舍床位-1
                if (updateDormitory != 1 || subAvailable != 1) throw new RuntimeException("学生更换宿舍失败");
            }
        }
        // 再删除宿舍
        for (Integer dormitoryId : dormitoryIdList) {
            Integer delete = this.dormitoryDao.deleteById(dormitoryId);
            if (delete != 1) throw new RuntimeException("宿舍删除失败");
        }
        // 最后才能删除楼栋
        Integer delete = this.buildingDao.delete(id);
        if (delete != 1) throw new RuntimeException("楼栋信息删除失败");
    }
}
