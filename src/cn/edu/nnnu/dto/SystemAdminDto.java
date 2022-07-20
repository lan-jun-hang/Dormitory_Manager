package cn.edu.nnnu.dto;

import cn.edu.nnnu.entity.SystemAdmin;

public class SystemAdminDto {
    private Integer code;
    private SystemAdmin systemAdmin;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public SystemAdmin getSystemAdmin() {
        return systemAdmin;
    }

    public void setSystemAdmin(SystemAdmin systemAdmin) {
        this.systemAdmin = systemAdmin;
    }
}
