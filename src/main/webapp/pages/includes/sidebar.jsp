<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<aside class="sidebar" style="display: flex; flex-direction: column; height: 100vh; overflow: hidden; position: fixed; width: 270px; z-index: 1000;">
    <!-- Logo Section (Fixed) -->
    <div class="logo-container" style="padding: 30px; shrink-0;">
        <div class="logo-icon">S</div>
        <span class="logo-text">Sarthak</span>
    </div>

    <!-- Scrollable Navigation Area -->
    <div class="sidebar-scrollable" style="flex: 1; overflow-y: auto; padding: 0 15px 20px 15px;">
        <nav class="sidebar-nav">
            <!-- Main Navigation -->
            <div class="nav-section">
                <h4 class="nav-title">Main Menu</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'dashboard' || empty param.action ? 'active' : ''}">
                        <a href="admin?action=dashboard" class="nav-link">
                            <i class="fas fa-th-large"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item ${param.action == 'interviews' ? 'active' : ''}">
                        <a href="admin?action=interviews" class="nav-link">
                            <i class="fas fa-video"></i>
                            <span>Interviews</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Organizations Section -->
            <div class="nav-section">
                <h4 class="nav-title">Organizations</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'jobBoard' ? 'active' : ''}">
                        <a href="admin?action=jobBoard" class="nav-link">
                            <i class="fas fa-clipboard-list"></i>
                            <span>Job Board</span>
                        </a>
                    </li>
                    <li class="nav-item ${param.action == 'jobs' ? 'active' : ''}">
                        <a href="admin?action=jobs" class="nav-link">
                            <i class="fas fa-briefcase"></i>
                            <span>Jobs</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Tools Management Section -->
            <div class="nav-section">
                <h4 class="nav-title">Tools</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'categories' ? 'active' : ''}">
                        <a href="admin?action=categories" class="nav-link">
                            <i class="fas fa-tags"></i>
                            <span>Categories</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Users Management Section -->
            <div class="nav-section">
                <h4 class="nav-title">Users</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'users' ? 'active' : ''}">
                        <a href="admin?action=users" class="nav-link">
                            <i class="fas fa-users"></i>
                            <span>Team</span>
                        </a>
                    </li>
                    <li class="nav-item ${param.action == 'candidates' ? 'active' : ''}">
                        <a href="admin?action=candidates" class="nav-link">
                            <i class="fas fa-user-graduate"></i>
                            <span>Candidates</span>
                        </a>
                    </li>
                    <li class="nav-item ${param.action == 'shortlisted' ? 'active' : ''}">
                        <a href="admin?action=shortlisted" class="nav-link">
                            <i class="fas fa-check-double"></i>
                            <span>Shortlisted</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>

    <!-- Fixed Logout Section (Bottom) -->
    <div class="sidebar-footer" style="padding: 15px; border-top: 1px solid rgba(255,255,255,0.1); shrink-0;">
        <div class="nav-section" style="margin-bottom: 0;">
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</aside>