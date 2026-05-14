<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Settings</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1D3E35',
                        secondary: '#4E7A6E',
                        accent: '#22c55e',
                        dark: '#0F211C',
                        surface: '#F4F7F6'
                    },
                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #F4F7F6; height: 100vh; overflow: hidden; }
        .dashboard-container { display: flex; height: 100vh; width: 100%; overflow: hidden; }
        .sidebar { width: 280px; height: 100%; display: flex; flex-direction: column; background: #1D3E35; flex-shrink: 0; }
        .sidebar-scroll-area { flex: 1; overflow-y: auto; scrollbar-width: thin; scrollbar-color: rgba(255, 255, 255, 0.2) transparent; }
        .sidebar-scroll-area::-webkit-scrollbar { width: 4px; }
        .sidebar-scroll-area::-webkit-scrollbar-track { background: transparent; }
        .sidebar-scroll-area::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.2); border-radius: 10px; }
        .main-content-wrapper { flex: 1; height: 100%; overflow-y: auto; display: flex; flex-direction: column; background-color: #F4F7F6; scroll-behavior: smooth; }
        #main-header { position: relative !important; top: auto !important; }
        .sidebar-item { transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1); border-radius: 12px; margin-bottom: 4px; color: rgba(255, 255, 255, 0.6); }
        .sidebar-item:hover { background-color: rgba(255, 255, 255, 0.1); color: #FFFFFF; }
        .sidebar-item.active { background-color: #4E7A6E; color: #FFFFFF; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); border-left: 4px solid #22c55e; }
        /* Toggle Switch */
        .toggle-checkbox:checked { right: 0; border-color: #22c55e; }
        .toggle-checkbox:checked + .toggle-label { background-color: #22c55e; }
        .toggle-checkbox { right: 0; z-index: 1; border-color: #e5e7eb; transition: all 0.3s; }
        .toggle-label { width: 3rem; height: 1.5rem; background-color: #e5e7eb; border-radius: 9999px; transition: all 0.3s; cursor: pointer; }
        .toggle-checkbox:checked { transform: translateX(100%); border-color: white; }
        @media (max-width: 1024px) { .sidebar { display: none; } body { overflow: auto; height: auto; } .dashboard-container { height: auto; display: block; } .main-content-wrapper { height: auto; overflow: visible; } #main-header { position: sticky !important; top: 0 !important; } }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #1D3E35; border-radius: 10px; }
    </style>
</head>

<body class="text-gray-900 bg-surface">
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-scroll-area p-6 flex flex-col custom-scrollbar">
                <div class="mb-12 px-4">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-20 w-auto brightness-0 invert opacity-90">
                </div>
                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Hiring Suite</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/employer/dashboard" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-chart-pie w-5"></i><span>Dashboard</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/post-job" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-plus-circle w-5"></i><span>Post New Job</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/manage-jobs" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-briefcase w-5"></i><span>Manage My Jobs</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/applicants" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-users-viewfinder w-5"></i><span>Manage Applicants</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/search-talent.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-magnifying-glass w-5"></i><span>Search Talent</span>
                        </a>
                    </nav>
                </div>
                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Company</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/employer/company-profile.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-building w-5"></i><span>Company Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/billing-plans.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-credit-card w-5"></i><span>Billing & Plans</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/settings.jsp" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-sliders w-5 text-accent"></i><span>Settings</span>
                        </a>
                    </nav>
                </div>
                <div class="mt-auto pt-8 border-t border-white/10">
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
                        <i class="fa-solid fa-right-from-bracket w-5"></i><span>Log Out</span>
                    </a>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="main-content-wrapper">
            <%@ include file="/includes/header.jsp" %>
            <main class="p-6 lg:p-8 flex flex-col gap-8 w-full max-w-full">
                <!-- Header -->
                <div class="flex flex-col md:flex-row justify-between gap-6">
                    <div>
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Account Settings</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Manage your preferences and security settings</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left Column -->
                    <div class="lg:col-span-2 space-y-8">
                        <!-- Personal Info -->
                        <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm">
                            <h3 class="text-lg font-black text-dark border-b border-gray-100 pb-4 mb-6">Personal Information</h3>
                            <form class="space-y-6">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Full Name</label>
                                        <input type="text" value="${employerName}" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Email Address</label>
                                        <input type="email" value="employer@sarthak.corp" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" disabled>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Phone Number</label>
                                    <input type="tel" value="+977 9800000000" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                </div>
                                <div class="flex justify-end">
                                    <button type="button" class="bg-primary text-white px-6 py-2.5 rounded-xl text-sm font-bold hover:bg-opacity-90 transition-all">Save Changes</button>
                                </div>
                            </form>
                        </div>

                        <!-- Security -->
                        <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm">
                            <h3 class="text-lg font-black text-dark border-b border-gray-100 pb-4 mb-6">Security Settings</h3>
                            <form class="space-y-6">
                                <div class="space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Current Password</label>
                                    <input type="password" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase tracking-wider">New Password</label>
                                        <input type="password" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Confirm New Password</label>
                                        <input type="password" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    </div>
                                </div>
                                <div class="flex justify-end">
                                    <button type="button" class="bg-dark text-white px-6 py-2.5 rounded-xl text-sm font-bold hover:bg-opacity-90 transition-all">Update Password</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Right Column: Preferences -->
                    <div class="space-y-8">
                        <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm">
                            <h3 class="text-lg font-black text-dark border-b border-gray-100 pb-4 mb-6">Notifications</h3>
                            
                            <div class="space-y-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <h4 class="text-sm font-bold text-dark">Email Notifications</h4>
                                        <p class="text-[0.65rem] text-gray-400 mt-1">Receive daily summaries.</p>
                                    </div>
                                    <div class="relative inline-block w-12 mr-2 align-middle select-none">
                                        <input type="checkbox" name="toggle" id="emailToggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer" checked/>
                                        <label for="emailToggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-gray-300 cursor-pointer"></label>
                                    </div>
                                </div>
                                
                                <div class="flex items-center justify-between">
                                    <div>
                                        <h4 class="text-sm font-bold text-dark">New Applications</h4>
                                        <p class="text-[0.65rem] text-gray-400 mt-1">Alerts when someone applies.</p>
                                    </div>
                                    <div class="relative inline-block w-12 mr-2 align-middle select-none">
                                        <input type="checkbox" name="toggle" id="appToggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer" checked/>
                                        <label for="appToggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-gray-300 cursor-pointer"></label>
                                    </div>
                                </div>

                                <div class="flex items-center justify-between">
                                    <div>
                                        <h4 class="text-sm font-bold text-dark">Marketing Emails</h4>
                                        <p class="text-[0.65rem] text-gray-400 mt-1">Promotions and updates.</p>
                                    </div>
                                    <div class="relative inline-block w-12 mr-2 align-middle select-none">
                                        <input type="checkbox" name="toggle" id="marketingToggle" class="toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4 appearance-none cursor-pointer"/>
                                        <label for="marketingToggle" class="toggle-label block overflow-hidden h-6 rounded-full bg-gray-300 cursor-pointer"></label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Danger Zone -->
                        <div class="bg-red-50 rounded-[2rem] p-8 border border-red-100 shadow-sm">
                            <h3 class="text-lg font-black text-red-600 border-b border-red-200 pb-4 mb-4">Danger Zone</h3>
                            <p class="text-xs font-medium text-red-500 mb-6">Once you delete your account, there is no going back. Please be certain.</p>
                            <button class="w-full bg-red-600 text-white py-3 rounded-xl text-sm font-bold hover:bg-red-700 transition-all">Delete Account</button>
                        </div>
                    </div>
                </div>

            </main>
            <div class="bg-[#1D3E35] pb-20">
                <%@ include file="/includes/footer.jsp" %>
            </div>
        </div>
    </div>
</body>
</html>
