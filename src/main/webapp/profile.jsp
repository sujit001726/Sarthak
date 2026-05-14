<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | User Profile</title>
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

        /* Profile Specific Styles */
        .cover-photo {
            height: 240px;
            background: linear-gradient(135deg, #1D3E35 0%, #4E7A6E 100%);
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .profile-pic-container {
            position: relative;
            margin-top: -80px;
            display: inline-block;
        }

        .profile-pic {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            border: 6px solid #F4F7F6;
            object-fit: cover;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .camera-overlay {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }

        .camera-overlay:hover {
            transform: scale(1.1);
            background: #E8F5F1;
        }

        /* Floating Chat Box */
        .chat-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 350px;
            background: white;
            border-radius: 20px 20px 0 0;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
        }

        .chat-widget.minimized {
            transform: translateY(calc(100% - 60px));
        }

        .chat-header {
            padding: 15px 20px;
            background: #1D3E35;
            color: white;
            border-radius: 20px 20px 0 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
        }

        .chat-messages {
            height: 350px;
            overflow-y: auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            background: #f9fafb;
        }

        .message {
            max-width: 80%;
            padding: 10px 15px;
            border-radius: 15px;
            font-size: 0.85rem;
            position: relative;
        }

        .message.sent {
            align-self: flex-end;
            background: #1D3E35;
            color: white;
            border-bottom-right-radius: 2px;
        }

        .message.received {
            align-self: flex-start;
            background: #e5e7eb;
            color: #1f2937;
            border-bottom-left-radius: 2px;
        }

        .message-time {
            font-size: 0.65rem;
            margin-top: 4px;
            opacity: 0.7;
            display: block;
        }

        .chat-input-area {
            padding: 15px;
            border-top: 1px solid #e5e7eb;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .chat-input {
            flex: 1;
            padding: 8px 15px;
            background: #f3f4f6;
            border-radius: 20px;
            font-size: 0.9rem;
            outline: none;
        }

        /* Status Dot */
        .status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            border: 2px solid white;
            position: absolute;
            bottom: 2px;
            right: 2px;
        }

        .status-online { background-color: #22c55e; }
        .status-offline { background-color: #9ca3af; }

        /* Custom UI */
        .kyc-card {
            background: white;
            border-radius: 24px;
            padding: 32px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid rgba(29, 62, 53, 0.05);
        }

        .tag-input-container {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            padding: 8px;
            background: #F4F7F6;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
        }

        .tag {
            background: #1D3E35;
            color: white;
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .tag i { cursor: pointer; opacity: 0.7; }
        .tag i:hover { opacity: 1; }

        /* Progress Bar */
        .progress-container {
            width: 100%;
            height: 8px;
            background: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #1D3E35, #22c55e);
            border-radius: 4px;
            transition: width 0.5s ease;
        }

        /* Notification Dot */
        .notif-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ef4444;
            color: white;
            font-size: 0.6rem;
            font-weight: 900;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid white;
        }
    </style>
</head>

<body class="text-gray-900 bg-surface">

    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="p-6 pb-0 px-10">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-20 w-auto brightness-0 invert opacity-90">
            </div>

            <div class="sidebar-scroll-area px-4">
                <div class="mb-10">
                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Menu</p>
                    <nav>
                        <a href="${pageContext.request.contextPath}/jobseeker/dashboard" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-grid-2 w-5"></i>
                            <span>Dashboard</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/job-market" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-compass w-5"></i>
                            <span>Job Market</span>
                        </a>
                        <a href="#" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                            <i class="fa-solid fa-user w-5"></i>
                            <span>My Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/messages" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-envelope w-5"></i>
                            <span>Messages</span>
                            <span class="ml-auto bg-accent text-primary text-[0.6rem] font-black px-1.5 py-0.5 rounded-full">2</span>
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
            </div>

            <div class="p-6 pt-8 border-t border-white/10 bg-primary">
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
                    <i class="fa-solid fa-power-off w-5"></i>
                    <span>Log Out</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="main-content-wrapper">
            <%@ include file="/includes/header.jsp" %>

            <main class="flex flex-col w-full">
                <!-- Cover & Profile Header -->
                <div class="relative w-full">
                    <div class="cover-photo" id="cover-photo-div" style="background-image: url('${coverImage}');">
                        <c:if test="${isOwnProfile}">
                            <button onclick="document.getElementById('cover-upload').click()" class="absolute top-4 right-4 bg-white/20 hover:bg-white/40 text-white px-4 py-2 rounded-xl text-xs font-bold transition-all backdrop-blur-sm">
                                <i class="fa-solid fa-camera mr-2"></i> Update Cover
                            </button>
                            <input type="file" class="hidden" id="cover-upload" accept="image/*">
                        </c:if>
                    </div>
                    
                    <div class="px-8 md:px-12">
                        <div class="flex flex-col md:flex-row md:items-end gap-6">
                            <div class="profile-pic-container">
                                <img src="${profileImage}" alt="Profile" class="profile-pic" id="profile-img-preview" onerror="this.src='https://ui-avatars.com/api/?name=${profileName}&background=1D3E35&color=fff&size=160'">
                                <c:if test="${isOwnProfile}">
                                    <div class="camera-overlay">
                                        <i class="fa-solid fa-camera text-primary"></i>
                                        <input type="file" class="hidden" id="profile-upload" accept="image/*">
                                    </div>
                                </c:if>
                                <div class="status-dot status-online w-5 h-5 border-4"></div>
                            </div>
                            
                            <div class="flex-1 pb-4">
                                <div class="flex flex-wrap items-center justify-between gap-4">
                                    <div>
                                        <h1 class="text-3xl font-black text-dark tracking-tight">${profileName}</h1>
                                        <p class="text-gray-500 font-bold italic">Senior Software Engineer &bull; Kathmandu, Nepal</p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <c:if test="${!isOwnProfile}">
                                            <c:choose>
                                                <c:when test="${friendStatus == 'received_pending'}">
                                                    <!-- Show Confirm and Reject buttons -->
                                                    <div class="flex items-center gap-2" id="friend-actions-group">
                                                        <button onclick="handleFriendAction('accept')" 
                                                            class="px-6 py-2.5 bg-accent text-white rounded-xl text-sm font-bold shadow-lg transition-all hover:scale-105 flex items-center gap-2 animate-pulse">
                                                            <i class="fa-solid fa-check"></i> Confirm
                                                        </button>
                                                        <button onclick="handleFriendAction('reject')" 
                                                            class="px-6 py-2.5 bg-red-500 text-white rounded-xl text-sm font-bold shadow-lg transition-all hover:scale-105 flex items-center gap-2">
                                                            <i class="fa-solid fa-xmark"></i> Reject
                                                        </button>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="btnText" value="Add Friend" />
                                                    <c:set var="btnIcon" value="fa-user-plus" />
                                                    <c:set var="btnClass" value="bg-primary" />
                                                    <c:set var="btnAction" value="toggle" />
                                                    
                                                    <c:choose>
                                                        <c:when test="${friendStatus == 'sent_pending'}">
                                                            <c:set var="btnText" value="Cancel Request" />
                                                            <c:set var="btnIcon" value="fa-xmark" />
                                                            <c:set var="btnClass" value="bg-red-500" />
                                                            <c:set var="btnAction" value="cancel" />
                                                        </c:when>
                                                        <c:when test="${friendStatus == 'accepted'}">
                                                            <c:set var="btnText" value="Friends" />
                                                            <c:set var="btnIcon" value="fa-user-check" />
                                                            <c:set var="btnClass" value="bg-accent" />
                                                            <c:set var="btnAction" value="none" />
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                    <button id="friend-btn" data-action="${btnAction}" onclick="toggleFriend()" 
                                                        class="px-6 py-2.5 ${btnClass} text-white rounded-xl text-sm font-bold shadow-lg transition-all hover:scale-105">
                                                        <i class="fa-solid ${btnIcon} mr-2"></i> ${btnText}
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <button onclick="toggleChat()" class="p-2.5 bg-white border border-gray-100 text-dark rounded-xl shadow-sm hover:bg-gray-50 transition-all">
                                                <i class="fa-solid fa-message"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${isOwnProfile}">
                                            <button type="button" id="edit-profile-btn" onclick="showEditProfile()" class="px-6 py-2.5 bg-primary text-white rounded-xl text-sm font-bold shadow-lg shadow-primary/20 transition-all hover:scale-105">
                                                <i class="fa-solid fa-pen-to-square mr-2"></i> <span id="edit-profile-btn-text">Edit Profile</span>
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sub Header Stats & Badge -->
                        <div class="flex flex-wrap items-center justify-between gap-6 py-6 border-b border-gray-100">
                            <div class="flex items-center gap-8">
                                <div class="text-center">
                                    <p class="text-xl font-black text-dark">2.4k</p>
                                    <p class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Followers</p>
                                </div>
                                <div class="text-center border-l border-gray-100 pl-8">
                                    <p class="text-xl font-black text-dark">482</p>
                                    <p class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Friends</p>
                                </div>
                                <div class="text-center border-l border-gray-100 pl-8">
                                    <p class="text-xl font-black text-dark">12</p>
                                    <p class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Jobs Done</p>
                                </div>
                            </div>

                            <div class="flex items-center gap-4 bg-accent/10 px-4 py-2 rounded-2xl border border-accent/20">
                                <div class="flex flex-col">
                                    <span class="text-[0.65rem] font-black text-accent uppercase tracking-wider">Availability</span>
                                    <span class="text-sm font-black text-primary">Open to Work</span>
                                </div>
                                <label class="relative inline-flex items-center cursor-pointer">
                                    <input type="checkbox" checked class="sr-only peer">
                                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-accent"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Grid Layout -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 p-8 md:p-12">
                    <!-- Left Column: KYC & Details -->
                    <div class="lg:col-span-2 flex flex-col gap-8">
                        <c:if test="${isOwnProfile}">
                            <div class="kyc-card">
                                <div class="flex flex-wrap items-start justify-between gap-4 mb-8">
                                    <div>
                                        <h2 class="text-xl font-black text-dark border-l-4 border-primary pl-4 uppercase tracking-tighter">Job Seeker Hub</h2>
                                        <p class="text-sm font-bold text-gray-400 mt-2 ml-5">Track readiness, resume status, and next application steps.</p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/jobseeker/dashboard" class="px-5 py-2.5 bg-primary text-white rounded-xl text-xs font-black shadow-lg shadow-primary/20 hover:bg-secondary transition-all">
                                        <i class="fa-solid fa-gauge-high mr-2"></i> Dashboard
                                    </a>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                                    <div class="bg-surface border border-gray-100 rounded-2xl p-5">
                                        <div class="flex items-center justify-between mb-4">
                                            <span class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Profile Strength</span>
                                            <i class="fa-solid fa-chart-line text-primary"></i>
                                        </div>
                                        <p class="text-3xl font-black text-dark leading-none">85%</p>
                                        <div class="progress-container mt-4">
                                            <div class="progress-bar" style="width: 85%"></div>
                                        </div>
                                    </div>

                                    <div class="bg-surface border border-gray-100 rounded-2xl p-5">
                                        <div class="flex items-center justify-between mb-4">
                                            <span class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Job Matches</span>
                                            <i class="fa-solid fa-bullseye text-accent"></i>
                                        </div>
                                        <p class="text-3xl font-black text-dark leading-none">24</p>
                                        <p class="text-xs font-bold text-gray-400 mt-3">New roles matching your profile</p>
                                    </div>

                                    <div class="bg-surface border border-gray-100 rounded-2xl p-5">
                                        <div class="flex items-center justify-between mb-4">
                                            <span class="text-[0.65rem] font-black text-gray-400 uppercase tracking-widest">Resume</span>
                                            <i class="fa-solid fa-file-lines text-red-500"></i>
                                        </div>
                                        <p class="text-sm font-black text-dark truncate">
                                            <c:choose>
                                                <c:when test="${not empty resumeFileName}">${resumeFileName}</c:when>
                                                <c:otherwise>Not uploaded</c:otherwise>
                                            </c:choose>
                                        </p>
                                        <button type="button" onclick="showEditProfile()" class="text-xs font-black text-primary mt-3 hover:underline">Update Resume</button>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div class="border border-primary/10 bg-primary/5 rounded-2xl p-5">
                                        <div class="flex items-start gap-4">
                                            <div class="w-11 h-11 rounded-xl bg-primary text-white flex items-center justify-center shrink-0">
                                                <i class="fa-solid fa-briefcase"></i>
                                            </div>
                                            <div>
                                                <p class="text-sm font-black text-dark">Recommended Next Step</p>
                                                <p class="text-xs font-bold text-gray-500 mt-1 leading-relaxed">Add 3 more skills and keep your resume current to improve employer matching.</p>
                                                <button type="button" onclick="showEditProfile()" class="inline-flex items-center mt-4 text-xs font-black text-primary hover:underline">
                                                    Improve Profile <i class="fa-solid fa-arrow-right ml-2"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="border border-accent/20 bg-accent/10 rounded-2xl p-5">
                                        <div class="flex items-start gap-4">
                                            <div class="w-11 h-11 rounded-xl bg-accent text-white flex items-center justify-center shrink-0">
                                                <i class="fa-solid fa-bell"></i>
                                            </div>
                                            <div>
                                                <p class="text-sm font-black text-dark">Application Reminder</p>
                                                <p class="text-xs font-bold text-gray-500 mt-1 leading-relaxed">Review fresh openings today and apply while your profile is marked open to work.</p>
                                                <a href="${pageContext.request.contextPath}/index.jsp" class="inline-flex items-center mt-4 text-xs font-black text-primary hover:underline">
                                                    Browse Jobs <i class="fa-solid fa-arrow-right ml-2"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <div class="kyc-card ${isOwnProfile ? 'hidden' : ''}" id="profile-details-card">
                            <div class="flex items-center justify-between mb-8">
                                <h2 class="text-xl font-black text-dark border-l-4 border-primary pl-4 uppercase tracking-tighter">${isOwnProfile ? 'Profile Details / KYC' : 'Profile Information'}</h2>
                                <div class="flex flex-col items-end">
                                    <span class="text-[0.65rem] font-black text-gray-400 uppercase mb-1">Completion 85%</span>
                                    <div class="progress-container w-32">
                                        <div class="progress-bar" style="width: 85%"></div>
                                    </div>
                                </div>
                            </div>

                            <form id="profileForm" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Full Name</label>
                                    <input type="text" name="fullName" value="${profileName}" ${isOwnProfile ? '' : 'disabled'} class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all disabled:opacity-70">
                                </div>
                                <c:if test="${isOwnProfile}">
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase">Date of Birth</label>
                                        <input type="date" name="dob" value="${dob}" class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all">
                                    </div>
                                </c:if>
                                <div class="space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Gender</label>
                                    <select name="gender" ${isOwnProfile ? '' : 'disabled'} class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all disabled:opacity-70">
                                        <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <c:if test="${isOwnProfile}">
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase">Phone Number</label>
                                        <input type="tel" name="phone" value="${phone}" class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all">
                                    </div>
                                    <div class="md:col-span-2 space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase">Email Address</label>
                                        <input type="email" name="email" value="${profileEmail}" class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase">National ID / Passport</label>
                                        <input type="text" name="nationalId" value="${nationalId}" placeholder="123-456-789" class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all">
                                    </div>
                                </c:if>
                                <div class="space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Employment Type</label>
                                    <select name="employmentType" ${isOwnProfile ? '' : 'disabled'} class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all disabled:opacity-70">
                                        <option value="Job Seeker" ${employmentType == 'Job Seeker' ? 'selected' : ''}>Job Seeker</option>
                                        <option value="Employer" ${employmentType == 'Employer' ? 'selected' : ''}>Employer</option>
                                        <option value="Freelancer" ${employmentType == 'Freelancer' ? 'selected' : ''}>Freelancer</option>
                                    </select>
                                </div>
                                <div class="md:col-span-2 space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Address</label>
                                    <textarea name="address" rows="2" ${isOwnProfile ? '' : 'disabled'} class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all disabled:opacity-70">${address}</textarea>
                                </div>
                                <div class="md:col-span-2 space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Skills</label>
                                    <div class="tag-input-container">
                                        <c:forEach items="${skills.split(',')}" var="skill">
                                            <c:if test="${not empty skill}">
                                                <div class="tag">${skill} <c:if test="${isOwnProfile}"><i class="fa-solid fa-xmark"></i></c:if></div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isOwnProfile}">
                                            <input type="text" id="skill-input" placeholder="Add skill..." class="bg-transparent border-none outline-none text-xs font-bold py-1 flex-1 min-w-[100px]">
                                        </c:if>
                                    </div>
                                    <input type="hidden" name="skills" id="skills-hidden" value="${skills}">
                                </div>
                                <div class="md:col-span-2 space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">About Me</label>
                                    <textarea name="bio" rows="4" ${isOwnProfile ? '' : 'disabled'} class="w-full bg-surface border border-gray-100 rounded-xl px-4 py-3 text-sm font-bold focus:border-primary outline-none transition-all disabled:opacity-70">${bio}</textarea>
                                </div>
                                <div class="md:col-span-2 space-y-2">
                                    <label class="text-xs font-black text-gray-500 uppercase">Resume (PDF)</label>
                                    <div class="flex items-center justify-between p-4 bg-primary/5 border border-primary/10 rounded-xl">
                                        <div class="flex items-center gap-3">
                                            <i class="fa-solid fa-file-pdf text-2xl text-red-500"></i>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${not empty resumeUrl}">
                                                        <a id="resume-link" href="${resumeUrl}" target="_blank" class="text-sm font-bold text-dark hover:text-primary hover:underline">
                                                            <span id="resume-file-name">${resumeFileName}</span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="text-sm font-bold text-dark" id="resume-file-name">No resume uploaded</p>
                                                    </c:otherwise>
                                                </c:choose>
                                                <p class="text-[0.6rem] text-gray-400 font-bold uppercase" id="resume-uploaded-at">
                                                    <c:choose>
                                                        <c:when test="${not empty resumeUploadedAt}">Uploaded on ${resumeUploadedAt}</c:when>
                                                        <c:otherwise>PDF or DOCX only</c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </div>
                                        </div>
                                        <c:if test="${isOwnProfile}">
                                            <button type="button" onclick="document.getElementById('resume-upload').click()" class="text-primary font-black text-xs hover:underline">Replace</button>
                                            <input type="file" class="hidden" id="resume-upload" accept="application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document,.pdf,.docx">
                                        </c:if>
                                    </div>
                                </div>
                                <c:if test="${isOwnProfile}">
                                    <div class="md:col-span-2 pt-4">
                                        <button type="button" onclick="saveProfile()" class="w-full bg-primary text-white py-4 rounded-2xl font-black shadow-xl shadow-primary/20 transition-all hover:scale-[1.01] active:scale-[0.98]">Save All Changes</button>
                                    </div>
                                </c:if>
                            </form>
                        </div>
                    </div>

                    <!-- Right Column: Network & Social -->
                    <div class="flex flex-col gap-8">
                        <!-- Friends List Widget -->
                        <div class="kyc-card">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="text-sm font-black text-dark border-l-4 border-primary pl-4 uppercase italic">Friends List</h3>
                                <a href="#" class="text-[0.6rem] font-black text-primary hover:underline">View All</a>
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <c:forEach items="${friends}" var="friend">
                                    <div class="flex flex-col items-center gap-2 p-3 bg-surface rounded-2xl group cursor-pointer hover:bg-white hover:shadow-md transition-all">
                                        <img src="${pageContext.request.contextPath}/image?userId=${friend.id}&type=profile" class="w-12 h-12 rounded-full border-2 border-white shadow-sm" onerror="this.src='https://ui-avatars.com/api/?name=${friend.name}&background=1D3E35&color=fff'">
                                        <p class="text-[0.7rem] font-bold text-dark text-center truncate w-full">${friend.name}</p>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty friends}">
                                    <p class="col-span-2 text-center text-xs text-gray-400 font-bold py-4">No friends yet</p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Notification Feed -->
                        <div class="kyc-card">
                            <h3 class="text-sm font-black text-dark mb-6 border-l-4 border-primary pl-4 uppercase italic">Notifications</h3>
                            <div class="space-y-4">
                                <c:forEach items="${notifications}" var="notif">
                                    <div class="flex gap-4 p-3 bg-blue-50/50 border border-blue-100 rounded-2xl relative">
                                        <c:if test="${!notif.read}"><div class="w-2 h-2 bg-blue-500 rounded-full absolute top-4 right-4"></div></c:if>
                                        <div class="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center shrink-0">
                                            <i class="fa-solid ${notif.type == 'friend_request' ? 'fa-user-plus' : 'fa-bell'} text-blue-600"></i>
                                        </div>
                                        <div>
                                            <p class="text-xs font-bold text-dark">${notif.content}</p>
                                            <p class="text-[0.6rem] font-bold text-gray-400 italic mt-1">${notif.createdAt}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty notifications}">
                                    <p class="text-center text-xs text-gray-400 font-bold py-4">No notifications</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <%@ include file="/includes/footer.jsp" %>
            </main>
        </div>
    </div>

    <!-- Floating Chat Widget -->
    <div id="chat-box" class="chat-widget minimized">
        <div class="chat-header" onclick="toggleChat()">
            <div class="flex items-center gap-3">
                <div class="relative">
                    <img src="${profileImage}" class="w-8 h-8 rounded-full border border-white/20" onerror="this.src='https://ui-avatars.com/api/?name=${profileName}&background=fff&color=1D3E35'">
                    <div class="status-dot status-online"></div>
                </div>
                <div>
                    <p class="text-xs font-black">${profileName}</p>
                    <p class="text-[0.55rem] font-bold text-white/60">Active Now</p>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <div class="notif-badge hidden" id="chat-notif">1</div>
                <i class="fa-solid fa-minus text-xs opacity-70"></i>
            </div>
        </div>
        <div class="chat-messages" id="chat-messages">
            <c:forEach items="${chatHistory}" var="msg">
                <div class="message ${msg.senderId == sessionScope.userId ? 'sent' : 'received'}">
                    <c:out value="${msg.body}"/>
                    <span class="message-time"><c:out value="${msg.formattedTime}"/></span>
                </div>
            </c:forEach>
            <c:if test="${empty chatHistory}">
                <div class="p-8 text-center text-[0.65rem] font-bold text-gray-400 italic">
                    No messages yet. Say hi to <c:out value="${user.name}"/>!
                </div>
            </c:if>
        </div>
        <div class="chat-input-area">
            <button class="text-gray-400 hover:text-primary"><i class="fa-regular fa-face-smile text-xl"></i></button>
            <input type="text" id="chat-input" placeholder="Type a message..." class="chat-input" onkeypress="handleChatPress(event)">
            <button onclick="sendMessage()" class="bg-primary text-white w-10 h-10 rounded-full flex items-center justify-center shadow-lg shadow-primary/20 transition-all hover:scale-110">
                <i class="fa-solid fa-paper-plane text-xs"></i>
            </button>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="fixed top-10 right-10 bg-primary text-white px-8 py-4 rounded-2xl shadow-2xl z-[5000] translate-x-[200%] transition-transform duration-500 ease-out flex items-center gap-4">
        <div class="w-8 h-8 bg-white/20 rounded-full flex items-center justify-center">
            <i class="fa-solid fa-check"></i>
        </div>
        <div>
            <p class="text-sm font-black">Success!</p>
            <p class="text-[0.7rem] font-bold opacity-80">Profile changes saved successfully.</p>
        </div>
    </div>

    <script>
        async function toggleFriend() {
            const btn = document.getElementById('friend-btn');
            if (!btn) return;
            const targetId = "${targetUserId}";
            const action = btn.getAttribute('data-action') || 'toggle';
            if (action === 'none') return;
            
            try {
                const response = await fetch(`${pageContext.request.contextPath}/friends/request`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `receiverId=\${targetId}&action=\${action}`
                });
                
                const data = await response.json();
                if (data.success) {
                    btn.innerHTML = `<i class="fa-solid \${data.icon} mr-2"></i> \${data.text}`;
                    btn.className = `px-6 py-2.5 \${data.class} text-white rounded-xl text-sm font-bold shadow-lg transition-all hover:scale-105`;
                    btn.setAttribute('data-action', data.action || 'toggle');
                    showToast("Network", data.message);
                }
            } catch (err) {
                console.error(err);
                showToast("Error", "Could not process request");
            }
        }

        async function handleFriendAction(action) {
            const targetId = "${targetUserId}";
            const group = document.getElementById('friend-actions-group');
            
            try {
                const response = await fetch(`${pageContext.request.contextPath}/friends/request`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `receiverId=\${targetId}&action=\${action}`
                });
                
                const data = await response.json();
                if (data.success) {
                    // Replace the action group with the new single button
                    const newBtn = document.createElement('button');
                    newBtn.id = 'friend-btn';
                    newBtn.className = `px-6 py-2.5 \${data.class} text-white rounded-xl text-sm font-bold shadow-lg transition-all hover:scale-105`;
                    newBtn.setAttribute('data-action', data.action || 'toggle');
                    newBtn.innerHTML = `<i class="fa-solid \${data.icon} mr-2"></i> \${data.text}`;
                    newBtn.onclick = toggleFriend;
                    
                    group.parentNode.replaceChild(newBtn, group);
                    showToast("Network", data.message);
                }
            } catch (err) {
                console.error(err);
                showToast("Error", "Could not process action");
            }
        }

        function showToast(title = "Success!", message = "Action completed successfully.") {
            const toast = document.getElementById('toast');
            if (!toast) return;
            toast.querySelector('p:first-child').innerText = title;
            toast.querySelector('p:last-child').innerText = message;
            toast.classList.remove('translate-x-[200%]');
            setTimeout(() => toast.classList.add('translate-x-[200%]'), 3000);
        }

        function toggleChat() {
            const chat = document.getElementById('chat-box');
            chat.classList.toggle('minimized');
            document.getElementById('chat-notif').classList.add('hidden');
        }

        function handleChatPress(e) {
            if (e.key === 'Enter') sendMessage();
        }

        async function sendMessage() {
            const input = document.getElementById('chat-input');
            const container = document.getElementById('chat-messages');
            const targetId = "${targetUserId}";
            const messageText = input.value.trim();
            
            if (!messageText) return;

            // Remove empty state message if it exists
            const emptyState = container.querySelector('.text-gray-400.italic');
            if (emptyState) emptyState.remove();

            const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            
            // Add to UI immediately
            const msg = document.createElement('div');
            msg.className = 'message sent';
            msg.innerHTML = `\${messageText}<span class="message-time">\${time}</span>`;
            container.appendChild(msg);
            input.value = '';
            container.scrollTop = container.scrollHeight;

            try {
                const response = await fetch(`${pageContext.request.contextPath}/messages/send`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: `receiverId=\${targetId}&body=\${encodeURIComponent(messageText)}`
                });
                
                if (!response.ok) {
                    msg.classList.add('opacity-50');
                    msg.innerHTML += '<i class="fa-solid fa-circle-exclamation text-red-500 ml-1" title="Failed to send"></i>';
                }
            } catch (err) {
                console.error("Failed to send message", err);
                msg.classList.add('opacity-50');
                msg.innerHTML += '<i class="fa-solid fa-circle-exclamation text-red-500 ml-1" title="Network error"></i>';
            }
        }


        function showEditProfile() {
            const card = document.getElementById('profile-details-card');
            const buttonText = document.getElementById('edit-profile-btn-text');
            if (!card) return;

            card.classList.toggle('hidden');
            const isVisible = !card.classList.contains('hidden');
            if (buttonText) {
                buttonText.textContent = isVisible ? 'Close Edit' : 'Edit Profile';
            }
            if (isVisible) {
                card.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        function saveProfile() {
            const form = document.getElementById('profileForm');
            const formData = new URLSearchParams(new FormData(form));

            fetch('${pageContext.request.contextPath}/save-profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast("Profile", "Profile changes saved successfully.");
                    const card = document.getElementById('profile-details-card');
                    const buttonText = document.getElementById('edit-profile-btn-text');
                    if (card) card.classList.add('hidden');
                    if (buttonText) buttonText.textContent = 'Edit Profile';
                } else {
                    alert(data.message || 'Failed to save profile.');
                }
            })
            .catch(error => {
                console.error('Error saving profile:', error);
                alert('Failed to save profile.');
            });
        }

        // Skills Management
        const skillInput = document.getElementById('skill-input');
        const skillsHidden = document.getElementById('skills-hidden');
        const tagContainer = document.querySelector('.tag-input-container');

        if (skillInput) {
            skillInput.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    const val = this.value.trim();
                    if (val) {
                        addSkill(val);
                        this.value = '';
                    }
                }
            });
        }

        function addSkill(skill) {
            let currentSkills = skillsHidden.value ? skillsHidden.value.split(',') : [];
            if (!currentSkills.includes(skill)) {
                currentSkills.push(skill);
                skillsHidden.value = currentSkills.join(',');
                
                const tag = document.createElement('div');
                tag.className = 'tag';
                tag.innerHTML = `\${skill} <i class="fa-solid fa-xmark cursor-pointer" onclick="removeSkill('\${skill}', this.parentElement)"></i>`;
                tagContainer.insertBefore(tag, skillInput);
            }
        }

        window.removeSkill = function(skill, element) {
            let currentSkills = skillsHidden.value.split(',');
            currentSkills = currentSkills.filter(s => s !== skill);
            skillsHidden.value = currentSkills.join(',');
            element.remove();
        }

        // Image upload preview & persist
        document.getElementById('profile-upload')?.addEventListener('change', async function(e) {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                
                // Show preview immediately
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profile-img-preview').src = e.target.result;
                    updateNavbarAvatar(e.target.result);
                }
                reader.readAsDataURL(file);
                
                // Upload to server
                const formData = new FormData();
                const uploadFile = await resizeImageForUpload(file, 1200, 0.86);
                formData.append('image', uploadFile, 'profile.jpg');
                formData.append('type', 'profile');
                
                fetch('${pageContext.request.contextPath}/upload-image', {
                    method: 'POST',
                    body: formData
                })
                .then(parseUploadResponse)
                .then(data => {
                    if (data.success) {
                        updateNavbarAvatar(data.imageUrl);
                        showToast("Upload", "Profile picture updated!");
                    } else {
                        alert(data.message || 'Failed to upload profile picture.');
                    }
                })
                .catch(error => {
                    console.error('Error uploading profile image:', error);
                    alert(error.message || 'Failed to upload profile picture.');
                });
            }
        });

        document.getElementById('cover-upload')?.addEventListener('change', async function(e) {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('cover-photo-div').style.backgroundImage = 'url(' + e.target.result + ')';
                }
                reader.readAsDataURL(file);
                
                const formData = new FormData();
                const uploadFile = await resizeImageForUpload(file, 1800, 0.86);
                formData.append('image', uploadFile, 'cover.jpg');
                formData.append('type', 'cover');
                
                fetch('${pageContext.request.contextPath}/upload-image', {
                    method: 'POST',
                    body: formData
                })
                .then(parseUploadResponse)
                .then(data => {
                    if (data.success) {
                        showToast("Upload", "Cover photo updated!");
                    } else {
                        alert(data.message || 'Failed to upload cover picture.');
                    }
                })
                .catch(error => {
                    console.error('Error uploading cover image:', error);
                    alert(error.message || 'Failed to upload cover picture.');
                });
            }
        });

        document.getElementById('resume-upload')?.addEventListener('change', function() {
            if (!this.files || !this.files[0]) return;

            const file = this.files[0];
            const formData = new FormData();
            formData.append('resume', file);

            fetch('${pageContext.request.contextPath}/upload-resume', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const nameEl = document.getElementById('resume-file-name');
                    const uploadedEl = document.getElementById('resume-uploaded-at');
                    if (nameEl) nameEl.textContent = data.fileName;
                    if (uploadedEl) uploadedEl.textContent = 'Uploaded just now';

                    let link = document.getElementById('resume-link');
                    if (!link && nameEl) {
                        link = document.createElement('a');
                        link.id = 'resume-link';
                        link.target = '_blank';
                        link.className = 'text-sm font-bold text-dark hover:text-primary hover:underline';
                        nameEl.parentNode.replaceChild(link, nameEl);
                        link.appendChild(nameEl);
                    }
                    if (link) link.href = data.downloadUrl;
                    showToast("Resume", "Resume uploaded successfully!");
                } else {
                    alert(data.message || 'Failed to upload resume.');
                }
            })
            .catch(error => {
                console.error('Error uploading resume:', error);
                alert('Failed to upload resume.');
            });
        });

        document.querySelector('.camera-overlay')?.addEventListener('click', () => {
            document.getElementById('profile-upload').click();
        });

        function updateNavbarAvatar(src) {
            const avatar = document.getElementById('nav-avatar');
            if (!avatar) return;
            avatar.innerHTML = '';
            const img = document.createElement('img');
            img.src = src;
            img.alt = 'Profile';
            img.className = 'nav-avatar-img';
            avatar.appendChild(img);
            avatar.classList.add('nav-avatar-circle');
        }

        async function parseUploadResponse(response) {
            const text = await response.text();
            let data;
            try {
                data = text ? JSON.parse(text) : {};
            } catch (error) {
                throw new Error(text || 'Upload failed.');
            }

            if (!response.ok || data.success === false) {
                throw new Error(data.message || 'Upload failed.');
            }
            return data;
        }

        function resizeImageForUpload(file, maxSize, quality) {
            return new Promise((resolve, reject) => {
                if (!file.type || !file.type.startsWith('image/')) {
                    reject(new Error('Only image files are allowed.'));
                    return;
                }

                const img = new Image();
                const objectUrl = URL.createObjectURL(file);
                img.onload = function() {
                    URL.revokeObjectURL(objectUrl);

                    let width = img.width;
                    let height = img.height;
                    const largestSide = Math.max(width, height);
                    if (largestSide > maxSize) {
                        const scale = maxSize / largestSide;
                        width = Math.round(width * scale);
                        height = Math.round(height * scale);
                    }

                    const canvas = document.createElement('canvas');
                    canvas.width = width;
                    canvas.height = height;
                    const ctx = canvas.getContext('2d');
                    ctx.drawImage(img, 0, 0, width, height);

                    canvas.toBlob(blob => {
                        if (!blob) {
                            reject(new Error('Could not prepare image for upload.'));
                            return;
                        }
                        resolve(blob);
                    }, 'image/jpeg', quality);
                };
                img.onerror = function() {
                    URL.revokeObjectURL(objectUrl);
                    reject(new Error('Could not read selected image.'));
                };
                img.src = objectUrl;
            });
        }
    </script>
</body>
</html>
