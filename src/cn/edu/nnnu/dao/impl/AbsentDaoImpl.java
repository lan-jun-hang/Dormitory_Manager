package cn.edu.nnnu.dao.impl;

import cn.edu.nnnu.dao.AbsentDao;
import cn.edu.nnnu.entity.Absent;
import cn.edu.nnnu.entity.Student;
import cn.edu.nnnu.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AbsentDaoImpl implements AbsentDao {
    @Override
    public Integer save(Absent absent) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "insert into absent(building_id ,dormitory_id ,student_id,dormitory_admin_id,create_date,reason) values (?,?,?,?,?,?) ";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, absent.getBuildingId());
            statement.setInt(2, absent.getDormitoryId());
            statement.setInt(3, absent.getStudentId());
            statement.setInt(4, absent.getDormitoryAdminId());
            statement.setString(5, absent.getCreateDate());
            statement.setString(6, absent.getReason());
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

    @Override
    public List<Absent> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT a.id,b.name,d.name,s.name,a.reason,da.name,a.create_date FROM dormitory d,student s,building b,absent a,dormitory_admin da WHERE d.id = a.dormitory_id AND s.id = a.student_id AND b.id = a.building_id AND da.id = a.dormitory_admin_id";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Absent> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                String buildingName = resultSet.getString(2);
                String dormitoryId = resultSet.getString(3);
                String studentName = resultSet.getString(4);
                String reason = resultSet.getString(5);
                String dormitoryAdminName = resultSet.getString(6);
                String createDate = resultSet.getString(7);
                list.add(new Absent(id, buildingName, dormitoryId, studentName, reason, dormitoryAdminName, createDate));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public List<Absent> search(String key, String value) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT a.id,b.name,d.name,s.name,a.reason,da.name,a.create_date \n" +
                "FROM \n" +
                "dormitory d,student s,building b,absent a,dormitory_admin da \n" +
                "WHERE \n" +
                "d.id = a.dormitory_id \n" +
                "AND s.id = a.student_id \n" +
                "AND b.id = a.building_id \n" +
                "AND da.id = a.dormitory_admin_id\n" +
                "AND d.`name` LIKE '%1%'";
        String keyStatement = "";
        switch (key) {
            case "buildingName": // 用楼栋进行搜索
                keyStatement = "and b.name";
                break;
            case "dormitoryName":
                keyStatement = "and d.name";
                break;
        }
        sql = sql + keyStatement + " like '%" + value + "%'";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Absent> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                String buildingName = resultSet.getString(2);
                String dormitoryId = resultSet.getString(3);
                String studentName = resultSet.getString(4);
                String reason = resultSet.getString(5);
                String dormitoryAdminName = resultSet.getString(6);
                String createDate = resultSet.getString(7);
                list.add(new Absent(id, buildingName, dormitoryId, studentName, reason, dormitoryAdminName, createDate));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }
}
