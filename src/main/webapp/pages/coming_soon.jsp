<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Coming Soon</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .coming-soon-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 60vh;
            text-align: center;
            color: var(--text-main);
        }
        .coming-soon-icon {
            font-size: 5rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }
        .coming-soon-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .coming-soon-text {
            color: var(--text-dim);
            font-size: 1.1rem;
            max-width: 500px;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" flush="true" />

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Feature in Development</h1>
                <p>We are actively building this feature.</p>
            </div>

            <div class="top-actions">
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="User">
                    <div class="user-info">
                        <span class="name">Admin</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="content-area">
            <div class="coming-soon-container">
                <i class="fas fa-tools coming-soon-icon"></i>
                <h2 class="coming-soon-title">Coming Soon!</h2>
                <p class="coming-soon-text">
                    This section is currently under development. Please check back later. 
                    Our team is working hard to bring you the best experience!
                </p>
            </div>
        </div>
    </main>
</body>
</html>
