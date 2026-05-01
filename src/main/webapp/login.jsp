<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Admin Login</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
            min-height: 100vh;
        }
        .login-container {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            text-align: center;
        }
        .login-logo {
            width: 48px;
            height: 48px;
            background: var(--primary);
            color: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 800;
            margin: 0 auto 1.5rem;
        }
        .login-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .login-header p {
            color: var(--text-dim);
            font-size: 0.9rem;
            margin-bottom: 2rem;
        }
        .form-group {
            text-align: left;
            margin-bottom: 1.25rem;
        }
        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .form-group input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
        }
        .login-btn {
            width: 100%;
            padding: 0.75rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">S</div>
        <div class="login-header">
            <h2>Admin Login</h2>
            <p>Welcome back! Please enter your details.</p>
        </div>

        <% if(request.getParameter("error") != null) { %>
            <div style="background: #fef2f2; color: var(--danger); padding: 0.75rem; border-radius: 8px; margin-bottom: 1rem; font-size: 0.85rem;">
                <i class="fas fa-exclamation-circle"></i> Invalid credentials, please try again.
            </div>
        <% } %>

        <form action="login" method="POST">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter your username" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="login-btn">
                Sign In
            </button>
        </form>

        <div style="margin-top: 2rem; font-size: 0.8rem; color: var(--text-dim);">
            &copy; 2024 Sarthak Solutions. All rights reserved.
        </div>
    </div>
</body>
</html>

