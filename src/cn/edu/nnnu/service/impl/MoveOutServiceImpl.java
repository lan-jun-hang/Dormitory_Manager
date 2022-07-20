package cn.edu.nnnu.service.impl;

import cn.edu.nnnu.dao.DormitoryDao;
import cn.edu.nnnu.dao.MoveOutDao;
import cn.edu.nnnu.dao.StudentDao;
import cn.edu.nnnu.dao.impl.DormitoryDaoImpl;
import cn.edu.nnnu.dao.impl.MoveOutDaoImpl;
import cn.edu.nnnu.dao.impl.StudentDaoImpl;
import cn.edu.nnnu.entity.MoveOut;
import cn.edu.nnnu.service.MoveOutService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class MoveOutServiceImpl implements MoveOutService {

    private MoveOutDao moveOutDao = new MoveOutDaoImpl();
    private StudentDao studentDao = new StudentDaoImpl();
    private DormitoryDao dormitoryDao = new DormitoryDaoImpl();

    @Override
    public void save(MoveOut moveOut) {
        // 迁出学生首先需要把学生状态改为“迁出”
        Integer updateStateByStudentId = this.studentDao.updateStateByStudentId(moveOut.getStudentId());
        // 对宿舍床位进行更新
        Integer addAvailable = this.dormitoryDao.addAvailable(moveOut.getDormitoryId());
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        moveOut.setCreateDate(simpleDateFormat.format(date));
        Integer save = this.moveOutDao.save(moveOut);
        if (save != 1 || updateStateByStudentId != 1 || addAvailable != 1) throw new RuntimeException("迁出学生失败");
    }

    @Override
    public List<MoveOut> list() {
        return this.moveOutDao.list();
    }

    @Override
    public List<MoveOut> search(String key, String value) {
        if (value.equals("")) return this.moveOutDao.list();
        return this.moveOutDao.search(key, value);
    }
}
