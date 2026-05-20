package sarthak.controller;

import sarthak.dao.FriendsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/friends")
public class FriendsServlet extends HttpServlet {

    private final FriendsDAO friendsDAO = new FriendsDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<FriendsDAO.Friend> friends = friendsDAO.getFriends(userId);
        List<FriendsDAO.Friend> pendingRequests = friendsDAO.getPendingRequests(userId);
        
        req.setAttribute("friends", friends);
        req.setAttribute("pendingRequests", pendingRequests);
        req.getRequestDispatcher("/friends.jsp").forward(req, resp);
    }
}
