<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>${formTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="page">
<header class="topbar">
    <strong class="brand">Sarthak Employer Portal</strong>
    <a class="nav-link" href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
</header>
<h1>${formTitle}</h1>
<c:if test="${not empty databaseError}">
    <div class="notice">${databaseError}</div>
</c:if>
<form class="panel form-panel" method="post" action="${formAction}">
    <label for="title">Job Title</label>
    <input id="title" name="title" value="${job.title}" required>

    <label for="description">Description</label>
    <textarea id="description" name="description" required>${job.description}</textarea>

    <label for="location">Location</label>
    <input id="location" name="location" value="${job.location}" required>

    <label for="salaryRange">Salary Range</label>
    <input id="salaryRange" name="salaryRange" value="${job.salaryRange}" placeholder="50000-70000">

    <label for="jobType">Job Type</label>
    <select id="jobType" name="jobType" required>
        <option value="full-time" ${job.jobType == 'full-time' ? 'selected' : ''}>Full-time</option>
        <option value="part-time" ${job.jobType == 'part-time' ? 'selected' : ''}>Part-time</option>
        <option value="contract" ${job.jobType == 'contract' ? 'selected' : ''}>Contract</option>
        <option value="internship" ${job.jobType == 'internship' ? 'selected' : ''}>Internship</option>
    </select>

    <label for="status">Status</label>
    <select id="status" name="status" required>
        <option value="active" ${job.status == 'active' ? 'selected' : ''}>Active</option>
        <option value="draft" ${job.status == 'draft' ? 'selected' : ''}>Draft</option>
        <option value="closed" ${job.status == 'closed' ? 'selected' : ''}>Closed</option>
    </select>

    <label for="deadline">Deadline</label>
    <input id="deadline" type="date" name="deadline" value="${job.deadline}" required>

    <div class="actions">
        <button class="button" type="submit">${submitLabel}</button>
        <a class="button secondary" href="${pageContext.request.contextPath}/employer/dashboard">Cancel</a>
    </div>
</form>
</main>
</body>
</html>
