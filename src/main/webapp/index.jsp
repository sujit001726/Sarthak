<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Job Portal — Find the right job you deserve.">
    <title>Nepal's Job Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1D3E35',
                        secondary: '#4E7A6E',
                        accent: '#4E7A6E',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style>
        .category-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); cursor: pointer; }
        .category-card:hover { border-color: #1D3E35; }
        .category-card.active { background: #1D3E35 !important; border-color: #1D3E35 !important; }
        .category-card.active h3 { color: white !important; }
        .category-card.active p { color: rgba(255,255,255,0.6) !important; }
        .category-card.active .cat-icon { background: rgba(255,255,255,0.1) !important; }
        .category-card.active .cat-icon svg { stroke: white !important; }

        .job-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); border: 1px solid #f1f1f1; }
        .job-card:hover { border-color: #1D3E35; background-color: #f0f7f4; transform: translateY(-5px); box-shadow: 0 15px 30px rgba(29,62,53,0.05); }

        .testimonial-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); background-color: #f0f7f4; border: 1px solid rgba(29,62,53,0.05); }
        .testimonial-card:hover { transform: translateY(-10px); box-shadow: 0 30px 60px rgba(29,62,53,0.1); background-color: #e6f2ed; border-color: #1D3E35; }
        .testimonial-card:hover p, .testimonial-card:hover h4 { color: #0f1a17 !important; }
        .testimonial-card:hover .text-primary { color: #1D3E35 !important; }
        .testimonial-card:hover .text-gray-400, .testimonial-card:hover .text-gray-600 { color: #4E7A6E !important; }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        .testimonial-card { animation: float 6s ease-in-out infinite; }
        .testimonial-card:nth-child(2) { animation-delay: 1s; animation-duration: 7s; }
        .testimonial-card:nth-child(3) { animation-delay: 2s; animation-duration: 5s; }
        .testimonial-card:hover { animation-play-state: paused; }

        .glass-panel { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1); }
        .bg-mesh { background-image: radial-gradient(at 0% 0%, rgba(78, 122, 110, 0.05) 0px, transparent 50%), radial-gradient(at 100% 100%, rgba(29, 62, 53, 0.05) 0px, transparent 50%); }
    </style>
</head>
<body class="text-[#1a1a1a] relative min-h-screen">
    <!-- Page Background Layer -->
    <div class="fixed inset-0 z-[-1] bg-[#f0f7f4]/60"></div>

    <div class="flex flex-col min-h-screen relative z-10">

    <%@ include file="/includes/header.jsp" %>

    <main class="flex-1">

        <!-- ===== HERO SECTION (Centered) ===== -->
        <section class="py-20 lg:py-32 px-8 relative overflow-hidden bg-primary">
            <!-- Premium Choice Hero Image -->
            <div class="absolute inset-0 z-0 opacity-60" style="background-image: url('${pageContext.request.contextPath}/images/hero-job-portal.png'); background-size: cover; background-position: center;"></div>
            <!-- Dynamic Emerald Gradient Overlay -->
            <div class="absolute inset-0 z-0 bg-gradient-to-b from-primary/90 via-primary/30 to-primary/95"></div>
            
            <div class="max-w-[1280px] mx-auto text-center relative z-10">
                <h1 class="text-[2.5rem] lg:text-[3.8rem] font-black leading-[1.1] text-white mb-6 tracking-tight">
                    Get The <span class="text-[#4ade80] drop-shadow-[0_5px_15px_rgba(74,222,128,0.3)]">Right Job</span><br>
                    You Deserve
                </h1>
                <p class="text-gray-200 text-base lg:text-lg mb-10 max-w-[600px] mx-auto font-medium">
                    1,80,370 jobs listed here! Your dream job is waiting.
                </p>

                <!-- Floating Search Bar -->
                <form action="${pageContext.request.contextPath}/job-market" method="GET" class="max-w-[650px] mx-auto bg-white rounded-2xl shadow-[0_15px_50px_rgba(29,62,53,0.06)] p-1 flex flex-col md:flex-row gap-1 border border-gray-50">
                    <div class="flex items-center gap-2.5 flex-1 px-3 py-2.5">
                        <svg class="text-gray-300" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                        <input type="text" name="q" placeholder="Job title or keyword" class="w-full text-[0.88rem] font-medium outline-none placeholder:text-gray-300">
                    </div>
                    <div class="hidden md:block w-px bg-gray-100 self-stretch my-2"></div>
                    <div class="flex items-center gap-2.5 flex-1 px-3 py-2.5">
                        <svg class="text-gray-300" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                        <input type="text" placeholder="Location (optional)" class="w-full text-[0.88rem] font-medium outline-none placeholder:text-gray-300">
                    </div>
                    <button type="submit" class="bg-primary hover:bg-secondary text-white font-bold px-6 md:px-8 py-2.5 rounded-xl text-[0.88rem] transition-all duration-300 shadow-lg shadow-primary/20">
                        Search
                    </button>
                </form>

            </div>
        </section>

        <!-- ===== CATEGORIES SECTION ===== -->
        <section class="py-20 bg-white bg-mesh relative overflow-hidden">
            <div class="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-gray-100 to-transparent"></div>
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16 text-center">
                <h2 class="text-[2.2rem] lg:text-[2.8rem] font-black text-[#0f1a17] mb-14">
                    One Platform<br>
                    Many <span class="text-secondary">Solutions</span>
                </h2>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Card 1 -->
                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-pink-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ec4899" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Marketing &<br>Communication</h3>
                            <p class="text-xs text-gray-400 mt-1">156 Jobs Available</p>
                        </div>
                    </div>

                    <!-- Card 2 -->
                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-blue-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#3b82f6" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Design &<br>Development</h3>
                            <p class="text-xs text-gray-400 mt-1">412 Jobs Available</p>
                        </div>
                    </div>

                    <!-- Card 3 -->
                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-indigo-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#6366f1" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Human Research &<br>Development</h3>
                            <p class="text-xs text-gray-400 mt-1">120 Jobs Available</p>
                        </div>
                    </div>

                    <!-- Card 4 -->
                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-orange-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#f97316" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"/><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Finance<br>Management</h3>
                            <p class="text-xs text-gray-400 mt-1">85 Jobs Available</p>
                        </div>
                    </div>

                    <!-- Row 2 -->
                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-purple-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#a855f7" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Project<br>Management</h3>
                            <p class="text-xs text-gray-400 mt-1">94 Jobs Available</p>
                        </div>
                    </div>

                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-green-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Customer<br>Support Care</h3>
                            <p class="text-xs text-gray-400 mt-1">210 Jobs Available</p>
                        </div>
                    </div>

                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-red-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Business &<br>Consulting</h3>
                            <p class="text-xs text-gray-400 mt-1">67 Jobs Available</p>
                        </div>
                    </div>

                    <div class="category-card bg-white p-8 rounded-2xl shadow-[0_8px_30px_rgba(0,0,0,0.03)] border border-gray-50 flex items-center gap-5 text-left" onclick="selectCategory(this)">
                        <div class="cat-icon w-14 h-14 bg-yellow-50 rounded-xl flex items-center justify-center shrink-0">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#eab308" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        </div>
                        <div>
                            <h3 class="font-bold text-[#0f1a17] text-[1.05rem]">Government<br>Jobs</h3>
                            <p class="text-xs text-gray-400 mt-1">45 Jobs Available</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== WHY CHOOSE US SECTION ===== -->
        <section class="py-24 bg-white">
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16">
                <div class="flex flex-col lg:flex-row items-center gap-16">
                    <div class="lg:w-1/2">
                        <div class="inline-block px-4 py-1.5 bg-primary/5 text-primary text-xs font-bold uppercase tracking-widest rounded-full mb-6">Our Advantages</div>
                        <h2 class="text-[2.2rem] lg:text-[3rem] font-black text-[#0f1a17] leading-tight mb-8">
                            We Help You To Find<br>
                            Your <span class="text-secondary">Dream Job</span>
                        </h2>
                        <div class="space-y-8">
                            <div class="flex gap-6">
                                <div class="w-14 h-14 rounded-2xl bg-primary flex items-center justify-center shrink-0 shadow-lg shadow-primary/20">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><path d="M22 4L12 14.01l-3-3"/></svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-bold text-[#0f1a17] mb-2">Verified Jobs Only</h4>
                                    <p class="text-gray-500 text-sm leading-relaxed">Every job post goes through a strict verification process to ensure your safety and security.</p>
                                </div>
                            </div>
                            <div class="flex gap-6">
                                <div class="w-14 h-14 rounded-2xl bg-secondary flex items-center justify-center shrink-0 shadow-lg shadow-secondary/20">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-bold text-[#0f1a17] mb-2">Quick Application</h4>
                                    <p class="text-gray-500 text-sm leading-relaxed">Apply to multiple jobs with a single click using our standardized resume builder.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="lg:w-1/2 relative">
                        <div class="absolute -top-10 -right-10 w-64 h-64 bg-primary/5 rounded-full blur-3xl"></div>
                        <div class="relative bg-gray-50 rounded-[2.5rem] p-4 border border-gray-100 shadow-2xl">
                            <img src="${pageContext.request.contextPath}/images/hero-job-portal.png" alt="Job Portal Advantages" class="rounded-[2rem] w-full h-[400px] object-cover">
                            <div class="absolute -bottom-6 -left-6 bg-white p-6 rounded-3xl shadow-xl border border-gray-50 flex items-center gap-4 animate-float">
                                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center text-white">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M20 6L9 17l-5-5"/></svg>
                                </div>
                                <div>
                                    <div class="text-2xl font-black text-[#0f1a17]">100k+</div>
                                    <div class="text-xs text-gray-400 font-bold uppercase">Success Hires</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== STATS SECTION ===== -->
        <section class="py-16 bg-[#1D3E35]">
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16">
                <div class="grid grid-cols-2 lg:grid-cols-4 gap-8 text-center">
                    <div>
                        <div class="text-[2.5rem] font-black text-white mb-1">10k+</div>
                        <div class="text-white/60 text-sm font-medium uppercase tracking-widest">Active Jobs</div>
                    </div>
                    <div>
                        <div class="text-[2.5rem] font-black text-white mb-1">5k+</div>
                        <div class="text-white/60 text-sm font-medium uppercase tracking-widest">Companies</div>
                    </div>
                    <div>
                        <div class="text-[2.5rem] font-black text-white mb-1">20k+</div>
                        <div class="text-white/60 text-sm font-medium uppercase tracking-widest">Job Seekers</div>
                    </div>
                    <div>
                        <div class="text-[2.5rem] font-black text-white mb-1">98%</div>
                        <div class="text-white/60 text-sm font-medium uppercase tracking-widest">Success Rate</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== FEATURED JOBS SECTION ===== -->
        <section class="py-24 relative overflow-hidden">
            <!-- Background Image with Light Greenish Tint -->
            <div class="absolute inset-0 z-0 opacity-5" style="background-image: url('${pageContext.request.contextPath}/images/hero-bg.png'); background-size: cover; background-position: center;"></div>
            <div class="absolute inset-0 z-0 bg-[#fcfdfd]/90"></div>
            
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16 text-center relative z-10">
                <h2 class="text-[2.2rem] lg:text-[2.8rem] font-black text-[#0f1a17] mb-14">
                    Featured <span class="text-secondary">Job Circulars</span>
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Job Card 1 -->
                    <div class="job-card bg-white p-8 rounded-3xl text-left">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-12 h-12 bg-gray-50 rounded-xl flex items-center justify-center overflow-hidden border border-gray-100">
                                <img src="https://img.icons8.com/color/48/microsoft.png" class="w-6 h-6" alt="Microsoft">
                            </div>
                            <div>
                                <div class="flex items-center gap-2">
                                    <h4 class="font-bold text-gray-800 text-sm">Microsoft</h4>
                                    <span class="px-2 py-0.5 bg-blue-50 text-blue-500 text-[0.6rem] font-bold rounded-full border border-blue-100 flex items-center gap-1">
                                        <svg width="8" height="8" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                                        Verified
                                    </span>
                                </div>
                                <p class="text-gray-400 text-[0.7rem]">New York, USA</p>
                            </div>
                        </div>
                        <h3 class="font-black text-[#0f1a17] text-lg mb-2">Visual Designer</h3>
                        <p class="text-secondary text-[0.7rem] font-bold uppercase tracking-wider mb-4">Full Time</p>
                        <p class="text-gray-400 text-xs leading-relaxed mb-8">
                            You will be expected to lead the company's entire UI strategy and...
                        </p>
                        <div class="flex items-center justify-between">
                            <span class="font-black text-gray-800">$2500<span class="text-gray-400 font-normal text-xs">/mo</span></span>
                            <button class="bg-gray-50 hover:bg-primary hover:text-white text-primary text-xs font-bold px-5 py-2.5 rounded-lg transition-all">Apply Now</button>
                        </div>
                    </div>

                    <!-- Job Card 2 -->
                    <div class="job-card bg-white p-8 rounded-3xl text-left">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-12 h-12 bg-gray-50 rounded-xl flex items-center justify-center overflow-hidden border border-gray-100">
                                <img src="https://img.icons8.com/color/48/behance.png" class="w-6 h-6" alt="Behance">
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-sm">Behance</h4>
                                <p class="text-gray-400 text-[0.7rem]">Remote</p>
                            </div>
                        </div>
                        <h3 class="font-black text-[#0f1a17] text-lg mb-2">Senior UI Designer</h3>
                        <p class="text-secondary text-[0.7rem] font-bold uppercase tracking-wider mb-4">Full Time</p>
                        <p class="text-gray-400 text-xs leading-relaxed mb-8">
                            You will be expected to lead the company's entire UI strategy and...
                        </p>
                        <div class="flex items-center justify-between">
                            <span class="font-black text-gray-800">$3200<span class="text-gray-400 font-normal text-xs">/mo</span></span>
                            <button class="bg-gray-50 hover:bg-primary hover:text-white text-primary text-xs font-bold px-5 py-2.5 rounded-lg transition-all">Apply Now</button>
                        </div>
                    </div>

                    <!-- Job Card 3 -->
                    <div class="job-card bg-white p-8 rounded-3xl text-left">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-12 h-12 bg-gray-50 rounded-xl flex items-center justify-center overflow-hidden border border-gray-100">
                                <img src="https://img.icons8.com/color/48/gmail-new.png" class="w-6 h-6" alt="Daily Mail">
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-sm">Daily Mail</h4>
                                <p class="text-gray-400 text-[0.7rem]">South Asia, UAE</p>
                            </div>
                        </div>
                        <h3 class="font-black text-[#0f1a17] text-lg mb-2">Mail Convertor</h3>
                        <p class="text-secondary text-[0.7rem] font-bold uppercase tracking-wider mb-4">Full Time</p>
                        <p class="text-gray-400 text-xs leading-relaxed mb-8">
                            You will be expected to lead the company's entire UI strategy and...
                        </p>
                        <div class="flex items-center justify-between">
                            <span class="font-black text-gray-800">$2800<span class="text-gray-400 font-normal text-xs">/mo</span></span>
                            <button class="bg-gray-50 hover:bg-primary hover:text-white text-primary text-xs font-bold px-5 py-2.5 rounded-lg transition-all">Apply Now</button>
                        </div>
                    </div>

                    <!-- Job Card 4 -->
                    <div class="job-card bg-white p-8 rounded-3xl text-left">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-12 h-12 bg-gray-50 rounded-xl flex items-center justify-center overflow-hidden border border-gray-100">
                                <img src="https://img.icons8.com/color/48/etsy.png" class="w-6 h-6" alt="Etsy">
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-sm">Etsy</h4>
                                <p class="text-gray-400 text-[0.7rem]">Remote</p>
                            </div>
                        </div>
                        <h3 class="font-black text-[#0f1a17] text-lg mb-2">Marketing Officer</h3>
                        <p class="text-secondary text-[0.7rem] font-bold uppercase tracking-wider mb-4">Full Time</p>
                        <p class="text-gray-400 text-xs leading-relaxed mb-8">
                            You will be expected to lead the company's entire UI strategy and...
                        </p>
                        <div class="flex items-center justify-between">
                            <span class="font-black text-gray-800">$2500<span class="text-gray-400 font-normal text-xs">/mo</span></span>
                            <button class="bg-gray-50 hover:bg-primary hover:text-white text-primary text-xs font-bold px-5 py-2.5 rounded-lg transition-all">Apply Now</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== EMPLOYER PROMO SECTION ===== -->
        <section class="py-16">
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16">
                <div class="bg-primary rounded-[3rem] p-8 lg:p-16 relative overflow-hidden shadow-2xl">
                    <div class="absolute top-0 right-0 w-[400px] h-[400px] bg-secondary/10 rounded-full blur-[100px] -mr-32 -mt-32"></div>
                    <div class="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-10">
                        <div class="lg:w-2/3">
                            <h2 class="text-[2rem] lg:text-[2.8rem] font-black text-white leading-tight mb-6">
                                Looking to hire the<br>
                                <span class="text-[#4ade80]">best talent in Nepal?</span>
                            </h2>
                            <p class="text-white/70 text-lg mb-10 max-w-[500px]">
                                Join thousands of top companies and find your next star employee today.
                            </p>
                            <div class="flex flex-wrap gap-4">
                                <a href="${pageContext.request.contextPath}/register-employer.jsp" class="bg-white text-primary px-10 py-4 rounded-2xl font-black hover:bg-secondary hover:text-white transition-all shadow-xl shadow-black/10">Post a Job Now</a>
                                <a href="#" class="border-2 border-white/20 text-white px-10 py-4 rounded-2xl font-black hover:bg-white/10 transition-all">Learn More</a>
                            </div>
                        </div>
                        <div class="hidden lg:block lg:w-1/3">
                            <div class="relative">
                                <div class="absolute inset-0 bg-secondary/20 blur-3xl rounded-full"></div>
                                <img src="${pageContext.request.contextPath}/images/auth-side.png" alt="Hire Talent" class="relative rounded-3xl w-full h-[300px] object-cover border-4 border-white/10 rotate-3 hover:rotate-0 transition-transform duration-500 shadow-2xl">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== TESTIMONIALS SECTION ===== -->
        <section class="py-24 bg-[#fcfdfd] relative">
            <div class="max-w-[1280px] mx-auto px-8 lg:px-16 text-center">
                <h2 class="text-[2.2rem] lg:text-[2.8rem] font-black text-[#0f1a17] mb-14">
                    What Our <span class="text-secondary">Users Say</span>
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <!-- Testimonial 1 -->
                    <div class="testimonial-card p-10 rounded-3xl text-left relative">
                        <div class="text-primary mb-6">
                            <svg width="40" height="40" viewBox="0 0 24 24" fill="currentColor"><path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z"/></svg>
                        </div>
                        <p class="text-gray-600 text-lg leading-relaxed mb-8 italic">
                            "The best job portal in Nepal. The application process is seamless and the interface is beautiful."
                        </p>
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full bg-secondary/20 flex items-center justify-center font-bold text-secondary">SK</div>
                            <div>
                                <h4 class="font-bold text-[#0f1a17]">Sandesh Khadka</h4>
                                <p class="text-xs text-gray-400">Backend Developer</p>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonial 3 -->
                    <div class="testimonial-card p-10 rounded-3xl text-left relative">
                        <div class="text-primary mb-6">
                            <svg width="40" height="40" viewBox="0 0 24 24" fill="currentColor"><path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z"/></svg>
                        </div>
                        <p class="text-gray-600 text-lg leading-relaxed mb-8 italic">
                            "As an employer, this platform made it incredibly easy to find top-tier candidates for our new office."
                        </p>
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full bg-accent/20 flex items-center justify-center font-bold text-accent">SM</div>
                            <div>
                                <h4 class="font-bold text-[#0f1a17]">Sita Magar</h4>
                                <p class="text-xs text-gray-400">HR Manager</p>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonial 2 -->
                    <div class="testimonial-card p-10 rounded-3xl text-left relative">
                        <div class="text-primary mb-6">
                            <svg width="40" height="40" viewBox="0 0 24 24" fill="currentColor"><path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z"/></svg>
                        </div>
                        <p class="text-gray-600 text-lg leading-relaxed mb-8 italic">
                            "The interface is so intuitive and the support is amazing. Found a great job in no time!"
                        </p>
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full bg-accent/20 flex items-center justify-center font-bold text-accent">AN</div>
                            <div>
                                <h4 class="font-bold text-[#0f1a17]">Aakriti Nepal</h4>
                                <p class="text-xs text-gray-400">Software Engineer</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>



    </main>

    <%@ include file="/includes/footer.jsp" %>
</div>
    <script>
        function selectCategory(card) {
            document.querySelectorAll('.category-card').forEach(function(c) {
                c.classList.remove('active');
            });
            card.classList.add('active');
            var categoryName = card.querySelector('h3').innerText.replace(/\n/g, ' ');
            window.location.href = "${pageContext.request.contextPath}/job-market?q=" + encodeURIComponent(categoryName);
        }

    </script>
</body>
</html>

<!-- commit iteration 1: Set up basic layout for index page -->

<!-- commit iteration 6: Implement AuthFilter for page protection -->
