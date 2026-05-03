<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employer Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page">
    <header class="topbar">
        <strong class="brand">Sarthak Employer Portal</strong>
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
    </header>
    <section class="hero-row">
        <div>
            <h1>Employer Dashboard</h1>
            <p>Welcome, ${employerName}!</p>
        </div>
        <div class="stats">
            <div class="stat">
                <span>Total Jobs Posted</span>
                <strong>${totalJobs}</strong>
            </div>
        </div>
    </section>
    <c:if test="${not empty flash}">
        <div class="notice">${flash}</div>
    </c:if>
    <c:if test="${not empty databaseError}">
        <div class="notice">${databaseError}</div>
    </c:if>
    <section class="panel">
        <div class="panel-head">
            <strong>Posted Jobs</strong>
            <a class="button" href="${pageContext.request.contextPath}/employer/post-job">Post New Job</a>
        </div>
        <div class="table-wrap">
    <table>
        <thead>
            <tr>
                <th>Job Title</th>
                <th>Location</th>
                <th>Type</th>
                <th>Status</th>
                <th>Posted Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="job" items="${jobs}">
                <tr>
                    <td>${job.title}</td>
                    <td>${job.location}</td>
                    <td>${job.jobType}</td>
                    <td>
                        <span class="badge badge-${job.status}">${job.status}</span>
                    </td>
                    <td>${job.postedAt}</td>
                    <td>
                        <div class="row-actions">
                        <a class="button secondary" href="${pageContext.request.contextPath}/employer/edit-job?id=${job.id}">Edit</a>
                        <form class="inline-form" method="post" action="${pageContext.request.contextPath}/employer/delete-job">
                            <input type="hidden" name="jobId" value="${job.id}">
                            <button class="button danger" type="submit" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                        <a class="button secondary" href="${pageContext.request.contextPath}/employer/applicants?jobId=${job.id}">Applicants</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty jobs}">
                <tr>
                    <td class="empty-state" colspan="6">No jobs posted yet.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
        </div>
    </section>
</main>
</body>
</html>
