package dao;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.Book;
import util.DBConnect;
import util.Json;

public class BookDao {
	public static boolean bookInsert(Book book) {
		Connection conn;
		PreparedStatement pst = null;
		conn = DBConnect.getConnection();
		String sql = "insert into book(bookName,author,price,ps) values(?,?,?,?);";
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, book.getBookName());
			pst.setString(2, book.getAuthor());
			pst.setString(3, book.getPrice());
			pst.setString(4, book.getPs());
			if(pst.executeUpdate() >= 1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
            close(conn, pst);
        }
		return false;
	}

	public static void bookSearch(Book book, PrintWriter printWriter) {
		Connection conn;
		PreparedStatement pst = null;
		String sql = "";
		conn = DBConnect.getConnection();
		String name = book.getBookName();
		String author = book.getAuthor();
		String price = book.getPrice();
		String ps = book.getPs();
		ResultSet rs;
		if(!"".equals(name)){
		    sql += "select * from book where bookName like \"%" + name + "%\" ";
        }
        if(!"".equals(author)){
		    if("".equals(sql)){
		        sql = "select * from book where author like \"%" + author + "%\" ";
            }else{
		        sql += "and author like \"%" + author + "%\" ";
            }
        }
        if(!"".equals(price)){
		    int p = Integer.parseInt(price);
            if("".equals(sql)){
                sql = "select * from book where price <= " + (p + 10) + "and price >= " + (p - 10) + " ";
            }else{
                sql += "and price <= " + (p + 10) + "and price >= " + (p - 10) + " ";
            }
        }
        if(!"".equals(ps)){
            if("".equals(sql)){
                sql = "select * from book where ps like \"%" + ps + "%\" ";
            }else{
                sql += "and ps like \"%" + ps + "%\" ";
            }
        }
        if("".equals(sql)){
		    sql = "select * from book";
        }
        try {
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            if (rs != null) {
                Json json = new Json();
                StringBuilder builder = new StringBuilder();
                rs.beforeFirst();
                if(!rs.next()){
                    json.putName("result");
                    json.putVaule("没有查到相关图书");
                    printWriter.print(json.toString());
                    return;
                }
                json.putName("result");
                json.putVaule("查询到以下结果");
                builder.append(json.toString());
                rs.beforeFirst();
                while (rs.next()) {
                    json.clear();
                    builder.append(",");
                    json.putName("bookId");
                    json.putVaule(rs.getString("bookId"));
                    json.putName("bookName");
                    json.putVaule(rs.getString("bookName"));
                    json.putName("author");
                    json.putVaule(rs.getString("author"));
                    json.putName("price");
                    json.putVaule(rs.getString("price"));
                    json.putName("ps");
                    json.putVaule(rs.getString("ps"));
                    builder.append(json.toString());
                }
                printWriter.print(builder.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(conn, pst);
        }
	}

	public static boolean bookDelete(String[] ids){
	    if(ids.length == 0){
	        return false;
        }
	    int num = 0;
	    Connection conn = DBConnect.getConnection();
	    PreparedStatement pst = null;
	    String sql = "";
	    for(String id : ids){
	        if("".equals(sql)){
	            sql = "delete from book where bookId=" + id;
            }else{
	            sql += " or bookId=" + id;
            }
        }
        try {
            pst = conn.prepareStatement(sql);
            num = pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(conn, pst);
        }
        return num == ids.length;
    }

    public static void bookEdit(Book book, PrintWriter printWriter){
	    Connection conn = DBConnect.getConnection();
	    PreparedStatement pst = null;
	    String sql = "";
	    String id = book.getBookId();
        String name = book.getBookName();
        String author = book.getAuthor();
        String price = book.getPrice();
        String ps = book.getPs();
        Json json = new Json();
        int num = 0;
        if(!"".equals(name)){
            sql = "update book set bookName=\"" + name + "\"";
        }
        if(!"".equals(author)){
            if("".equals(sql)){
                sql = "update book set author=\"" + author + "\"";
            }else{
                sql += ", author=\"" + author + "\"";
            }
        }
        if(!"".equals(price)){
            if("".equals(sql)){
                sql = "update book set price=\"" + price + "\"";
            }else{
                sql += ", price=\"" + price + "\"";
            }
        }
        if(!"".equals(ps)){
            if("".equals(sql)){
                sql = "update book set ps=\"" + ps + "\"";
            }else{
                sql += ", ps=\"" + ps + "\"";
            }
        }
        sql += " where bookId=" + id;
        try {
            pst = conn.prepareStatement(sql);
            num = pst.executeUpdate();
            if(num != 1){
                json.putName("result");
                json.putVaule("修改图书信息失败");
                printWriter.print(json.toString());
                return;
            }
            json.putName("result");
            json.putVaule("修改图书信息成功");
            StringBuilder builder = new StringBuilder();
            builder.append(json.toString());
            json.clear();
            builder.append(",");
            json.putName("bookName");
            json.putVaule(name);
            json.putName("author");
            json.putVaule(author);
            json.putName("price");
            json.putVaule(price);
            json.putName("ps");
            json.putVaule(ps);
            builder.append(json.toString());
            printWriter.print(builder.toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(conn, pst);
        }
    }

    public static ArrayList<Book> getBooksByIds(String[] bookIds){
	    Connection conn = DBConnect.getConnection();
	    PreparedStatement pst = null;
	    ResultSet rs;
	    StringBuilder sql = null;
        ArrayList<Book> bookList = new ArrayList<>();
	    for(String bookId: bookIds){
	        if(sql == null){
	            sql = new StringBuilder("select * from book where bookId=").append(bookId);
            }else{
                sql.append(" or bookId=").append(bookId);
            }
        }
        if(sql == null){
	        return null;
        }
        try {
            pst = conn.prepareStatement(sql.toString());
            rs = pst.executeQuery();
            while(rs.next()){
                Book book = new Book();
                book.setBookId(rs.getString("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getString("price"));
                book.setPs(rs.getString("ps"));
                bookList.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
	        close(conn, pst);
        }
        return bookList;
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
