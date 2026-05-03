<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sarthak Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">
</head>
<body>
<main class="login-shell">
<section class="login-card">
    <h1>Sarthak Employer Portal</h1>
    <p>Use the demo employer account to open the dashboard.</p>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <button class="button" type="submit">Continue as Employer</button>
    </form>
</section>
</main>
</body>
</html>
