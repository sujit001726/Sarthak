<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Page Not Found</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; height: 100vh;">
    <div class="bg-mesh"></div>
    <div class="login-card animate-fade">
        <h1 style="font-size: 5rem; color: var(--primary);">404</h1>
        <h2 style="margin-bottom: 1rem;">Oops! Page not found</h2>
        <p style="color: var(--text-dim); margin-bottom: 2rem;">The page you are looking for might have been removed or is temporarily unavailable.</p>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-primary">Go to Dashboard</a>
    </div>
</body>
</html>
