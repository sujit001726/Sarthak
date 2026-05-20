<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Command Messages</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
        .main-content-wrapper {
            flex: 1;
            height: 100%;
            display: flex;
            background-color: #F4F7F6;
        }
        .chat-list {
            width: 320px;
            background: white;
            border-right: 1px solid #E5E7EB;
            display: flex;
            flex-direction: column;
        }
        .chat-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: #F9FAFB;
        }
        .message-bubble {
            max-width: 75%;
            padding: 10px 16px;
            border-radius: 20px;
            margin-bottom: 4px;
            font-size: 0.85rem;
            line-height: 1.5;
            position: relative;
            word-wrap: break-word;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .message-sent {
            background: #1D3E35;
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
            margin-left: auto;
        }
        .message-received {
            background: white;
            color: #1F2937;
            align-self: flex-start;
            border-bottom-left-radius: 4px;
            margin-right: auto;
            border: 1px solid #f0f0f0;
        }
        .sidebar-item {
            transition: all 0.2s ease;
            border-radius: 12px;
            margin-bottom: 4px;
            color: rgba(255, 255, 255, 0.6);
        }
        .sidebar-item:hover { background: rgba(255, 255, 255, 0.1); color: white; }
        .sidebar-item.active { background: #4E7A6E; color: white; border-left: 4px solid #22c55e; }
        
        .convo-item {
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .convo-item:hover { background: #F3F4F6; }
        .convo-item.active { background: #EEF2FF; border-right: 3px solid #1D3E35; }
        
        #messages-container {
            flex: 1;
            overflow-y: auto;
            padding: 24px;
            display: flex;
            flex-direction: column;
        }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-thumb { background: #CBD5E1; border-radius: 10px; }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <!-- Main Sidebar -->
        <aside class="sidebar">
            <div class="p-6 flex flex-col h-full">
                <div class="mb-12 px-4">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-20 w-auto brightness-0 invert opacity-90">
                </div>
                <nav class="flex-1">
                    <c:choose>
                        <c:when test="${userRole == 'employer'}">
                            <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Hiring Suite</p>
                            <a href="${pageContext.request.contextPath}/employer/dashboard" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-chart-pie w-5"></i> <span>Dashboard</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/employer/post-job" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-plus-circle w-5"></i> <span>Post New Job</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/employer/manage-jobs" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-briefcase w-5"></i> <span>Manage My Jobs</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/employer/applicants" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-users-viewfinder w-5"></i> <span>Manage Applicants</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">Navigation</p>
                            <a href="${pageContext.request.contextPath}/jobseeker/dashboard" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-grid-2 w-5"></i> <span>Dashboard</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/job-market" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                                <i class="fa-solid fa-compass w-5"></i> <span>Job Market</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    
                    <a href="${pageContext.request.contextPath}/messages" class="sidebar-item active flex items-center gap-4 px-4 py-3 text-sm font-bold">
                        <i class="fa-solid fa-envelope w-5"></i> <span>Messages</span>
                    </a>

                    <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] my-6 px-4">Account</p>
                    <a href="#" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-semibold">
                        <i class="fa-solid fa-user-gear w-5"></i> <span>Settings</span>
                    </a>
                </nav>
                <div class="mt-auto pt-8 border-t border-white/10">
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400">
                        <i class="fa-solid fa-right-from-bracket w-5"></i>
                        <span>Log Out</span>
                    </a>
                </div>
            </div>
        </aside>

        <!-- Messages Interface -->
        <div class="main-content-wrapper">
            <!-- Conversations List -->
            <div class="chat-list">
                <div class="p-6 border-b border-gray-100">
                    <h2 class="text-xl font-black text-primary italic tracking-tighter uppercase">Messages</h2>
                    <div class="mt-4 relative">
                        <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-xs"></i>
                        <input type="text" placeholder="Search chats..." class="w-full bg-gray-50 border-none rounded-xl py-2 pl-9 pr-4 text-xs font-bold focus:ring-2 focus:ring-primary/10">
                    </div>
                </div>
                <div class="flex-1 overflow-y-auto">
                    <c:forEach var="convo" items="${conversations}">
                        <div onclick="window.location.href='${pageContext.request.contextPath}/messages?userId=${convo.senderId == sessionUserId ? convo.receiverId : convo.senderId}'" 
                             class="convo-item p-4 flex items-center gap-4 border-b border-gray-50 ${activeChatId == (convo.senderId == sessionUserId ? convo.receiverId : convo.senderId) ? 'active' : ''}">
                            <div class="w-12 h-12 bg-primary/5 rounded-full flex items-center justify-center shrink-0 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/image?userId=${convo.senderId == sessionUserId ? convo.receiverId : convo.senderId}&type=profile" 
                                     onerror="this.src='https://ui-avatars.com/api/?name=${convo.subject}&background=1D3E35&color=fff&size=50'"
                                     class="w-full h-full object-cover">
                            </div>
                            <div class="flex-1 min-w-0">
                                <div class="flex justify-between items-center mb-1">
                                    <h4 class="text-sm font-black text-dark truncate">${convo.subject}</h4>
                                    <span class="text-[0.6rem] font-bold text-gray-400">
                                        <c:choose>
                                            <c:when test="${not empty convo.createdAt}">
                                                <!-- Formatting date simplified -->
                                                12:45
                                            </c:when>
                                        </c:choose>
                                    </span>
                                </div>
                                <p class="text-xs text-gray-500 truncate">${convo.body}</p>
                            </div>
                            <c:if test="${!convo.read && convo.receiverId == sessionUserId}">
                                <div class="w-2 h-2 bg-accent rounded-full"></div>
                            </c:if>
                        </div>
                    </c:forEach>
                    <c:if test="${empty conversations}">
                        <div class="p-10 text-center text-gray-400 italic text-sm">No conversations yet</div>
                    </c:if>
                </div>
            </div>

            <!-- Chat Area -->
            <div class="chat-area">
                <c:choose>
                    <c:when test="${not empty activeChatId}">
                        <!-- Chat Header -->
                        <div class="p-4 bg-white border-b border-gray-100 flex items-center justify-between shadow-sm">
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 bg-accent/20 rounded-full flex items-center justify-center overflow-hidden shrink-0">
                                    <img src="${pageContext.request.contextPath}/image?userId=${activeChatId}&type=profile" 
                                         onerror="this.src='https://ui-avatars.com/api/?name=${activeChatName}&background=22c55e&color=fff&size=40'"
                                         class="w-full h-full object-cover">
                                </div>
                                <div>
                                    <h3 class="text-sm font-black text-dark uppercase tracking-tight">${not empty activeChatName ? activeChatName : 'Active Conversation'}</h3>
                                    <span class="text-[0.6rem] font-bold text-accent uppercase flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 bg-accent rounded-full animate-pulse"></span> Online
                                    </span>
                                </div>
                            </div>
                            <div class="flex gap-2">
                                <button class="w-9 h-9 rounded-lg hover:bg-gray-100 text-gray-400 transition-all"><i class="fa-solid fa-phone"></i></button>
                                <button class="w-9 h-9 rounded-lg hover:bg-gray-100 text-gray-400 transition-all"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                            </div>
                        </div>

                        <!-- Messages Display -->
                        <div id="messages-container">
                            <c:forEach var="msg" items="${chatHistory}">
                                <div class="message-bubble ${msg.senderId eq sessionUserId ? 'message-sent' : 'message-received'}">
                                    ${msg.body}
                                    <div class="text-[0.5rem] mt-1 opacity-50 text-right">Just now</div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Chat Input -->
                        <div class="p-6 bg-white border-t border-gray-100">
                            <form id="chat-form" class="flex items-center gap-4">
                                <button type="button" class="text-gray-400 hover:text-primary transition-all"><i class="fa-solid fa-paperclip"></i></button>
                                <input type="text" id="message-input" placeholder="Type your message here..." 
                                       class="flex-1 bg-gray-50 border-none rounded-2xl py-3 px-6 text-sm font-semibold focus:ring-4 focus:ring-primary/5 transition-all">
                                <button type="submit" class="bg-primary text-white w-12 h-12 rounded-2xl flex items-center justify-center shadow-lg shadow-primary/20 hover:scale-105 active:scale-95 transition-all">
                                    <i class="fa-solid fa-paper-plane"></i>
                                </button>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex-1 flex flex-col items-center justify-center text-center p-20">
                            <div class="w-24 h-24 bg-gray-100 rounded-[2.5rem] flex items-center justify-center text-gray-300 text-4xl mb-6">
                                <i class="fa-solid fa-comments"></i>
                            </div>
                            <h3 class="text-xl font-black text-dark uppercase italic tracking-tighter">Command Center Messaging</h3>
                            <p class="text-sm font-bold text-gray-400 mt-2 max-w-xs">Select a conversation from the sidebar to start collaborating in real-time.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        const userId = ${empty sessionUserId ? 'null' : sessionUserId};
        const activeChatId = ${empty activeChatId ? 'null' : activeChatId};
        let socket;

        function connectWebSocket() {
            const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
            const host = window.location.host;
            const path = '${pageContext.request.contextPath}/chat';
            
            socket = new WebSocket(protocol + '//' + host + path);

            socket.onopen = () => console.log('Connected to WebSocket');
            
            socket.onmessage = (event) => {
                const data = JSON.parse(event.data);
                if (data.type === 'message') {
                    // If we are currently chatting with this person, display the message
                    if (data.senderId === activeChatId || data.senderId === userId) {
                        displayMessage(data.senderId, data.body);
                    } else {
                        // Show notification or update sidebar
                        console.log('New message from ' + data.senderId);
                    }
                }
            };

            socket.onclose = () => {
                console.log('WebSocket closed. Reconnecting...');
                setTimeout(connectWebSocket, 3000);
            };
        }

        function displayMessage(senderId, body) {
            const container = document.getElementById('messages-container');
            // Use loose equality to handle string vs number comparisons safely
            const isSent = senderId == userId;
            
            const messageDiv = document.createElement('div');
            messageDiv.className = `message-bubble ${isSent ? 'message-sent' : 'message-received'}`;
            messageDiv.innerHTML = body + `<div class="text-[0.5rem] mt-1 opacity-50 text-right">Just now</div>`;
            
            container.appendChild(messageDiv);
            container.scrollTop = container.scrollHeight;
        }

        document.getElementById('chat-form')?.addEventListener('submit', (e) => {
            e.preventDefault();
            const input = document.getElementById('message-input');
            const body = input.value.trim();
            
            if (body && socket && socket.readyState === WebSocket.OPEN && activeChatId) {
                const message = {
                    receiverId: activeChatId,
                    body: body
                };
                socket.send(JSON.stringify(message));
                input.value = '';
            }
        });

        // Initialize
        if (activeChatId) {
            connectWebSocket();
            const container = document.getElementById('messages-container');
            container.scrollTop = container.scrollHeight;
        }
    </script>
</body>
</html>
