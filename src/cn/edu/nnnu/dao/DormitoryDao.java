package cn.edu.nnnu.dao;

import cn.edu.nnnu.entity.Dormitory;

import java.util.List;

public interface DormitoryDao {
    public List<Dormitory> list();

    public List<Dormitory> search(String key, String value);

    public List<Dormitory> availableList();

    public Integer subAvailable(Integer id);

    public Integer addAvailable(Integer id);

    public List<Integer> findDormitoryIdByBuildingId(Integer id);

    public Integer availableId();

    public Integer deleteById(Integer id);

    public Integer save(Dormitory dormitory);

    public Integer update(Dormitory dormitory);

    public Integer delete(Integer id);

    public List<Dormitory> findByBuildingId(Integer id);
}
