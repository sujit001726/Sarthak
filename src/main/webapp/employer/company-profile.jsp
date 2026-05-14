<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Company Profile</title>
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
                        <a href="${pageContext.request.contextPath}/employer/company-profile.jsp" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-building w-5 text-accent"></i><span>Company Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/billing-plans.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-credit-card w-5"></i><span>Billing & Plans</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/settings.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-sliders w-5"></i><span>Settings</span>
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
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Company Profile</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Showcase your brand and attract top talent</p>
                    </div>
                    <button class="bg-primary text-white px-8 py-3 rounded-xl text-sm font-bold hover:bg-opacity-90 shadow-lg shadow-primary/20">Save Changes</button>
                </div>

                <!-- Form Section -->
                <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm max-w-4xl">
                    <div class="flex items-center gap-8 mb-8 border-b border-gray-100 pb-8">
                        <div class="w-24 h-24 bg-surface rounded-2xl flex items-center justify-center text-gray-400 border-2 border-dashed border-gray-300 relative group cursor-pointer">
                            <i class="fa-solid fa-camera text-2xl group-hover:text-primary"></i>
                            <div class="absolute inset-0 bg-primary/10 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
                        </div>
                        <div>
                            <h3 class="font-bold text-dark text-lg">Company Logo</h3>
                            <p class="text-xs text-gray-400 mt-1">Recommended size 512x512px. PNG or JPG.</p>
                            <button class="mt-3 text-sm text-primary font-bold hover:underline">Upload Image</button>
                        </div>
                    </div>
                    
                    <form class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Name</label>
                                <input type="text" value="Sarthak Corp" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Industry</label>
                                <select class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    <option>Technology & Software</option>
                                    <option>Finance</option>
                                    <option>Healthcare</option>
                                    <option>Education</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="space-y-2">
                            <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Website URL</label>
                            <input type="url" value="https://sarthak.corp" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                        </div>
                        
                        <div class="space-y-2">
                            <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Description</label>
                            <textarea rows="4" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-medium text-dark focus:ring-2 focus:ring-primary">Sarthak Corp is a leading technology company focused on delivering innovative solutions...</textarea>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-4 border-t border-gray-100">
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Size</label>
                                <select class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    <option>1-50 Employees</option>
                                    <option selected>51-200 Employees</option>
                                    <option>201-500 Employees</option>
                                    <option>500+ Employees</option>
                                </select>
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Founded Year</label>
                                <input type="number" value="2015" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Location</label>
                                <input type="text" value="Kathmandu, Nepal" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                            </div>
                        </div>
                    </form>
                </div>
            </main>
            <div class="bg-[#1D3E35] pb-20">
                <%@ include file="/includes/footer.jsp" %>
            </div>
        </div>
    </div>
</body>
</html>
