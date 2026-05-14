<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="relative inline-block" id="notification-wrapper">
    <!-- Notification Bell -->
    <button id="notification-btn" class="relative p-2.5 bg-surface hover:bg-gray-100 rounded-xl transition-all duration-300 group">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary group-hover:scale-110 transition-transform">
            <path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"></path>
            <path d="M10.3 21a1.94 1.94 0 0 0 3.4 0"></path>
        </svg>
        <span id="notification-badge" class="hidden absolute top-2 right-2 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
    </button>

    <!-- Dropdown Panel -->
    <div id="notification-dropdown" class="hidden absolute right-0 mt-3 w-80 md:w-96 bg-white rounded-3xl shadow-[0_20px_50px_rgba(29,62,53,0.15)] border border-gray-100 z-[1100] overflow-hidden origin-top-right transition-all duration-300 scale-95 opacity-0">
        <div class="p-5 border-b border-gray-50 flex items-center justify-between bg-primary/5">
            <div class="flex items-center gap-2">
                <h3 class="text-sm font-black text-primary uppercase tracking-wider">Notifications</h3>
                <span id="unread-count-pill" class="hidden bg-primary text-white text-[0.6rem] font-bold px-2 py-0.5 rounded-full">0 New</span>
            </div>
            <button id="mark-all-read" class="text-[0.65rem] font-black text-primary/60 hover:text-primary transition-colors">Mark all as read</button>
        </div>

        <!-- Scrollable Area -->
        <div id="notification-list" class="max-h-[400px] overflow-y-auto custom-scrollbar bg-white">
            <div class="p-10 text-center flex flex-col items-center">
                <div class="w-16 h-16 bg-surface rounded-full flex items-center justify-center mb-4">
                    <svg class="animate-spin h-6 w-6 text-primary/30" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                </div>
                <p class="text-xs font-bold text-gray-400 italic">Syncing notifications...</p>
            </div>
        </div>

        <div class="p-4 bg-gray-50/50 border-t border-gray-50">
            <button id="clear-all-notifications" class="w-full py-2.5 bg-white border border-gray-200 rounded-xl text-[0.7rem] font-black text-gray-400 hover:text-primary hover:border-primary transition-all shadow-sm">
                Clear All History
            </button>
        </div>
    </div>
</div>

<style>
    #notification-dropdown.show {
        display: block;
        transform: scale(100%);
        opacity: 1;
    }
    
    .notification-item {
        transition: all 0.2s ease;
    }
    
    .notification-item:hover {
        background-color: #f8fafc;
    }
    
    .unread-indicator {
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background-color: #22c55e;
    }
</style>

