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

                .sidebar-scroll-area::-webkit-scrollbar {
                    width: 4px;
                }

                .sidebar-scroll-area::-webkit-scrollbar-track {
                    background: transparent;
                }

                .sidebar-scroll-area::-webkit-scrollbar-thumb {
                    background: rgba(255, 255, 255, 0.2);
                    border-radius: 10px;
                }

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
                #main-header {
                    position: relative !important;
                    top: auto !important;
                }

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
                    display: flex;
                    flex-direction: column;
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
                    body {
                        overflow-x: hidden !important;
                        height: auto !important;
                    }

                    .sidebar {
                        position: fixed !important;
                        left: -280px !important;
                        top: 0 !important;
                        bottom: 0 !important;
                        width: 280px !important;
                        z-index: 5000 !important;
                        transform: translateX(0) !important;
                        transition: transform 0.3s ease !important;
                        display: flex !important;
                        box-shadow: 20px 0 50px rgba(0,0,0,0.3) !important;
                    }

                    body.sidebar-open .sidebar {
                        transform: translateX(280px) !important;
                    }

                    body.sidebar-open::after {
                        content: '';
                        position: fixed;
                        inset: 0;
                        background: rgba(15, 33, 28, 0.8) !important;
                        z-index: 4500 !important;
                        backdrop-filter: blur(5px) !important;
                    }

                    .main-content-wrapper, .main-wrapper {
                        margin-left: 0 !important;
                        width: 100% !important;
                        min-width: 100% !important;
                        height: auto !important;
                        overflow: visible !important;
                        padding: 0 !important;
                    }

                    .dashboard-container {
                        display: block !important;
                        height: auto !important;
                    }

                    #main-header {
                        position: sticky !important;
                        top: 0 !important;
                        z-index: 1000 !important;
                    }

                    #desktop-search, .desktop-search {
                        display: none !important;
                    }

                    .mobile-sidebar-close {
                        display: flex !important;
                        position: absolute;
                        top: 20px;
                        right: 15px;
                        width: 36px;
                        height: 36px;
                        background: rgba(255,255,255,0.1);
                        color: white;
                        border-radius: 10px;
                        align-items: center;
                        justify-content: center;
                        z-index: 10;
                        cursor: pointer;
                        border: 1px solid rgba(255,255,255,0.2);
                    }
                    
                    .grid-cols-2.md\:grid-cols-4 {
                        grid-template-columns: 1fr !important;
                    }
                    
                    .p-6.lg\:p-8 {
                        padding: 1rem !important;
                    }

                    table {
                        display: block !important;
                        overflow-x: auto !important;
                        width: 100% !important;
                    }
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
                    <%@ include file="/includes/sidebar.jsp" %>
                </aside>

                <!-- Main Fluid Content Wrapper (The ONLY scrollable area) -->
                <div class="main-content-wrapper">
                    <!-- Global Header (Inside scrollable region) -->
                    <%@ include file="/includes/header.jsp" %>

                        <main class="p-6 lg:p-8 flex flex-col gap-6 w-full max-w-full">

                            <c:if test="${not empty flash or not empty successMessage}">
                                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl relative mb-4 animate-fadeIn"
                                    role="alert">
                                    <span class="block sm:inline font-bold">${not empty flash ? flash :
                                        successMessage}</span>
                                </div>
                            </c:if>

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
                                        <span
                                            class="text-[0.65rem] font-black text-primary uppercase tracking-wider">Plan:
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
                                            <i
                                                class="fa-solid fa-briefcase text-primary opacity-20 text-xl mb-4 block"></i>
                                            <h3 class="text-3xl font-black text-dark">${totalJobs}</h3>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                                Total Posted</p>
                                        </div>
                                        <div
                                            class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm group">
                                            <i
                                                class="fa-solid fa-circle-check text-accent opacity-20 text-xl mb-4 block"></i>
                                            <h3 class="text-3xl font-black text-dark">${totalJobs}</h3>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
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
                                            <p
                                                class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
                                                Total Applicants</p>
                                        </div>
                                        <div
                                            class="stat-card bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm group">
                                            <i
                                                class="fa-solid fa-star text-amber-400 opacity-20 text-xl mb-4 block"></i>
                                            <h3 class="text-3xl font-black text-dark">08</h3>
                                            <p
                                                class="text-[0.6rem] font-black text-gray-400 uppercase tracking-[0.2em]">
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
                                                <p class="text-[0.65rem] font-bold text-gray-400 mt-1 pl-5">Real-time
                                                    status
                                                    of your recruitment funnel</p>
                                            </div>
                                            <div class="flex gap-2 relative">
                                                <!-- Filter Dropdown Container -->
                                                <div class="relative">
                                                    <button onclick="toggleFilterMenu()"
                                                        class="p-2.5 bg-surface border border-gray-100 rounded-xl hover:bg-gray-100 transition-all focus:outline-none focus:ring-2 focus:ring-primary/20">
                                                        <i class="fa-solid fa-filter text-primary"></i>
                                                    </button>
                                                    <div id="filterDropdown" class="hidden absolute right-0 mt-2 w-40 bg-white rounded-xl shadow-lg border border-gray-100 py-2 z-50">
                                                        <button onclick="filterJobs('all')" class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-surface font-bold transition-colors">Show All</button>
                                                        <button onclick="filterJobs('active')" class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-surface font-bold transition-colors">Active Only</button>
                                                        <button onclick="filterJobs('closed')" class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-surface font-bold transition-colors">Closed Only</button>
                                                    </div>
                                                </div>
                                                
                                                <a href="${pageContext.request.contextPath}/employer/export-jobs"
                                                    class="p-2.5 bg-surface border border-gray-100 rounded-xl hover:bg-gray-100 transition-all text-center inline-block"
                                                    title="Download CSV">
                                                    <i class="fa-solid fa-download text-primary"></i>
                                                </a>
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
                                                        <tr class="job-row group hover:bg-surface/50 transition-colors" data-status="${job.status.toLowerCase()}">
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
                                                                        <i
                                                                            class="fa-solid fa-pen-to-square text-sm"></i>
                                                                    </a>
                                                                    <form method="post" id="delete-form-${job.id}"
                                                                        action="${pageContext.request.contextPath}/employer/delete-job"
                                                                        class="inline">
                                                                        <input type="hidden" name="jobId"
                                                                            value="${job.id}">
                                                                        <button type="button"
                                                                            onclick="openDeleteModal(${job.id})"
                                                                            class="p-2.5 bg-red-50 text-red-600 rounded-xl hover:bg-red-600 hover:text-white transition-all"
                                                                            title="Delete">
                                                                            <i
                                                                                class="fa-solid fa-trash-can text-sm"></i>
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
                                                                    <h4 class="text-sm font-black text-dark">No active
                                                                        job
                                                                        postings found</h4>
                                                                    <p
                                                                        class="text-[0.65rem] font-bold text-gray-400 mt-1">
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
                                            <p class="text-xs font-black text-dark">New applicant for "Senior UI
                                                Designer"
                                            </p>
                                            <p class="text-[0.65rem] font-bold text-gray-400 italic">45 seconds ago</p>
                                        </div>
                                    </div>
                                    <div class="flex gap-4">
                                        <div class="w-2 h-2 mt-2 bg-blue-500 rounded-full shrink-0"></div>
                                        <div>
                                            <p class="text-xs font-black text-dark">Interview scheduled with Panas Kafle
                                            </p>
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
                        </main>

                        <div class="bg-[#1D3E35] pb-20">
                            <!-- Global Footer (Inside scrollable region) -->
                            <%@ include file="/includes/footer.jsp" %>
                        </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div id="deleteModal" class="fixed inset-0 z-[100] hidden flex items-center justify-center p-4">
                <div class="absolute inset-0 bg-dark/40 backdrop-blur-sm transition-opacity" onclick="closeDeleteModal()"></div>
                <div class="bg-white rounded-[2rem] shadow-2xl w-full max-w-sm overflow-hidden z-10 transform scale-95 opacity-0 transition-all duration-300" id="deleteModalContent">
                    <div class="p-8 text-center">
                        <div class="w-20 h-20 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-6 text-red-500 text-3xl shadow-inner border border-red-100">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                        </div>
                        <h3 class="text-2xl font-black text-dark mb-3 tracking-tight">Delete Job?</h3>
                        <p class="text-sm font-medium text-gray-500 mb-8 leading-relaxed">Are you sure you want to delete this job posting permanently? This action cannot be undone.</p>
                        <div class="flex gap-4 justify-center">
                            <button onclick="closeDeleteModal()" class="px-6 py-3 rounded-xl text-sm font-bold text-gray-600 bg-gray-50 hover:bg-gray-100 transition-colors w-full border border-gray-200">Cancel</button>
                            <button id="confirmDeleteBtn" class="px-6 py-3 rounded-xl text-sm font-bold text-white bg-red-500 hover:bg-red-600 transition-all shadow-lg shadow-red-500/20 active:scale-[0.98] w-full">Delete Job</button>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                let currentJobIdToDelete = null;

                function openDeleteModal(jobId) {
                    currentJobIdToDelete = jobId;
                    const modal = document.getElementById('deleteModal');
                    const content = document.getElementById('deleteModalContent');
                    
                    modal.classList.remove('hidden');
                    // Small delay to allow display:block to apply before animating opacity/scale
                    setTimeout(() => {
                        content.classList.remove('scale-95', 'opacity-0');
                        content.classList.add('scale-100', 'opacity-100');
                    }, 10);
                }

                function closeDeleteModal() {
                    const modal = document.getElementById('deleteModal');
                    const content = document.getElementById('deleteModalContent');
                    
                    content.classList.remove('scale-100', 'opacity-100');
                    content.classList.add('scale-95', 'opacity-0');
                    
                    setTimeout(() => {
                        modal.classList.add('hidden');
                        currentJobIdToDelete = null;
                    }, 300);
                }

                document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
                    if (currentJobIdToDelete) {
                        document.getElementById('delete-form-' + currentJobIdToDelete).submit();
                    }
                });

                function toggleFilterMenu() {
                    const dropdown = document.getElementById('filterDropdown');
                    dropdown.classList.toggle('hidden');
                }

                // Close dropdown if clicked outside
                window.onclick = function(event) {
                    if (!event.target.closest('.relative')) {
                        const dropdowns = document.getElementsByClassName("absolute right-0 mt-2");
                        for (let i = 0; i < dropdowns.length; i++) {
                            if (!dropdowns[i].classList.contains('hidden')) {
                                dropdowns[i].classList.add('hidden');
                            }
                        }
                    }
                }

                function filterJobs(status) {
                    const rows = document.querySelectorAll('.job-row');
                    rows.forEach(row => {
                        if (status === 'all') {
                            row.style.display = '';
                        } else {
                            if (row.getAttribute('data-status') === status) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        }
                    });
                    document.getElementById('filterDropdown').classList.add('hidden');
                }
            </script>

        </body>

        </html>