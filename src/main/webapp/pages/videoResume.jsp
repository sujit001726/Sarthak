<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Video Resumes Hub</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <aside class="sidebar">
        <div class="logo-container">
            <div class="logo-icon">S</div>
            <span class="logo-text">Sarthak</span>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section">
                <ul class="nav-list">
                    <li class="nav-item "><a href="admin?action=dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li class="nav-item "><a href="admin?action=interviews" class="nav-link"><i class="fas fa-video"></i> Interviews</a></li>
                </ul>
            </div>
            <div class="nav-section">
                <h4 class="nav-title">Organizations</h4>
                <ul class="nav-list">
                    <li class="nav-item "><a href="admin?action=jobBoard" class="nav-link"><i class="fas fa-clipboard-list"></i> Job Board</a></li>
                    <li class="nav-item "><a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a></li>
                </ul>
            </div>
            <div class="nav-section">
                <h4 class="nav-title">Tools Management</h4>
                <ul class="nav-list">
                    <li class="nav-item "><a href="admin?action=quizzes" class="nav-link"><i class="fas fa-pen-nib"></i> Quiz Designer</a></li>
                    <li class="nav-item "><a href="admin?action=interviewDesigner" class="nav-link"><i class="fas fa-user-tie"></i> Interview Designer</a></li>
                    <li class="nav-item "><a href="admin?action=traits" class="nav-link"><i class="fas fa-star"></i> Traits</a></li>
                    <li class="nav-item "><a href="admin?action=categories" class="nav-link"><i class="fas fa-tags"></i> Categories</a></li>
                </ul>
            </div>
            <div class="nav-section">
                <h4 class="nav-title">Users Management</h4>
                <ul class="nav-list">
                    <li class="nav-item "><a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a></li>
                    <li class="nav-item "><a href="admin?action=candidates" class="nav-link"><i class="fas fa-user-graduate"></i> Candidates</a></li>
                    <li class="nav-item active"><a href="admin?action=videoResume" class="nav-link"><i class="fas fa-play-circle"></i> Videos Resume Hub</a></li>
                    <li class="nav-item "><a href="admin?action=shortlisted" class="nav-link"><i class="fas fa-check-double"></i> Shortlisted</a></li>
                </ul>
            </div>
        </nav>
        <div class="nav-section" style="margin-top: auto;">
             <ul class="nav-list">
                <li class="nav-item"><a href="login.jsp" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    </aside>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Video Resumes Hub</h1>
                <p>Manage and organize your data efficiently.</p>
            </div>
            <div class="top-actions">
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="User">
                    <div class="user-info">
                        <span class="name">Admin</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card" style="min-height: 400px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; color: var(--text-dim);">
                <i class="fas fa-play-circle" style="font-size: 4rem; color: var(--primary); margin-bottom: 20px;"></i>
                <h2>Welcome to Video Resumes Hub</h2>
                <p style="margin-top: 10px; max-width: 600px;">This module allows you to interact with all functions related to Video Resumes Hub. The full data integration is currently being mapped to the backend API.</p>
                <button class="btn-sm btn-primary" style="margin-top: 20px; font-size: 1rem; padding: 0.75rem 1.5rem;">Create New Entry +</button>
            </div>
        </div>
    </main>
</body>
</html>
