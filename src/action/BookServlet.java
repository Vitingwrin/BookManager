package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDao;
import beans.Book;
import util.Json;

public class BookServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws  IOException {
		req.setCharacterEncoding("UTF-8");
		String method = req.getParameter("submit");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");
        PrintWriter printWriter = res.getWriter();
		if("删除".equals(method)){
            String[] ids = req.getParameterValues("del_checkbox");
            if(BookDao.bookDelete(ids)){
                printWriter.print("true");
            }else{
                printWriter.print("false");
            }
        }else{
            Book book = new Book();
            book.setBookName(req.getParameter("bookName"));
            book.setAuthor(req.getParameter("author"));
            book.setPrice(req.getParameter("price"));
            book.setPs(req.getParameter("ps"));
            if ("新增".equals(method)) {
                Json json = new Json();
                if (BookDao.bookInsert(book)) {
                    json.putName("result");
                    json.putVaule("新增图书成功");
                    json.putName("bookName");
                    json.putVaule(book.getBookName());
                    json.putName("author");
                    json.putVaule(book.getAuthor());
                    json.putName("price");
                    json.putVaule(book.getPrice());
                    json.putName("ps");
                    json.putVaule(book.getPs());
                    printWriter.print(json.toString());
                } else {
                    json.putName("result");
                    json.putVaule("新增图书失败");
                    printWriter.print(json.toString());
                }
            } else if ("查询".equals(method)) {
                BookDao.bookSearch(book, printWriter);
            } else if ("修改".equals(method)) {
                book.setBookId(req.getParameter("bookId"));
                BookDao.bookEdit(book, printWriter);
            }
        }

	}
}
