<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Interview Management</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.45);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.open { display: flex; }
        .modal-box {
            background: #fff;
            border-radius: 12px;
            padding: 28px 32px;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }
        .modal-box h3 { margin: 0 0 20px; font-size: 1.1rem; color: #1e1b4b; }
        .form-group { display: grid; gap: 6px; margin-bottom: 16px; }
        .form-group label { font-size: 0.85rem; font-weight: 600; color: #374151; }
        .form-group input, .form-group select {
            padding: 9px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
            outline: none;
            transition: border 0.2s;
        }
        .form-group input:focus, .form-group select:focus { border-color: #4f46e5; }
        .modal-actions { display: flex; gap: 10px; justify-content: flex-end; margin-top: 8px; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="interviews" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Interviews Dashboard</h1>
                <p>Track and manage candidate interviews</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search by candidate...">
                </div>
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=4f46e5&color=fff" alt="User">
                    <div class="user-info"><span class="name">Admin</span></div>
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade">
                <div class="card-header">
                    <div>
                        <h3>Upcoming Interviews</h3>
                        <p style="font-size:0.8rem;color:var(--text-dim);">Scheduling for the current week</p>
                    </div>
                    <button class="btn-sm btn-primary" onclick="openScheduleModal()">Schedule New +</button>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Candidate</th>
                                <th>Date &amp; Time</th>
                                <th>Interviewer</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="interview" items="${interviews}">
                                <tr>
                                    <td><div style="font-weight:600;">${interview.candidate}</div></td>
                                    <td><div style="font-size:0.85rem;color:var(--text-main);"><i class="far fa-calendar-alt"></i> ${interview.time}</div></td>
                                    <td>
                                        <div style="display:flex;align-items:center;gap:8px;">
                                            <img src="https://ui-avatars.com/api/?name=${interview.interviewer}&background=f1f5f9" style="width:24px;height:24px;border-radius:50%;">
                                            <span>${interview.interviewer}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge" style="background:#eff6ff;color:var(--info);">${interview.status}</span>
                                    </td>
                                    <td>
                                        <div style="display:flex;gap:8px;">
                                            <button class="btn-sm btn-outline" style="color:var(--success)"><i class="fas fa-video"></i> Start</button>
                                            <button class="btn-sm btn-outline"><i class="fas fa-edit"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty interviews}">
                                <tr>
                                    <td colspan="5">
                                        <div style="padding:4rem;text-align:center;color:var(--text-dim);">
                                            <i class="fas fa-calendar-times" style="font-size:3rem;margin-bottom:1rem;opacity:0.2;"></i>
                                            <p>No interviews scheduled yet.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Schedule Interview Modal -->
    <div class="modal-overlay" id="scheduleModal">
        <div class="modal-box">
            <h3><i class="fas fa-calendar-plus" style="color:#4f46e5;margin-right:8px;"></i>Schedule New Interview</h3>
            <form action="admin" method="POST">
                <input type="hidden" name="action" value="scheduleInterview">

                <div class="form-group">
                    <label>Application (Candidate → Job)</label>
                    <select name="applicationId" required>
                        <option value="">-- Select Application --</option>
                        <c:forEach var="app" items="${applications}">
                            <option value="${app.applicationId}">${app.candidateName} → ${app.jobTitle}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Interviewer Name</label>
                    <input type="text" name="interviewer" placeholder="e.g. Samir Thapa" required>
                </div>

                <div class="form-group">
                    <label>Date &amp; Time</label>
                    <input type="datetime-local" name="scheduledAt" required>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="status">
                        <option value="scheduled">Scheduled</option>
                        <option value="completed">Completed</option>
                        <option value="cancelled">Cancelled</option>
                    </select>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-sm btn-outline" onclick="closeScheduleModal()">Cancel</button>
                    <button type="submit" class="btn-sm btn-primary">Save Interview</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openScheduleModal()  { document.getElementById('scheduleModal').classList.add('open'); }
        function closeScheduleModal() { document.getElementById('scheduleModal').classList.remove('open'); }
        // Close on backdrop click
        document.getElementById('scheduleModal').addEventListener('click', function(e) {
            if (e.target === this) closeScheduleModal();
        });
    </script>
</body>
</html>
