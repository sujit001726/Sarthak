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
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div class="lg:col-span-2 bg-white p-6 rounded-lg shadow-sm">
        <h1 class="text-2xl font-semibold text-gray-800 mb-4">Create New Job Posting</h1>
        <form action="${pageContext.request.contextPath}/employer/save-job" method="post" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700">Job Title</label>
            <input name="title" class="mt-1 block w-full border rounded px-3 py-2" placeholder="e.g., Senior Product Designer" />
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">Department</label>
              <input name="department" class="mt-1 block w-full border rounded px-3 py-2" placeholder="Engineering" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Employment Type</label>
              <select name="jobType" class="mt-1 block w-full border rounded px-3 py-2">
                <option>Full-time</option>
                <option>Part-time</option>
                <option>Contract</option>
              </select>
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">Location</label>
            <input name="location" class="mt-1 block w-full border rounded px-3 py-2" placeholder="e.g., San Francisco (Remote)" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">Job Description</label>
            <textarea name="description" rows="8" class="mt-1 block w-full border rounded px-3 py-2" placeholder="Outline the responsibilities, requirements, and day-to-day expectations..."></textarea>
          </div>
          <div class="flex justify-end">
            <button class="bg-gray-200 text-gray-700 px-4 py-2 rounded mr-2">Save Draft</button>
            <button class="bg-blue-600 text-white px-4 py-2 rounded">Publish Job Posting</button>
          </div>
        </form>
      </div>

      <aside class="bg-white p-6 rounded-lg shadow-sm">
        <div class="text-sm text-slate-500 mb-2">Live Preview</div>
        <div class="border rounded p-4">
          <div class="flex justify-between items-start">
            <div>
              <div class="text-lg font-semibold">Senior Product Designer</div>
              <div class="text-xs text-slate-500">Product Design • Engineering</div>
              <div class="text-xs text-slate-500 mt-2">San Francisco (Remote)</div>
            </div>
            <div class="text-xs text-slate-400">NCM</div>
          </div>
          <div class="mt-4 text-sm text-slate-600">$140k - $180k • Full-time</div>
          <div class="mt-4">
            <button class="w-full bg-blue-600 text-white px-3 py-2 rounded">Preview</button>
          </div>
        </div>
      </aside>
    </div>
  </main>

  <jsp:include page="/WEB-INF/includes/footer.jsp"/>
</body>
</html>
