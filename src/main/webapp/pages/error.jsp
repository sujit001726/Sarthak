<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sarthak | Error</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div style="display: flex; align-items: center; justify-content: center; height: 100vh; width: 100%; flex-direction: column; text-align: center; background: #f8fafc;">
        <i class="fas fa-exclamation-triangle" style="font-size: 5rem; color: #ef4444; margin-bottom: 2rem;"></i>
        <h1 style="font-size: 2rem; color: #1e293b; margin-bottom: 1rem;">Oops! Something went wrong</h1>
        <div style="background: white; padding: 2rem; border-radius: 12px; border: 1px solid #e2e8f0; max-width: 600px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);">
            <p style="color: #ef4444; font-weight: 700; margin-bottom: 1rem;">${errorMessage}</p>
            <p style="color: #64748b; font-size: 0.9rem;">${errorDetail}</p>
            <div style="margin-top: 2rem; border-top: 1px solid #f1f5f9; padding-top: 1rem;">
                <a href="admin?action=dashboard" class="btn-sm btn-primary" style="text-decoration: none;">Return to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
