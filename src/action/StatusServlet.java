package action;

import dao.BookDao;
import dao.StatusDao;
import beans.Book;
import util.Json;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class StatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = resp.getWriter();
        String uri = req.getRequestURI();
        String page = uri.substring(uri.lastIndexOf('/') + 1, uri.lastIndexOf('.'));
        Cookie[] cookies = req.getCookies();
        String userName = "";
        for(Cookie cookie: cookies){
            if(cookie.getName().compareTo("userName") == 0){
                userName = cookie.getValue();
                break;
            }
        }
        if("lendBook".equals(page)){
            String[] bookIds = req.getParameterValues("lend_checkbox");
            if(bookIds.length == 0){
                printWriter.print("error");
                return;
            }
            StatusDao dao = new StatusDao();
            int num = dao.getLentQTY(userName);
            StringBuilder books = null;
            if(num == StatusDao.ERROR){
                printWriter.print("error");
                return;
            }
            if(num + bookIds.length > 8){
                printWriter.print("overflow");
            }else{
                for(String bookId: bookIds){
                    if(!dao.isExistsStatus(bookId, userName)){
                        if(!dao.lendBook(bookId, userName)) {
                            printWriter.print("error");
                        }
                    }else{
                        if(books == null){
                            books = new StringBuilder();
                        }
                        books.append(bookId).append(",");
                    }
                }
                if(books == null){
                    printWriter.print("successful");
                }else{
                    books.deleteCharAt(books.length() - 1);
                    printWriter.print(books.toString());
                }
            }
        }else if("getBook".equals(page)){
            StatusDao dao = new StatusDao();
            String[] bookIds = dao.getBookIds(userName);
            ArrayList<Book> bookList = BookDao.getBooksByIds(bookIds);
            if(bookList == null || bookList.isEmpty()){
                printWriter.print("null");
                return;
            }
            Json json = new Json();
            StringBuilder builder = new StringBuilder();
            for(Book book: bookList){
                json.clear();
                json.putName("bookId");
                json.putVaule(book.getBookId());
                json.putName("bookName");
                json.putVaule(book.getBookName());
                json.putName("author");
                json.putVaule(book.getAuthor());
                json.putName("price");
                json.putVaule(book.getPrice());
                json.putName("ps");
                json.putVaule(book.getPs());
                builder.append(json.toString());
                builder.append(",");
            }
            builder.deleteCharAt(builder.length() - 1);
            printWriter.print(builder.toString());
        }else if("returnBook".equals(page)){
            String[] bookIds = req.getParameterValues("return_checkbox");
            StatusDao dao = new StatusDao();
            StringBuilder books = null;
            for(String bookId: bookIds){
                if(!dao.returnBook(bookId, userName) || !dao.delStatus(bookId, userName)){
                    if(books == null){
                        books = new StringBuilder();
                    }
                    books.append(bookId).append(",");
                }
            }
            if(books == null){
                printWriter.print("successful");
            }else{
                books.deleteCharAt(books.length() - 1);
                printWriter.print(books.toString());
            }
        }
    }
}
