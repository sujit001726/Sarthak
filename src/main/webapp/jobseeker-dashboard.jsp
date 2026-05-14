<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Pro Job Seeker Dashboard</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link
                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
            <script>
                tailwind.config = {
                    theme: {
                        extend: {
                            colors: {
                                primary: '#1D3E35',
                                secondary: '#4E7A6E',
                                accent: '#22c55e',
                                dark: '#0F211C',
                                surface: '#F4F7F6',
                                sidebar: '#1D3E35'
                            },
                            fontFamily: {
                                sans: ['Plus Jakarta Sans', 'sans-serif'],
                            }
                        }
                    }
                }
            </script>
            <style>
                body {
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    background-color: #F4F7F6;
                    height: 100vh;
                    overflow: hidden;
                }

                .dashboard-container {
                    display: flex;
                    height: 100vh;
                    width: 100%;
                    overflow: hidden;
                }

                .sidebar {
                    width: 280px;
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    background: #1D3E35;
                    flex-shrink: 0;
                }

                .sidebar-scroll-area {
                    flex: 1;
                    overflow-y: auto;
                    scrollbar-width: thin;
                    scrollbar-color: rgba(255, 255, 255, 0.2) transparent;
                }

                .sidebar-scroll-area::-webkit-scrollbar { width: 4px; }
                .sidebar-scroll-area::-webkit-scrollbar-track { background: transparent; }
                .sidebar-scroll-area::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.2); border-radius: 10px; }

                .main-content-wrapper {
                    flex: 1;
                    height: 100%;
                    overflow-y: auto;
                    display: flex;
                    flex-direction: column;
                    background-color: #F4F7F6;
                    scroll-behavior: smooth;
                }

                /* Ensure the global header scrolls if the user wants only sidebar to be constant */
                #main-header { position: relative !important; top: auto !important; }

                .sidebar-item {
                    transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                    border-radius: 12px;
                    margin-bottom: 4px;
                    color: rgba(255, 255, 255, 0.6);
                }

                .sidebar-item:hover {
                    background-color: rgba(255, 255, 255, 0.1);
                    color: #FFFFFF;
                }

                .sidebar-item.active {
                    background-color: #4E7A6E;
                    color: #FFFFFF;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    border-left: 4px solid #22c55e;
                }

                .content-grid {
                    display: grid;
                    grid-template-columns: 1fr 380px;
                    gap: 24px;
                    width: 100%;
                }

                .stat-card {
                    transition: all 0.3s ease;
                }

                .stat-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 10px 20px -5px rgba(29, 62, 53, 0.1);
                }

                .job-tag {
                    font-size: 0.6rem;
                    padding: 3px 8px;
                    border-radius: 4px;
                    font-weight: 800;
                    text-transform: uppercase;
                }

                @media (max-width: 1440px) {
                    .content-grid {
                        grid-template-columns: 1fr;
                    }
                }

                @media (max-width: 1024px) {
                    .sidebar {
                        display: none;
                    }
                    body { overflow: auto; height: auto; }
                    .dashboard-container { height: auto; display: block; }
                    .main-content-wrapper { height: auto; overflow: visible; }
                    #main-header { position: sticky !important; top: 0 !important; }
                }

                ::-webkit-scrollbar {
                    width: 6px;
                }

                ::-webkit-scrollbar-track {
                    background: transparent;
                }

                ::-webkit-scrollbar-thumb {
                    background: #1D3E35;
                    border-radius: 10px;
                }
            </style>
        </head>

        <body class="text-gray-900 bg-surface">

                <div class="dashboard-container">
                    <!-- Sidebar (Stationary) -->
                    <aside class="sidebar">
                        <!-- Fixed Branding -->
                        <div class="p-6 pb-0 px-10">
                            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak"
                                class="h-20 w-auto brightness-0 invert opacity-90">
                        </div>

                        <!-- Scrollable Nav Area -->
                        <div class="sidebar-scroll-area px-4 custom-scrollbar">
                            <div class="mb-10">
                                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                                    Menu</p>
                                <nav>
                                    <a href="#"
                                        class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                                        <i class="fa-solid fa-grid-2 w-5"></i>
                                        <span>Dashboard</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/job-market"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-compass w-5"></i>
                                        <span>Job Market</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/messages"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-envelope w-5"></i>
                                        <span>Messages</span>
                                        <span
                                            class="ml-auto bg-accent text-primary text-[0.6rem] font-black px-1.5 py-0.5 rounded-full">2</span>
                                    </a>
                                </nav>
                            </div>

                            <div class="mb-10">
                                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                                    Network</p>
                                <nav>
                                    <a href="${pageContext.request.contextPath}/friends"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-users w-5"></i>
                                        <span>Friends</span>
                                    </a>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-briefcase w-5"></i>
                                        <span>Job Invitations</span>
                                    </a>
                                </nav>
                            </div>

                            <div class="mb-10">
                                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                                    Personal</p>
                                <nav>
                                    <a href="${pageContext.request.contextPath}/profile"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-user w-5"></i>
                                        <span>My Profile</span>
                                    </a>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-gear w-5"></i>
                                        <span>Settings</span>
                                    </a>
                                </nav>
                            </div>
                        </div>

                        <!-- Fixed Logout Section -->
                        <div class="p-6 pt-8 border-t border-white/10 bg-primary">
                            <a href="${pageContext.request.contextPath}/logout"
                                class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
                                <i class="fa-solid fa-power-off w-5"></i>
                                <span>Log Out</span>
                            </a>
                        </div>
                    </aside>

                    <!-- Main Fluid Content Wrapper (The ONLY scrollable area) -->
                    <div class="main-content-wrapper">
                        <!-- Global Header (Inside scrollable region) -->
                        <%@ include file="/includes/header.jsp" %>

                        <main class="p-6 lg:p-8 flex flex-col gap-6 w-full max-w-full">

                        <c:if test="${not empty successMessage}">
                            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl relative mb-4 animate-fadeIn" role="alert">
                                <span class="block sm:inline font-bold">${successMessage}</span>
                            </div>
                        </c:if>

                        <!-- Fluid Quick Actions Bar -->
                        <div
                            class="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm flex flex-wrap items-center justify-between gap-4">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-primary rounded-xl flex items-center justify-center text-white text-xl font-bold italic overflow-hidden">
                                    <c:choose>
                                        <c:when test="${not empty profileImage}">
                                            <img src="${profileImage}" class="w-full h-full object-cover" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                            <span style="display:none;">${userInitials}</span>
                                        </c:when>
                                        <c:otherwise>${userInitials}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <h2 class="text-sm font-black text-dark">Welcome back,
                                        <c:out value="${userName}" default="User" />!
                                    </h2>
                                    <p class="text-[0.65rem] font-bold text-gray-400 italic">Quick Access Dashboard</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-2">
                                <a href="${pageContext.request.contextPath}/friends"
                                    class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all flex items-center gap-2">
                                    <i class="fa-solid fa-users-viewfinder"></i> Search Friends
                                </a>
                                <button
                                    class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all">Search
                                    Jobs</button>
                                <button
                                    class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all">My
                                    Stats</button>
                                <button
                                    class="bg-primary text-white px-5 py-2 rounded-lg text-[0.7rem] font-black shadow-lg shadow-primary/20 transition-all">Update
                                    CV</button>
                            </div>
                        </div>

                        <div class="content-grid">
                            <!-- Left Main Stack -->
                            <div class="flex flex-col gap-6">

                                <!-- Stats Bar -->
                                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                                    <div class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                                        <div class="flex items-center justify-between mb-2">
                                            <i class="fa-solid fa-paper-plane text-primary opacity-20 text-xl"></i>
                                            <span class="text-[0.6rem] font-black text-accent">+2 new</span>
                                        </div>
                                        <h3 class="text-2xl font-black text-dark">12</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                            Applications</p>
                                    </div>
                                    <div class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                                        <div class="flex items-center justify-between mb-2">
                                            <i class="fa-solid fa-users text-primary opacity-20 text-xl"></i>
                                            <span class="text-[0.6rem] font-black text-accent">+1 new</span>
                                        </div>
                                        <h3 class="text-2xl font-black text-dark">04</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                            Interviews</p>
                                    </div>
                                    <div class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                                        <div class="flex items-center justify-between mb-2">
                                            <i class="fa-solid fa-eye text-primary opacity-20 text-xl"></i>
                                            <span class="text-[0.6rem] font-black text-blue-500">24h focus</span>
                                        </div>
                                        <h3 class="text-2xl font-black text-dark">128</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                            Profile Views</p>
                                    </div>
                                    <div class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                                        <div class="flex items-center justify-between mb-2">
                                            <i class="fa-solid fa-bookmark text-primary opacity-20 text-xl"></i>
                                            <span class="text-[0.6rem] font-black text-gray-300">Saved</span>
                                        </div>
                                        <h3 class="text-2xl font-black text-dark">08</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                            Saved Jobs</p>
                                    </div>
                                </div>

                                <!-- Market Insights (New Feature to Fill Space) -->
                                <div
                                    class="bg-primary rounded-3xl p-8 text-white relative overflow-hidden shadow-2xl shadow-primary/20">
                                    <div
                                        class="absolute top-0 right-0 w-64 h-64 bg-white/5 rounded-full -mr-32 -mt-32 blur-3xl">
                                    </div>
                                    <div
                                        class="relative z-10 flex flex-col md:flex-row items-center justify-between gap-8">
                                        <div class="max-w-md">
                                            <span
                                                class="inline-block px-3 py-1 bg-accent/20 text-accent text-[0.6rem] font-black uppercase rounded-full mb-4">Market
                                                Trends</span>
                                            <h2 class="text-2xl font-black mb-4">Tech Hiring is up <span
                                                    class="text-accent">14%</span> in your area.</h2>
                                            <p class="text-xs text-white/60 leading-relaxed mb-6 italic font-medium">
                                                Employers are looking for "Frontend Developers" with React experience.
                                                Your profile matches 85% of these criteria.</p>
                                            <button
                                                class="bg-accent text-primary px-6 py-3 rounded-xl text-[0.7rem] font-black hover:bg-white transition-all">View
                                                Hot Jobs</button>
                                        </div>
                                        <div class="hidden md:grid grid-cols-2 gap-4 shrink-0">
                                            <div
                                                class="bg-white/10 p-4 rounded-2xl border border-white/10 backdrop-blur-sm text-center">
                                                <p class="text-[0.5rem] font-black text-white/50 uppercase">Avg Salary
                                                </p>
                                                <p class="text-lg font-black text-accent">$85k</p>
                                            </div>
                                            <div
                                                class="bg-white/10 p-4 rounded-2xl border border-white/10 backdrop-blur-sm text-center">
                                                <p class="text-[0.5rem] font-black text-white/50 uppercase">Open Roles
                                                </p>
                                                <p class="text-lg font-black text-accent">1.2k</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Recommended Feed -->
                                <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm">
                                    <div class="flex items-center justify-between mb-8 px-2">
                                        <h2
                                            class="text-lg font-black text-dark italic border-l-4 border-primary pl-4 uppercase tracking-tighter">
                                            Recommended For You</h2>
                                        <button class="text-[0.65rem] font-black text-primary underline">View All
                                            Matches</button>
                                    </div>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <!-- Job Card -->
                                        <div
                                            class="group p-6 bg-surface rounded-3xl border border-transparent hover:border-primary/10 hover:bg-white hover:shadow-xl transition-all duration-300">
                                            <div class="flex gap-4 mb-4">
                                                <div
                                                    class="w-12 h-12 bg-white rounded-2xl shadow-sm border border-gray-50 flex items-center justify-center font-black text-primary text-xl">
                                                    G</div>
                                                <div class="overflow-hidden">
                                                    <h4 class="text-sm font-black text-dark truncate">Senior UI Designer
                                                    </h4>
                                                    <p class="text-[0.65rem] font-bold text-gray-400 italic">Google Inc.
                                                        &bull; Hybrid</p>
                                                </div>
                                            </div>
                                            <div class="flex gap-2 mb-6">
                                                <span class="job-tag bg-primary/5 text-primary">Full Time</span>
                                                <span class="job-tag bg-accent/10 text-accent">$120k</span>
                                            </div>
                                            <button
                                                class="w-full py-3 bg-white border border-gray-100 rounded-xl text-[0.65rem] font-black text-dark group-hover:bg-primary group-hover:text-white transition-all">Apply
                                                Now</button>
                                        </div>
                                        <!-- Job Card -->
                                        <div
                                            class="group p-6 bg-surface rounded-3xl border border-transparent hover:border-primary/10 hover:bg-white hover:shadow-xl transition-all duration-300">
                                            <div class="flex gap-4 mb-4">
                                                <div
                                                    class="w-12 h-12 bg-white rounded-2xl shadow-sm border border-gray-50 flex items-center justify-center font-black text-secondary text-xl">
                                                    M</div>
                                                <div class="overflow-hidden">
                                                    <h4 class="text-sm font-black text-dark truncate">DevOps Engineer
                                                    </h4>
                                                    <p class="text-[0.65rem] font-bold text-gray-400 italic">Microsoft
                                                        &bull; Remote</p>
                                                </div>
                                            </div>
                                            <div class="flex gap-2 mb-6">
                                                <span class="job-tag bg-primary/5 text-primary">Remote</span>
                                                <span class="job-tag bg-accent/10 text-accent">$140k</span>
                                            </div>
                                            <button
                                                class="w-full py-3 bg-white border border-gray-100 rounded-xl text-[0.65rem] font-black text-dark group-hover:bg-primary group-hover:text-white transition-all">Apply
                                                Now</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Tools Stack -->
                            <div class="flex flex-col gap-6">
                                <!-- Profile Health -->
                                <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm text-center">
                                    <h3
                                        class="text-sm font-black text-dark mb-8 text-left border-l-4 border-accent pl-4 uppercase italic">
                                        Profile Health</h3>
                                    <div class="flex justify-center mb-6">
                                        <div class="relative w-32 h-32 flex items-center justify-center">
                                            <svg class="w-full h-full -rotate-90">
                                                <circle cx="64" cy="64" r="56" stroke="#F4F7F6" stroke-width="10"
                                                    fill="transparent" />
                                                <circle cx="64" cy="64" r="56" stroke="#1D3E35" stroke-width="10"
                                                    fill="transparent" stroke-dasharray="351" stroke-dashoffset="52"
                                                    stroke-linecap="round" />
                                            </svg>
                                            <div class="absolute">
                                                <span class="text-2xl font-black text-dark leading-none">85%</span>
                                                <p
                                                    class="text-[0.5rem] font-bold text-gray-400 uppercase tracking-widest">
                                                    Health</p>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text-[0.7rem] font-bold text-gray-400 mb-6 italic px-2">Your profile is
                                        missing <span class="text-primary font-black underline">Skills</span> section.
                                    </p>
                                    <button
                                        class="w-full bg-primary text-white py-3.5 rounded-2xl text-[0.7rem] font-black shadow-xl shadow-primary/10">Complete
                                        Now</button>
                                </div>

                                <!-- Skills Matrix (New Feature to Fill Space) -->
                                <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm">
                                    <h3
                                        class="text-sm font-black text-dark mb-6 text-left border-l-4 border-primary pl-4 uppercase italic">
                                        My Skills</h3>
                                    <div class="flex flex-wrap gap-2">
                                        <span
                                            class="px-3 py-1.5 bg-surface text-[0.65rem] font-bold rounded-lg border border-gray-50">Java
                                            Spring</span>
                                        <span
                                            class="px-3 py-1.5 bg-surface text-[0.65rem] font-bold rounded-lg border border-gray-50">JSP/Servlets</span>
                                        <span
                                            class="px-3 py-1.5 bg-surface text-[0.65rem] font-bold rounded-lg border border-gray-50">SQL</span>
                                        <span
                                            class="px-3 py-1.5 bg-surface text-[0.65rem] font-bold rounded-lg border border-gray-50">Tailwind
                                            CSS</span>
                                        <button
                                            class="px-3 py-1.5 bg-primary/5 text-primary text-[0.65rem] font-black rounded-lg border border-primary/10">+
                                            Add Skill</button>
                                    </div>
                                </div>

                                <!-- Timeline -->
                                <div class="bg-dark rounded-[2.5rem] p-8 text-white shadow-2xl shadow-dark/30">
                                    <h3 class="text-xs font-black mb-6 uppercase tracking-[0.2em] text-white/30 italic">
                                        Timeline</h3>
                                    <div class="space-y-6">
                                        <div class="flex items-center gap-4 group">
                                            <div
                                                class="w-12 h-12 bg-white/10 rounded-2xl flex flex-col items-center justify-center shrink-0 border border-white/5 transition-colors group-hover:bg-accent group-hover:text-primary">
                                                <span class="text-[0.55rem] font-black uppercase opacity-60">Oct</span>
                                                <span class="text-base font-black leading-none">15</span>
                                            </div>
                                            <div class="overflow-hidden">
                                                <p class="text-[0.75rem] font-bold truncate">Technical Review</p>
                                                <p class="text-[0.6rem] text-white/40">Zoom &bull; 2:00 PM</p>
                                            </div>
                                        </div>
                                    </div>
                                    <button
                                        class="w-full mt-10 bg-accent text-primary py-3.5 rounded-2xl text-[0.7rem] font-black hover:bg-white transition-all">Full
                                        Calendar</button>
                                </div>

                                <!-- Quick Drop -->
                                <div
                                    class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm flex flex-col items-center justify-center text-center">
                                    <div
                                        class="w-14 h-14 bg-surface rounded-full flex items-center justify-center mb-4">
                                        <i class="fa-solid fa-cloud-arrow-up text-primary/40 text-xl"></i>
                                    </div>
                                    <p class="text-[0.65rem] font-black text-gray-400">Update Active CV</p>
                                    <p class="text-[0.55rem] text-gray-300 italic mt-1">PDF or DOCX only</p>
                                </div>
                            </div>
                        </div>

                        <!-- New Full-Width Activity Log (To fill bottom space) -->
                        <div class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-sm w-full">
                            <h2
                                class="text-lg font-black text-dark mb-10 italic border-l-4 border-primary pl-4 uppercase tracking-tighter">
                                System & Recruiter Activity</h2>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-1.5 bg-accent rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-bold text-dark">Recruiter from Microsoft viewed your
                                            profile</p>
                                        <p class="text-[0.6rem] font-medium text-gray-400 italic">2 minutes ago</p>
                                    </div>
                                </div>
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-1.5 bg-blue-500 rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-bold text-dark">Your application to Google was
                                            Shortlisted</p>
                                        <p class="text-[0.6rem] font-medium text-gray-400 italic">3 hours ago</p>
                                    </div>
                                </div>
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-1.5 bg-primary/20 rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-bold text-dark">System: Weekly career report is ready</p>
                                        <p class="text-[0.6rem] font-medium text-gray-400 italic">Today, 9:00 AM</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Global Footer (Inside scrollable region) -->
                        <%@ include file="/includes/footer.jsp" %>
                    </div>
                </div>

        </body>

        </html>

        </html>
