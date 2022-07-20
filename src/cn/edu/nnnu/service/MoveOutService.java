package cn.edu.nnnu.service;

import cn.edu.nnnu.entity.MoveOut;

import java.util.List;

public interface MoveOutService {
    public void save(MoveOut moveOut);

    public List<MoveOut> list();

    public List<MoveOut> search(String key,String value);
}
