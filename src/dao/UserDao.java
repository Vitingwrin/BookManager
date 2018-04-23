package dao;

import beans.User;
import util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    public boolean checkPwd(User user, boolean who){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select userPwd from users where userName=? and isAdmin=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, user.getUserName());
            pst.setBoolean(2, who);
            rs = pst.executeQuery();
            if(rs.next()){
                if(rs.getString("userPwd").equals(user.getUserPwd())){
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return false;
    }

    public boolean checkIsUserExists(String name){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select * from users where userName=? and isAdmin=false";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return false;
    }

    public boolean userAdd(User user){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        String sql = "insert into users(userName, userPwd) values(?,?)";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, user.getUserName());
            pst.setString(2, user.getUserPwd());
            if(pst.executeUpdate() == 1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return false;
    }

    public String checkIsAdmin(String name){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select isAdmin from users where userName=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();
            if(rs.next()){
                boolean isAdmin = rs.getBoolean("isAdmin");
                if(rs.next()){
                    return "both";
                }else if(isAdmin){
                    return "true";
                }else {
                    return "false";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return null;
    }

    private static void close(Connection conn, PreparedStatement pst){
        try {
            if(conn != null) {
                conn.close();
            }
            if(pst != null) {
                pst.close();
            }
        }catch(SQLException e) {
            e.printStackTrace();
        }
    }
}
