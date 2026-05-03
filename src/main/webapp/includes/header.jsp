<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="sticky top-0 z-[1000] bg-white border-b border-gray-100 shadow-[0_2px_15px_-3px_rgba(29,62,53,0.07)] before:content-[''] before:absolute before:top-0 before:left-0 before:w-full before:h-[3px] before:bg-gradient-to-r before:from-primary before:to-secondary" id="main-header">
    <div class="max-w-[1440px] mx-auto px-6 md:px-10 h-[70px] md:h-[80px] flex items-center justify-between gap-4">

        <!-- Left: Logo + Search -->
        <div class="flex items-center gap-4 md:gap-6 shrink-0">
            <a href="${pageContext.request.contextPath}/index.jsp" class="flex items-center shrink-0 hover:scale-105 transition-transform duration-300" id="nav-logo">
                <img src="${pageContext.request.contextPath}/images/logo.png"
                     alt="Sarthak Job Portal"
                     class="h-[50px] md:h-[65px] w-auto block object-contain">
            </a>
            <div class="hidden lg:flex items-center gap-2 bg-gray-50 border border-gray-100 rounded-lg px-3 py-1.5 w-[220px] transition-all hover:border-primary/40 hover:shadow-sm focus-within:bg-white focus-within:ring-2 focus-within:ring-primary/20 focus-within:border-primary/30 group">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" class="text-gray-400 group-focus-within:text-primary transition-colors" viewBox="0 0 24 24">
                    <path d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z" stroke-linecap="round"/>
                </svg>
                <input type="text" placeholder="Search jobs..." id="header-search-input" class="bg-transparent border-none outline-none text-[0.85rem] text-[#333] w-full font-['Inter'] placeholder:text-gray-400">
            </div>
        </div>

        <!-- Desktop Nav -->
        <nav class="hidden lg:flex items-center ml-auto" id="main-nav">

            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/index.jsp" id="nav-home" class="nav-item px-5 py-2 text-[#444] text-[0.95rem] font-bold hover:text-primary transition-all relative after:content-[''] after:absolute after:bottom-0 after:left-1/2 after:w-0 after:h-[2px] after:bg-primary after:transition-all hover:after:w-full hover:after:left-0">Home</a>
                <a href="${pageContext.request.contextPath}/index.jsp" id="nav-jobs" class="nav-item px-5 py-2 text-[#444] text-[0.95rem] font-bold hover:text-primary transition-all relative after:content-[''] after:absolute after:bottom-0 after:left-1/2 after:w-0 after:h-[2px] after:bg-primary after:transition-all hover:after:w-full hover:after:left-0">Find Jobs</a>
                <a href="#" id="nav-companies" class="nav-item px-5 py-2 text-[#444] text-[0.95rem] font-bold hover:text-primary transition-all relative after:content-[''] after:absolute after:bottom-0 after:left-1/2 after:w-0 after:h-[2px] after:bg-primary after:transition-all hover:after:w-full hover:after:left-0">Browse Companies</a>
                
                <div class="h-6 w-[1px] bg-gray-200 mx-3"></div>

                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <!-- Logged-in: Me avatar dropdown -->
                        <div class="relative group flex items-center gap-3 px-4 py-2 cursor-pointer hover:bg-gray-50 rounded-xl transition-all" id="nav-me-wrapper">
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-primary to-secondary text-white flex items-center justify-center text-xs font-extrabold uppercase shadow-md shadow-primary/20" id="nav-avatar">
                                <span id="avatar-initial"></span>
                            </div>
                            <span class="text-[0.92rem] font-bold text-[#1a1a1a]">Me ▾</span>
                            <div class="hidden group-hover:block absolute top-full right-0 bg-white border border-gray-100 rounded-xl shadow-[0_10px_40px_rgba(0,0,0,0.1)] min-w-[220px] z-[200] overflow-hidden mt-1 animate-fadeIn">
                                <div class="p-5 border-b border-gray-50 bg-gray-50/50">
                                    <strong class="block text-[#1a1a1a] text-sm font-extrabold">${sessionScope.userName}</strong>
                                    <span class="inline-block mt-1 px-2 py-0.5 bg-primary/10 text-primary text-[0.65rem] font-bold uppercase rounded-md tracking-wider">${sessionScope.userRole}</span>
                                </div>
                                <div class="p-2">
                                    <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 p-3 text-red-500 text-sm hover:bg-red-50 font-bold rounded-lg transition-all">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9"/></svg>
                                        Sign Out
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Right: Auth Links -->
                        <div class="flex items-center gap-4">
                            <a href="${pageContext.request.contextPath}/login.jsp" class="text-primary font-bold hover:text-secondary transition-colors px-2 py-1">Login</a>
                            <span class="text-gray-300 font-medium">/</span>
                            <a href="${pageContext.request.contextPath}/register.jsp" class="bg-primary text-white px-6 py-2.5 rounded-xl font-bold text-sm hover:bg-secondary transition-all shadow-lg shadow-primary/20">Sign Up</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <script>
                (function(){
                    var name = "${sessionScope.userName}";
                    if(name) {
                        var letter = name.charAt(0).toUpperCase();
                        var el = document.getElementById('avatar-initial');
                        if(el) el.textContent = letter;
                    }
                })();
            </script>

        </nav>

        <!-- Mobile: Hamburger & Search Toggle -->
        <div class="flex lg:hidden items-center gap-4">
            <button class="p-2 text-[#444] hover:bg-gray-100 rounded-lg transition-all" id="mobile-search-toggle">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
            </button>
            <button class="p-2 text-primary hover:bg-gray-100 rounded-lg transition-all" id="mobile-menu-toggle">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" id="menu-icon-open"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" id="menu-icon-close" class="hidden"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </button>
        </div>

    </div>

    <!-- Mobile Drawer -->
    <div id="mobile-drawer" class="fixed inset-0 z-[2000] bg-black/50 opacity-0 pointer-events-none transition-opacity duration-300 lg:hidden">
        <div id="drawer-content" class="absolute top-0 right-0 w-[280px] h-full bg-white shadow-2xl translate-x-full transition-transform duration-300 ease-in-out p-6">
            <div class="flex flex-col h-full">
                <div class="flex items-center justify-between mb-8">
                    <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-10 w-auto">
                    <button class="p-2 text-gray-400 hover:text-primary transition-colors" onclick="toggleDrawer()">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 6L6 18M6 6l12 12"/></svg>
                    </button>
                </div>

                <div class="flex flex-col gap-2">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="p-3 text-lg font-bold text-[#333] hover:bg-gray-50 rounded-xl">Home</a>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="p-3 text-lg font-bold text-[#333] hover:bg-gray-50 rounded-xl">Find Jobs</a>
                    <a href="#" class="p-3 text-lg font-bold text-[#333] hover:bg-gray-50 rounded-xl">Browse Companies</a>
                </div>

                <div class="mt-auto pt-6 border-t border-gray-100">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <div class="flex items-center gap-3 p-3 bg-gray-50 rounded-2xl mb-4">
                                <div class="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center font-bold">
                                    ${sessionScope.userName.charAt(0).toUpperCase()}
                                </div>
                                <div class="overflow-hidden">
                                    <p class="font-bold text-[#1a1a1a] truncate text-sm">${sessionScope.userName}</p>
                                    <p class="text-[0.65rem] text-gray-400 uppercase font-black">${sessionScope.userRole}</p>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center justify-center gap-2 p-4 bg-red-50 text-red-600 rounded-xl font-bold">Sign Out</a>
                        </c:when>
                        <c:otherwise>
                            <div class="flex flex-col gap-3">
                                <a href="${pageContext.request.contextPath}/login.jsp" class="flex items-center justify-center p-4 bg-gray-50 text-primary rounded-xl font-bold">Login</a>
                                <a href="${pageContext.request.contextPath}/register.jsp" class="flex items-center justify-center p-4 bg-primary text-white rounded-xl font-bold shadow-lg shadow-primary/20">Sign Up</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Mobile Search Overlay -->
    <div id="mobile-search-bar" class="absolute top-[70px] left-0 w-full bg-white border-b border-gray-100 p-4 transition-all duration-300 -translate-y-full opacity-0 z-[900] lg:hidden">
        <div class="relative">
            <input type="text" placeholder="Search for jobs, companies..." class="w-full bg-gray-50 border border-gray-100 rounded-xl px-12 py-3.5 text-sm outline-none focus:border-primary transition-all">
            <svg class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
        </div>
    </div>
</header>

<style type="text/tailwindcss">
@layer utilities {
    .nav-item.active {
        @apply text-primary;
    }
    .nav-item.active::after {
        @apply w-full left-0 !important;
    }
}
</style>

<script>
(function() {
    var path = window.location.pathname;
    var items = document.querySelectorAll('.nav-item');
    
    // Clear all first
    items.forEach(function(item) { item.classList.remove('active'); });

    if (path === '/' || path.endsWith('index.jsp') || path.endsWith('/')) {
        document.getElementById('nav-home').classList.add('active');
    } else {
        items.forEach(function(item) {
            var href = item.getAttribute('href');
            if (href && href !== '#' && path.includes(href.split('/').pop())) {
                item.classList.add('active');
            }
        });
    }

    // Mobile Menu Toggle
    var menuToggle = document.getElementById('mobile-menu-toggle');
    var drawer = document.getElementById('mobile-drawer');
    var drawerContent = document.getElementById('drawer-content');
    var iconOpen = document.getElementById('menu-icon-open');
    var iconClose = document.getElementById('menu-icon-close');

    window.toggleDrawer = function() {
        var isOpen = !drawer.classList.contains('pointer-events-none');
        if (isOpen) {
            drawer.classList.add('opacity-0', 'pointer-events-none');
            drawerContent.classList.add('translate-x-full');
            iconOpen.classList.remove('hidden');
            iconClose.classList.add('hidden');
            document.body.style.overflow = '';
        } else {
            drawer.classList.remove('opacity-0', 'pointer-events-none');
            drawerContent.classList.remove('translate-x-full');
            iconOpen.classList.add('hidden');
            iconClose.classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }
    };

    menuToggle.addEventListener('click', toggleDrawer);
    drawer.addEventListener('click', function(e) {
        if (e.target === drawer) toggleDrawer();
    });

    // Mobile Search Toggle
    var searchToggle = document.getElementById('mobile-search-toggle');
    var searchBar = document.getElementById('mobile-search-bar');
    searchToggle.addEventListener('click', function() {
        var isHidden = searchBar.classList.contains('-translate-y-full');
        if (isHidden) {
            searchBar.classList.remove('-translate-y-full', 'opacity-0');
            searchBar.classList.add('translate-y-0', 'opacity-100');
        } else {
            searchBar.classList.add('-translate-y-full', 'opacity-0');
            searchBar.classList.remove('translate-y-0', 'opacity-100');
        }
    });
})();
</script>
