package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.SystemAdminDao;
import cn.edu.nnnu.dao.impl.SystemAdminDaoImpl;
import cn.edu.nnnu.dto.SystemAdminDto;
import cn.edu.nnnu.entity.SystemAdmin;
import cn.edu.nnnu.service.SystemAdminService;

public class SystemAdminServiceImpl implements SystemAdminService {

    private SystemAdminDao systemAdminDao = new SystemAdminDaoImpl();
    private SystemAdminDto systemAdminDto = new SystemAdminDto();

    @Override
    public SystemAdminDto login(String username, String password) {
        SystemAdmin systemAdmin = this.systemAdminDao.findByUsername(username);
        if (username == null) {
            systemAdminDto.setCode(-1);
        } else {
            if (!systemAdmin.getPassword().equals(password)) {
                systemAdminDto.setCode(-2);
            } else {
                systemAdminDto.setCode(0);
                systemAdminDto.setSystemAdmin(systemAdmin);
            }
        }
        return systemAdminDto;
    }
}
