<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Admin Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <li class="nav-item active"><a href="admin?action=dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li class="nav-item"><a href="admin?action=interviews" class="nav-link"><i class="fas fa-video"></i> Interviews</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Organizations</h4>
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=jobBoard" class="nav-link"><i class="fas fa-clipboard-list"></i> Job Board</a></li>
                    <li class="nav-item"><a href="admin?action=jobs" class="nav-link"><i class="fas fa-briefcase"></i> Jobs</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Tools Management</h4>
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=quizzes" class="nav-link"><i class="fas fa-pen-nib"></i> Quiz Designer</a></li>
                    <li class="nav-item"><a href="admin?action=interviewDesigner" class="nav-link"><i class="fas fa-user-tie"></i> Interview Designer</a></li>
                    <li class="nav-item"><a href="admin?action=traits" class="nav-link"><i class="fas fa-star"></i> Traits</a></li>
                    <li class="nav-item"><a href="admin?action=categories" class="nav-link"><i class="fas fa-tags"></i> Categories</a></li>
                </ul>
            </div>

            <div class="nav-section">
                <h4 class="nav-title">Users Management</h4>
                <ul class="nav-list">
                    <li class="nav-item"><a href="admin?action=users" class="nav-link"><i class="fas fa-users"></i> Team</a></li>
                    <li class="nav-item"><a href="admin?action=candidates" class="nav-link"><i class="fas fa-user-graduate"></i> Candidates</a></li>
                    <li class="nav-item"><a href="admin?action=videoResume" class="nav-link"><i class="fas fa-play-circle"></i> Videos Resume Hub</a></li>
                    <li class="nav-item"><a href="admin?action=shortlisted" class="nav-link"><i class="fas fa-check-double"></i> Shortlisted</a></li>
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
                <h1>Good morning, ${adminName != null ? adminName : 'James'}</h1>
                <p>Here's what you need to focus on today</p>
            </div>

            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search for jobs, candidates...">
                </div>
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=James&background=2563eb&color=fff" alt="User">
                    <div class="user-info">
                        <span class="name">James</span>
                    </div>
                    <i class="fas fa-chevron-down" style="font-size: 0.7rem; color: var(--text-dim);"></i>
                </div>
            </div>
        </header>

        <div class="content-area">
            <section class="stats-container">
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${jobCount}</span>
                        <div class="stat-icon-mini" style="background: #eff6ff; color: #3b82f6;"><i class="fas fa-briefcase"></i></div>
                    </div>
                    <span class="stat-label">All Jobs</span>
                    <a href="#" class="stat-more">View More <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${userCount}</span>
                        <div class="stat-icon-mini" style="background: #fdf2f8; color: #db2777;"><i class="fas fa-users"></i></div>
                    </div>
                    <span class="stat-label">Total Candidates</span>
                    <a href="#" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">130</span>
                        <div class="stat-icon-mini" style="background: #f5f3ff; color: #7c3aed;"><i class="fas fa-file-alt"></i></div>
                    </div>
                    <span class="stat-label">Total Applications</span>
                    <a href="#" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">26</span>
                        <div class="stat-icon-mini" style="background: #fff7ed; color: #ea580c;"><i class="fas fa-video"></i></div>
                    </div>
                    <span class="stat-label">Total Interviews</span>
                    <a href="#" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">12</span>
                        <div class="stat-icon-mini" style="background: #f0fdf4; color: #16a34a;"><i class="fas fa-check-circle"></i></div>
                    </div>
                    <span class="stat-label">Total Hired</span>
                    <a href="#" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">08</span>
                        <div class="stat-icon-mini" style="background: #fef2f2; color: #dc2626;"><i class="fas fa-times-circle"></i></div>
                    </div>
                    <span class="stat-label">Total Rejected</span>
                    <a href="#" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
            </section>

            <div class="dashboard-grid">
                <div class="grid-left">
                    <div class="content-card">
                        <div class="card-header">
                            <h3>Your Job Ads</h3>
                            <div>
                                <button class="btn-sm btn-outline">VIEW ALL</button>
                                <button class="btn-sm btn-primary">Create Job Ad +</button>
                            </div>
                        </div>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Job Title</th>
                                    <th>New</th>
                                    <th>Waiting</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="job" items="${recentJobs}">
                                    <tr>
                                        <td>
                                            <div class="job-row">
                                                <span class="job-title">${job.title}</span>
                                                <span class="job-meta">W1</span>
                                            </div>
                                        </td>
                                        <td><strong>185</strong></td>
                                        <td>0</td>
                                        <td><strong>250</strong></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentJobs}">
                                    <tr><td colspan="4" style="text-align: center; color: var(--text-dim);">No job ads found</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="content-card">
                        <div class="card-header">
                            <h3>Top Experience Levels</h3>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Entry Level</span><span>45%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width: 45%; background: #3b82f6;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Intermediate</span><span>30%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width: 30%; background: #f59e0b;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Senior</span><span>15%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width: 15%; background: #10b981;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Expert</span><span>10%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width: 10%; background: #7c3aed;"></div></div>
                        </div>
                    </div>

                    <div class="content-card">
                        <div class="card-header">
                            <h3>Top 5 candidate</h3>
                        </div>
                        <div class="candidate-list">
                            <div class="candidate-card">
                                <img src="https://ui-avatars.com/api/?name=Barbara+Crooks&background=random" alt="C1">
                                <span class="candidate-name">Barbara Crooks</span>
                                <span class="candidate-email">lori_fisher@gmail.com</span>
                                <div class="tag-list">
                                    <span class="tag">Technician</span>
                                    <span class="tag">Agent</span>
                                </div>
                            </div>
                            <div class="candidate-card">
                                <img src="https://ui-avatars.com/api/?name=Tabitha+Blick&background=random" alt="C2">
                                <span class="candidate-name">Tabitha Blick</span>
                                <span class="candidate-email">tobin_borer87@gmail.com</span>
                                <div class="tag-list">
                                    <span class="tag">Consultant</span>
                                    <span class="tag">Engineer</span>
                                </div>
                            </div>
                            <div class="candidate-card">
                                <img src="https://ui-avatars.com/api/?name=Melanie+Runolfsson&background=random" alt="C3">
                                <span class="candidate-name">Melanie Runolfsson</span>
                                <span class="candidate-email">stewart_brakus@gmail.com</span>
                                <div class="tag-list">
                                    <span class="tag">Specialist</span>
                                    <span class="tag">Agent</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="grid-right">
                    <div class="content-card">
                        <div class="card-header">
                            <h3>Total Overview</h3>
                        </div>
                        <div class="donut-container">
                            <canvas id="overviewChart"></canvas>
                            <div class="donut-center">
                                <span class="val">12</span>
                                <span class="lbl">Total Candidates</span>
                            </div>
                        </div>
                    </div>

                    <div class="content-card">
                        <div class="card-header">
                            <h3>Pending Quizzes</h3>
                        </div>
                        <ul class="nav-list">
                            <li class="nav-item" style="border-bottom: 1px solid #f1f5f9; padding: 10px 0;">
                                <p style="font-size: 0.85rem;">Which type of work environment do you prefer?</p>
                            </li>
                            <li class="nav-item" style="border-bottom: 1px solid #f1f5f9; padding: 10px 0;">
                                <p style="font-size: 0.85rem;">What type of tasks do you enjoy the most?</p>
                            </li>
                        </ul>
                    </div>

                    <div class="calendar-card">
                        <div class="calendar-header">
                            <span>November 2024</span>
                            <div><i class="fas fa-chevron-left"></i> <i class="fas fa-chevron-right"></i></div>
                        </div>
                        <div class="calendar-grid">
                            <div class="cal-day-name">M</div><div class="cal-day-name">T</div><div class="cal-day-name">W</div><div class="cal-day-name">T</div><div class="cal-day-name">F</div><div class="cal-day-name">S</div><div class="cal-day-name">S</div>
                            <div class="cal-date">28</div><div class="cal-date">29</div><div class="cal-date">30</div><div class="cal-date">31</div><div class="cal-date">1</div><div class="cal-date">2</div><div class="cal-date">3</div>
                            <div class="cal-date">4</div><div class="cal-date">5</div><div class="cal-date">6</div><div class="cal-date">7</div><div class="cal-date">8</div><div class="cal-date">9</div><div class="cal-date">10</div>
                            <div class="cal-date active">11</div><div class="cal-date">12</div><div class="cal-date">13</div><div class="cal-date">14</div><div class="cal-date">15</div><div class="cal-date">16</div><div class="cal-date">17</div>
                        </div>
                    </div>

                    <div class="banner">
                        <div class="banner-content">
                            <h4>Buy More Job Ads</h4>
                            <button class="btn-sm btn-primary">Upgrade Now</button>
                        </div>
                        <img src="https://img.freepik.com/free-photo/smiling-businesswoman-standing-with-arms-crossed_171337-12001.jpg" alt="Banner">
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        const ctx = document.getElementById('overviewChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Recommended', 'Shortlisted', 'Applicants', 'Interview', 'Rejected', 'Hired'],
                datasets: [{
                    data: [5, 2, 2, 2, 1, 0],
                    backgroundColor: ['#2563eb', '#3b82f6', '#0ea5e9', '#f59e0b', '#ef4444', '#10b981'],
                    borderWidth: 0,
                    cutout: '80%'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } }
            }
        });
    </script>
</body>
</html>

