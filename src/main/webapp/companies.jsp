<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Companies</title>
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
        .company-card { transition: all 0.3s ease; }
        .company-card:hover { transform: translateY(-4px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); }
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
            <%@ include file="/includes/sidebar.jsp" %>
        </aside>

        <!-- Main Content -->
        <div class="main-content-wrapper">
            <%@ include file="/includes/header.jsp" %>
            <main class="p-6 lg:p-8 flex flex-col gap-8 w-full max-w-full">
                <!-- Header -->
                <div class="flex flex-col md:flex-row justify-between gap-6">
                    <div>
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Companies</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Discover top employers actively hiring on Sarthak</p>
                    </div>
                </div>

                <!-- Search Bar -->
                <form action="${pageContext.request.contextPath}/companies" method="GET">
                    <div class="bg-white rounded-[2rem] p-6 border border-gray-100 shadow-sm flex flex-col md:flex-row gap-4 items-center">
                        <div class="relative w-full flex-1 group">
                            <i class="fa-solid fa-magnifying-glass absolute left-6 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary transition-all"></i>
                            <input type="text" name="q" value="${searchQuery}" placeholder="Search companies by name..." class="w-full bg-surface border-none rounded-2xl py-4 pl-14 pr-6 text-sm font-bold focus:outline-none focus:ring-4 focus:ring-primary/10 transition-all">
                        </div>
                        <button type="submit" class="w-full md:w-auto bg-primary text-white px-10 py-4 rounded-2xl text-[0.8rem] font-black shadow-xl shadow-primary/20 hover:scale-[1.05] transition-all">Search</button>
                    </div>
                </form>

                <!-- Results Grid -->
                <div class="grid grid-cols-1 md:grid-cols-3 xl:grid-cols-4 gap-6">
                    <c:forEach var="company" items="${companies}">
                        <div class="company-card bg-white border border-gray-100 rounded-[2rem] p-6 flex flex-col gap-4 relative overflow-hidden group">
                            <div class="flex items-center gap-4">
                                <div class="w-14 h-14 bg-emerald-100 rounded-[1.2rem] flex items-center justify-center overflow-hidden shadow-lg shrink-0">
                                    <img src="${pageContext.request.contextPath}/image?userId=${company.id}&type=profile"
                                        onerror="this.outerHTML='<div class=\'w-full h-full flex items-center justify-center text-emerald-600 text-xl font-black\'>${company.fullName.substring(0,1)}</div>'"
                                        class="w-full h-full object-cover">
                                </div>
                                <div class="min-w-0">
                                    <h3 class="text-lg font-black text-dark leading-none truncate">${company.fullName}</h3>
                                    <p class="text-[0.65rem] font-bold text-gray-400 mt-1 uppercase truncate">${company.email}</p>
                                </div>
                            </div>
                            <div class="flex flex-wrap gap-2 mt-2">
                                <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Employer</span>
                                <span class="bg-surface px-2 py-1 rounded-md text-[0.55rem] font-black text-secondary uppercase">Verified</span>
                            </div>
                            <p class="text-xs text-gray-500 font-medium line-clamp-2">Partner company registered on the Sarthak platform.</p>
                            <div class="mt-auto flex gap-2 pt-4">
                                <a href="${pageContext.request.contextPath}/job-market?company=${company.fullName}" class="flex-1 text-center bg-gray-50 text-dark border border-gray-200 py-2.5 rounded-xl text-xs font-black hover:bg-gray-100 transition-all">
                                    <i class="fa-solid fa-briefcase mr-2"></i> View Jobs
                                </a>
                                <c:if test="${not empty sessionScope.userId}">
                                    <a href="${pageContext.request.contextPath}/messages?userId=${company.id}" class="w-10 flex items-center justify-center bg-primary text-white py-2.5 rounded-xl text-xs font-black hover:bg-dark transition-all">
                                        <i class="fa-regular fa-paper-plane"></i>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty companies}">
                        <div class="col-span-full p-10 text-center text-gray-400 italic text-sm">No companies found.</div>
                    </c:if>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
