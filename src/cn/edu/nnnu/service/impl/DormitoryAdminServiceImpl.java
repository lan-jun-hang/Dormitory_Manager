package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.DormitoryAdminDao;
import cn.edu.nnnu.dao.impl.DormitoryAdminImpl;
import cn.edu.nnnu.dto.DormitoryAdminDto;
import cn.edu.nnnu.entity.DormitoryAdmin;
import cn.edu.nnnu.service.DormitoryAdminService;

import java.util.List;

public class DormitoryAdminServiceImpl implements DormitoryAdminService {

    private DormitoryAdminDao dormitoryAdminDao = new DormitoryAdminImpl();

    @Override
    public List<DormitoryAdmin> list() {
        return this.dormitoryAdminDao.list();
    }

    @Override
    public List<DormitoryAdmin> search(String key, String value) {
        if (value.equals("")) return dormitoryAdminDao.list();
        return dormitoryAdminDao.search(key, value);
    }

    @Override
    public void save(DormitoryAdmin dormitoryAdmin) {
        Integer save = this.dormitoryAdminDao.save(dormitoryAdmin);
        if (save != 1) throw new RuntimeException("宿管信息添加失败");
    }

    @Override
    public void update(DormitoryAdmin dormitoryAdmin) {
        Integer update = this.dormitoryAdminDao.update(dormitoryAdmin);
        if (update != 1) throw new RuntimeException("宿管信息更新失败");
    }

    @Override
    public void delete(Integer id) {
        Integer delete = this.dormitoryAdminDao.delete(id);
        if (delete != 1) throw new RuntimeException("宿管信息删除失败");
    }

    @Override
    public DormitoryAdminDto login(String username, String password) {
        DormitoryAdmin dormitoryAdmin = this.dormitoryAdminDao.findByUsername(username);
        DormitoryAdminDto dormitoryAdminDto = new DormitoryAdminDto();
        if (dormitoryAdmin == null) {
            dormitoryAdminDto.setCode(-1);
        } else {
            if (!dormitoryAdmin.getPassword().equals(password)) {
                dormitoryAdminDto.setCode(-2);
            } else {
                dormitoryAdminDto.setCode(0);
                dormitoryAdminDto.setDormitoryAdmin(dormitoryAdmin);
            }
        }
        return dormitoryAdminDto;
    }

}
