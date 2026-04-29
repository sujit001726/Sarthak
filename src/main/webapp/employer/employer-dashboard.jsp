<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employer Dashboard</title>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/header.jsp"/>
    <h1>Employer Dashboard</h1>
    <p>Welcome, ${employerName}!</p>
    <p>Total Jobs Posted: ${totalJobs}</p>
    <a href="${pageContext.request.contextPath}/employer/post-job">Post New Job</a>
    <table border="1">
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
                        <a href="${pageContext.request.contextPath}/employer/edit-job?id=${job.id}">Edit</a> |
                        <form method="post" action="${pageContext.request.contextPath}/employer/delete-job" style="display:inline;">
                            <input type="hidden" name="jobId" value="${job.id}">
                            <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
                        </form> |
                        <a href="${pageContext.request.contextPath}/employer/applicants?jobId=${job.id}">View Applicants</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty jobs}">
                <tr>
                    <td colspan="6">No jobs posted yet.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <jsp:include page="/WEB-INF/includes/footer.jsp"/>
</body>
</html>