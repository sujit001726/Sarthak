<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Employer Command Center</title>
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

                .glass-effect {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                }
            </style>
        </head>

        <body class="text-gray-900 bg-surface">

                <div class="dashboard-container">
                    <!-- Sidebar (Stationary) -->
                    <aside class="sidebar">
                        <div class="sidebar-scroll-area p-6 flex flex-col custom-scrollbar">
                            <!-- Branding -->
                            <div class="mb-12 px-4">
                                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak"
                                    class="h-20 w-auto brightness-0 invert opacity-90">
                            </div>

                            <div class="mb-10">
                                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                                    Hiring Suite</p>
                                <nav>
                                    <a href="#"
                                        class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                                        <i class="fa-solid fa-chart-pie w-5 text-accent"></i>
                                        <span>Dashboard</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/employer/post-job"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-plus-circle w-5"></i>
                                        <span>Post New Job</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/employer/manage-jobs"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-briefcase w-5"></i>
                                        <span>Manage My Jobs</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/employer/applicants"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-users-viewfinder w-5"></i>
                                        <span>Manage Applicants</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/messages"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-envelope w-5"></i>
                                        <span>Messages</span>
                                    </a>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-magnifying-glass w-5"></i>
                                        <span>Search Talent</span>
                                    </a>
                                </nav>
                            </div>

                            <div class="mb-10">
                                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                                    Company</p>
                                <nav>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-building w-5"></i>
                                        <span>Company Profile</span>
                                    </a>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-credit-card w-5"></i>
                                        <span>Billing & Plans</span>
                                    </a>
                                    <a href="#"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-sliders w-5"></i>
                                        <span>Settings</span>
                                    </a>
                                </nav>
                            </div>

                            <!-- Logout Bottom -->
                            <div class="mt-auto pt-8 border-t border-white/10">
                                <a href="${pageContext.request.contextPath}/logout"
                                    class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
                                    <i class="fa-solid fa-right-from-bracket w-5"></i>
                                    <span>Log Out</span>
                                </a>
                            </div>
                        </div>
                    </aside>

                    <!-- Main Fluid Content Wrapper (The ONLY scrollable area) -->
                    <div class="main-content-wrapper">
                        <!-- Global Header (Inside scrollable region) -->
                        <%@ include file="/includes/header.jsp" %>

                        <main class="p-6 lg:p-8 flex flex-col gap-6 w-full max-w-full">

                        <!-- Quick Actions Bar -->
                        <div
                            class="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm flex flex-wrap items-center justify-between gap-6">
                            <div class="flex items-center gap-5">
                                <div
                                    class="w-14 h-14 bg-primary rounded-2xl flex items-center justify-center text-white text-2xl font-black italic shadow-lg shadow-primary/20">
                                    <c:choose>
                                        <c:when test="${not empty employerName}">
                                            ${employerName.substring(0,1).toUpperCase()}
                                        </c:when>
                                        <c:otherwise>E</c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <h2 class="text-base font-black text-dark">Welcome back, ${employerName}!</h2>
                                    <p class="text-[0.7rem] font-bold text-gray-400 italic flex items-center gap-2">
                                        <span class="w-2 h-2 bg-accent rounded-full animate-pulse"></span>
                                        Command Center &bull; Active Recruitment
                                    </p>
                                </div>
                            </div>
                            <div class="flex items-center gap-3">
                                <div
                                    class="hidden xl:flex items-center gap-2 bg-surface px-4 py-2 rounded-xl border border-gray-100 mr-4">
                                    <i class="fa-solid fa-calendar-check text-primary text-sm"></i>
                                    <span class="text-[0.65rem] font-black text-primary uppercase tracking-wider">Plan:
                                        Premium Pro</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/employer/post-job"
                                    class="bg-primary text-white px-6 py-3 rounded-xl text-[0.75rem] font-black shadow-xl shadow-primary/20 hover:scale-[1.02] transition-all flex items-center gap-2">
                                    <i class="fa-solid fa-plus"></i>
                                    Post New Job
                                </a>
                            </div>
                        </div>


                        <div class="content-grid">
                            <!-- Left Main Stack -->
                            <div class="flex flex-col gap-6">

                                <!-- Stats Bar -->
                                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                                    <div
                                        class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm relative overflow-hidden group">
                                        <div
                                            class="absolute -right-4 -top-4 w-20 h-20 bg-primary/5 rounded-full group-hover:scale-150 transition-transform">
                                        </div>
                                        <i class="fa-solid fa-briefcase text-primary opacity-20 text-xl mb-4 block"></i>
                                        <h3 class="text-3xl font-black text-dark">${totalJobs}</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                            Total Posted</p>
                                    </div>
                                    <div
                                        class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm group">
                                        <i
                                            class="fa-solid fa-circle-check text-accent opacity-20 text-xl mb-4 block"></i>
                                        <h3 class="text-3xl font-black text-dark">${totalJobs}</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                            Active Jobs</p>
                                    </div>
                                    <div
                                        class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm group">
                                        <i
                                            class="fa-solid fa-users-rays text-primary opacity-20 text-xl mb-4 block"></i>
                                        <div class="flex items-center justify-between">
                                            <h3 class="text-3xl font-black text-dark">124</h3>
                                            <span
                                                class="bg-accent/10 text-accent text-[0.6rem] font-black px-2 py-0.5 rounded">+12%</span>
                                        </div>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                            Total Applicants</p>
                                    </div>
                                    <div
                                        class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm group">
                                        <i class="fa-solid fa-star text-amber-400 opacity-20 text-xl mb-4 block"></i>
                                        <h3 class="text-3xl font-black text-dark">08</h3>
                                        <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                            Shortlisted</p>
                                    </div>
                                </div>

                                <!-- Main Jobs Table -->
                                <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm">
                                    <div class="flex items-center justify-between mb-10 px-2">
                                        <div>
                                            <h2
                                                class="text-xl font-black text-dark italic border-l-4 border-primary pl-4 uppercase tracking-tighter">
                                                Your Active Postings</h2>
                                            <p class="text-[0.65rem] font-bold text-gray-400 mt-1 pl-5">Real-time status
                                                of your recruitment funnel</p>
                                        </div>
                                        <div class="flex gap-2">
                                            <button
                                                class="p-2.5 bg-surface border border-gray-100 rounded-xl hover:bg-gray-100 transition-all">
                                                <i class="fa-solid fa-filter text-primary"></i>
                                            </button>
                                            <button
                                                class="p-2.5 bg-surface border border-gray-100 rounded-xl hover:bg-gray-100 transition-all">
                                                <i class="fa-solid fa-download text-primary"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="overflow-x-auto">
                                        <table class="w-full text-left">
                                            <thead>
                                                <tr class="border-b border-gray-50">
                                                    <th
                                                        class="pb-5 px-4 text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                                        Job Details</th>
                                                    <th
                                                        class="pb-5 px-4 text-[0.6rem] font-black text-gray-400 uppercase tracking-widest text-center">
                                                        Applicants</th>
                                                    <th
                                                        class="pb-5 px-4 text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                                        Status</th>
                                                    <th
                                                        class="pb-5 px-4 text-[0.6rem] font-black text-gray-400 uppercase tracking-widest text-right">
                                                        Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y divide-gray-50">
                                                <c:forEach var="job" items="${jobs}">
                                                    <tr class="group hover:bg-surface/50 transition-colors">
                                                        <td class="py-5 px-4">
                                                            <div class="flex items-center gap-4">
                                                                <div
                                                                    class="w-10 h-10 bg-primary/5 rounded-xl flex items-center justify-center font-black text-primary text-xs italic group-hover:bg-primary group-hover:text-white transition-all">
                                                                    J</div>
                                                                <div>
                                                                    <h4 class="text-sm font-black text-dark">
                                                                        ${job.title}</h4>
                                                                    <p
                                                                        class="text-[0.65rem] font-bold text-gray-400 uppercase tracking-tighter">
                                                                        ${job.location} &bull; ${job.jobType}</p>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="py-5 px-4 text-center">
                                                            <div class="flex flex-col items-center">
                                                                <span
                                                                    class="text-sm font-black text-dark italic">12</span>
                                                                <span
                                                                    class="text-[0.5rem] font-black text-accent uppercase">+3
                                                                    NEW</span>
                                                            </div>
                                                        </td>
                                                        <td class="py-5 px-4">
                                                            <span
                                                                class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[0.55rem] font-black uppercase tracking-wider
                                                    ${job.status == 'active' ? 'bg-accent/10 text-accent' : 'bg-amber-100 text-amber-600'}">
                                                                <span
                                                                    class="w-1.5 h-1.5 rounded-full ${job.status == 'active' ? 'bg-accent animate-pulse' : 'bg-amber-500'}"></span>
                                                                ${job.status}
                                                            </span>
                                                        </td>
                                                        <td class="py-5 px-4">
                                                            <div class="flex items-center justify-end gap-2">
                                                                <a href="${pageContext.request.contextPath}/employer/applicants?jobId=${job.id}"
                                                                    class="p-2.5 bg-primary/5 text-primary rounded-xl hover:bg-primary hover:text-white transition-all"
                                                                    title="View Applicants">
                                                                    <i class="fa-solid fa-user-group text-sm"></i>
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/employer/edit-job?id=${job.id}"
                                                                    class="p-2.5 bg-blue-50 text-blue-600 rounded-xl hover:bg-blue-600 hover:text-white transition-all"
                                                                    title="Edit Job">
                                                                    <i class="fa-solid fa-pen-to-square text-sm"></i>
                                                                </a>
                                                                <form method="post"
                                                                    action="${pageContext.request.contextPath}/employer/delete-job"
                                                                    class="inline">
                                                                    <input type="hidden" name="jobId" value="${job.id}">
                                                                    <button type="submit"
                                                                        onclick="return confirm('Archive this job posting?')"
                                                                        class="p-2.5 bg-red-50 text-red-600 rounded-xl hover:bg-red-600 hover:text-white transition-all"
                                                                        title="Delete">
                                                                        <i class="fa-solid fa-trash-can text-sm"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty jobs}">
                                                    <tr>
                                                        <td colspan="4" class="py-20 text-center">
                                                            <div class="flex flex-col items-center">
                                                                <div
                                                                    class="w-20 h-20 bg-surface rounded-full flex items-center justify-center mb-4">
                                                                    <i
                                                                        class="fa-solid fa-briefcase text-primary opacity-20 text-3xl"></i>
                                                                </div>
                                                                <h4 class="text-sm font-black text-dark">No active job
                                                                    postings found</h4>
                                                                <p class="text-[0.65rem] font-bold text-gray-400 mt-1">
                                                                    Start hiring today by posting your first job</p>
                                                                <a href="${pageContext.request.contextPath}/employer/post-job"
                                                                    class="mt-6 bg-primary text-white px-8 py-3 rounded-xl text-[0.7rem] font-black shadow-lg shadow-primary/20">Post
                                                                    My First Job</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Tools Stack -->
                            <div class="flex flex-col gap-6">
                                <!-- Hiring Insights -->
                                <div
                                    class="bg-primary rounded-[2.5rem] p-8 text-white shadow-2xl shadow-primary/20 relative overflow-hidden">
                                    <div class="absolute -right-4 -bottom-4 w-32 h-32 bg-white/5 rounded-full"></div>
                                    <h3
                                        class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 italic">
                                        Hiring AI Insights</h3>
                                    <div class="space-y-6">
                                        <div class="flex gap-4">
                                            <div
                                                class="w-10 h-10 bg-accent rounded-2xl flex items-center justify-center text-primary shrink-0">
                                                <i class="fa-solid fa-bolt-lightning text-sm"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs font-black leading-tight">Your "Java Developer" role
                                                    is trending.</p>
                                                <p class="text-[0.6rem] font-bold text-white/40 italic mt-1">+45% more
                                                    views than avg.</p>
                                            </div>
                                        </div>
                                        <div class="flex gap-4">
                                            <div
                                                class="w-10 h-10 bg-white/10 rounded-2xl flex items-center justify-center text-accent shrink-0 border border-white/10">
                                                <i class="fa-solid fa-bullseye text-sm"></i>
                                            </div>
                                            <div>
                                                <p class="text-xs font-black leading-tight">8 Candidates match your
                                                    requirements.</p>
                                                <p class="text-[0.6rem] font-bold text-white/40 italic mt-1">Click to
                                                    view auto-shortlist.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <button
                                        class="w-full mt-10 bg-white/10 border border-white/20 text-white py-3.5 rounded-2xl text-[0.7rem] font-black hover:bg-accent hover:text-primary hover:border-transparent transition-all">Optimize
                                        My Ads</button>
                                </div>

                                <!-- Top Candidates (Placeholder Feature) -->
                                <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm">
                                    <h3
                                        class="text-sm font-black text-dark mb-8 border-l-4 border-accent pl-4 uppercase italic">
                                        Top Candidates</h3>
                                    <div class="space-y-6">
                                        <div class="flex items-center gap-4 group cursor-pointer">
                                            <div
                                                class="w-12 h-12 rounded-2xl bg-surface flex items-center justify-center text-primary font-black text-lg group-hover:bg-primary group-hover:text-white transition-all">
                                                S</div>
                                            <div>
                                                <h4 class="text-xs font-black text-dark">Sujit Shaha</h4>
                                                <p class="text-[0.55rem] font-black text-gray-400 italic">Frontend Lead
                                                    &bull; 98% Match</p>
                                            </div>
                                            <i
                                                class="fa-solid fa-chevron-right ml-auto text-gray-300 group-hover:text-primary transition-all"></i>
                                        </div>
                                        <div class="flex items-center gap-4 group cursor-pointer">
                                            <div
                                                class="w-12 h-12 rounded-2xl bg-surface flex items-center justify-center text-secondary font-black text-lg group-hover:bg-primary group-hover:text-white transition-all">
                                                P</div>
                                            <div>
                                                <h4 class="text-xs font-black text-dark">Panas Kafle</h4>
                                                <p class="text-[0.55rem] font-black text-gray-400 italic">UI Designer
                                                    &bull; 92% Match</p>
                                            </div>
                                            <i
                                                class="fa-solid fa-chevron-right ml-auto text-gray-300 group-hover:text-primary transition-all"></i>
                                        </div>
                                    </div>
                                    <button class="w-full mt-10 text-[0.65rem] font-black text-primary underline">Search
                                        All Talent</button>
                                </div>

                                <!-- Company Health -->
                                <div class="bg-dark rounded-[2.5rem] p-8 text-white shadow-2xl shadow-dark/40">
                                    <h3
                                        class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-8 italic">
                                        Profile Strength</h3>
                                    <div class="flex justify-center mb-8">
                                        <div class="relative w-32 h-32 flex items-center justify-center">
                                            <svg class="w-full h-full -rotate-90">
                                                <circle cx="64" cy="64" r="56" stroke="rgba(255,255,255,0.05)"
                                                    stroke-width="10" fill="transparent" />
                                                <circle cx="64" cy="64" r="56" stroke="#22c55e" stroke-width="10"
                                                    fill="transparent" stroke-dasharray="351" stroke-dashoffset="87"
                                                    stroke-linecap="round" />
                                            </svg>
                                            <div class="absolute text-center">
                                                <span class="text-2xl font-black text-white leading-none">75%</span>
                                                <p class="text-[0.4rem] font-bold text-white/40 uppercase">Trust Score
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text-center text-[0.6rem] font-bold text-white/40 italic px-2">Complete
                                        <span class="text-accent underline font-black">Company Video</span> to reach
                                        100%.</p>
                                </div>
                            </div>
                        </div>

                        <!-- Full-Width Feed -->
                        <div class="bg-white rounded-[2.5rem] p-10 border border-gray-100 shadow-sm w-full">
                            <div class="flex items-center justify-between mb-10">
                                <h2
                                    class="text-xl font-black text-dark italic border-l-4 border-primary pl-4 uppercase tracking-tighter">
                                    Recruitment Activity</h2>
                                <span
                                    class="bg-primary/5 text-primary text-[0.6rem] font-black px-4 py-1.5 rounded-full">Live
                                    Feed</span>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-2 bg-accent rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-black text-dark">New applicant for "Senior UI Designer"
                                        </p>
                                        <p class="text-[0.65rem] font-bold text-gray-400 italic">45 seconds ago</p>
                                    </div>
                                </div>
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-2 bg-blue-500 rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-black text-dark">Interview scheduled with Panas Kafle</p>
                                        <p class="text-[0.65rem] font-bold text-gray-400 italic">2 hours ago</p>
                                    </div>
                                </div>
                                <div class="flex gap-4">
                                    <div class="w-2 h-2 mt-2 bg-amber-500 rounded-full shrink-0"></div>
                                    <div>
                                        <p class="text-xs font-black text-dark">Reminder: Job post "DevOps Engineer"
                                            expires in 2 days</p>
                                        <p class="text-[0.65rem] font-bold text-gray-400 italic">System Alert</p>
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