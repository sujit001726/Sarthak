<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Search Talent</title>
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
        .talent-card { transition: all 0.3s ease; }
        .talent-card:hover { transform: translateY(-4px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); }
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
                        <a href="${pageContext.request.contextPath}/employer/search-talent.jsp" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-magnifying-glass w-5 text-accent"></i><span>Search Talent</span>
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
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Talent Search</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Discover top candidates matching your needs</p>
                    </div>
                </div>

                <!-- Search Bar -->
                <div class="bg-white rounded-[2rem] p-6 border border-gray-100 shadow-sm flex flex-col md:flex-row gap-4 items-center">
                    <div class="relative w-full flex-1 group">
                        <i class="fa-solid fa-magnifying-glass absolute left-6 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary transition-all"></i>
                        <input type="text" placeholder="Job title, keywords, or company..." class="w-full bg-surface border-none rounded-2xl py-4 pl-14 pr-6 text-sm font-bold focus:outline-none focus:ring-4 focus:ring-primary/10 transition-all">
                    </div>
                    <div class="relative w-full md:w-1/3 group">
                        <i class="fa-solid fa-location-dot absolute left-6 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary transition-all"></i>
                        <input type="text" placeholder="Location" class="w-full bg-surface border-none rounded-2xl py-4 pl-14 pr-6 text-sm font-bold focus:outline-none focus:ring-4 focus:ring-primary/10 transition-all">
                    </div>
                    <button class="w-full md:w-auto bg-primary text-white px-10 py-4 rounded-2xl text-[0.8rem] font-black shadow-xl shadow-primary/20 hover:scale-[1.05] transition-all">Find Talent</button>
                </div>

                <!-- Results Grid -->
                <div class="grid grid-cols-1 md:grid-cols-3 xl:grid-cols-4 gap-6">
                    <!-- Sample Card -->
                    <div class="talent-card bg-white border border-gray-100 rounded-[2rem] p-6 flex flex-col gap-4 relative overflow-hidden group">
                        <div class="absolute top-4 right-4 bg-accent/10 text-accent text-[0.6rem] font-black px-3 py-1 rounded-full">PRO</div>
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 bg-blue-100 rounded-[1.2rem] flex items-center justify-center text-blue-600 text-xl font-black shadow-lg">A</div>
                            <div>
                                <h3 class="text-lg font-black text-dark leading-none">Aarav Sharma</h3>
                                <p class="text-[0.65rem] font-bold text-gray-400 mt-1 uppercase">Full Stack Developer</p>
                            </div>
                        </div>
                        <div class="flex flex-wrap gap-2 mt-2">
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Java</span>
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Spring Boot</span>
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">React</span>
                        </div>
                        <p class="text-xs text-gray-500 font-medium line-clamp-2">Experienced developer specializing in scalable backend systems and responsive web apps.</p>
                        <div class="mt-auto flex gap-2 pt-4">
                            <button class="flex-1 bg-surface text-primary py-2.5 rounded-xl text-xs font-black hover:bg-primary hover:text-white transition-all">View Profile</button>
                            <button class="w-10 flex items-center justify-center bg-surface text-primary rounded-xl hover:bg-primary hover:text-white transition-all"><i class="fa-regular fa-envelope"></i></button>
                        </div>
                    </div>
                    <!-- Sample Card 2 -->
                    <div class="talent-card bg-white border border-gray-100 rounded-[2rem] p-6 flex flex-col gap-4 relative overflow-hidden group">
                        <div class="absolute top-4 right-4 bg-accent/10 text-accent text-[0.6rem] font-black px-3 py-1 rounded-full">PRO</div>
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 bg-purple-100 rounded-[1.2rem] flex items-center justify-center text-purple-600 text-xl font-black shadow-lg">P</div>
                            <div>
                                <h3 class="text-lg font-black text-dark leading-none">Priya Gurung</h3>
                                <p class="text-[0.65rem] font-bold text-gray-400 mt-1 uppercase">UI/UX Designer</p>
                            </div>
                        </div>
                        <div class="flex flex-wrap gap-2 mt-2">
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Figma</span>
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Prototyping</span>
                            <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">CSS</span>
                        </div>
                        <p class="text-xs text-gray-500 font-medium line-clamp-2">Creative designer with a passion for building user-centric interfaces.</p>
                        <div class="mt-auto flex gap-2 pt-4">
                            <button class="flex-1 bg-surface text-primary py-2.5 rounded-xl text-xs font-black hover:bg-primary hover:text-white transition-all">View Profile</button>
                            <button class="w-10 flex items-center justify-center bg-surface text-primary rounded-xl hover:bg-primary hover:text-white transition-all"><i class="fa-regular fa-envelope"></i></button>
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
