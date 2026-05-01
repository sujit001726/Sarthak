<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Coming Soon</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .coming-soon-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 60vh;
            text-align: center;
            color: var(--text-main);
        }
        .coming-soon-icon {
            font-size: 5rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }
        .coming-soon-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .coming-soon-text {
            color: var(--text-dim);
            font-size: 1.1rem;
            max-width: 500px;
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp" flush="true" />
    
    <!-- Assuming the JSP files duplicate sidebar, we need to paste the sidebar or just show a simpler page. 
         Wait, since each JSP has its own sidebar hardcoded, I will just paste the dashboard's sidebar here 
         but update active classes using EL. 
    -->
    <aside class="sidebar">
        <div class="logo-container">
            <div class="logo-icon">S</div>
            <span class="logo-text">Sarthak</span>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'dashboard' ? 'active' : ''}"><a href="admin?action=dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li class="nav-item ${param.action == 'interviews' ? 'active' : ''}"><a href="admin?action=interviews" class="nav-link"><i class="fas fa-video"></i> Interviews</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Organizations</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'jobBoard' ? 'active' : ''}"><a href="admin?action=jobBoard" class="nav-link"><i class="fas fa-clipboard-list"></i> Job Board</a></li>
                    <li class="nav-item ${param.action == 'jobs' ? 'active' : ''}"><a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Tools Management</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'quizzes' ? 'active' : ''}"><a href="admin?action=quizzes" class="nav-link"><i class="fas fa-pen-nib"></i> Quiz Designer</a></li>
                    <li class="nav-item ${param.action == 'interviewDesigner' ? 'active' : ''}"><a href="admin?action=interviewDesigner" class="nav-link"><i class="fas fa-user-tie"></i> Interview Designer</a></li>
                    <li class="nav-item ${param.action == 'traits' ? 'active' : ''}"><a href="admin?action=traits" class="nav-link"><i class="fas fa-star"></i> Traits</a></li>
                    <li class="nav-item ${param.action == 'categories' ? 'active' : ''}"><a href="admin?action=categories" class="nav-link"><i class="fas fa-tags"></i> Categories</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Users Management</h4>
                <ul class="nav-list">
                    <li class="nav-item ${param.action == 'users' ? 'active' : ''}"><a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a></li>
                    <li class="nav-item ${param.action == 'candidates' ? 'active' : ''}"><a href="admin?action=candidates" class="nav-link"><i class="fas fa-user-graduate"></i> Candidates</a></li>
                    <li class="nav-item ${param.action == 'videoResume' ? 'active' : ''}"><a href="admin?action=videoResume" class="nav-link"><i class="fas fa-play-circle"></i> Videos Resume Hub</a></li>
                    <li class="nav-item ${param.action == 'shortlisted' ? 'active' : ''}"><a href="admin?action=shortlisted" class="nav-link"><i class="fas fa-check-double"></i> Shortlisted</a></li>
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
                <h1>Feature in Development</h1>
                <p>We are actively building this feature.</p>
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
            <div class="coming-soon-container">
                <i class="fas fa-tools coming-soon-icon"></i>
                <h2 class="coming-soon-title">Coming Soon!</h2>
                <p class="coming-soon-text">
                    This section is currently under development. Please check back later. 
                    Our team is working hard to bring you the best experience!
                </p>
            </div>
        </div>
    </main>
</body>
</html>
