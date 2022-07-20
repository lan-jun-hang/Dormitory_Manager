package cn.edu.nnnu.dao.impl;

import cn.edu.nnnu.dao.BuildingDao;
import cn.edu.nnnu.entity.Building;
import cn.edu.nnnu.entity.Dormitory;
import cn.edu.nnnu.entity.DormitoryAdmin;
import cn.edu.nnnu.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BuildingDaoImpl implements BuildingDao {
    @Override
    public List<Building> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT building.id,building.name,building.introduction,dormitory_admin.name,dormitory_admin.id FROM building,dormitory_admin WHERE building.admin_id = dormitory_admin.id";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Building> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                String name = resultSet.getString(2);
                String introduction = resultSet.getString(3);
                String adminName = resultSet.getString(4);
                Integer adminId = resultSet.getInt(5);
                list.add(new Building(id, name, introduction, adminName, adminId));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public List<Building> search(String key, String value) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT building.id,building.name,building.introduction,dormitory_admin.name,dormitory_admin.id " +
                "FROM building,dormitory_admin WHERE building.admin_id = dormitory_admin.id AND building."
                + key + " LIKE '%" + value + "%'";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Building> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                String name = resultSet.getString(2);
                String introduction = resultSet.getString(3);
                String adminName = resultSet.getString(4);
                Integer adminId = resultSet.getInt(5);
                list.add(new Building(id, name, introduction, adminName, adminId));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public Integer save(Building building) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "insert into building(name,introduction,admin_id) values (?,?,?) ";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, building.getName());
            statement.setString(2, building.getIntroduction());
            statement.setInt(3, building.getAdminId());
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

    @Override
    public Integer update(Building building) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "update building set name = ?,introduction = ?,admin_id = ? where id = ?";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, building.getName());
            statement.setString(2, building.getIntroduction());
            statement.setInt(3, building.getAdminId());
            statement.setInt(4,building.getId());
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

    @Override
    public Integer delete(Integer id) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "delete from building where id = " + id;
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

}
