<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Applicants</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page">
<header class="topbar">
    <strong class="brand">Sarthak Employer Portal</strong>
    <a class="nav-link" href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
</header>
<h1>Applicants</h1>
<p>Job: <strong>${job.title}</strong></p>
<c:if test="${not empty databaseError}">
    <div class="notice">${databaseError}</div>
</c:if>
<section class="panel">
<div class="table-wrap">
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="empty-state" colspan="3">No applicants for this job yet.</td>
    </tr>
    </tbody>
</table>
</div>
</section>
</main>
</body>
</html>
