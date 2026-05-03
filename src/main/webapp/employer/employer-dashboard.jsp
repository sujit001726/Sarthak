<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/includes/head.jsp"/>
</head>
<body class="bg-gray-100 min-h-screen">
    <jsp:include page="/WEB-INF/includes/header.jsp"/>

    <div class="max-w-7xl mx-auto px-0 lg:px-6 py-8 grid grid-cols-12 gap-6">
        <div class="col-span-12 lg:col-span-3">
            <jsp:include page="/WEB-INF/includes/sidebar.jsp"/>
        </div>

        <main class="col-span-12 lg:col-span-6">
            <div class="px-6">
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
                    <div class="bg-white p-4 rounded-lg shadow">
                        <div class="text-xs text-slate-500">Active Jobs</div>
                        <div class="text-2xl font-semibold text-slate-800">${totalJobs}</div>
                    </div>
                    <div class="bg-white p-4 rounded-lg shadow">
                        <div class="text-xs text-slate-500">Total Applications</div>
                        <div class="text-2xl font-semibold text-slate-800">${totalApplications}</div>
                    </div>
                    <div class="bg-white p-4 rounded-lg shadow">
                        <div class="text-xs text-slate-500">Shortlisted</div>
                        <div class="text-2xl font-semibold text-slate-800">${shortlistedCount}</div>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow p-6 mb-6">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-medium text-slate-800">Active Hiring Pipeline</h3>
                        <div class="text-sm text-slate-500">Manage and track candidate progression</div>
                    </div>

                    <!-- Simple pipeline stepper -->
                    <div class="space-y-4">
                        <div class="w-full bg-slate-100 rounded-full h-2 relative">
                            <div class="absolute left-0 top-0 h-2 rounded-full bg-blue-600" style="width:45%"></div>
                        </div>
                        <div class="flex justify-between text-sm text-slate-600">
                            <div class="text-center"><div class="font-semibold text-slate-800">Applied</div><div>450 candidates</div></div>
                            <div class="text-center"><div class="font-semibold text-slate-800">Shortlisted</div><div>84 candidates</div></div>
                            <div class="text-center"><div class="font-semibold text-slate-800">Interview</div><div>12 scheduled</div></div>
                            <div class="text-center"><div class="font-semibold text-slate-800">Hired</div><div>0 total</div></div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow p-6">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-medium text-slate-800">Recent Applications</h3>
                        <a href="#" class="text-sm text-blue-600">View All</a>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="min-w-full table-auto">
                            <thead class="bg-slate-50 text-slate-500 text-sm">
                                <tr>
                                    <th class="px-4 py-3 text-left">Candidate</th>
                                    <th class="px-4 py-3 text-left">Job Title</th>
                                    <th class="px-4 py-3 text-left">Applied Date</th>
                                    <th class="px-4 py-3 text-left">Status</th>
                                    <th class="px-4 py-3 text-left">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="text-sm text-slate-700">
                                <tr class="border-b">
                                    <td class="px-4 py-4 flex items-center gap-3">
                                        <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center text-blue-700">AJ</div>
                                        <div>
                                            <div class="font-medium">Alex Johnson</div>
                                            <div class="text-xs text-slate-500">alex.j@example.com</div>
                                        </div>
                                    </td>
                                    <td class="px-4 py-4">Senior Product Designer</td>
                                    <td class="px-4 py-4">Oct 24, 2023</td>
                                    <td class="px-4 py-4"><span class="inline-flex items-center px-2 py-1 rounded bg-amber-100 text-amber-800 text-xs">Interviewing</span></td>
                                    <td class="px-4 py-4">...</td>
                                </tr>
                                <tr class="border-b">
                                    <td class="px-4 py-4 flex items-center gap-3">
                                        <div class="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center text-green-700">SL</div>
                                        <div>
                                            <div class="font-medium">Sarah Lee</div>
                                            <div class="text-xs text-slate-500">sarah.lee@tech.com</div>
                                        </div>
                                    </td>
                                    <td class="px-4 py-4">Full Stack Developer</td>
                                    <td class="px-4 py-4">Oct 23, 2023</td>
                                    <td class="px-4 py-4"><span class="inline-flex items-center px-2 py-1 rounded bg-indigo-100 text-indigo-800 text-xs">Shortlisted</span></td>
                                    <td class="px-4 py-4">...</td>
                                </tr>
                                <tr>
                                    <td class="px-4 py-4 flex items-center gap-3">
                                        <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center text-purple-700">MW</div>
                                        <div>
                                            <div class="font-medium">Marcus Wright</div>
                                            <div class="text-xs text-slate-500">m.wright@dev.io</div>
                                        </div>
                                    </td>
                                    <td class="px-4 py-4">DevOps Engineer</td>
                                    <td class="px-4 py-4">Oct 22, 2023</td>
                                    <td class="px-4 py-4"><span class="inline-flex items-center px-2 py-1 rounded bg-slate-100 text-slate-800 text-xs">Applied</span></td>
                                    <td class="px-4 py-4">...</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>

        <aside class="col-span-12 lg:col-span-3 px-6">
            <div class="bg-white rounded-lg shadow p-6 mb-6">
                <div class="flex items-center gap-4">
                    <img src="${pageContext.request.contextPath}/resources/img/avatar.png" alt="avatar" class="w-12 h-12 rounded-full"/>
                    <div>
                        <div class="font-medium">Kasmira Karki</div>
                        <div class="text-sm text-slate-500">HR Director • Premium Plan</div>
                    </div>
                </div>
                <div class="mt-4 flex gap-2">
                    <a href="#" class="flex-1 bg-white border rounded px-3 py-2 text-sm text-slate-700">Edit Profile</a>
                    <a href="#" class="flex-1 bg-slate-800 text-white rounded px-3 py-2 text-sm">Account Settings</a>
                </div>
            </div>

            <div class="bg-white rounded-lg shadow p-6">
                <h4 class="text-sm font-medium text-slate-800 mb-2">Recent Activity</h4>
                <ul class="text-sm text-slate-600 space-y-3">
                    <li>New application received for Senior Product Designer</li>
                    <li>Interview with Alex Johnson starting in 15 mins</li>
                    <li>Application for Backend Lead moved to "Shortlisted"</li>
                </ul>
            </div>
        </aside>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>
</body>
</html>