package com.sarthak.sarthak.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/admin", "/pages/*"})
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI();
        boolean isLoginPage = path.endsWith("login.jsp") || path.endsWith("login");
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
        
        // Check if user is admin
        boolean isAdmin = (session != null && "admin".equals(session.getAttribute("userRole")));

        if (isLoginPage) {
            // Allow access to login page
            chain.doFilter(request, response);
        } else if (isLoggedIn && isAdmin) {
            // Admin user - allow access to admin pages
            chain.doFilter(request, response);
        } else if (isLoggedIn && !isAdmin) {
            // Non-admin user trying to access admin pages - redirect to their dashboard
            String userRole = (String) session.getAttribute("userRole");
            if ("employer".equals(userRole)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/employer/dashboard");
            } else if ("job_seeker".equals(userRole)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/jobseeker/dashboard");
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            }
        } else {
            // Not logged in - redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    public void destroy() {}
}
