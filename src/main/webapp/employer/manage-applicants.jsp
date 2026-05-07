<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Manage Applicants</title>
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

                .applicant-card {
                    transition: all 0.3s ease;
                }

                .applicant-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
                }

                .status-tab {
                    position: relative;
                }

                .status-tab.active::after {
                    content: '';
                    position: absolute;
                    bottom: -2px;
                    left: 0;
                    right: 0;
                    height: 3px;
                    background: #22c55e;
                    border-radius: 10px;
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
                                    <a href="${pageContext.request.contextPath}/employer/dashboard"
                                        class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                        <i class="fa-solid fa-chart-pie w-5"></i>
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
                                    <a href="#"
                                        class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                                        <i class="fa-solid fa-users-viewfinder w-5 text-accent"></i>
                                        <span>Manage Applicants</span>
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

                        <main class="p-6 lg:p-8 flex flex-col gap-8 w-full max-w-full">

                        <!-- Page Title & Stats -->
                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                            <div>
                                <h1
                                    class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">
                                    Applicant Pool</h1>
                                <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Review and manage candidates across
                                    all your active job postings</p>
                            </div>

                            <div class="flex gap-4">
                                <div
                                    class="bg-white px-6 py-4 rounded-3xl border border-gray-100 shadow-sm flex items-center gap-4">
                                    <div
                                        class="w-10 h-10 bg-primary/5 rounded-2xl flex items-center justify-center text-primary">
                                        <i class="fa-solid fa-users"></i>
                                    </div>
                                    <div>
                                        <p
                                            class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest leading-none mb-1">
                                            Total</p>
                                        <h3 class="text-xl font-black text-dark leading-none">1,248</h3>
                                    </div>
                                </div>
                                <div
                                    class="bg-white px-6 py-4 rounded-3xl border border-gray-100 shadow-sm flex items-center gap-4">
                                    <div
                                        class="w-10 h-10 bg-accent/10 rounded-2xl flex items-center justify-center text-accent">
                                        <i class="fa-solid fa-user-plus"></i>
                                    </div>
                                    <div>
                                        <p
                                            class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest leading-none mb-1">
                                            New</p>
                                        <h3 class="text-xl font-black text-dark leading-none">24</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Search & Filters Card -->
                        <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm flex flex-col gap-8">
                            <div class="flex flex-wrap items-center justify-between gap-6">
                                <!-- Tabs -->
                                <div class="flex gap-8 overflow-x-auto pb-2">
                                    <button
                                        class="status-tab active px-2 py-1 text-sm font-black text-dark uppercase tracking-tighter italic">All
                                        Applicants</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">New
                                        Arrivals</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">Interviewing</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">Shortlisted</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all text-red-400">Rejected</button>
                                </div>

                                <!-- Search -->
                                <div class="relative w-full md:w-80 group">
                                    <i
                                        class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-primary transition-all"></i>
                                    <input type="text" placeholder="Search by name or role..."
                                        class="w-full bg-surface border border-gray-100 rounded-2xl py-3 pl-12 pr-4 text-sm font-bold focus:outline-none focus:ring-4 focus:ring-primary/5 focus:border-primary transition-all">
                                </div>
                            </div>

                            <!-- Applicants Grid -->
                            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">

                                <!-- Applicant Card 1 -->
                                <div
                                    class="applicant-card bg-white border border-gray-100 rounded-[2.5rem] p-8 flex flex-col gap-6 relative overflow-hidden group">
                                    <!-- AI Match Score Badge -->
                                    <div class="absolute top-6 right-6 flex flex-col items-end">
                                        <div
                                            class="bg-accent/10 text-accent text-[0.65rem] font-black px-3 py-1 rounded-full border border-accent/20">
                                            98% MATCH</div>
                                    </div>

                                    <div class="flex items-center gap-5">
                                        <div
                                            class="w-16 h-16 bg-primary rounded-[1.5rem] flex items-center justify-center text-white text-2xl font-black italic shadow-xl shadow-primary/20">
                                            S</div>
                                        <div>
                                            <h3 class="text-lg font-black text-dark leading-none">Sujit Shaha</h3>
                                            <p class="text-xs font-bold text-gray-400 mt-1 uppercase tracking-tighter">
                                                Applied for: <span class="text-primary italic">Senior Frontend
                                                    Engineer</span></p>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4 py-4 border-y border-gray-50">
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Experience</p>
                                            <p class="text-xs font-black text-dark italic">6.5 Years</p>
                                        </div>
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Expected</p>
                                            <p class="text-xs font-black text-dark italic">रु 150k - 180k</p>
                                        </div>
                                    </div>

                                    <div class="flex flex-wrap gap-2">
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">React</span>
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">Node.js</span>
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">TypeScript</span>
                                    </div>

                                    <div class="flex items-center gap-3 mt-2">
                                        <button
                                            class="flex-1 bg-primary text-white py-3 rounded-2xl text-[0.7rem] font-black hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-primary/20">View
                                            Portfolio</button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-surface text-primary rounded-2xl hover:bg-primary hover:text-white transition-all">
                                            <i class="fa-solid fa-envelope"></i>
                                        </button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-red-50 text-red-500 rounded-2xl hover:bg-red-500 hover:text-white transition-all">
                                            <i class="fa-solid fa-xmark"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Applicant Card 2 -->
                                <div
                                    class="applicant-card bg-white border border-gray-100 rounded-[2.5rem] p-8 flex flex-col gap-6 relative overflow-hidden group">
                                    <div class="absolute top-6 right-6 flex flex-col items-end">
                                        <div
                                            class="bg-amber-400/10 text-amber-600 text-[0.65rem] font-black px-3 py-1 rounded-full border border-amber-400/20">
                                            85% MATCH</div>
                                    </div>

                                    <div class="flex items-center gap-5">
                                        <div
                                            class="w-16 h-16 bg-secondary rounded-[1.5rem] flex items-center justify-center text-white text-2xl font-black italic shadow-xl shadow-secondary/20">
                                            N</div>
                                        <div>
                                            <h3 class="text-lg font-black text-dark leading-none">Narayani</h3>
                                            <p class="text-xs font-bold text-gray-400 mt-1 uppercase tracking-tighter">
                                                Applied for: <span class="text-primary italic">UI/UX Designer</span></p>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4 py-4 border-y border-gray-50">
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Experience</p>
                                            <p class="text-xs font-black text-dark italic">3 Years</p>
                                        </div>
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Expected</p>
                                            <p class="text-xs font-black text-dark italic">रु 80k - 100k</p>
                                        </div>
                                    </div>

                                    <div class="flex flex-wrap gap-2">
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">Figma</span>
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">Adobe
                                            XD</span>
                                    </div>

                                    <div class="flex items-center gap-3 mt-2">
                                        <button
                                            class="flex-1 bg-primary text-white py-3 rounded-2xl text-[0.7rem] font-black hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-primary/20">View
                                            Portfolio</button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-surface text-primary rounded-2xl hover:bg-primary hover:text-white transition-all">
                                            <i class="fa-solid fa-envelope"></i>
                                        </button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-red-50 text-red-500 rounded-2xl hover:bg-red-500 hover:text-white transition-all">
                                            <i class="fa-solid fa-xmark"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Applicant Card 3 -->
                                <div
                                    class="applicant-card bg-white border border-gray-100 rounded-[2.5rem] p-8 flex flex-col gap-6 relative overflow-hidden group">
                                    <div class="absolute top-6 right-6 flex flex-col items-end">
                                        <div
                                            class="bg-accent/10 text-accent text-[0.65rem] font-black px-3 py-1 rounded-full border border-accent/20">
                                            92% MATCH</div>
                                    </div>

                                    <div class="flex items-center gap-5">
                                        <div
                                            class="w-16 h-16 bg-accent rounded-[1.5rem] flex items-center justify-center text-primary text-2xl font-black italic shadow-xl shadow-accent/20">
                                            A</div>
                                        <div>
                                            <h3 class="text-lg font-black text-dark leading-none">Anish Regmi</h3>
                                            <p class="text-xs font-bold text-gray-400 mt-1 uppercase tracking-tighter">
                                                Applied for: <span class="text-primary italic">Backend Developer</span>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4 py-4 border-y border-gray-50">
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Experience</p>
                                            <p class="text-xs font-black text-dark italic">4 Years</p>
                                        </div>
                                        <div>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                Expected</p>
                                            <p class="text-xs font-black text-dark italic">रु 120k - 150k</p>
                                        </div>
                                    </div>

                                    <div class="flex flex-wrap gap-2">
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">Java</span>
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">Spring
                                            Boot</span>
                                        <span
                                            class="bg-surface px-3 py-1 rounded-lg text-[0.55rem] font-black text-secondary uppercase tracking-wider">MySQL</span>
                                    </div>

                                    <div class="flex items-center gap-3 mt-2">
                                        <button
                                            class="flex-1 bg-primary text-white py-3 rounded-2xl text-[0.7rem] font-black hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-primary/20">View
                                            Portfolio</button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-surface text-primary rounded-2xl hover:bg-primary hover:text-white transition-all">
                                            <i class="fa-solid fa-envelope"></i>
                                        </button>
                                        <button
                                            class="w-12 h-12 flex items-center justify-center bg-red-50 text-red-500 rounded-2xl hover:bg-red-500 hover:text-white transition-all">
                                            <i class="fa-solid fa-xmark"></i>
                                        </button>
                                    </div>
                                </div>

                            </div>

                            <!-- Load More / Pagination -->
                            <div class="flex items-center justify-center mt-6">
                                <button
                                    class="px-10 py-4 bg-surface border border-gray-100 rounded-2xl text-[0.75rem] font-black text-primary hover:bg-primary hover:text-white transition-all italic tracking-tighter">Load
                                    More Candidates (24 Left)</button>
                            </div>
                        </div>

                        <!-- Global Footer (Inside scrollable region) -->
                        <%@ include file="/includes/footer.jsp" %>
                    </div>
                </div>

        </body>

        </html>