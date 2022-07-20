package cn.edu.nnnu.util;

import java.lang.annotation.Target;
import java.sql.*;

public class JDBCUtil {
    private static String url = "jdbc:mysql://localhost:3306/dormitory?serverTimezone=UTC&useSSL=false&characterEncoding=utf8";
    private static String userName = "root";
    private static String userPass = "000000";
    private static String driver = "com.mysql.jdbc.Driver";

    static {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, userName, userPass);
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return connection;
    }

    public static void release(Connection connection, Statement statement, ResultSet resultSet) {
        try {
            if (connection!=null){
                connection.close();
            }
            if (statement!=null){
                statement.close();
            }
            if (resultSet!=null){
                resultSet.close();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
