package cn.edu.nnnu.dto;

import cn.edu.nnnu.entity.DormitoryAdmin;

public class DormitoryAdminDto {
    private Integer code;
    private DormitoryAdmin dormitoryAdmin;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public DormitoryAdmin getDormitoryAdmin() {
        return dormitoryAdmin;
    }

    public void setDormitoryAdmin(DormitoryAdmin dormitoryAdmin) {
        this.dormitoryAdmin = dormitoryAdmin;
    }
}
