package cn.edu.nnnu.dao.impl;

import cn.edu.nnnu.dao.MoveOutDao;
import cn.edu.nnnu.entity.MoveOut;
import cn.edu.nnnu.entity.Student;
import cn.edu.nnnu.util.JDBCUtil;
import com.mysql.jdbc.JDBC4PreparedStatement;
import com.sun.org.apache.bcel.internal.generic.MONITORENTER;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MoveOutDaoImpl implements MoveOutDao {


    @Override
    public Integer save(MoveOut moveOut) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "insert into moveout(student_id ,dormitory_id ,reason,create_date) values (?,?,?,?) ";
        PreparedStatement statement = null;
        Integer result = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, moveOut.getStudentId());
            statement.setInt(2, moveOut.getDormitoryId());
            statement.setString(3, moveOut.getReason());
            statement.setString(4, moveOut.getCreateDate());
            result = statement.executeUpdate();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, null);
        }
        return result;
    }

    @Override
    public List<MoveOut> list() {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT m.id,s.name,d.name,m.reason,m.create_date FROM moveout m,student s,dormitory d WHERE m.student_id = s.id AND m.dormitory_id = d.id";
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<MoveOut> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer id = resultSet.getInt(1);
                String studentName = resultSet.getString(2);
                String dormitoryName = resultSet.getString(3);
                String reason = resultSet.getString(4);
                String createDate = resultSet.getString(5);
                list.add(new MoveOut(id, studentName, dormitoryName, reason, createDate));
            }

        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }

    @Override
    public List<MoveOut> search(String key, String value) {
        Connection connection = JDBCUtil.getConnection();
        String sql = "SELECT m.id,s.name,d.name,m.reason,m.create_date FROM moveout m,student s,dormitory d WHERE m.student_id = s.id AND m.dormitory_id = d.id ";
        String keyStatement = "";
        switch (key) {
            case "studentName":
                keyStatement = "and s.name";
                break;
            case "dormitoryName":
                keyStatement = "and d.name";
                break;
        }
        sql = sql + keyStatement + " like '%" + value + "%'";
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        List<MoveOut> list = new ArrayList<>();
        try {
            statement = connection.prepareStatement(sql);

//            System.out.println("=================== 测试sql语句 =====================");
//            String printSql = ((JDBC4PreparedStatement)statement).asSql();
//            System.out.println(printSql);
//            System.out.println("====================================================");

            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Integer studentId = resultSet.getInt(1);
                String studentName = resultSet.getString(2);
                String dormitoryName = resultSet.getString(3);
                String reason = resultSet.getString(4);
                String createDate = resultSet.getString(5);
                list.add(new MoveOut(studentId, studentName, dormitoryName, reason, createDate));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        } finally {
            JDBCUtil.release(connection, statement, resultSet);
        }
        return list;
    }
}
