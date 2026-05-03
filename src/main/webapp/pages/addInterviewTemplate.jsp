<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Design Interview</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="interviewDesigner" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Interview Designer</h1>
                <p>Create a structured interview process template</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header">
                    <h3>Template Details</h3>
                </div>
                
                <form action="admin" method="POST" style="display: grid; gap: 20px;">
                    <input type="hidden" name="action" value="saveInterviewTemplate">
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Template Name</label>
                        <input type="text" name="name" required placeholder="e.g. Standard Software Engineer Interview" style="padding: 12px; border: 1px solid var(--border-color); border-radius: 8px;">
                    </div>
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Interview Stages (JSON or Comma separated)</label>
                        <textarea name="stages" rows="4" placeholder="Screening, Technical, Management, HR" style="padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; resize: none;"></textarea>
                    </div>
                    
                    <div style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 10px;">
                        <a href="admin?action=interviewDesigner" class="btn-sm btn-outline" style="text-decoration: none; padding: 10px 20px;">Cancel</a>
                        <button type="submit" class="btn-sm btn-primary" style="padding: 10px 30px;">Save Template</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
