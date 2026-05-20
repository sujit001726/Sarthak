<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Settings</title>
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
        /* Toggle Switch */
        .toggle-checkbox:checked { right: 0; border-color: #22c55e; }
        .toggle-checkbox:checked + .toggle-label { background-color: #22c55e; }
        .toggle-checkbox { right: 0; z-index: 1; border-color: #e5e7eb; transition: all 0.3s; }
        .toggle-label { width: 3rem; height: 1.5rem; background-color: #e5e7eb; border-radius: 9999px; transition: all 0.3s; cursor: pointer; }
        .toggle-checkbox:checked { transform: translateX(100%); border-color: white; }
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

            .dashboard-container {
                height: auto;
                display: block;
            }

            .main-content-wrapper {
                height: auto;
                overflow: visible;
                margin-left: 0 !important;
                width: 100% !important;
                min-width: 100% !important;
            }

            #main-header {
                position: sticky !important;
                top: 0 !important;
            }
        }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #1D3E35; border-radius: 10px; }
    </style>
</head>

<body class="text-gray-900 bg-surface">
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <%@ include file="/includes/sidebar.jsp" %>
        </aside>

        <!-- Main Content -->
        <div class="main-content-wrapper">
            <%@ include file="/includes/header.jsp" %>
            <main class="p-6 lg:p-8 flex flex-col gap-8 w-full max-w-full">

                <!-- Page Header -->
                <div class="flex flex-col md:flex-row justify-between gap-6">
                    <div>
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Account Settings</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Manage your preferences and security settings</p>
                    </div>
                </div>

                <!-- Flash Messages -->
                <c:if test="${not empty settingsSuccess}">
                    <div class="flex items-center gap-3 bg-green-50 border border-green-200 text-green-700 px-5 py-4 rounded-2xl font-bold text-sm animate-pulse-once">
                        <i class="fa-solid fa-circle-check text-green-500"></i>
                        ${settingsSuccess}
                    </div>
                </c:if>
                <c:if test="${not empty settingsError}">
                    <div class="flex items-center gap-3 bg-red-50 border border-red-200 text-red-700 px-5 py-4 rounded-2xl font-bold text-sm">
                        <i class="fa-solid fa-triangle-exclamation text-red-500"></i>
                        ${settingsError}
                    </div>
                </c:if>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left Column -->
                    <div class="lg:col-span-2 space-y-8">

                        <!-- Personal Info Form -->
                        <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm">
                            <h3 class="text-lg font-black text-dark border-b border-gray-100 pb-4 mb-6">Personal Information</h3>
                            <form method="post" action="${pageContext.request.contextPath}/employer/settings" class="space-y-6">
                                <input type="hidden" name="action" value="save_profile">
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label for="fullName" class="text-xs font-black text-gray-500 uppercase tracking-wider">Full Name</label>
                                        <input type="text" id="fullName" name="fullName"
                                               value="${settingName}"
                                               required
                                               class="w-full bg-surface border border-gray-200 rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary focus:outline-none transition-all">
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Email Address</label>
                                        <input type="email" value="${settingEmail}"
                                               disabled
                                               class="w-full bg-gray-100 border border-gray-200 rounded-xl py-3 px-4 font-bold text-gray-400 cursor-not-allowed">
                                        <p class="text-[0.6rem] text-gray-400 italic">Email cannot be changed.</p>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label for="phone" class="text-xs font-black text-gray-500 uppercase tracking-wider">Phone Number</label>
                                    <input type="tel" id="phone" name="phone"
                                           value="${settingPhone}"
                                           placeholder="+977 9800000000"
                                           class="w-full bg-surface border border-gray-200 rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary focus:outline-none transition-all">
                                </div>
                                <div class="flex justify-end">
                                    <button type="submit"
                                            class="bg-primary text-white px-8 py-3 rounded-xl text-sm font-bold hover:bg-opacity-90 hover:scale-[1.02] transition-all shadow-lg shadow-primary/20 flex items-center gap-2">
                                        <i class="fa-solid fa-floppy-disk"></i>
                                        Save Changes
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Security / Password Form -->
                        <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm">
                            <h3 class="text-lg font-black text-dark border-b border-gray-100 pb-4 mb-6">Security Settings</h3>
                            <form method="post" action="${pageContext.request.contextPath}/employer/settings" class="space-y-6" id="passwordForm">
                                <input type="hidden" name="action" value="update_password">
                                <div class="space-y-2">
                                    <label for="currentPassword" class="text-xs font-black text-gray-500 uppercase tracking-wider">Current Password</label>
                                    <input type="password" id="currentPassword" name="currentPassword" required
                                           class="w-full bg-surface border border-gray-200 rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary focus:outline-none transition-all"
                                           placeholder="••••••••">
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label for="newPassword" class="text-xs font-black text-gray-500 uppercase tracking-wider">New Password</label>
                                        <input type="password" id="newPassword" name="newPassword" required
                                               class="w-full bg-surface border border-gray-200 rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary focus:outline-none transition-all"
                                               placeholder="••••••••">
                                    </div>
                                    <div class="space-y-2">
                                        <label for="confirmPassword" class="text-xs font-black text-gray-500 uppercase tracking-wider">Confirm New Password</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" required
                                               class="w-full bg-surface border border-gray-200 rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary focus:outline-none transition-all"
                                               placeholder="••••••••">
                                    </div>
                                </div>
                                <div id="pwMatchError" class="hidden text-xs font-bold text-red-500">
                                    <i class="fa-solid fa-triangle-exclamation mr-1"></i> Passwords do not match.
                                </div>
                                <div class="flex justify-end">
                                    <button type="submit"
                                            class="bg-dark text-white px-8 py-3 rounded-xl text-sm font-bold hover:bg-opacity-90 hover:scale-[1.02] transition-all shadow-lg flex items-center gap-2">
                                        <i class="fa-solid fa-lock"></i>
                                        Update Password
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="space-y-8">
                        <!-- Danger Zone -->
                        <div class="bg-red-50/50 rounded-[2rem] p-8 border border-red-100/80 shadow-sm backdrop-blur-sm">
                            <h3 class="text-lg font-black text-red-600 border-b border-red-100 pb-4 mb-4 flex items-center gap-2">
                                <i class="fa-solid fa-triangle-exclamation"></i>
                                Danger Zone
                            </h3>
                            <p class="text-xs font-semibold text-red-500/80 mb-6 leading-relaxed">
                                Once you delete your account, all your active job listings, received applications, and corporate profile details will be permanently purged. Please proceed with extreme caution.
                            </p>
                            <button type="button" onclick="openDeleteModal()"
                                    class="w-full bg-red-600 text-white py-3.5 rounded-xl text-sm font-bold hover:bg-red-700 hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg shadow-red-600/10 flex items-center justify-center gap-2">
                                <i class="fa-solid fa-trash-can"></i>
                                Delete Account
                            </button>
                        </div>
                    </div>
                </div>

            </main>
            <div class="bg-[#1D3E35] pb-20">
                <%@ include file="/includes/footer.jsp" %>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="fixed inset-0 z-[200] hidden items-center justify-center p-4">
        <div class="absolute inset-0 bg-dark/50 backdrop-blur-sm" onclick="closeDeleteModal()"></div>
        <div id="deleteModalContent" class="bg-white rounded-[2rem] shadow-2xl w-full max-w-sm overflow-hidden z-10 transform scale-95 opacity-0 transition-all duration-300">
            <div class="p-8 text-center">
                <div class="w-20 h-20 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-6 text-red-500 text-3xl border border-red-100">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <h3 class="text-2xl font-black text-dark mb-3 tracking-tight">Delete Account?</h3>
                <p class="text-sm font-medium text-gray-500 mb-8 leading-relaxed">
                    This will permanently delete your account, all job postings, and all associated data.
                    <span class="font-black text-red-500">This cannot be undone.</span>
                </p>
                <form method="post" action="${pageContext.request.contextPath}/employer/settings">
                    <input type="hidden" name="action" value="delete_account">
                    <div class="flex gap-4 justify-center">
                        <button type="button" onclick="closeDeleteModal()"
                                class="px-6 py-3 rounded-xl text-sm font-bold text-gray-600 bg-gray-50 hover:bg-gray-100 transition-colors w-full border border-gray-200">
                            Cancel
                        </button>
                        <button type="submit"
                                class="px-6 py-3 rounded-xl text-sm font-bold text-white bg-red-600 hover:bg-red-700 transition-all shadow-lg shadow-red-500/20 w-full">
                            Yes, Delete
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // ── Delete Modal ──────────────────────────────────────────────────────
        function openDeleteModal() {
            const modal   = document.getElementById('deleteModal');
            const content = document.getElementById('deleteModalContent');
            modal.classList.remove('hidden');
            modal.classList.add('flex');
            setTimeout(() => {
                content.classList.remove('scale-95', 'opacity-0');
                content.classList.add('scale-100', 'opacity-100');
            }, 10);
        }

        function closeDeleteModal() {
            const modal   = document.getElementById('deleteModal');
            const content = document.getElementById('deleteModalContent');
            content.classList.remove('scale-100', 'opacity-100');
            content.classList.add('scale-95', 'opacity-0');
            setTimeout(() => {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            }, 300);
        }

        // ── Client-side password match check ─────────────────────────────────
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const np  = document.getElementById('newPassword').value;
            const cp  = document.getElementById('confirmPassword').value;
            const err = document.getElementById('pwMatchError');
            if (np !== cp) {
                e.preventDefault();
                err.classList.remove('hidden');
            } else {
                err.classList.add('hidden');
            }
        });

        // Hide error on input
        ['newPassword', 'confirmPassword'].forEach(id => {
            document.getElementById(id).addEventListener('input', () => {
                document.getElementById('pwMatchError').classList.add('hidden');
            });
        });

        // ── Auto-dismiss flash messages ───────────────────────────────────────
        setTimeout(() => {
            document.querySelectorAll('[class*="bg-green-50"], [class*="bg-red-50"]').forEach(el => {
                if (el.closest('main')) {
                    el.style.transition = 'opacity 0.5s';
                    el.style.opacity = '0';
                    setTimeout(() => el.remove(), 500);
                }
            });
        }, 4000);
    </script>
</body>
</html>
