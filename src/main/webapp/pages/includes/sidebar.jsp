<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<aside class="sidebar">
    <nav class="sidebar-nav" style="padding-top: 20px;">
        <div class="nav-section">
            <ul class="nav-list">
                <li class="nav-item ${param.action == 'dashboard' || empty param.action ? 'active' : ''}">
                    <a href="admin?action=dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a>
                </li>
                <li class="nav-item ${param.action == 'interviews' ? 'active' : ''}">
                    <a href="admin?action=interviews" class="nav-link"><i class="fas fa-video"></i> Interviews</a>
                </li>
            </ul>
        </div>

        <div class="nav-section">
            <h4 class="nav-title">Organizations</h4>
            <ul class="nav-list">
                <li class="nav-item ${param.action == 'jobBoard' ? 'active' : ''}">
                    <a href="admin?action=jobBoard" class="nav-link"><i class="fas fa-clipboard-list"></i> Job Board</a>
                </li>
                <li class="nav-item ${param.action == 'jobs' ? 'active' : ''}">
                    <a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a>
                </li>
            </ul>
        </div>

        <div class="nav-section">
            <h4 class="nav-title">Tools Management</h4>
            <ul class="nav-list">
                <li class="nav-item ${param.action == 'categories' ? 'active' : ''}">
                    <a href="admin?action=categories" class="nav-link"><i class="fas fa-tags"></i> Categories</a>
                </li>
            </ul>
        </div>

        <div class="nav-section">
            <h4 class="nav-title">Users Management</h4>
            <ul class="nav-list">
                <li class="nav-item ${param.action == 'users' ? 'active' : ''}">
                    <a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a>
                </li>
                <li class="nav-item ${param.action == 'candidates' ? 'active' : ''}">
                    <a href="admin?action=candidates" class="nav-link"><i class="fas fa-user-graduate"></i> Candidates</a>
                </li>
                <li class="nav-item ${param.action == 'shortlisted' ? 'active' : ''}">
                    <a href="admin?action=shortlisted" class="nav-link"><i class="fas fa-check-double"></i> Shortlisted</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="nav-section" style="margin-top: auto;">
        <ul class="nav-list">
            <li class="nav-item">
                <a href="login.jsp" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </li>
        </ul>
    </div>
</aside>