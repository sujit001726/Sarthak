<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sarthak | Admin Gateway</title>
    <!-- Important: Meta refresh ensures redirect happens even if JS is disabled -->
    <meta http-equiv="refresh" content="2;url=login.jsp">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .gateway-container {
            height: 100vh;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .loader {
            width: 48px;
            height: 48px;
            border: 5px solid #FFF;
            border-bottom-color: var(--primary);
            border-radius: 50%;
            display: inline-block;
            box-sizing: border-box;
            animation: rotation 1s linear infinite;
            margin-bottom: 20px;
        }
        @keyframes rotation {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="bg-mesh"></div>
    <div class="gateway-container animate-fade">
        <span class="loader"></span>
        <h1 class="logo">SARTHAK</h1>
        <p style="color: var(--text-dim); margin-top: 10px;">
            Initializing Secure Admin Session...
        </p>
        <p style="font-size: 0.8rem; color: var(--text-dim); margin-top: 20px;">
            Connecting to Nepal Job Portal Infrastructure
        </p>
    </div>
</body>
</html>
