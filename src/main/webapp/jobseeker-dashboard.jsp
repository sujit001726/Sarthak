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

                            <c:if test="${not empty successMessage}">
                                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-xl relative mb-4 animate-fadeIn"
                                    role="alert">
                                    <span class="block sm:inline font-bold">${successMessage}</span>
                                </div>
                            </c:if>

                            <!-- Fluid Quick Actions Bar -->
                            <div
                                class="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm flex flex-wrap items-center justify-between gap-4">
                                <div class="flex items-center gap-4">
                                    <div
                                        class="w-12 h-12 bg-primary rounded-xl flex items-center justify-center text-white text-xl font-bold italic overflow-hidden">
                                        <c:choose>
                                            <c:when test="${not empty profileImage}">
                                                <img src="${profileImage}" class="w-full h-full object-cover"
                                                    onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                                <span style="display:none;">${userInitials}</span>
                                            </c:when>
                                            <c:otherwise>${userInitials}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <h2 class="text-sm font-black text-dark">Welcome back,
                                            <c:out value="${userName}" default="User" />!
                                        </h2>
                                        <p class="text-[0.65rem] font-bold text-gray-400 italic">Quick Access Dashboard
                                        </p>
                                    </div>
                                </div>
                                <div class="flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/friends"
                                        class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all flex items-center gap-2">
                                        <i class="fa-solid fa-users-viewfinder text-primary/70"></i> Search Friends
                                    </a>
                                    <a href="${pageContext.request.contextPath}/job-market"
                                        class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all flex items-center gap-2">
                                        <i class="fa-solid fa-briefcase text-primary/70"></i> Search Jobs
                                    </a>
                                    <button onclick="openStatsModal('apps')"
                                        class="bg-surface hover:bg-gray-100 px-4 py-2 rounded-lg text-[0.7rem] font-black text-primary transition-all flex items-center gap-2">
                                        <i class="fa-solid fa-chart-simple text-primary/70"></i> My Stats
                                    </button>
                                    <a href="${pageContext.request.contextPath}/profile?updateCv=true"
                                        class="bg-primary text-white px-5 py-2 rounded-lg text-[0.7rem] font-black shadow-lg shadow-primary/20 transition-all hover:bg-secondary flex items-center gap-2">
                                        <i class="fa-solid fa-cloud-arrow-up"></i> Update CV
                                    </a>
                                </div>
                            </div>

                            <!-- Main Dashboard Content (Clean 1-Column Layout) -->
                            <div class="flex flex-col gap-6 w-full">

                                    <!-- Stats Bar -->
                                    <div id="seeker-stats-bar" class="grid grid-cols-2 md:grid-cols-4 gap-4">
                                         <div onclick="openStatsModal('apps')"
                                             class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm cursor-pointer hover:scale-[1.02] active:scale-[0.98] transition-all">
                                             <div class="flex items-center justify-between mb-2">
                                                 <i class="fa-solid fa-paper-plane text-primary opacity-20 text-xl"></i>
                                                 <span class="text-[0.6rem] font-black text-accent">+2 new</span>
                                             </div>
                                             <h3 class="text-2xl font-black text-dark">
                                                 <c:out value="${totalApplications < 10 ? '0' : ''}${totalApplications}" />
                                             </h3>
                                             <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                                 Applications</p>
                                         </div>
                                         <div onclick="openStatsModal('interviews')"
                                             class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm cursor-pointer hover:scale-[1.02] active:scale-[0.98] transition-all">
                                             <div class="flex items-center justify-between mb-2">
                                                 <i class="fa-solid fa-users text-primary opacity-20 text-xl"></i>
                                                 <span class="text-[0.6rem] font-black text-accent">+1 new</span>
                                             </div>
                                             <h3 class="text-2xl font-black text-dark">
                                                 <c:out value="${upcomingInterviews < 10 ? '0' : ''}${upcomingInterviews}" />
                                             </h3>
                                             <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                                 Interviews</p>
                                         </div>
                                         <div onclick="openStatsModal('views')"
                                             class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm cursor-pointer hover:scale-[1.02] active:scale-[0.98] transition-all">
                                             <div class="flex items-center justify-between mb-2">
                                                 <i class="fa-solid fa-eye text-primary opacity-20 text-xl"></i>
                                                 <span class="text-[0.6rem] font-black text-blue-500">24h focus</span>
                                             </div>
                                             <h3 class="text-2xl font-black text-dark">
                                                 <c:out value="${profileViews < 10 ? '0' : ''}${profileViews}" />
                                             </h3>
                                             <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">
                                                 Profile Views</p>
                                         </div>
                                         <div onclick="openStatsModal('saved')"
                                             class="stat-card bg-white p-6 rounded-2xl border border-gray-100 shadow-sm cursor-pointer hover:scale-[1.02] active:scale-[0.98] transition-all">
                                             <div class="flex items-center justify-between mb-2">
                                                 <i class="fa-solid fa-bookmark text-primary opacity-20 text-xl"></i>
                                                 <span class="text-[0.6rem] font-black text-gray-300">Saved</span>
                                             </div>
                                             <h3 class="text-2xl font-black text-dark">
                                                 <c:out value="${savedJobs < 10 ? '0' : ''}${savedJobs}" />
                                             </h3>
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
                                                <p
                                                    class="text-xs text-white/60 leading-relaxed mb-6 italic font-medium">
                                                    Employers are looking for "Frontend Developers" with React
                                                    experience.
                                                    Your profile matches 85% of these criteria.</p>
                                                <button
                                                    class="bg-accent text-primary px-6 py-3 rounded-xl text-[0.7rem] font-black hover:bg-white transition-all">View
                                                    Hot Jobs</button>
                                            </div>
                                            <div class="hidden md:grid grid-cols-2 gap-4 shrink-0">
                                                <div
                                                    class="bg-white/10 p-4 rounded-2xl border border-white/10 backdrop-blur-sm text-center">
                                                    <p class="text-[0.5rem] font-black text-white/50 uppercase">Avg
                                                        Salary
                                                    </p>
                                                    <p class="text-lg font-black text-accent">$85k</p>
                                                </div>
                                                <div
                                                    class="bg-white/10 p-4 rounded-2xl border border-white/10 backdrop-blur-sm text-center">
                                                    <p class="text-[0.5rem] font-black text-white/50 uppercase">Open
                                                        Roles
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
                                            <a href="${pageContext.request.contextPath}/job-market" class="text-[0.65rem] font-black text-primary underline hover:text-accent transition-colors">View All
                                                Matches</a>
                                        </div>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <c:choose>
                                                <c:when test="${empty recommendedJobs}">
                                                    <div class="col-span-full py-12 text-center flex flex-col items-center justify-center bg-surface rounded-3xl border border-dashed border-gray-200">
                                                        <i class="fa-solid fa-briefcase text-gray-300 text-3xl mb-3"></i>
                                                        <p class="text-xs font-black text-dark uppercase tracking-wider">No Active Jobs Yet</p>
                                                        <p class="text-[0.65rem] text-gray-400 italic mt-1 px-4">There are currently no active job postings in the database. Post one using an Employer account!</p>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="job" items="${recommendedJobs}" varStatus="loop">
                                                        <c:if test="${loop.index < 4}">
                                                            <div class="group p-6 bg-surface rounded-3xl border border-transparent hover:border-primary/10 hover:bg-white hover:shadow-xl transition-all duration-300">
                                                                <div class="flex gap-4 mb-4">
                                                                    <div class="w-12 h-12 bg-white rounded-2xl shadow-sm border border-gray-50 flex items-center justify-center font-black text-primary text-xl uppercase italic shrink-0">
                                                                        ${not empty job.title ? job.title.substring(0, 1) : 'J'}
                                                                    </div>
                                                                    <div class="overflow-hidden">
                                                                        <h4 class="text-sm font-black text-dark truncate group-hover:text-primary transition-colors">${job.title}</h4>
                                                                        <p class="text-[0.65rem] font-bold text-gray-400 italic">${job.companyName} &bull; ${job.location}</p>
                                                                    </div>
                                                                </div>
                                                                <div class="flex gap-2 mb-6">
                                                                    <span class="job-tag bg-primary/5 text-primary">${job.jobType}</span>
                                                                    <span class="job-tag bg-accent/10 text-accent">${job.salaryRange}</span>
                                                                </div>
                                                                <button onclick="openApplyModal(${job.id}, '${not empty job.title ? job.title.replace('\'', '\\\'') : 'this job'}', ${job.employerId})"
                                                                    class="w-full py-3 bg-white border border-gray-100 rounded-xl text-[0.65rem] font-black text-dark group-hover:bg-primary group-hover:text-white transition-all">
                                                                    Apply Now
                                                                </button>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
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
                                            <p class="text-xs font-bold text-dark">System: Weekly career report is ready
                                            </p>
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

                 <!-- Apply Job Modal -->
                 <div id="applyModal"
                     class="fixed inset-0 bg-dark/80 backdrop-blur-sm z-50 hidden flex items-center justify-center opacity-0 transition-opacity duration-300">
                     <div class="bg-white rounded-[2rem] p-8 w-full max-w-md shadow-2xl transform scale-95 transition-transform duration-300"
                         id="applyModalContent">
                         <div class="flex justify-between items-start mb-6 border-b border-gray-100 pb-4">
                             <div>
                                 <h2 class="text-2xl font-black text-dark tracking-tighter uppercase italic">Apply for
                                     Role</h2>
                                 <p class="text-sm font-bold text-gray-400 mt-1" id="modalJobTitle">Job Title</p>
                             </div>
                             <button onclick="closeApplyModal()"
                                 class="w-10 h-10 rounded-xl bg-gray-50 text-gray-400 hover:text-red-500 hover:bg-red-50 transition-colors flex items-center justify-center shrink-0">
                                 <i class="fa-solid fa-xmark"></i>
                             </button>
                         </div>
                         <form action="${pageContext.request.contextPath}/apply-job" method="POST" class="space-y-5">
                             <input type="hidden" name="jobId" id="modalJobId">
                             <input type="hidden" name="employerId" id="modalEmployerId">

                             <div class="space-y-2">
                                 <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Full
                                     Name</label>
                                 <input type="text" name="applicantName" value="${userName}"
                                     class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary"
                                     required>
                             </div>

                             <div class="space-y-2">
                                 <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Email
                                     Address</label>
                                 <input type="email" name="applicantEmail" value="${userEmail}"
                                     class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary"
                                     required>
                             </div>

                             <div class="space-y-2">
                                 <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Cover Note
                                     (Optional)</label>
                                 <textarea name="coverNote" rows="3"
                                     class="w-full bg-surface border-none rounded-xl py-3 px-4 font-medium text-dark focus:ring-2 focus:ring-primary"
                                     placeholder="Why are you a good fit?"></textarea>
                             </div>

                             <button type="submit"
                                 class="w-full bg-primary text-white py-4 rounded-xl text-sm font-black shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all mt-4">
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
                  <!-- Stats Insights Modal -->
                  <div id="statsModal"
                       class="fixed inset-0 bg-dark/80 backdrop-blur-sm z-[1000] hidden flex items-center justify-center opacity-0 transition-opacity duration-300">
                      <div class="bg-white rounded-[2rem] p-8 w-full max-w-2xl shadow-2xl transform scale-95 transition-transform duration-300"
                           id="statsModalContent">
                          <div class="flex justify-between items-start mb-6 border-b border-gray-100 pb-4">
                              <div>
                                  <h2 class="text-2xl font-black text-dark tracking-tighter uppercase italic text-primary">My Career Insights</h2>
                                  <p class="text-xs font-bold text-gray-400 mt-1">Real-time engagement and application status tracking</p>
                              </div>
                              <button onclick="closeStatsModal()"
                                  class="w-10 h-10 rounded-xl bg-gray-50 text-gray-400 hover:text-red-500 hover:bg-red-50 transition-colors flex items-center justify-center shrink-0">
                                  <i class="fa-solid fa-xmark"></i>
                              </button>
                          </div>

                          <!-- Tab Headers -->
                          <div class="flex gap-2 border-b border-gray-100 pb-4 mb-6 overflow-x-auto">
                              <button onclick="switchStatsTab('apps')" id="tab-btn-apps" class="px-4 py-2 rounded-xl text-xs font-black bg-primary text-white transition-all whitespace-nowrap">
                                  <i class="fa-solid fa-paper-plane mr-2"></i> Applications
                              </button>
                              <button onclick="switchStatsTab('interviews')" id="tab-btn-interviews" class="px-4 py-2 rounded-xl text-xs font-black text-gray-400 hover:bg-gray-50 transition-all whitespace-nowrap">
                                  <i class="fa-solid fa-users mr-2"></i> Interviews
                              </button>
                              <button onclick="switchStatsTab('views')" id="tab-btn-views" class="px-4 py-2 rounded-xl text-xs font-black text-gray-400 hover:bg-gray-50 transition-all whitespace-nowrap">
                                  <i class="fa-solid fa-eye mr-2"></i> Profile Views
                              </button>
                              <button onclick="switchStatsTab('saved')" id="tab-btn-saved" class="px-4 py-2 rounded-xl text-xs font-black text-gray-400 hover:bg-gray-50 transition-all whitespace-nowrap">
                                  <i class="fa-solid fa-bookmark mr-2"></i> Saved Jobs
                              </button>
                          </div>

                          <!-- Tab Contents -->
                          <!-- 1. Applications Content -->
                          <div id="tab-content-apps" class="stats-tab-content space-y-6">
                              <div class="grid grid-cols-3 gap-4">
                                  <div class="bg-surface p-4 rounded-2xl text-center">
                                      <p class="text-2xl font-black text-primary">${totalApplications}</p>
                                      <p class="text-[0.55rem] font-black text-gray-400 uppercase tracking-wider mt-1">Submitted</p>
                                  </div>
                                  <div class="bg-surface p-4 rounded-2xl text-center">
                                      <p class="text-2xl font-black text-accent"><c:out value="${totalApplications > 0 ? 1 : 0}" /></p>
                                      <p class="text-[0.55rem] font-black text-gray-400 uppercase tracking-wider mt-1">Shortlisted</p>
                                  </div>
                                  <div class="bg-surface p-4 rounded-2xl text-center">
                                      <p class="text-2xl font-black text-blue-500"><c:out value="${totalApplications > 1 ? 1 : 0}" /></p>
                                      <p class="text-[0.55rem] font-black text-gray-400 uppercase tracking-wider mt-1">Under Review</p>
                                  </div>
                              </div>

                              <div class="space-y-3">
                                  <h4 class="text-xs font-black text-dark uppercase tracking-wider">Application Funnel</h4>
                                  <div class="space-y-2">
                                      <div>
                                          <div class="flex justify-between text-[0.65rem] font-bold text-gray-500 mb-1">
                                              <span>Review Rate</span>
                                              <span>80%</span>
                                          </div>
                                          <div class="progress-container">
                                              <div class="progress-bar" style="width: 80%"></div>
                                          </div>
                                      </div>
                                      <div>
                                          <div class="flex justify-between text-[0.65rem] font-bold text-gray-500 mb-1">
                                              <span>Shortlist Success</span>
                                              <span>45%</span>
                                          </div>
                                          <div class="progress-container">
                                              <div class="progress-bar animate-progressBar" style="width: 45%; background: #22c55e;"></div>
                                          </div>
                                      </div>
                                  </div>
                              </div>

                              <div class="p-4 bg-primary/5 rounded-2xl border border-primary/10">
                                  <p class="text-xs font-bold text-dark leading-relaxed">
                                      <i class="fa-solid fa-circle-info text-primary mr-2"></i> 
                                      Your application response rate is higher than 85% of other developers in Kathmandu. Keep applying to roles marked "High Match".
                                  </p>
                              </div>
                          </div>

                          <!-- 2. Interviews Content -->
                          <div id="tab-content-interviews" class="stats-tab-content space-y-6 hidden">
                              <div class="p-8 text-center bg-surface rounded-3xl border border-dashed border-gray-200">
                                  <div class="w-14 h-14 bg-accent/10 text-accent rounded-full flex items-center justify-center mx-auto mb-4">
                                      <i class="fa-solid fa-video text-2xl"></i>
                                  </div>
                                  <h3 class="text-sm font-black text-dark uppercase tracking-wider">Upcoming Interviews</h3>
                                  <p class="text-xs text-gray-400 italic mt-2">You have <span class="font-bold text-primary">${upcomingInterviews}</span> upcoming interview scheduled.</p>
                                  
                                  <c:choose>
                                      <c:when test="${upcomingInterviews > 0}">
                                          <div class="mt-6 p-4 bg-white border border-gray-100 rounded-2xl text-left max-w-md mx-auto flex items-start gap-4">
                                              <div class="w-10 h-10 bg-primary/5 text-primary rounded-xl flex items-center justify-center shrink-0">
                                                  <i class="fa-solid fa-calendar-check"></i>
                                              </div>
                                              <div>
                                                  <h4 class="text-xs font-black text-dark">Technical Screening</h4>
                                                  <p class="text-[0.65rem] font-bold text-gray-400 mt-0.5">Software Engineering Role</p>
                                                  <p class="text-[0.65rem] font-black text-primary mt-2 uppercase tracking-wide"><i class="fa-solid fa-clock mr-1"></i> Tomorrow, 3:00 PM</p>
                                              </div>
                                          </div>
                                      </c:when>
                                      <c:otherwise>
                                          <p class="text-xs text-gray-400 mt-4 leading-relaxed">Schedule mock interviews or respond to recruiter requests in the messages panel to book your first interview!</p>
                                      </c:otherwise>
                                  </c:choose>
                              </div>
                          </div>

                          <!-- 3. Views Content -->
                          <div id="tab-content-views" class="stats-tab-content space-y-6 hidden">
                              <div class="grid grid-cols-2 gap-4">
                                  <div class="bg-surface p-5 rounded-2xl border border-gray-50 flex items-center gap-4">
                                      <div class="w-10 h-10 bg-primary/10 text-primary rounded-xl flex items-center justify-center shrink-0 text-lg">
                                          <i class="fa-solid fa-eye"></i>
                                      </div>
                                      <div>
                                          <p class="text-2xl font-black text-dark">${profileViews}</p>
                                          <p class="text-[0.55rem] font-black text-gray-400 uppercase tracking-wider">Total Profile Views</p>
                                      </div>
                                  </div>
                                  <div class="bg-surface p-5 rounded-2xl border border-gray-50 flex items-center gap-4">
                                      <div class="w-10 h-10 bg-accent/10 text-accent rounded-xl flex items-center justify-center shrink-0 text-lg">
                                          <i class="fa-solid fa-arrow-trend-up"></i>
                                      </div>
                                      <div>
                                          <p class="text-2xl font-black text-dark">+14%</p>
                                          <p class="text-[0.55rem] font-black text-gray-400 uppercase tracking-wider">Weekly Growth</p>
                                      </div>
                                  </div>
                              </div>

                              <div class="space-y-3">
                                  <h4 class="text-xs font-black text-dark uppercase tracking-wider">Viewer Distribution</h4>
                                  <div class="space-y-3">
                                      <div class="flex items-center justify-between text-xs font-bold text-gray-500 bg-surface p-3 rounded-xl">
                                          <div class="flex items-center gap-3">
                                              <span class="w-2.5 h-2.5 bg-primary rounded-full"></span>
                                              <span>Tech Recruiters</span>
                                          </div>
                                          <span>65%</span>
                                      </div>
                                      <div class="flex items-center justify-between text-xs font-bold text-gray-500 bg-surface p-3 rounded-xl">
                                          <div class="flex items-center gap-3">
                                              <span class="w-2.5 h-2.5 bg-accent rounded-full"></span>
                                              <span>Engineering Leads</span>
                                          </div>
                                          <span>25%</span>
                                      </div>
                                      <div class="flex items-center justify-between text-xs font-bold text-gray-500 bg-surface p-3 rounded-xl">
                                          <div class="flex items-center gap-3">
                                              <span class="w-2.5 h-2.5 bg-blue-500 rounded-full"></span>
                                              <span>Other Job Seekers</span>
                                          </div>
                                          <span>10%</span>
                                      </div>
                                  </div>
                              </div>
                          </div>

                          <!-- 4. Saved Content -->
                          <div id="tab-content-saved" class="stats-tab-content space-y-6 hidden">
                              <div class="p-8 text-center bg-surface rounded-3xl border border-dashed border-gray-200">
                                  <div class="w-14 h-14 bg-blue-50 text-blue-500 rounded-full flex items-center justify-center mx-auto mb-4">
                                      <i class="fa-solid fa-bookmark text-2xl"></i>
                                  </div>
                                  <h3 class="text-sm font-black text-dark uppercase tracking-wider">Saved Job Openings</h3>
                                  <p class="text-xs text-gray-400 italic mt-2">You currently have <span class="font-bold text-primary">${savedJobs}</span> saved job listings.</p>
                                  <a href="${pageContext.request.contextPath}/job-market" class="inline-block mt-6 px-6 py-3 bg-primary text-white rounded-xl text-xs font-black shadow-lg shadow-primary/20 hover:scale-105 transition-all">
                                      Browse Job Market
                                  </a>
                              </div>
                          </div>
                      </div>
                  </div>

                  <style>
                      .progress-container {
                          width: 100%;
                          background-color: #f3f4f6;
                          border-radius: 9999px;
                          height: 6px;
                          overflow: hidden;
                      }
                      .progress-bar {
                          height: 100%;
                          background-color: #1D3E35;
                          border-radius: 9999px;
                          transition: width 0.5s ease-in-out;
                      }
                  </style>

                  <script>
                      function openStatsModal(initialTab = 'apps') {
                          const modal = document.getElementById('statsModal');
                          const content = document.getElementById('statsModalContent');
                          if (!modal) return;

                          modal.classList.remove('hidden');
                          // Trigger reflow
                          void modal.offsetWidth;

                          modal.classList.remove('opacity-0');
                          modal.classList.add('flex');
                          if (content) {
                              content.classList.remove('scale-95');
                              content.classList.add('scale-100');
                          }
                          
                          switchStatsTab(initialTab);
                      }

                      function closeStatsModal() {
                          const modal = document.getElementById('statsModal');
                          const content = document.getElementById('statsModalContent');
                          if (!modal) return;

                          modal.classList.add('opacity-0');
                          if (content) {
                              content.classList.add('scale-95');
                              content.classList.remove('scale-100');
                          }

                          setTimeout(() => {
                              modal.classList.add('hidden');
                              modal.classList.remove('flex');
                          }, 300);
                      }

                      function switchStatsTab(tabId) {
                          // Hide all contents
                          document.querySelectorAll('.stats-tab-content').forEach(el => {
                              el.classList.add('hidden');
                          });

                          // Deactivate all button styles
                          const activeClass = ['bg-primary', 'text-white'];
                          const inactiveClass = ['text-gray-400', 'hover:bg-gray-50'];

                          ['apps', 'interviews', 'views', 'saved'].forEach(id => {
                              const btn = document.getElementById('tab-btn-' + id);
                              if (btn) {
                                  activeClass.forEach(c => btn.classList.remove(c));
                                  inactiveClass.forEach(c => btn.classList.remove(c));
                                  
                                  if (id === tabId) {
                                      activeClass.forEach(c => btn.classList.add(c));
                                  } else {
                                      inactiveClass.forEach(c => btn.classList.add(c));
                                  }
                              }
                          });

                          // Show selected content
                          const targetContent = document.getElementById('tab-content-' + tabId);
                          if (targetContent) {
                              targetContent.classList.remove('hidden');
                          }
                      }
                  </script>
         </html>