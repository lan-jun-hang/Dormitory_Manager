package cn.edu.nnnu.dao;

import cn.edu.nnnu.entity.MoveOut;

import java.util.List;

public interface MoveOutDao {
    public Integer save(MoveOut moveOut);

    public List<MoveOut> list();

    public List<MoveOut> search(String key,String value);
}
