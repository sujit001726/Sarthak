<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Post New Job</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="jobs" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Post New Job</h1>
                <p>Add a new job opening to the platform</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header">
                    <h3>Job Details</h3>
                </div>
                
                <form action="admin" method="POST" style="display: grid; gap: 20px;">
                    <input type="hidden" name="action" value="saveJob">
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Job Title</label>
                        <input type="text" name="title" required placeholder="e.g. Senior Java Developer" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Company Name</label>
                            <input type="text" name="company" required placeholder="e.g. Sarthak IT Solutions" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                        </div>
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Location</label>
                            <input type="text" name="location" required placeholder="e.g. Kathmandu, Nepal" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                        </div>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Salary Range</label>
                            <input type="text" name="salary" placeholder="e.g. Rs. 50,000 - 80,000" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                        </div>
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Job Status</label>
                            <select name="status" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                                <option value="pending">Pending Review</option>
                                <option value="approved">Approved</option>
                                <option value="new">New</option>
                            </select>
                        </div>
                    </div>
                    
                    <div style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px;">
                        <a href="admin?action=jobs" class="btn-sm btn-outline" style="text-decoration: none; display: flex; align-items: center; padding: 10px 20px;">Cancel</a>
                        <button type="submit" class="btn-sm btn-primary" style="padding: 10px 30px; font-size: 0.9rem;">Post Job</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
