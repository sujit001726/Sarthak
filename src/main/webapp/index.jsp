<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Seeker Dashboard - Sarthak</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="logo">
                <i class="fa-solid fa-briefcase"></i>
                <span>Sarthak</span>
            </div>
            
            <ul class="nav-links">
                <li class="active">
                    <a href="${pageContext.request.contextPath}/dashboard">
                        <i class="fa-solid fa-border-all"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-paper-plane"></i>
                        <span>My Applications</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-bookmark"></i>
                        <span>Saved Jobs</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-video"></i>
                        <span>Interviews</span>
                    </a>
                </li>

                <li class="nav-heading">ACCOUNT</li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-user"></i>
                        <span>My Profile</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-gear"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>

            <div class="logout-wrapper">
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    <span>Logout</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="topbar">
                <div class="greeting">
                    <h1>Good morning, ${not empty sessionScope.userName ? sessionScope.userName : 'Seeker'}</h1>
                    <p>Here's what you need to focus on today</p>
                </div>
                <div class="topbar-actions">
                    <div class="search-bar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" placeholder="Search for jobs, companies...">
                    </div>
                    <div class="profile-menu">
                        <div class="avatar">
                            ${not empty sessionScope.userInitials ? sessionScope.userInitials : 'JS'}
                        </div>
                        <span>${not empty sessionScope.userName ? sessionScope.userName : 'Job Seeker'}</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </header>

            <!-- Dashboard Widgets -->
            <div class="dashboard-widgets">
                <!-- Top Cards -->
                <div class="cards-grid">
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>${not empty totalApplications ? totalApplications : '12'}</h3>
                            <p>Total Applications</p>
                            <a href="#" class="more-link">View More &rarr;</a>
                        </div>
                        <div class="stat-icon icon-blue">
                            <i class="fa-solid fa-briefcase"></i>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>${not empty savedJobs ? savedJobs : '24'}</h3>
                            <p>Saved Jobs</p>
                            <a href="#" class="more-link">More Info &rarr;</a>
                        </div>
                        <div class="stat-icon icon-pink">
                            <i class="fa-solid fa-bookmark"></i>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>${not empty upcomingInterviews ? upcomingInterviews : '3'}</h3>
                            <p>Upcoming Interviews</p>
                            <a href="#" class="more-link">More Info &rarr;</a>
                        </div>
                        <div class="stat-icon icon-purple">
                            <i class="fa-solid fa-video"></i>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>${not empty profileViews ? profileViews : '45'}</h3>
                            <p>Profile Views</p>
                            <a href="#" class="more-link">More Info &rarr;</a>
                        </div>
                        <div class="stat-icon icon-orange">
                            <i class="fa-solid fa-eye"></i>
                        </div>
                    </div>
                </div>

                <!-- Middle Section: Table and Chart -->
                <div class="middle-grid">
                    <!-- Recent Applications Table -->
                    <div class="panel table-panel">
                        <div class="panel-header">
                            <h2>Recent Applications</h2>
                            <div class="panel-actions">
                                <button class="btn btn-outline">VIEW ALL</button>
                                <button class="btn btn-primary">Browse Jobs +</button>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>JOB TITLE</th>
                                        <th>COMPANY</th>
                                        <th>STATUS</th>
                                        <th>APPLIED DATE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="job-title-cell">
                                                <strong>Software Engineer</strong>
                                                <span>Remote</span>
                                            </div>
                                        </td>
                                        <td>TechCorp Inc.</td>
                                        <td><span class="badge badge-waiting">In Review</span></td>
                                        <td>Oct 12, 2026</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="job-title-cell">
                                                <strong>Frontend Developer</strong>
                                                <span>New York, NY</span>
                                            </div>
                                        </td>
                                        <td>Innovate LLC</td>
                                        <td><span class="badge badge-new">Interview</span></td>
                                        <td>Oct 10, 2026</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="job-title-cell">
                                                <strong>UI/UX Designer</strong>
                                                <span>San Francisco, CA</span>
                                            </div>
                                        </td>
                                        <td>Designify</td>
                                        <td><span class="badge badge-rejected">Rejected</span></td>
                                        <td>Oct 05, 2026</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Profile Overview Donut Chart -->
                    <div class="panel chart-panel">
                        <h2>Profile Completeness</h2>
                        <div class="chart-container">
                            <div class="donut-chart">
                                <div class="donut-hole">
                                    <span class="donut-value">85%</span>
                                    <span class="donut-label">Completed</span>
                                </div>
                            </div>
                        </div>
                        <p class="text-center mt-3 text-muted">Update your resume to reach 100%</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
