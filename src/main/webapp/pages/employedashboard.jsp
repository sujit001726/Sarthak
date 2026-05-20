<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 4/29/2026
  Time: 8:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <jsp:include page="/WEB-INF/includes/head.jsp"/>
</head>
<body class="bg-gray-100 min-h-screen">
  <jsp:include page="/WEB-INF/includes/header.jsp"/>

  <main class="max-w-7xl mx-auto px-6 py-8">
    <div class="bg-white p-6 rounded-lg shadow-sm">
      <h1 class="text-2xl font-semibold text-gray-800">Employee Dashboard</h1>
      <p class="text-gray-600 mt-2">Welcome, ${employerName}!</p>
    </div>
  </main>

  <jsp:include page="/WEB-INF/includes/footer.jsp"/>
</body>
</html>
