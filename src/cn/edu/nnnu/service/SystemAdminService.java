package cn.edu.nnnu.service;

import cn.edu.nnnu.dto.SystemAdminDto;

public interface SystemAdminService {
    public SystemAdminDto login(String username, String password);
}