<script>
(function() {
    const wrapper = document.getElementById('notification-wrapper');
    const btn = document.getElementById('notification-btn');
    const dropdown = document.getElementById('notification-dropdown');
    const list = document.getElementById('notification-list');
    const badge = document.getElementById('notification-badge');
    const pill = document.getElementById('unread-count-pill');
    const markAllBtn = document.getElementById('mark-all-read');
    
    const contextPath = '${pageContext.request.contextPath}';

    const toggleDropdown = (e) => {
        e.stopPropagation();
        const isOpen = dropdown.classList.contains('show');
        if (!isOpen) {
            dropdown.classList.remove('hidden');
            setTimeout(() => dropdown.classList.add('show'), 10);
            fetchNotifications();
        } else {
            dropdown.classList.remove('show');
            setTimeout(() => dropdown.classList.add('hidden'), 300);
        }
    };

    const fetchUnreadCount = async () => {
        try {
            const res = await fetch(contextPath + '/notifications?action=count');
            const data = await res.json();
            if (data.count > 0) {
                badge.classList.remove('hidden');
                pill.textContent = data.count + ' New';
                pill.classList.remove('hidden');
            } else {
                badge.classList.add('hidden');
                pill.classList.add('hidden');
            }
        } catch (e) { console.error('Count error:', e); }
    };

    const fetchNotifications = async () => {
        try {
            const res = await fetch(contextPath + '/notifications');
            const notifications = await res.json();
            renderNotifications(notifications);
        } catch (e) {
            list.innerHTML = '<div class="p-8 text-center text-red-500 text-xs font-bold">Failed to load notifications</div>';
        }
    };

    const timeAgo = (dateStr) => {
        const date = new Date(dateStr);
        const now = new Date();
        const seconds = Math.floor((now - date) / 1000);
        
        let interval = Math.floor(seconds / 31536000);
        if (interval >= 1) return interval + "y ago";
        interval = Math.floor(seconds / 2592000);
        if (interval >= 1) return interval + "mo ago";
        interval = Math.floor(seconds / 86400);
        if (interval >= 1) return interval + "d ago";
        interval = Math.floor(seconds / 3600);
        if (interval >= 1) return interval + "h ago";
        interval = Math.floor(seconds / 60);
        if (interval >= 1) return interval + "m ago";
        return "Just now";
    };

    const renderNotifications = (notifications) => {
        if (!notifications || notifications.length === 0) {
            list.innerHTML = `
                <div class="p-12 text-center">
                    <div class="w-16 h-16 bg-surface rounded-full flex items-center justify-center mx-auto mb-4 opacity-50">
                        <i class="fa-solid fa-bell-slash text-primary text-xl"></i>
                    </div>
                    <p class="text-xs font-black text-gray-400 uppercase tracking-widest">No notifications yet</p>
                    <p class="text-[0.65rem] text-gray-300 italic mt-1">We'll notify you of any updates</p>
                </div>
            `;
            return;
        }

        list.innerHTML = notifications.map(n => {
            const icon = n.type === 'friend_request' ? 'fa-user-plus text-blue-500' : 
                         n.type === 'friend_accepted' ? 'fa-user-check text-green-500' :
                         n.type === 'job_post' ? 'fa-briefcase text-green-500' : 
                         n.type === 'message' ? 'fa-envelope text-amber-500' : 'fa-bell text-primary';
            
            return `
                <div class="notification-item p-4 relative cursor-pointer border-b border-gray-50 flex gap-4 \${n.read ? 'opacity-70' : ''}" onclick="markAsRead(\${n.id}, '\${n.linkUrl || '#'}')">
                    \${!n.read ? '<div class="unread-indicator"></div>' : ''}
                    <div class="w-10 h-10 bg-surface rounded-xl flex items-center justify-center shrink-0">
                        <i class="fa-solid \${icon} text-sm"></i>
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-xs font-black text-dark truncate">\${n.title}</p>
                        <p class="text-[0.65rem] font-medium text-gray-500 line-clamp-2 mt-0.5">\${n.body}</p>
                        <p class="text-[0.55rem] font-bold text-gray-300 mt-2 uppercase tracking-tighter italic">\${timeAgo(n.createdAt)}</p>
                    </div>
                </div>
            `;
        }).join('');
    };

    window.markAsRead = async (id, link) => {
        try {
            await fetch(contextPath + '/notifications', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=markRead&id=' + id
            });
            if (link && link !== '#') {
                // Prepend contextPath if link starts with / and doesn't already have it
                const finalLink = (link.startsWith('/') && !link.startsWith(contextPath)) ? contextPath + link : link;
                window.location.href = finalLink;
            } else fetchUnreadCount();
        } catch (e) { console.error(e); }
    };

    document.getElementById('clear-all-notifications').onclick = async (e) => {
        e.stopPropagation();
        if(!confirm('Clear all notifications?')) return;
        try {
            await fetch(contextPath + '/notifications', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=clearAll'
            });
            fetchNotifications();
            fetchUnreadCount();
        } catch (e) { console.error(e); }
    };

    markAllBtn.onclick = async (e) => {
        e.stopPropagation();
        try {
            await fetch(contextPath + '/notifications', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=markAllRead'
            });
            fetchNotifications();
            fetchUnreadCount();
        } catch (e) { console.error(e); }
    };

    btn.onclick = toggleDropdown;
    document.addEventListener('click', () => {
        dropdown.classList.remove('show');
        setTimeout(() => dropdown.classList.add('hidden'), 300);
    });

    // Initial check
    fetchUnreadCount();
    setInterval(fetchUnreadCount, 30000);
})();
</script>
