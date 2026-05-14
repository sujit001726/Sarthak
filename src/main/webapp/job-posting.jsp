<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sarthak | ${formTitle}</title>
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

                .glass-card {
                    background: rgba(255, 255, 255, 0.9);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                }

                .form-input {
                    transition: all 0.2s ease;
                    border: 1px solid #E5E7EB;
                }

                .form-input:focus {
                    border-color: #1D3E35;
                    box-shadow: 0 0 0 4px rgba(29, 62, 53, 0.1);
                    outline: none;
                }

                .label-style {
                    font-size: 0.75rem;
                    font-weight: 800;
                    color: #1D3E35;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    margin-bottom: 0.5rem;
                    display: block;
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
                                        class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                                        <i class="fa-solid fa-plus-circle w-5 text-accent"></i>
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

                        <main class="max-w-5xl mx-auto px-6 py-12 w-full flex-1">
                            <!-- Navigation Breadcrumb -->
                            <div class="flex items-center gap-2 mb-8 text-[0.7rem] font-bold text-gray-400 uppercase tracking-widest">
                                <a href="${pageContext.request.contextPath}/employer/dashboard" class="hover:text-primary transition-colors">Dashboard</a>
                                <i class="fa-solid fa-chevron-right text-[0.5rem]"></i>
                                <span class="text-primary italic">${formTitle}</span>
                            </div>

                            <div class="flex flex-col gap-8">
                                <div class="flex items-end justify-between">
                                    <div>
                                        <h1 class="text-4xl font-black text-primary italic leading-none tracking-tighter">${formTitle}</h1>
                                        <p class="text-sm font-bold text-gray-400 mt-2">Design your next high-impact role at Sarthak</p>
                                    </div>
                                    <div class="hidden md:flex items-center gap-4 text-right">
                                        <div class="w-12 h-12 rounded-2xl bg-white border border-gray-100 flex items-center justify-center text-primary shadow-sm">
                                            <i class="fa-solid fa-feather-pointed text-xl"></i>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${not empty databaseError}">
                                    <div class="bg-red-50 border border-red-200 p-4 rounded-2xl flex items-center gap-4">
                                        <i class="fa-solid fa-circle-exclamation text-red-500"></i>
                                        <p class="text-sm font-bold text-red-800">${databaseError}</p>
                                    </div>
                                </c:if>

                                <form action="${formAction}" method="POST" class="glass-card rounded-[2.5rem] p-10 shadow-2xl shadow-primary/5 border border-white">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                        <!-- Form contents... (I will keep them but fix the nesting) -->
                                        <div class="flex flex-col gap-6 md:col-span-2">
                                            <div>
                                                <label class="label-style">Job Title</label>
                                                <input type="text" name="title" value="${job.title}" required placeholder="e.g. Senior Frontend Engineer" class="form-input w-full p-4 rounded-2xl text-sm font-semibold bg-white/50">
                                            </div>
                                            <div>
                                                <label class="label-style">Detailed Description</label>
                                                <textarea name="description" required rows="6" placeholder="Outline the responsibilities, requirements, and benefits..." class="form-input w-full p-4 rounded-2xl text-sm font-semibold bg-white/50 resize-none">${job.description}</textarea>
                                            </div>
                                        </div>
                                        <div class="flex flex-col gap-6">
                                            <div>
                                                <label class="label-style">Location</label>
                                                <div class="relative">
                                                    <i class="fa-solid fa-location-dot absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                                                    <input type="text" name="location" value="${job.location}" required placeholder="e.g. Remote, Kathmandu" class="form-input w-full pl-10 pr-4 py-4 rounded-2xl text-sm font-semibold bg-white/50">
                                                </div>
                                            </div>
                                            <div>
                                                <label class="label-style">Salary Range (Monthly)</label>
                                                <div class="relative">
                                                    <i class="fa-solid fa-money-bill-wave absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                                                    <input type="text" name="salaryRange" value="${job.salaryRange}" placeholder="e.g. 50k - 80k" class="form-input w-full pl-10 pr-4 py-4 rounded-2xl text-sm font-semibold bg-white/50">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="flex flex-col gap-6">
                                            <div class="grid grid-cols-2 gap-4">
                                                <div>
                                                    <label class="label-style">Job Type</label>
                                                    <select name="jobType" required class="form-input w-full p-4 rounded-2xl text-sm font-bold bg-white/50 appearance-none">
                                                        <option value="full-time" ${job.jobType=='full-time' ? 'selected' : ''}>Full-time</option>
                                                        <option value="part-time" ${job.jobType=='part-time' ? 'selected' : ''}>Part-time</option>
                                                        <option value="contract" ${job.jobType=='contract' ? 'selected' : ''}>Contract</option>
                                                        <option value="internship" ${job.jobType=='internship' ? 'selected' : ''}>Internship</option>
                                                    </select>
                                                </div>
                                                <div>
                                                    <label class="label-style">Status</label>
                                                    <select name="status" required class="form-input w-full p-4 rounded-2xl text-sm font-bold bg-white/50 appearance-none">
                                                        <option value="active" ${job.status=='active' ? 'selected' : ''}>Active</option>
                                                        <option value="draft" ${job.status=='draft' ? 'selected' : ''}>Draft</option>
                                                        <option value="closed" ${job.status=='closed' ? 'selected' : ''}>Closed</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div>
                                                <label class="label-style">Application Deadline</label>
                                                <input type="date" name="deadline" value="${job.deadline}" required class="form-input w-full p-4 rounded-2xl text-sm font-bold bg-white/50">
                                            </div>
                                        </div>
                                        <div class="md:col-span-2 pt-8 border-t border-gray-100 flex items-center justify-between gap-4 mt-4">
                                            <a href="${pageContext.request.contextPath}/employer/dashboard" class="px-8 py-4 rounded-2xl text-[0.7rem] font-black text-gray-400 hover:text-primary transition-all flex items-center gap-2 uppercase tracking-widest">
                                                <i class="fa-solid fa-xmark"></i> Cancel
                                            </a>
                                            <button type="submit" class="bg-primary text-white px-12 py-4 rounded-2xl text-[0.75rem] font-black shadow-xl shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all flex items-center gap-3">
                                                <i class="fa-solid fa-paper-plane"></i> ${submitLabel}
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </main>

                        <div class="bg-[#1D3E35] pb-20">
                            <!-- Global Footer (Inside scrollable region) -->
                            <%@ include file="/includes/footer.jsp" %>
                        </div>
                    </div>
                </div>

        </body>

        </html>