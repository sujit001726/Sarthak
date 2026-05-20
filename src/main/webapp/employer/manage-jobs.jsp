<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | Manage My Jobs</title>
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

                .job-card {
                    transition: all 0.3s ease;
                }

                .job-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05);
                    border-color: #1D3E35;
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
                        <%@ include file="/includes/sidebar.jsp" %>
                    </aside>

                    <!-- Main Fluid Content Wrapper (The ONLY scrollable area) -->
                    <div class="main-content-wrapper">
                        <!-- Global Header (Inside scrollable region) -->
                        <%@ include file="/includes/header.jsp" %>

                        <main class="p-6 lg:p-8 flex flex-col gap-8 w-full max-w-full">

                        <!-- Page Title & Quick Stats -->
                        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                            <div>
                                <h1
                                    class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">
                                    Job Inventory</h1>
                                <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Maintain and monitor your
                                    organization's active recruitment postings</p>
                            </div>

                            <a href="${pageContext.request.contextPath}/employer/post-job"
                                class="bg-primary text-white px-8 py-4 rounded-2xl text-[0.8rem] font-black shadow-xl shadow-primary/20 hover:scale-[1.05] transition-all flex items-center gap-3">
                                <i class="fa-solid fa-plus-circle"></i>
                                Deploy New Opening
                            </a>
                        </div>

                        <!-- Stats Bar -->
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                            <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex flex-col">
                                <span class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-3">Live
                                    Now</span>
                                <h3 class="text-2xl font-black text-dark leading-none">12</h3>
                                <div class="mt-auto pt-4 flex items-center gap-2">
                                    <span class="w-2 h-2 bg-accent rounded-full animate-pulse"></span>
                                    <span class="text-[0.6rem] font-bold text-accent uppercase italic">Active
                                        Streams</span>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex flex-col">
                                <span
                                    class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-3">Applicants</span>
                                <h3 class="text-2xl font-black text-dark leading-none">842</h3>
                                <div class="mt-auto pt-4">
                                    <span class="text-[0.6rem] font-bold text-gray-400 uppercase tracking-tighter">+45
                                        New this week</span>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex flex-col">
                                <span
                                    class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-3">Drafts</span>
                                <h3 class="text-2xl font-black text-dark leading-none">03</h3>
                                <div class="mt-auto pt-4">
                                    <span class="text-[0.6rem] font-bold text-amber-500 uppercase italic">Pending
                                        Review</span>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-[2rem] border border-gray-100 shadow-sm flex flex-col">
                                <span class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-3">Avg.
                                    Reach</span>
                                <h3 class="text-2xl font-black text-dark leading-none">1.2k</h3>
                                <div class="mt-auto pt-4">
                                    <span class="text-[0.6rem] font-bold text-primary uppercase italic">Views /
                                        Job</span>
                                </div>
                            </div>
                        </div>

                        <!-- Job List Section -->
                        <div class="bg-white rounded-[2.5rem] p-8 border border-gray-100 shadow-sm flex flex-col gap-8">
                            <div class="flex flex-wrap items-center justify-between gap-6 border-b border-gray-50 pb-6">
                                <!-- Tabs -->
                                <div class="flex gap-8 overflow-x-auto">
                                    <button
                                        class="status-tab active px-2 py-1 text-sm font-black text-dark uppercase tracking-tighter italic">All
                                        Postings</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">Active</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">Paused</button>
                                    <button
                                        class="status-tab px-2 py-1 text-sm font-bold text-gray-400 hover:text-dark uppercase tracking-tighter italic transition-all">Expired</button>
                                </div>

                                <div class="flex gap-4">
                                    <div class="relative group">
                                        <i
                                            class="fa-solid fa-magnifying-glass absolute left-4 top-1/2 -translate-y-1/2 text-gray-300 group-focus-within:text-primary transition-all"></i>
                                        <input type="text" id="jobSearchInput" placeholder="Search title..."
                                            class="bg-surface border border-gray-100 rounded-xl py-2.5 pl-12 pr-4 text-xs font-bold focus:outline-none focus:ring-4 focus:ring-primary/5 focus:border-primary transition-all">
                                    </div>
                                </div>
                            </div>

                            <!-- Jobs Table/List -->
                            <div class="space-y-4">

                                <c:forEach var="job" items="${jobs}">
                                    <!-- Job Row Item -->
                                    <div
                                        class="job-card bg-white border border-gray-100 rounded-3xl p-6 flex flex-wrap items-center justify-between gap-6 hover:bg-surface/30">
                                        <div class="flex items-center gap-6 min-w-[300px]">
                                            <div
                                                class="w-14 h-14 bg-primary/5 rounded-2xl flex items-center justify-center text-primary text-xl font-black italic">
                                                J</div>
                                            <div>
                                                <h3 class="text-base font-black text-dark leading-tight">${job.title}
                                                </h3>
                                                <div class="flex items-center gap-3 mt-1">
                                                    <span
                                                        class="text-[0.6rem] font-bold text-gray-400 uppercase tracking-tighter">${job.location}</span>
                                                    <span class="w-1 h-1 bg-gray-300 rounded-full"></span>
                                                    <span
                                                        class="text-[0.6rem] font-bold text-gray-400 uppercase tracking-tighter">${job.jobType}</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="flex gap-10 items-center">
                                            <div class="text-center">
                                                <p
                                                    class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                    Applicants</p>
                                                <div class="flex items-center justify-center gap-2">
                                                    <span class="text-sm font-black text-dark">42</span>
                                                    <a href="${pageContext.request.contextPath}/employer/applicants?jobId=${job.id}"
                                                        class="text-[0.55rem] font-black text-accent hover:underline">VIEW
                                                        ALL</a>
                                                </div>
                                            </div>
                                            <div class="text-center">
                                                <p
                                                    class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                    Status</p>
                                                <span
                                                    class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[0.55rem] font-black uppercase tracking-wider
                                        ${job.status == 'active' ? 'bg-accent/10 text-accent' : 'bg-amber-100 text-amber-600'}">
                                                    <span
                                                        class="w-1.5 h-1.5 rounded-full ${job.status == 'active' ? 'bg-accent animate-pulse' : 'bg-amber-500'}"></span>
                                                    ${job.status}
                                                </span>
                                            </div>
                                            <div class="text-center">
                                                <p
                                                    class="text-[0.6rem] font-black text-gray-300 uppercase tracking-widest mb-1">
                                                    Exp. Date</p>
                                                <p class="text-xs font-bold text-dark italic">${job.deadline != null ?
                                                    job.deadline : 'Open'}</p>
                                            </div>
                                        </div>

                                        <div class="flex items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/employer/edit-job?id=${job.id}"
                                                class="p-3 bg-primary/5 text-primary rounded-xl hover:bg-primary hover:text-white transition-all shadow-sm"
                                                title="Edit Job">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <button
                                                class="p-3 bg-secondary/5 text-secondary rounded-xl hover:bg-secondary hover:text-white transition-all shadow-sm"
                                                title="Pause / Expire">
                                                <i class="fa-solid fa-pause"></i>
                                            </button>
                                            <form method="post" id="delete-form-${job.id}"
                                                action="${pageContext.request.contextPath}/employer/delete-job"
                                                class="inline">
                                                <input type="hidden" name="jobId" value="${job.id}">
                                                <button type="button"
                                                    onclick="openDeleteModal(${job.id})"
                                                    class="p-3 bg-red-50 text-red-500 rounded-xl hover:bg-red-500 hover:text-white transition-all shadow-sm"
                                                    title="Delete">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty jobs}">
                                    <div
                                        class="py-20 text-center bg-surface/20 rounded-3xl border-2 border-dashed border-gray-100">
                                        <i class="fa-solid fa-folder-open text-gray-200 text-5xl mb-6 block"></i>
                                        <h4 class="text-lg font-black text-dark uppercase italic tracking-tighter">
                                            Inventory is empty</h4>
                                        <p class="text-xs font-bold text-gray-400 mt-2">You haven't posted any jobs yet.
                                            Start building your team today.</p>
                                        <a href="${pageContext.request.contextPath}/employer/post-job"
                                            class="mt-8 inline-block bg-primary text-white px-10 py-4 rounded-2xl text-[0.7rem] font-black shadow-xl shadow-primary/20">Post
                                            New Job</a>
                                    </div>
                                </c:if>

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

                const searchInput = document.getElementById('jobSearchInput');
                if (searchInput) {
                    searchInput.addEventListener('input', function(e) {
                        const searchTerm = e.target.value.toLowerCase();
                        const jobCards = document.querySelectorAll('.job-card');
                        
                        jobCards.forEach(card => {
                            const titleElement = card.querySelector('h3');
                            if (titleElement) {
                                const title = titleElement.textContent.toLowerCase();
                                if (title.includes(searchTerm)) {
                                    card.style.display = '';
                                } else {
                                    card.style.display = 'none';
                                }
                            }
                        });
                    });
                }
            </script>

        </body>

        </html>