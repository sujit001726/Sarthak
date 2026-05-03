<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/includes/head.jsp"/>
</head>
<body class="bg-gray-100 min-h-screen">
    <jsp:include page="/WEB-INF/includes/header.jsp"/>

    <main class="max-w-4xl mx-auto px-6 py-12">
        <div class="bg-white p-8 rounded-lg shadow-sm text-center">
            <h1 class="text-3xl font-bold text-gray-800">Welcome to Employer Hub</h1>
            <p class="text-gray-600 mt-2">A clean, Tailwind-based UI prototype.</p>
            <div class="mt-6">
                <a href="hello-servlet" class="inline-block bg-blue-600 text-white px-4 py-2 rounded">Hello Servlet</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>
</body>
</html>