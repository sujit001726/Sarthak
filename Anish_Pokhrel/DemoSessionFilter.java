package sarthak.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class DemoSessionFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (request instanceof HttpServletRequest httpRequest) {
            HttpSession session = httpRequest.getSession(true);
            if (session.getAttribute("userId") == null) {
                session.setAttribute("userId", 1);
                session.setAttribute("role", "jobseeker");
                session.setAttribute("name", "Anish Pokhrel");
            }
        }
        chain.doFilter(request, response);
    }
}
