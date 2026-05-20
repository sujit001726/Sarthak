package sarthak.controller;

import sarthak.dao.UserDAO;
import sarthak.model.User;
import sarthak.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Handles employer Account Settings page.
 * GET  /employer/settings  -> loads the settings form with real user data
 * POST /employer/settings  -> dispatches to save_profile / update_password / delete_account
 */
@WebServlet(urlPatterns = {"/employer/settings", "/settings"})
public class AccountSettingsServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        User user  = userDAO.getUserById(userId);

        if (user != null) {
            req.setAttribute("settingName",  user.getFullName());
            req.setAttribute("settingEmail", user.getEmail());
            req.setAttribute("settingPhone", userDAO.getPhone(userId));
        }

        // Pass flash messages set by POST redirect
        HttpSession s = req.getSession(false);
        if (s != null) {
            String success = (String) s.getAttribute("settingsSuccess");
            String error   = (String) s.getAttribute("settingsError");
            if (success != null) { req.setAttribute("settingsSuccess", success); s.removeAttribute("settingsSuccess"); }
            if (error   != null) { req.setAttribute("settingsError",   error);   s.removeAttribute("settingsError");   }
        }

        req.setAttribute("activeSidebar", "employer_settings");
        req.getRequestDispatcher("/employer/settings.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int    userId = (Integer) session.getAttribute("userId");
        String action = req.getParameter("action");

        String redirectUrl = req.getRequestURI();

        if ("save_profile".equals(action)) {
            handleSaveProfile(req, resp, session, userId, redirectUrl);
        } else if ("update_password".equals(action)) {
            handleUpdatePassword(req, resp, session, userId, redirectUrl);
        } else if ("delete_account".equals(action)) {
            handleDeleteAccount(req, resp, session, userId, redirectUrl);
        } else {
            resp.sendRedirect(redirectUrl);
        }
    }

    // ── Save Profile ──────────────────────────────────────────────────────────
    private void handleSaveProfile(HttpServletRequest req, HttpServletResponse resp,
                                   HttpSession session, int userId, String redirectUrl)
            throws IOException {

        String fullName = req.getParameter("fullName");
        String phone    = req.getParameter("phone");

        if (fullName == null || fullName.trim().isEmpty()) {
            session.setAttribute("settingsError", "Full name cannot be empty.");
            resp.sendRedirect(redirectUrl);
            return;
        }

        try {
            userDAO.updateProfile(userId, fullName.trim(), phone != null ? phone.trim() : "");
            // Refresh name in session
            session.setAttribute("userName",     fullName.trim());
            session.setAttribute("name",         fullName.trim());
            session.setAttribute("settingsSuccess", "Profile updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("settingsError", "Failed to update profile. Please try again.");
        }

        resp.sendRedirect(redirectUrl);
    }

    // ── Update Password ───────────────────────────────────────────────────────
    private void handleUpdatePassword(HttpServletRequest req, HttpServletResponse resp,
                                      HttpSession session, int userId, String redirectUrl)
            throws IOException {

        String currentPassword  = req.getParameter("currentPassword");
        String newPassword      = req.getParameter("newPassword");
        String confirmPassword  = req.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            session.setAttribute("settingsError", "All password fields are required.");
            resp.sendRedirect(redirectUrl);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("settingsError", "New passwords do not match.");
            resp.sendRedirect(redirectUrl);
            return;
        }

        if (newPassword.length() < 6) {
            session.setAttribute("settingsError", "New password must be at least 6 characters.");
            resp.sendRedirect(redirectUrl);
            return;
        }

        // Verify current password
        User user = userDAO.getUserById(userId);
        if (user == null || !PasswordUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
            session.setAttribute("settingsError", "Current password is incorrect.");
            resp.sendRedirect(redirectUrl);
            return;
        }

        try {
            String hashed = PasswordUtil.hashPassword(newPassword);
            userDAO.updatePassword(userId, hashed);
            session.setAttribute("settingsSuccess", "Password updated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("settingsError", "Failed to update password. Please try again.");
        }

        resp.sendRedirect(redirectUrl);
    }

    // ── Delete Account ────────────────────────────────────────────────────────
    private void handleDeleteAccount(HttpServletRequest req, HttpServletResponse resp,
                                     HttpSession session, int userId, String redirectUrl)
            throws IOException {

        boolean deleted = userDAO.deleteUser(userId);

        if (deleted) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login?deleted=true");
        } else {
            session.setAttribute("settingsError", "Failed to delete account. Please contact support.");
            resp.sendRedirect(redirectUrl);
        }
    }
}
