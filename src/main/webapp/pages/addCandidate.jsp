<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Add New Candidate</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="candidates" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Add New Candidate</h1>
                <p>Register a new candidate in the system</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header">
                    <h3>Candidate Personal Details</h3>
                </div>
                
                <form action="admin" method="POST" style="display: grid; gap: 20px;">
                    <input type="hidden" name="action" value="saveCandidate">
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Full Name</label>
                        <input type="text" name="name" required placeholder="e.g. John Doe" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Email Address</label>
                            <input type="email" name="email" required placeholder="john.doe@example.com" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                        </div>
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Phone Number</label>
                            <input type="text" name="phone" placeholder="+977 98XXXXXXXX" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                        </div>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Experience Level</label>
                            <select name="level" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                                <option value="entry_level">Entry Level</option>
                                <option value="intermediate">Intermediate</option>
                                <option value="senior">Senior</option>
                                <option value="expert">Expert</option>
                            </select>
                        </div>
                        <div style="display: grid; gap: 8px;">
                            <label style="font-weight: 600; font-size: 0.9rem;">Initial Status</label>
                            <select name="status" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px;">
                                <option value="applied">Applied</option>
                                <option value="screened">Screened</option>
                                <option value="shortlisted">Shortlisted</option>
                            </select>
                        </div>
                    </div>
                    
                    <div style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px;">
                        <a href="admin?action=candidates" class="btn-sm btn-outline" style="text-decoration: none; display: flex; align-items: center; padding: 10px 20px;">Cancel</a>
                        <button type="submit" class="btn-sm btn-primary" style="padding: 10px 30px; font-size: 0.9rem;">Add Candidate</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
