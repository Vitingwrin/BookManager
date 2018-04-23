package action;

import dao.UserDao;
import beans.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UserServlet extends HttpServlet {

    private final static boolean USER = false;
    private final static boolean ADMIN = true;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = resp.getWriter();
        String uri = req.getRequestURI();
        String page = uri.substring(uri.lastIndexOf('/') + 1, uri.lastIndexOf('.'));
        if("login".equals(page)){
            boolean who = USER;
            User user = new User();
            if(req.getParameter("admin") != null) {
                who = ADMIN;
            }
            user.setUserName(req.getParameter("userName"));
            user.setUserPwd(req.getParameter("userPwd"));
            UserDao dao = new UserDao();
            if(dao.checkPwd(user, who)){
                printWriter.print(user.getUserName());
            }else{
                printWriter.print("failed");
            }
        }else if("register".equals(page)){
            User user = new User();
            user.setUserName(req.getParameter("userName"));
            user.setUserPwd(req.getParameter("userPwd"));
            UserDao dao = new UserDao();
            if(dao.userAdd(user)){
                printWriter.print(user.getUserName());
            }else{
                printWriter.print("failed");
            }
        }else{
            printWriter.print("false");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = resp.getWriter();
        String uri = req.getRequestURI();
        String page = uri.substring(uri.lastIndexOf('/') + 1, uri.lastIndexOf('.'));
        if("checkName".equals(page)){
            UserDao dao = new UserDao();
            if(dao.checkIsUserExists(req.getParameter("userName"))){
                printWriter.print("exists");
            }
        }else if("checkIsAdmin".equals(page)){
            UserDao dao = new UserDao();
            printWriter.print(dao.checkIsAdmin(req.getParameter("userName")));
        }

    }
}
