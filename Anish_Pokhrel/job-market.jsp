<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Job Market</title>
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
            transform: translateY(-3px);
            box-shadow: 0 10px 20px -5px rgba(29, 62, 53, 0.1);
        }

        @media (max-width: 1024px) {
            .sidebar { display: none; }
            body { overflow: auto; height: auto; }
            .dashboard-container { height: auto; display: block; }
            .main-content-wrapper { height: auto; overflow: visible; }
            #main-header { position: sticky !important; top: 0 !important; }
        }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #1D3E35; border-radius: 10px; }
    </style>
</head>

<body class="text-gray-900 bg-surface">

    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="p-6 pb-0 px-10">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-20 w-auto brightness-0 invert opacity-90">
            </div>

            <div class="sidebar-scroll-area px-4 custom-scrollbar">
                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Menu</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/jobseeker/dashboard" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-grid-2 w-5"></i>
                            <span>Dashboard</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/job-market" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-compass w-5"></i>
                            <span>Job Market</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/messages" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-envelope w-5"></i>
                            <span>Messages</span>
                        </a>
                    </nav>
                </div>

                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Network</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/friends" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-users w-5"></i>
                            <span>Friends</span>
                        </a>
                        <a href="#" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-briefcase w-5"></i>
                            <span>Job Invitations</span>
                        </a>
                    </nav>
                </div>

                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Personal</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/profile" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-user w-5"></i>
                            <span>My Profile</span>
                        </a>
                        <a href="#" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-gear w-5"></i>
                            <span>Settings</span>
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Fixed Logout Section -->
            <div class="p-6 pt-8 border-t border-white/10 bg-primary">
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
                    <i class="fa-solid fa-power-off w-5"></i>
                    <span>Log Out</span>
                </a>
            </div>
        </aside>

        <!-- Main Fluid Content Wrapper -->
        <div class="main-content-wrapper">
            <!-- Global Header -->
            <jsp:include page="/includes/header.jsp" />

            <main class="p-6 lg:p-8 flex flex-col gap-6 w-full max-w-full">

                <!-- Page Header & Main Search -->
                <div class="bg-white rounded-3xl p-8 shadow-sm border border-gray-100 relative overflow-hidden">
                    <!-- Decorative background element -->
                    <div class="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-primary/5 to-secondary/10 rounded-full blur-3xl -translate-y-1/2 translate-x-1/4 pointer-events-none"></div>
                    
                    <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
                        <div>
                            <h1 class="text-3xl font-black text-dark tracking-tight uppercase italic mb-2">Job Market</h1>
                            <p class="text-sm text-gray-500 font-medium">Discover your next career opportunity from top employers.</p>
                        </div>
                        
                        <div class="w-full md:w-auto flex-1 max-w-lg">
                            <form action="${pageContext.request.contextPath}/job-market" method="GET" class="flex gap-2">
                                <div class="relative flex-1 group">
                                    <i class="fa-solid fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary transition-colors"></i>
                                    <input type="text" name="q" value="${searchQuery}" placeholder="Search jobs by title, skill, or location..." 
                                           class="w-full bg-gray-50 border border-gray-200 rounded-xl py-3 pl-11 pr-4 text-sm font-semibold focus:ring-4 focus:ring-primary/10 focus:border-primary transition-all outline-none">
                                </div>
                                <button type="submit" class="bg-primary text-white px-6 py-3 rounded-xl font-bold text-sm shadow-lg shadow-primary/20 hover:scale-105 active:scale-95 transition-all whitespace-nowrap">
                                    Search Jobs
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty sessionScope.flash}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-6 py-4 rounded-2xl relative shadow-sm flex items-center gap-4 animate-[fadeIn_0.3s_ease-out]">
                        <div class="w-10 h-10 bg-green-100 rounded-xl flex items-center justify-center shrink-0">
                            <i class="fa-solid fa-circle-check text-green-500 text-xl"></i>
                        </div>
                        <div>
                            <h4 class="text-sm font-black tracking-tight">Success!</h4>
                            <span class="block text-xs font-bold text-green-600 mt-0.5">${sessionScope.flash}</span>
                        </div>
                    </div>
                    <c:remove var="flash" scope="session"/>
                </c:if>

                <!-- Filters & Results Header -->
                <div class="flex items-center justify-between mt-2">
                    <h2 class="text-lg font-bold text-dark flex items-center gap-2">
                        <i class="fa-solid fa-list-ul text-primary"></i>
                        <c:choose>
                            <c:when test="${not empty searchQuery}">
                                Search Results for "<span class="text-primary italic">${searchQuery}</span>"
                            </c:when>
                            <c:otherwise>
                                All Available Jobs
                            </c:otherwise>
                        </c:choose>
                        <span class="bg-gray-100 text-gray-600 text-xs py-1 px-2.5 rounded-full ml-2">${jobs.size()}</span>
                    </h2>
                    
                    <div class="flex items-center gap-3">
                        <span class="text-xs font-bold text-gray-400 uppercase tracking-wide">Sort By:</span>
                        <select class="bg-white border border-gray-200 rounded-lg text-sm font-semibold py-1.5 px-3 focus:outline-none focus:ring-2 focus:ring-primary/20 text-dark">
                            <option>Most Recent</option>
                            <option>Highest Salary</option>
                        </select>
                    </div>
                </div>

                <!-- Job Listings Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                    <c:choose>
                        <c:when test="${empty jobs}">
                            <div class="col-span-full bg-white rounded-3xl p-12 text-center border border-gray-100 shadow-sm flex flex-col items-center justify-center">
                                <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center text-gray-300 text-3xl mb-4">
                                    <i class="fa-solid fa-briefcase"></i>
                                </div>
                                <h3 class="text-xl font-black text-dark mb-2">No jobs found</h3>
                                <p class="text-gray-500 text-sm max-w-md mx-auto font-medium">We couldn't find any jobs matching your criteria. Try adjusting your search or check back later.</p>
                                <c:if test="${not empty searchQuery}">
                                    <a href="${pageContext.request.contextPath}/job-market" class="mt-6 text-primary font-bold text-sm hover:underline">Clear Search</a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="job" items="${jobs}">
                                <div class="job-card bg-white rounded-3xl p-6 border border-gray-100 shadow-sm flex flex-col h-full relative group overflow-hidden">
                                    <!-- Hover accent line -->
                                    <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary to-accent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                                    
                                    <div class="flex justify-between items-start mb-4">
                                        <div class="w-12 h-12 rounded-xl bg-primary/5 text-primary flex items-center justify-center font-black text-xl italic shrink-0">
                                            ${not empty job.title ? job.title.substring(0,1) : 'J'}
                                        </div>
                                        <div class="flex flex-col items-end gap-1">
                                            <span class="text-[0.65rem] font-black uppercase tracking-wider ${job.jobType == 'Full-Time' ? 'bg-green-100 text-green-700' : 'bg-blue-100 text-blue-700'} px-2 py-1 rounded-md">
                                                ${job.jobType != null ? job.jobType : 'Full-Time'}
                                            </span>
                                            <span class="text-[0.7rem] text-gray-400 font-bold"><i class="fa-regular fa-clock mr-1"></i> ${job.postedAt != null ? job.postedAt.toString().substring(0, 10) : 'Recently'}</span>
                                        </div>
                                    </div>

                                    <h3 class="text-lg font-black text-dark leading-tight mb-1 group-hover:text-primary transition-colors">${job.title}</h3>
                                    <div class="flex items-center gap-3 text-xs text-gray-500 font-semibold mb-4">
                                        <span class="flex items-center gap-1.5"><i class="fa-solid fa-location-dot text-gray-400"></i> ${job.location}</span>
                                        <span class="w-1 h-1 bg-gray-300 rounded-full"></span>
                                        <span class="flex items-center gap-1.5 text-accent font-bold"><i class="fa-solid fa-sack-dollar"></i> ${job.salaryRange}</span>
                                    </div>

                                    <p class="text-sm text-gray-600 line-clamp-3 mb-6 flex-1">${job.description}</p>

                                    <div class="flex items-center gap-3 mt-auto pt-4 border-t border-gray-50">
                                        <button onclick="openApplyModal(${job.id}, '${not empty job.title ? job.title.replace('\'', '\\\'') : 'this job'}', ${job.employerId})" class="flex-1 bg-primary text-white text-sm font-bold py-2.5 rounded-xl hover:bg-secondary transition-colors text-center">
                                            Apply Now
                                        </button>
                                        <button class="w-10 h-10 rounded-xl bg-gray-50 text-gray-400 hover:text-primary hover:bg-primary/5 transition-colors flex items-center justify-center shrink-0 border border-gray-100">
                                            <i class="fa-regular fa-bookmark"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <!-- Apply Job Modal -->
    <div id="applyModal" class="fixed inset-0 bg-dark/80 backdrop-blur-sm z-50 hidden flex items-center justify-center opacity-0 transition-opacity duration-300">
        <div class="bg-white rounded-[2rem] p-8 w-full max-w-md shadow-2xl transform scale-95 transition-transform duration-300" id="applyModalContent">
            <div class="flex justify-between items-start mb-6 border-b border-gray-100 pb-4">
                <div>
                    <h2 class="text-2xl font-black text-dark tracking-tighter uppercase italic">Apply for Role</h2>
                    <p class="text-sm font-bold text-gray-400 mt-1" id="modalJobTitle">Job Title</p>
                </div>
                <button onclick="closeApplyModal()" class="w-10 h-10 rounded-xl bg-gray-50 text-gray-400 hover:text-red-500 hover:bg-red-50 transition-colors flex items-center justify-center shrink-0">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/apply-job" method="POST" class="space-y-5">
                <input type="hidden" name="jobId" id="modalJobId">
                <input type="hidden" name="employerId" id="modalEmployerId">
                
                <div class="space-y-2">
                    <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Full Name</label>
                    <input type="text" name="applicantName" value="${sessionScope.name}" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" required>
                </div>
                
                <div class="space-y-2">
                    <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Email Address</label>
                    <input type="email" name="applicantEmail" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" required>
                </div>
                
                <div class="space-y-2">
                    <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Cover Note (Optional)</label>
                    <textarea name="coverNote" rows="3" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-medium text-dark focus:ring-2 focus:ring-primary" placeholder="Why are you a good fit?"></textarea>
                </div>
                
                <button type="submit" class="w-full bg-primary text-white py-4 rounded-xl text-sm font-black shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all mt-4">
                    Confirm Application
                </button>
            </form>
        </div>
    </div>

    <script>
        function openApplyModal(jobId, jobTitle, employerId) {
            document.getElementById('modalJobId').value = jobId;
            document.getElementById('modalJobTitle').innerText = jobTitle;
            document.getElementById('modalEmployerId').value = employerId;
            
            const modal = document.getElementById('applyModal');
            const content = document.getElementById('applyModalContent');
            
            modal.classList.remove('hidden');
            // Trigger reflow
            void modal.offsetWidth;
            
            modal.classList.remove('opacity-0');
            content.classList.remove('scale-95');
        }

        function closeApplyModal() {
            const modal = document.getElementById('applyModal');
            const content = document.getElementById('applyModalContent');
            
            modal.classList.add('opacity-0');
            content.classList.add('scale-95');
            
            setTimeout(() => {
                modal.classList.add('hidden');
            }, 300);
        }
    </script>
</body>
</html>
