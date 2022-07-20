package cn.edu.nnnu.dao;

import cn.edu.nnnu.entity.SystemAdmin;

public interface SystemAdminDao {
    public SystemAdmin findByUsername(String username);
}
