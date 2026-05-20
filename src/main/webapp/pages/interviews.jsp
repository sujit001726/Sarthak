<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Interview Management</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                @media (max-width: 1024px) {
                    /* Sidebar & Overlay */
                    .sidebar {
                        position: fixed !important;
                        left: -280px !important;
                        top: 0 !important;
                        bottom: 0 !important;
                        width: 280px !important;
                        z-index: 5000 !important;
                        transform: translateX(0) !important;
                        transition: transform 0.3s ease !important;
                        display: flex !important;
                    }
                    body.sidebar-open .sidebar {
                        transform: translateX(280px) !important;
                    }
                    body.sidebar-open::after {
                        content: '';
                        position: fixed;
                        inset: 0;
                        background: rgba(0,0,0,0.6);
                        z-index: 4500;
                        backdrop-filter: blur(4px);
                    }

                    /* Header Optimization */
                    .top-nav {
                        padding: 0 10px !important;
                        height: 80px !important;
                        flex-direction: column !important;
                        align-items: flex-start !important;
                        justify-content: center !important;
                        gap: 0 !important;
                    }
                    .mobile-menu-toggle {
                        position: absolute !important;
                        left: 10px !important;
                        top: 20px !important;
                    }
                    .welcome-msg {
                        margin-left: 45px !important;
                        padding-top: 5px !important;
                    }
                    .welcome-msg h1 { font-size: 1.1rem !important; margin: 0 !important; }
                    .welcome-msg p { display: block !important; font-size: 0.75rem !important; margin-top: 2px !important; }
                    .top-actions {
                        position: absolute !important;
                        right: 10px !important;
                        top: 15px !important;
                    }
                    .search-box { display: none !important; }

                    /* Table to Card Transformation */
                    .data-table, .data-table thead, .data-table tbody, .data-table th, .data-table td, .data-table tr {
                        display: block !important;
                    }
                    .data-table thead { display: none !important; }
                    .data-table tr {
                        margin-bottom: 15px !important;
                        border: 1px solid rgba(29, 62, 53, 0.1) !important;
                        border-radius: 12px !important;
                        padding: 12px !important;
                        background: #fff !important;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.05) !important;
                    }
                    .data-table td {
                        padding: 8px 0 !important;
                        border-bottom: 1px solid #f1f5f9 !important;
                        display: flex !important;
                        justify-content: space-between !important;
                        align-items: center !important;
                        text-align: right !important;
                        white-space: normal !important;
                    }
                    .data-table td:last-child { border-bottom: none !important; }
                    
                    /* Adding labels for card view */
                    .data-table td::before {
                        content: attr(data-label) !important;
                        font-weight: 700 !important;
                        color: var(--primary) !important;
                        font-size: 0.75rem !important;
                        text-transform: uppercase !important;
                        margin-right: 10px !important;
                        text-align: left !important;
                    }

                    .main-wrapper {
                        margin-left: 0 !important;
                        width: 100% !important;
                        min-width: 100% !important;
                        padding: 0 !important;
                    }
                    .content-area { padding: 10px !important; }
                    .content-card { padding: 12px !important; }
                    .card-header h3 { font-size: 1rem !important; }
                }
            </style>
            <style>
                .modal-overlay {
                    display: none;
                    position: fixed;
                    inset: 0;
                    background: rgba(0, 0, 0, 0.45);
                    z-index: 1000;
                    align-items: center;
                    justify-content: center;
                }

                .modal-overlay.open {
                    display: flex;
                }

                .modal-box {
                    background: #fff;
                    border-radius: 12px;
                    padding: 28px 32px;
                    width: 100%;
                    max-width: 480px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                }

                .modal-box h3 {
                    margin: 0 0 20px;
                    font-size: 1.1rem;
                    color: #1e1b4b;
                }

                .form-group {
                    display: grid;
                    gap: 6px;
                    margin-bottom: 16px;
                }

                .form-group label {
                    font-size: 0.85rem;
                    font-weight: 600;
                    color: #374151;
                }

                .form-group input,
                .form-group select {
                    width: 100%;
                    box-sizing: border-box;
                    padding: 9px 12px;
                    border: 1px solid #e2e8f0;
                    border-radius: 8px;
                    font-size: 0.9rem;
                    outline: none;
                    transition: border-color 0.2s;
                }
                    transition: border 0.2s;
                }

                .form-group input:focus,
                .form-group select:focus {
                    border-color: #4f46e5;
                }

                .modal-actions {
                    display: flex;
                    gap: 10px;
                    justify-content: flex-end;
                    margin-top: 8px;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/sidebar.jsp">
                <jsp:param name="action" value="interviews" />
            </jsp:include>

            <jsp:include page="includes/header.jsp">
                <jsp:param name="title" value="Interviews Dashboard" />
                <jsp:param name="subtitle" value="Track and manage candidate interviews" />
            </jsp:include>

            <main class="main-wrapper">
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
                                        <th style="width: 20%">Candidate</th>
                                        <th style="width: 20%">Company</th>
                                        <th style="width: 15%">Date &amp; Time</th>
                                        <th style="width: 15%">Interviewer</th>
                                        <th style="width: 10%">Status</th>
                                        <th style="width: 20%">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="interview" items="${interviews}">
                                        <tr>
                                            <td data-label="Candidate">
                                                <div style="font-weight:700; color: var(--primary);">${interview.candidate}</div>
                                            </td>
                                            <td data-label="Company">
                                                <div style="font-size:0.85rem;color:var(--secondary);font-weight:600;">
                                                    ${interview.companyName}</div>
                                            </td>
                                            <td data-label="Time">
                                                <div style="font-size:0.85rem;color:var(--text-main);"><i
                                                        class="far fa-calendar-alt"></i> ${interview.time}</div>
                                            </td>
                                            <td data-label="Interviewer">
                                                <div style="display:flex;align-items:center;gap:8px;">
                                                    <img src="https://ui-avatars.com/api/?name=${interview.interviewer}&background=f1f5f9&color=1D3E35"
                                                        style="width:28px;height:28px;border-radius:50%; border: 1px solid #E8F5F1;">
                                                    <span style="font-weight: 500;">${interview.interviewer}</span>
                                                </div>
                                            </td>
                                            <td data-label="Status">
                                                <span class="status-badge"
                                                    style="background:var(--primary-light);color:var(--primary); font-size: 0.7rem;">${interview.status}</span>
                                            </td>
                                            <td data-label="Actions">
                                                <div style="display:flex;gap:8px; flex-wrap: nowrap;">
                                                    <button class="btn-sm btn-outline" style="color:var(--success); border-color: var(--success);"><i
                                                            class="fas fa-video"></i> Start</button>
                                                    <button class="btn-sm btn-outline"><i
                                                            class="fas fa-edit"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty interviews}">
                                        <tr>
                                            <td colspan="6">
                                                <div style="padding:4rem;text-align:center;color:var(--text-dim);">
                                                    <i class="fas fa-calendar-times"
                                                        style="font-size:3rem;margin-bottom:1rem;opacity:0.2;"></i>
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
                    <h3><i class="fas fa-calendar-plus" style="color:#4f46e5;margin-right:8px;"></i>Schedule New
                        Interview</h3>
                    <form action="admin" method="POST">
                        <input type="hidden" name="action" value="scheduleInterview">

                        <div class="form-group">
                            <label>Target Job Position</label>
                            <select name="jobId" required>
                                <option value="">-- Select Job --</option>
                                <c:forEach var="j" items="${jobs}">
                                    <option value="${j.id}">${j.title} (${j.company})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Candidate Name</label>
                            <input type="text" name="candidateName" placeholder="e.g. Sujit" required>
                        </div>

                        <div class="form-group">
                            <label>Interviewer Name</label>
                            <input type="text" name="interviewer" placeholder="e.g. Panas" required>
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
                            <button type="button" class="btn-sm btn-outline"
                                onclick="closeScheduleModal()">Cancel</button>
                            <button type="submit" class="btn-sm btn-primary">Save Interview</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function openScheduleModal() { document.getElementById('scheduleModal').classList.add('open'); }
                function closeScheduleModal() { document.getElementById('scheduleModal').classList.remove('open'); }
                // Close on backdrop click
                document.getElementById('scheduleModal').addEventListener('click', function (e) {
                    if (e.target === this) closeScheduleModal();
                });
            </script>
        </body>

        </html>