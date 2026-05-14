package sarthak.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;

@WebServlet("/users/search")
public class UserSearchServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);
        Integer currentUserId = (session != null) ? (Integer) session.getAttribute("userId") : -1;

        String query = request.getParameter("q");
        if (query == null || query.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        List<User> results = userDAO.searchUsers(query, currentUserId);
        JSONArray jsonArray = new JSONArray();
        for (User user : results) {
            JSONObject obj = new JSONObject();
            obj.put("id", user.getId());
            obj.put("name", user.getFullName());
            obj.put("role", user.getRole().toString());
            // In a real app, we'd add avatar URL here
            jsonArray.put(obj);
        }
        response.getWriter().write(jsonArray.toString());
    }
}
