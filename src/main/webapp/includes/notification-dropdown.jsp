<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="notification-wrapper-outer" id="notification-wrapper">
    <!-- Notification Bell -->
    <button id="notification-btn" class="bell-trigger">
        <i class="fas fa-bell"></i>
        <span id="notification-badge" style="display: none;"></span>
    </button>

    <!-- Dropdown Panel -->
    <div id="notification-dropdown" class="notif-dropdown-box" style="display: none;">
        <div class="notif-header">
            <div class="notif-title-group">
                <h3>Notifications</h3>
                <span id="unread-count-pill" style="display: none;">0</span>
            </div>
            <button id="mark-all-read" class="header-action-btn">Mark all as read</button>
        </div>

        <div id="notification-list" class="notif-scroll-area">
            <div class="notif-empty-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading...</p>
            </div>
        </div>

        <div class="notif-footer">
            <button id="clear-all-notifications" class="footer-action-btn">
                <i class="fas fa-trash-alt"></i> Clear All History
            </button>
        </div>
    </div>
</div>

<style>
    .notification-wrapper-outer {
        position: relative;
        display: inline-flex;
        align-items: center;
    }

    .bell-trigger {
        background: #f8fffe;
        border: 1px solid rgba(29, 62, 53, 0.1);
        color: #1D3E35;
        width: 42px;
        height: 42px;
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        position: relative;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .bell-trigger:hover {
        background: #E8F5F1;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(29, 62, 53, 0.1);
    }

    #notification-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 10px;
        height: 10px;
        background: #ef4444;
        border-radius: 50%;
        border: 2px solid white;
        box-shadow: 0 0 0 2px rgba(239, 68, 68, 0.2);
    }

    .notif-dropdown-box {
        position: absolute;
        top: calc(100% + 15px);
        right: 0;
        width: 360px;
        background: white;
        border-radius: 24px;
        box-shadow: 0 20px 60px rgba(29, 62, 53, 0.15);
        border: 1px solid rgba(29, 62, 53, 0.08);
        z-index: 9999;
        overflow: hidden;
        animation: notifSlideIn 0.3s ease-out;
    }

    @keyframes notifSlideIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .notif-header {
        padding: 20px 24px;
        border-bottom: 1px solid #f1f5f9;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #f8fffe;
    }

    .notif-title-group {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .notif-header h3 {
        font-size: 1rem;
        font-weight: 800;
        color: #1D3E35;
        margin: 0;
    }

    #unread-count-pill {
        background: #1D3E35;
        color: white;
        font-size: 0.7rem;
        padding: 2px 10px;
        border-radius: 20px;
        font-weight: 700;
    }

    .header-action-btn {
        background: rgba(78, 122, 110, 0.05);
        border: 1px solid rgba(78, 122, 110, 0.15);
        color: #4E7A6E;
        font-size: 0.68rem;
        font-weight: 700;
        cursor: pointer;
        padding: 4px 10px;
        border-radius: 8px;
        transition: all 0.2s;
        text-transform: uppercase;
        letter-spacing: 0.02em;
    }

    .header-action-btn:hover {
        background: #1D3E35;
        color: white;
        border-color: #1D3E35;
        box-shadow: 0 4px 10px rgba(29, 62, 53, 0.2);
    }

    .notif-scroll-area {
        max-height: 400px;
        overflow-y: auto;
        background: white;
    }

    .notif-empty-state, .notif-loading {
        padding: 48px 24px;
        text-align: center;
        color: #94a3b8;
    }

    .notif-empty-state i {
        font-size: 2.5rem;
        opacity: 0.15;
        margin-bottom: 16px;
        display: block;
    }

    .notif-empty-state p {
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .notif-item {
        padding: 20px 24px;
        border-bottom: 1px solid #f8fafc;
        display: flex;
        gap: 16px;
        cursor: pointer;
        transition: all 0.2s;
        position: relative;
    }

    .notif-item:hover {
        background: #f8fffe;
    }

    .notif-item.unread {
        background: rgba(29, 62, 53, 0.03);
    }

    .notif-item.unread::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background: #1D3E35;
    }

    .notif-icon-circle {
        width: 44px;
        height: 44px;
        border-radius: 14px;
        background: #E8F5F1;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #1D3E35;
        font-size: 1rem;
        flex-shrink: 0;
        box-shadow: 0 2px 8px rgba(29, 62, 53, 0.05);
    }

    .notif-info {
        flex: 1;
        min-width: 0;
    }

    .notif-item-title {
        font-size: 0.85rem;
        font-weight: 800;
        color: #1D3E35;
        margin: 0 0 4px 0;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .notif-item-body {
        font-size: 0.78rem;
        color: #64748b;
        line-height: 1.5;
        margin: 0;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .notif-item-time {
        font-size: 0.65rem;
        color: #94a3b8;
        margin-top: 8px;
        font-weight: 700;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .notif-footer {
        padding: 16px 24px;
        border-top: 1px solid #f1f5f9;
        background: #f8fffe;
    }

    .footer-action-btn {
        width: 100%;
        padding: 12px;
        background: white;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 700;
        color: #64748b;
        cursor: pointer;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .footer-action-btn:hover {
        border-color: #ef4444;
        color: #ef4444;
        background: #fffafa;
    }

    /* Custom Scrollbar */
    .notif-scroll-area::-webkit-scrollbar { width: 6px; }
    .notif-scroll-area::-webkit-scrollbar-track { background: transparent; }
    .notif-scroll-area::-webkit-scrollbar-thumb { background: #e2e8f0; border-radius: 10px; }
    .notif-scroll-area::-webkit-scrollbar-thumb:hover { background: #cbd5e1; }
    /* Mobile Responsiveness */
    @media (max-width: 480px) {
        .notif-dropdown-box {
            width: calc(100vw - 32px);
            right: -60px; /* Offset to center better relative to bell */
            border-radius: 16px;
        }
        
        .notif-header {
            padding: 16px;
        }
        
        .notif-item {
            padding: 16px;
        }
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
    const clearAllBtn = document.getElementById('clear-all-notifications');
    
    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1)) || '';
    const finalContextPath = contextPath.includes('pages') ? contextPath.substring(0, contextPath.indexOf('/pages')) : contextPath;

    const toggleDropdown = (e) => {
        e.stopPropagation();
        const isOpen = dropdown.style.display === 'block';
        if (!isOpen) {
            dropdown.style.display = 'block';
            fetchNotifications();
        } else {
            dropdown.style.display = 'none';
        }
    };

    const fetchUnreadCount = async () => {
        try {
            const res = await fetch(finalContextPath + '/notifications?action=count');
            const data = await res.json();
            if (data.count > 0) {
                badge.style.display = 'block';
                pill.textContent = data.count;
                pill.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
                pill.style.display = 'none';
            }
        } catch (e) { console.error('Count error:', e); }
    };

    const fetchNotifications = async () => {
        list.innerHTML = `
            <div class="notif-loading">
                <i class="fas fa-circle-notch fa-spin"></i>
                <p>Connecting to server...</p>
            </div>
        `;
        try {
            const res = await fetch(finalContextPath + '/notifications');
            if (!res.ok) throw new Error('Status: ' + res.status);
            const notifications = await res.json();
            renderNotifications(notifications);
        } catch (e) {
            list.innerHTML = `
                <div class="notif-empty-state">
                    <i class="fas fa-plug" style="opacity:0.2;"></i>
                    <p style="font-size:0.7rem;">Backend Offline</p>
                    <span style="font-size:0.6rem; color:#94a3b8; display:block; margin-top:4px;">\${e.message}</span>
                </div>
            `;
        }
    };

    const timeAgo = (dateStr) => {
        const date = new Date(dateStr);
        const now = new Date();
        const seconds = Math.floor((now - date) / 1000);
        let interval = Math.floor(seconds / 86400);
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
                <div class="notif-empty-state">
                    <i class="fas fa-bell-slash"></i>
                    <p>No new updates</p>
                </div>
            `;
            return;
        }

        list.innerHTML = notifications.map(n => {
            const icon = n.type === 'friend_request' ? 'fa-user-plus' : 
                         n.type === 'friend_accepted' ? 'fa-user-check' :
                         n.type === 'job_post' ? 'fa-briefcase' : 
                         n.type === 'message' ? 'fa-envelope' : 'fa-bell';
            
            return `
                <div class="notif-item \${n.read ? 'read' : 'unread'}" onclick="handleNotifClick(\${n.id}, '\${n.linkUrl || '#'}')">
                    <div class="notif-icon-circle"><i class="fas \${icon}"></i></div>
                    <div class="notif-info">
                        <p class="notif-item-title">\${n.title}</p>
                        <p class="notif-item-body">\${n.body}</p>
                        <p class="notif-item-time"><i class="far fa-clock"></i> \${timeAgo(n.createdAt)}</p>
                    </div>
                </div>
            `;
        }).join('');
    };

    window.handleNotifClick = async (id, link) => {
        try {
            await fetch(contextPath + '/notifications', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=markRead&id=' + id
            });
            if (link && link !== '#') {
                window.location.href = (link.startsWith('/') && !link.startsWith(contextPath)) ? contextPath + link : link;
            } else {
                fetchNotifications();
                fetchUnreadCount();
            }
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

    clearAllBtn.onclick = async (e) => {
        e.stopPropagation();
        if(!confirm('Delete all notification history?')) return;
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

    btn.onclick = toggleDropdown;
    document.addEventListener('click', (e) => {
        if (!wrapper.contains(e.target)) {
            dropdown.style.display = 'none';
        }
    });

    // Initial check
    fetchUnreadCount();
    setInterval(fetchUnreadCount, 30000);
})();
</script>
