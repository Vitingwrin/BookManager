package dao;

import util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StatusDao {
    public final static int ERROR = -1;

    public boolean isExistsStatus(String bookId, String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select * from bookStatus where bookId=? and userName=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, bookId);
            pst.setString(2, userName);
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

    public boolean lendBook(String bookId, String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        String sql = "insert into bookStatus(isLent,bookId,userName) values(true,?,?)";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, bookId);
            pst.setString(2, userName);
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

    public boolean returnBook(String bookId, String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        String sql = "update bookStatus set isLent=false where bookId=? and userName=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, bookId);
            pst.setString(2, userName);
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

    public boolean delStatus(String bookId, String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        String sql = "delete from bookStatus where isLent is false and bookId=? and userName=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, bookId);
            pst.setString(2, userName);
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

    public String[] getBookIds(String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select bookId from bookStatus where userName=?";
        List<String> list = new ArrayList<>();
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, userName);
            rs = pst.executeQuery();
            while(rs.next()){
                list.add(rs.getString("bookId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return list.toArray(new String[0]);
    }

    public int getLentQTY(String userName){
        Connection conn = DBConnect.getConnection();
        PreparedStatement pst = null;
        ResultSet rs;
        String sql = "select count(*) from bookStatus where userName=?";
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, userName);
            rs = pst.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, pst);
        }
        return ERROR;
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
