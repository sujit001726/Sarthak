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
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="dashboard" />
    </jsp:include>


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
                                <a href="admin?action=addJob" class="btn-sm btn-primary" style="text-decoration: none;">Create Job Ad +</a>
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

                    <div class="content-card calendar-dynamic">
                        <div class="card-header">
                            <h3>Calendar</h3>
                        </div>
                        <div class="calendar-container">
                            <div id="calendar-header-v3" style="display: flex !important; justify-content: center !important; align-items: center !important; gap: 40px !important; margin: 30px 0 !important; width: 100% !important; visibility: visible !important; opacity: 1 !important;">
                                <button onclick="prevMonth()" style="background: none !important; border: none !important; font-size: 30px !important; color: #4f46e5 !important; cursor: pointer !important; padding: 10px !important; display: block !important;">&lt;</button>
                                <span id="FINAL_MONTH_DISPLAY" style="font-size: 24px !important; font-weight: 900 !important; color: #000000 !important; display: block !important; text-align: center !important; min-width: 150px !important; visibility: visible !important; opacity: 1 !important;">MAY 2026</span>
                                <button onclick="nextMonth()" style="background: none !important; border: none !important; font-size: 30px !important; color: #4f46e5 !important; cursor: pointer !important; padding: 10px !important; display: block !important;">&gt;</button>
                            </div>
                            <div class="calendar-grid-dynamic" id="calendarGrid">
                                <!-- Days will be injected here -->
                            </div>
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
        // Calendar Logic
        let currentDate = new Date();

        function renderCalendar() {
            const monthDisplay = document.getElementById('FINAL_MONTH_DISPLAY');
            const calendarGrid = document.getElementById('calendarGrid');
            if (!monthDisplay || !calendarGrid) return;
            
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();
            
            const firstDay = new Date(year, month, 1).getDay();
            const lastDate = new Date(year, month + 1, 0).getDate();
            
            const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            monthDisplay.innerText = `${monthNames[month]} ${year}`;
            
            calendarGrid.innerHTML = '';
            
            const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            dayNames.forEach(day => {
                const dayHeader = document.createElement('div');
                dayHeader.className = 'calendar-day-header';
                dayHeader.innerText = day;
                calendarGrid.appendChild(dayHeader);
            });
            
            for (let i = 0; i < firstDay; i++) {
                const emptyCell = document.createElement('div');
                emptyCell.className = 'calendar-date-cell empty';
                calendarGrid.appendChild(emptyCell);
            }
            
            const today = new Date();
            for (let i = 1; i <= lastDate; i++) {
                const dateCell = document.createElement('div');
                dateCell.className = 'calendar-date-cell';
                if (i === today.getDate() && month === today.getMonth() && year === today.getFullYear()) {
                    dateCell.classList.add('today');
                }
                dateCell.innerText = i;
                calendarGrid.appendChild(dateCell);
            }
        }

        window.prevMonth = () => { currentDate.setMonth(currentDate.getMonth() - 1); renderCalendar(); };
        window.nextMonth = () => { currentDate.setMonth(currentDate.getMonth() + 1); renderCalendar(); };

        renderCalendar();

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

