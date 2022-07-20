package cn.edu.nnnu.dao.impl;

import cn.edu.nnnu.dao.DormitoryAdminDao;
import cn.edu.nnnu.entity.DormitoryAdmin;
import cn.edu.nnnu.entity.SystemAdmin;
import cn.edu.nnnu.util.JDBCUtil;
import com.mysql.jdbc.JDBC4PreparedStatement;
import com.sun.org.apache.bcel.internal.generic.DADD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DormitoryAdminImpl implements DormitoryAdminDao {
    @Override
    public List<DormitoryAdmin> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from dormitory_admin";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<DormitoryAdmin> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt(1);
                String username = resultSet.getString(2);
                String password = resultSet.getString(3);
                String name = resultSet.getString(4);
                String gender = resultSet.getString(5);
                String telephone = resultSet.getString(6);
                list.add(new DormitoryAdmin(id, username, password, name, gender, telephone));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public List<DormitoryAdmin> search(String key, String value) {

        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from dormitory_admin where  " + key + " like ?";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<DormitoryAdmin> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + value + "%");
            resultSet = statement.executeQuery();
//            String rsq = ((JDBC4PreparedStatement) statement).asSql();
//            System.out.println("============");
//            System.out.println(value);
//            System.out.println(rsq);
//            System.out.println("============");
            while (resultSet.next()) {
                int id = resultSet.getInt(1);
                String username = resultSet.getString(2);
                String password = resultSet.getString(3);
                String name = resultSet.getString(4);
                String gender = resultSet.getString(5);
                String telephone = resultSet.getString(6);
                list.add(new DormitoryAdmin(id, username, password, name, gender, telephone));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public Integer save(DormitoryAdmin dormitoryAdmin) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "insert into dormitory_admin(username,password,name,gender,telephone) values (?,?,?,?,?) ";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, dormitoryAdmin.getUsername());
            statement.setString(2, dormitoryAdmin.getPassword());
            statement.setString(3, dormitoryAdmin.getName());
            statement.setString(4, dormitoryAdmin.getGender());
            statement.setString(5, dormitoryAdmin.getTelephone());
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

    @Override
    public Integer update(DormitoryAdmin dormitoryAdmin) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "update dormitory_admin set username = ? ,password=?,name =?,gender=?,telephone=? where id=?";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, dormitoryAdmin.getUsername());
            statement.setString(2, dormitoryAdmin.getPassword());
            statement.setString(3, dormitoryAdmin.getName());
            statement.setString(4, dormitoryAdmin.getGender());
            statement.setString(5, dormitoryAdmin.getTelephone());
            statement.setInt(6, dormitoryAdmin.getId());
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
        String sql = "delete from dormitory_admin where id = " + id;
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

    @Override
    public DormitoryAdmin findByUsername(String username) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "select * from dormitory_admin where  username = ?";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        DormitoryAdmin dormitoryAdmin = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                username = resultSet.getString(2);
                String password = resultSet.getString(3);
                String name = resultSet.getString(4);
                dormitoryAdmin = new DormitoryAdmin(id,username, password, name);
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return dormitoryAdmin;
    }

}
