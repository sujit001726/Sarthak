<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | My Network</title>
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
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #F4F7F6; height: 100vh; overflow: hidden; }
        .dashboard-container { display: flex; height: 100vh; width: 100%; overflow: hidden; }
        .sidebar { width: 280px; height: 100%; display: flex; flex-direction: column; background: #1D3E35; flex-shrink: 0; }
        .sidebar-scroll-area { flex: 1; overflow-y: auto; scrollbar-width: thin; }
        .main-content-wrapper { flex: 1; height: 100%; overflow-y: auto; display: flex; flex-direction: column; background-color: #F4F7F6; }
        .sidebar-item { transition: all 0.2s; border-radius: 12px; margin-bottom: 4px; color: rgba(255, 255, 255, 0.6); }
        .sidebar-item:hover { background-color: rgba(255, 255, 255, 0.1); color: #FFFFFF; }
        .sidebar-item.active { background-color: #4E7A6E; color: #FFFFFF; border-left: 4px solid #22c55e; }
        .friend-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .friend-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px -5px rgba(29, 62, 53, 0.1); }
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
                        <a href="${pageContext.request.contextPath}/profile" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                            <i class="fa-solid fa-user w-5"></i>
                            <span>My Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/job-market" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
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
                        <a href="${pageContext.request.contextPath}/friends" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
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

            <main class="p-8 md:p-12 w-full max-w-7xl mx-auto">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
                    <div>
                        <h1 class="text-3xl font-black text-dark border-l-8 border-primary pl-6 uppercase tracking-tighter italic">My Network</h1>
                        <p class="text-gray-400 font-bold mt-2 ml-8">Connect with professionals and grow your circle.</p>
                    </div>
                    <div class="flex items-center gap-4 relative">
                        <div class="relative">
                            <input type="text" id="friend-search-input" placeholder="Search professionals..." 
                                class="bg-white border border-gray-100 rounded-2xl px-12 py-3.5 text-sm font-bold outline-none focus:border-primary transition-all w-80 shadow-sm"
                                onkeyup="searchFriends(this.value)">
                            <i class="fa-solid fa-magnifying-glass absolute left-5 top-1/2 -translate-y-1/2 text-gray-300"></i>
                            
                            <!-- Search Results Dropdown -->
                            <div id="search-results" class="absolute top-full left-0 right-0 mt-4 bg-white rounded-2xl shadow-2xl border border-gray-100 hidden z-50 overflow-hidden">
                                <div class="p-4 border-b border-gray-50 bg-surface/50">
                                    <p class="text-[0.6rem] font-black text-gray-400 uppercase tracking-widest">Search Results</p>
                                </div>
                                <div id="results-list" class="max-h-80 overflow-y-auto">
                                    <!-- Results injected here -->
                                </div>
                            </div>
                        </div>
                        <button class="bg-primary text-white px-8 py-3.5 rounded-2xl font-black text-sm shadow-xl shadow-primary/20 hover:scale-105 transition-all">Add Friend</button>
                    </div>
                </div>

                <script>
                    let searchTimeout;
                    async function searchFriends(query) {
                        const resultsDiv = document.getElementById('search-results');
                        const list = document.getElementById('results-list');
                        
                        if (!query || query.length < 2) {
                            resultsDiv.classList.add('hidden');
                            return;
                        }

                        clearTimeout(searchTimeout);
                        searchTimeout = setTimeout(async () => {
                            try {
                                const response = await fetch(`${pageContext.request.contextPath}/users/search?q=\${encodeURIComponent(query)}`);
                                const data = await response.json();
                                
                                list.innerHTML = '';
                                if (data.length === 0) {
                                    list.innerHTML = '<div class="p-8 text-center text-xs font-bold text-gray-400 italic">No professionals found matching "\' + query + \'"</div>';
                                } else {
                                    data.forEach(user => {
                                        list.innerHTML += `
                                            <a href="${pageContext.request.contextPath}/profile?userId=\${user.id}" class="flex items-center gap-4 p-4 hover:bg-surface transition-all border-b border-gray-50 last:border-0 group">
                                                <div class="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center shrink-0">
                                                    <i class="fa-solid fa-user text-primary text-sm"></i>
                                                </div>
                                                <div>
                                                    <p class="text-sm font-black text-dark group-hover:text-primary transition-all">\${user.name}</p>
                                                    <p class="text-[0.65rem] font-bold text-gray-400 uppercase tracking-widest">\${user.role}</p>
                                                </div>
                                                <div class="ml-auto">
                                                    <i class="fa-solid fa-chevron-right text-gray-200 text-xs"></i>
                                                </div>
                                            </a>
                                        `;
                                    });
                                }
                                resultsDiv.classList.remove('hidden');
                            } catch (err) {
                                console.error(err);
                            }
                        }, 300);
                    }

                    // Hide results when clicking outside
                    document.addEventListener('click', (e) => {
                        if (!e.target.closest('#friend-search-input') && !e.target.closest('#search-results')) {
                            document.getElementById('search-results').classList.add('hidden');
                        }
                    });

                    async function handleRequestAction(senderId, action) {
                        try {
                            const response = await fetch(`${pageContext.request.contextPath}/friends/request`, {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: `receiverId=\${senderId}&action=\${action}`
                            });
                            const data = await response.json();
                            if (data.success) {
                                const card = document.getElementById(`request-card-\${senderId}`);
                                card.classList.add('scale-95', 'opacity-0');
                                setTimeout(() => {
                                    card.remove();
                                    // Optionally reload if empty to hide header or show placeholder
                                    if (document.querySelectorAll('[id^="request-card-"]').length === 0) {
                                        location.reload();
                                    }
                                }, 300);
                            }
                        } catch (err) {
                            console.error(err);
                        }
                    }
                </script>

                <!-- Friend Requests Section -->
                <c:if test="${not empty pendingRequests}">
                    <div class="mb-12">
                        <div class="flex items-center gap-3 mb-6">
                            <h2 class="text-lg font-black text-dark uppercase tracking-tight">Friend Requests</h2>
                            <span class="bg-red-500 text-white text-[0.6rem] font-bold px-2 py-0.5 rounded-full">${pendingRequests.size()} New</span>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                            <c:forEach items="${pendingRequests}" var="request">
                                <div id="request-card-${request.id}" class="bg-white rounded-2xl p-4 border border-gray-100 shadow-sm flex items-center gap-4 transition-all hover:shadow-md">
                                    <img src="${pageContext.request.contextPath}/image?userId=${request.id}&type=profile" 
                                         onerror="this.src='https://ui-avatars.com/api/?name=${request.name}&background=1D3E35&color=fff&size=50'"
                                         class="w-12 h-12 rounded-xl shrink-0 object-cover">
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-black text-dark truncate">${request.name}</p>
                                        <p class="text-[0.6rem] font-bold text-gray-400 uppercase tracking-widest truncate">${request.role}</p>
                                        <div class="flex items-center gap-2 mt-3">
                                            <button onclick="handleRequestAction(${request.id}, 'accept')" class="flex-1 py-2 bg-primary text-white rounded-lg text-[0.65rem] font-black hover:bg-secondary transition-all">Confirm</button>
                                            <button onclick="handleRequestAction(${request.id}, 'reject')" class="flex-1 py-2 bg-gray-100 text-dark rounded-lg text-[0.65rem] font-black hover:bg-gray-200 transition-all">Reject</button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="flex items-center gap-3 mb-6">
                    <h2 class="text-lg font-black text-dark uppercase tracking-tight">Friends List</h2>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                    <c:forEach items="${friends}" var="friend">
                        <div class="friend-card bg-white rounded-3xl p-6 border border-gray-50 shadow-sm flex flex-col items-center text-center">
                            <div class="relative mb-4">
                                <img src="${pageContext.request.contextPath}/image?userId=${friend.id}&type=profile" 
                                     onerror="this.src='https://ui-avatars.com/api/?name=${friend.name}&background=1D3E35&color=fff&size=100'"
                                     class="w-24 h-24 rounded-full border-4 border-white shadow-md object-cover">
                                <div class="absolute bottom-1 right-1 w-5 h-5 border-4 border-white rounded-full ${friend.online ? 'bg-accent' : 'bg-gray-400'}"></div>
                            </div>
                            
                            <h3 class="text-lg font-black text-dark mb-1">${friend.name}</h3>
                            <p class="text-[0.65rem] font-bold text-gray-400 uppercase tracking-widest mb-4">${friend.role}</p>
                            
                            <div class="flex items-center gap-2 mb-6">
                                <span class="px-3 py-1 bg-surface text-[0.6rem] font-black text-primary rounded-lg border border-gray-100 uppercase">Nepal</span>
                                <span class="px-3 py-1 bg-surface text-[0.6rem] font-black text-primary rounded-lg border border-gray-100 uppercase">Tech</span>
                            </div>

                            <div class="grid grid-cols-2 gap-3 w-full">
                                <a href="${pageContext.request.contextPath}/messages?userId=${friend.id}" class="flex items-center justify-center gap-2 py-3 bg-primary text-white rounded-xl text-xs font-black shadow-lg shadow-primary/10 hover:bg-secondary transition-all">
                                    <i class="fa-solid fa-message-dots"></i> Message
                                </a>
                                <a href="${pageContext.request.contextPath}/profile?userId=${friend.id}" class="flex items-center justify-center gap-2 py-3 bg-white border border-gray-100 text-dark rounded-xl text-xs font-black hover:bg-gray-50 transition-all">
                                    <i class="fa-solid fa-user"></i> Profile
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty friends}">
                        <div class="col-span-full py-20 text-center">
                            <div class="w-24 h-24 bg-white rounded-full flex items-center justify-center mx-auto mb-6 shadow-sm border border-gray-50">
                                <i class="fa-solid fa-users-slash text-3xl text-gray-200"></i>
                            </div>
                            <h2 class="text-xl font-black text-dark italic">No friends found yet</h2>
                            <p class="text-gray-400 font-bold mt-2">Start searching for professionals to build your network!</p>
                        </div>
                    </c:if>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
