<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Billing & Plans</title>
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
        .plan-card { transition: all 0.3s ease; border: 2px solid transparent; }
        .plan-card:hover { transform: translateY(-4px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); }
        .plan-card.active { border-color: #22c55e; }
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
                        <a href="${pageContext.request.contextPath}/employer/company-profile.jsp" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-building w-5"></i><span>Company Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/employer/billing-plans.jsp" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-credit-card w-5 text-accent"></i><span>Billing & Plans</span>
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
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Billing & Plans</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Manage your subscription and billing details</p>
                    </div>
                </div>

                <!-- Current Plan Info -->
                <div class="bg-primary rounded-[2rem] p-8 text-white shadow-xl shadow-primary/20 relative overflow-hidden flex flex-col md:flex-row justify-between items-center gap-6">
                    <div class="absolute -right-10 -bottom-10 w-48 h-48 bg-white/5 rounded-full"></div>
                    <div class="z-10">
                        <p class="text-[0.7rem] font-black text-white/50 uppercase tracking-widest mb-1">Current Plan</p>
                        <h2 class="text-3xl font-black text-accent italic">Premium Pro</h2>
                        <p class="text-sm mt-2 font-medium">Billed annually. Next billing date: <span class="font-bold">Dec 15, 2026</span></p>
                    </div>
                    <div class="z-10 flex gap-4">
                        <button class="bg-white/10 border border-white/20 px-6 py-3 rounded-xl text-sm font-bold hover:bg-white/20 transition-all">Cancel Plan</button>
                        <button class="bg-accent text-primary px-6 py-3 rounded-xl text-sm font-bold shadow-lg hover:bg-opacity-90 transition-all">Update Payment Method</button>
                    </div>
                </div>

                <!-- Plans Grid -->
                <div>
                    <h3 class="text-lg font-black text-dark italic mb-6">Available Plans</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        <!-- Basic Plan -->
                        <div class="plan-card bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm flex flex-col">
                            <h4 class="text-xl font-black text-dark">Starter</h4>
                            <p class="text-sm text-gray-400 font-medium mt-2">For small businesses hiring occasionally.</p>
                            <div class="my-6">
                                <span class="text-4xl font-black text-dark">Free</span>
                            </div>
                            <ul class="space-y-4 mb-8 flex-1">
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> 1 Active Job Posting</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Basic Applicant Tracking</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Standard Support</li>
                            </ul>
                            <button class="w-full bg-surface text-primary py-3 rounded-xl text-sm font-bold hover:bg-primary hover:text-white transition-all">Downgrade to Starter</button>
                        </div>
                        
                        <!-- Premium Plan -->
                        <div class="plan-card active bg-white rounded-[2rem] p-8 shadow-xl shadow-accent/10 flex flex-col relative transform md:-translate-y-4">
                            <div class="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-accent text-white text-[0.6rem] font-black px-4 py-1.5 rounded-full tracking-widest uppercase">Current Plan</div>
                            <h4 class="text-xl font-black text-dark">Premium Pro</h4>
                            <p class="text-sm text-gray-400 font-medium mt-2">For growing companies actively hiring.</p>
                            <div class="my-6 flex items-baseline gap-1">
                                <span class="text-4xl font-black text-dark">रु 5000</span>
                                <span class="text-sm text-gray-400 font-bold">/mo</span>
                            </div>
                            <ul class="space-y-4 mb-8 flex-1">
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> 10 Active Job Postings</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Advanced Analytics</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Talent Search Access</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Priority Support</li>
                            </ul>
                            <button class="w-full bg-primary text-white py-3 rounded-xl text-sm font-bold cursor-default opacity-80">Current Plan</button>
                        </div>

                        <!-- Enterprise Plan -->
                        <div class="plan-card bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm flex flex-col">
                            <h4 class="text-xl font-black text-dark">Enterprise</h4>
                            <p class="text-sm text-gray-400 font-medium mt-2">Custom solutions for large organizations.</p>
                            <div class="my-6">
                                <span class="text-4xl font-black text-dark">Custom</span>
                            </div>
                            <ul class="space-y-4 mb-8 flex-1">
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Unlimited Job Postings</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Dedicated Account Manager</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> Custom Integrations</li>
                                <li class="flex items-center gap-3 text-sm font-semibold text-gray-600"><i class="fa-solid fa-check text-accent"></i> 24/7 Phone Support</li>
                            </ul>
                            <button class="w-full bg-surface text-primary py-3 rounded-xl text-sm font-bold hover:bg-primary hover:text-white transition-all">Contact Sales</button>
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
