<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Add Category</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="categories" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Add New Category</h1>
                <p>Define a new job category for listings</p>
            </div>
        </header>

        <div class="content-area">
            <div class="content-card animate-fade" style="max-width: 600px; margin: 0 auto;">
                <div class="card-header">
                    <h3>Category Details</h3>
                </div>
                
                <form action="admin" method="POST" style="display: grid; gap: 20px;">
                    <input type="hidden" name="action" value="saveCategory">
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Category Name</label>
                        <input type="text" name="name" required placeholder="e.g. Technology, Finance, Marketing" style="padding: 12px; border: 1px solid var(--border-color); border-radius: 8px;">
                    </div>
                    
                    <div style="display: grid; gap: 8px;">
                        <label style="font-weight: 600; font-size: 0.9rem;">Description</label>
                        <textarea name="description" rows="4" placeholder="Brief description of the category..." style="padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; resize: none;"></textarea>
                    </div>
                    
                    <div style="display: flex; gap: 10px; justify-content: flex-end; margin-top: 10px;">
                        <a href="admin?action=categories" class="btn-sm btn-outline" style="text-decoration: none; padding: 10px 20px;">Cancel</a>
                        <button type="submit" class="btn-sm btn-primary" style="padding: 10px 30px;">Save Category</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
