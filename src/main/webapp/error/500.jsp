<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Server Error</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; height: 100vh;">
    <div class="bg-mesh"></div>
    <div class="login-card animate-fade">
        <h1 style="font-size: 5rem; color: var(--danger);">500</h1>
        <h2 style="margin-bottom: 1rem;">Internal Server Error</h2>
        <p style="color: var(--text-dim); margin-bottom: 2rem;">Something went wrong on our end. We're working on it!</p>
        <pre style="text-align: left; background: #eee; padding: 10px; overflow-x: auto; font-size: 12px; color: red;">
            ${exception != null ? exception.message : requestScope['jakarta.servlet.error.exception']}
            <% if(exception != null) exception.printStackTrace(new java.io.PrintWriter(out)); %>
        </pre>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-primary">Retry Connection</a>
    </div>
</body>
</html>
