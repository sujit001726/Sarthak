<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="sarthak.dao.MessageDAO" %>
<%
    int unreadMsgCount = 0;
    if (session.getAttribute("userId") != null) {
        MessageDAO msgDao = new MessageDAO();
        unreadMsgCount = msgDao.getUnreadMessageCount((Integer) session.getAttribute("userId"));
    }
    request.setAttribute("unreadMsgCount", unreadMsgCount);
%>

<c:set var="uri" value="${pageContext.request.requestURI}" />
<c:set var="active" value="${activeSidebar}" />
<c:if test="${empty active}">
    <c:choose>
        <c:when test="${uri.contains('/employer/dashboard')}"><c:set var="active" value="employer_dashboard" /></c:when>
        <c:when test="${uri.contains('/employer/post-job') || uri.contains('/employer/post-job.jsp')}"><c:set var="active" value="employer_post_job" /></c:when>
        <c:when test="${uri.contains('/employer/manage-jobs') || uri.contains('/employer/manage-jobs.jsp')}"><c:set var="active" value="employer_manage_jobs" /></c:when>
        <c:when test="${uri.contains('/employer/applicants') || uri.contains('/employer/manage-applicants.jsp')}"><c:set var="active" value="employer_applicants" /></c:when>
        <c:when test="${uri.contains('/employer/search-talent') || uri.contains('/employer/search-talent.jsp')}"><c:set var="active" value="employer_search_talent" /></c:when>
        <c:when test="${uri.contains('/employer/company-profile') || uri.contains('/employer/company-profile.jsp')}"><c:set var="active" value="employer_company_profile" /></c:when>
        <c:when test="${uri.contains('/employer/search-companies')}"><c:set var="active" value="employer_search_companies" /></c:when>
        <c:when test="${uri.contains('/companies')}"><c:set var="active" value="companies" /></c:when>
        <c:when test="${uri.contains('/employer/billing-plans') || uri.contains('/employer/billing-plans.jsp')}"><c:set var="active" value="employer_billing_plans" /></c:when>
        <c:when test="${uri.contains('/employer/settings') || uri.contains('/employer/settings.jsp') || uri.contains('/settings')}"><c:set var="active" value="employer_settings" /></c:when>
        <c:when test="${uri.contains('/messages')}"><c:set var="active" value="messages" /></c:when>
        <c:when test="${uri.contains('/jobseeker/dashboard')}"><c:set var="active" value="jobseeker_dashboard" /></c:when>
        <c:when test="${uri.contains('/job-market')}"><c:set var="active" value="jobseeker_job_market" /></c:when>
        <c:when test="${uri.contains('/friends')}"><c:set var="active" value="jobseeker_friends" /></c:when>
        <c:when test="${uri.contains('/profile')}"><c:set var="active" value="jobseeker_profile" /></c:when>
    </c:choose>
</c:if>


<div class="sidebar-scroll-area p-6 flex flex-col h-full custom-scrollbar">
    <!-- Branding -->
    <div class="mb-12 px-4">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak"
            class="h-20 w-auto brightness-0 invert opacity-90">
    </div>

    <!-- Scrollable Nav Area -->
    <c:choose>
        <c:when test="${sessionScope.userRole == 'employer' || userRole == 'employer'}">
            <!-- Employer Sidebar -->
            <div class="mb-10 flex-1">
                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                    Hiring Suite</p>
                <nav>
                    <a href="${pageContext.request.contextPath}/employer/dashboard"
                        class="sidebar-item ${active == 'employer_dashboard' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-chart-pie w-5 ${active == 'employer_dashboard' ? 'text-accent' : ''}"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/employer/post-job"
                        class="sidebar-item ${active == 'employer_post_job' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-plus-circle w-5 ${active == 'employer_post_job' ? 'text-accent' : ''}"></i>
                        <span>Post New Job</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/employer/manage-jobs"
                        class="sidebar-item ${active == 'employer_manage_jobs' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-briefcase w-5 ${active == 'employer_manage_jobs' ? 'text-accent' : ''}"></i>
                        <span>Manage My Jobs</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/employer/applicants"
                        class="sidebar-item ${active == 'employer_applicants' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-users-viewfinder w-5 ${active == 'employer_applicants' ? 'text-accent' : ''}"></i>
                        <span>Manage Applicants</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/messages"
                        class="sidebar-item ${active == 'messages' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-envelope w-5 ${active == 'messages' ? 'text-accent' : ''}"></i>
                        <span>Messages</span>
                        <c:if test="${unreadMsgCount > 0}">
                            <span class="ml-auto bg-accent text-primary text-[0.6rem] font-black px-1.5 py-0.5 rounded-full">${unreadMsgCount}</span>
                        </c:if>
                    </a>

                    <a href="${pageContext.request.contextPath}/employer/search-companies"
                        class="sidebar-item ${active == 'employer_search_companies' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-network-wired w-5 ${active == 'employer_search_companies' ? 'text-accent' : ''}"></i>
                        <span>Company Network</span>
                    </a>
                </nav>
            </div>

            <div class="mb-10">
                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                    Company</p>
                <nav>

                    <a href="${pageContext.request.contextPath}/employer/billing-plans.jsp"
                        class="sidebar-item ${active == 'employer_billing_plans' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-credit-card w-5 ${active == 'employer_billing_plans' ? 'text-accent' : ''}"></i>
                        <span>Billing & Plans</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/employer/settings"
                        class="sidebar-item ${active == 'employer_settings' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-sliders w-5 ${active == 'employer_settings' ? 'text-accent' : ''}"></i>
                        <span>Settings</span>
                    </a>
                </nav>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Job Seeker Sidebar -->
            <div class="mb-10 flex-1">
                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                    Menu</p>
                <nav>
                    <a href="${pageContext.request.contextPath}/jobseeker/dashboard"
                        class="sidebar-item ${active == 'jobseeker_dashboard' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-grid-2 w-5 ${active == 'jobseeker_dashboard' ? 'text-accent' : ''}"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/job-market"
                        class="sidebar-item ${active == 'jobseeker_job_market' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-compass w-5 ${active == 'jobseeker_job_market' ? 'text-accent' : ''}"></i>
                        <span>Job Market</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/messages"
                        class="sidebar-item ${active == 'messages' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-envelope w-5 ${active == 'messages' ? 'text-accent' : ''}"></i>
                        <span>Messages</span>
                        <c:if test="${unreadMsgCount > 0}">
                            <span class="ml-auto bg-accent text-primary text-[0.6rem] font-black px-1.5 py-0.5 rounded-full">${unreadMsgCount}</span>
                        </c:if>
                    </a>
                </nav>
            </div>

            <div class="mb-10">
                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                    Network</p>
                <nav>
                    <a href="${pageContext.request.contextPath}/friends"
                        class="sidebar-item ${active == 'jobseeker_friends' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-users w-5 ${active == 'jobseeker_friends' ? 'text-accent' : ''}"></i>
                        <span>Friends</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/companies"
                        class="sidebar-item ${active == 'companies' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-building-user w-5 ${active == 'companies' ? 'text-accent' : ''}"></i>
                        <span>Companies</span>
                    </a>
                </nav>
            </div>

            <div class="mb-10">
                <p class="text-[0.6rem] font-black text-white/30 uppercase tracking-[0.2em] mb-6 px-4">
                    Personal</p>
                <nav>
                    <a href="${pageContext.request.contextPath}/profile"
                        class="sidebar-item ${active == 'jobseeker_profile' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-user w-5 ${active == 'jobseeker_profile' ? 'text-accent' : ''}"></i>
                        <span>My Profile</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/settings"
                        class="sidebar-item ${active == 'employer_settings' ? 'active font-bold' : 'font-semibold'} flex items-center gap-4 px-4 py-3 text-sm">
                        <i class="fa-solid fa-gear w-5 ${active == 'employer_settings' ? 'text-accent' : ''}"></i>
                        <span>Settings</span>
                    </a>
                </nav>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Fixed Logout Section -->
    <div class="mt-auto pt-8 border-t border-white/10">
        <a href="${pageContext.request.contextPath}/logout"
            class="sidebar-item flex items-center gap-4 px-4 py-3 text-sm font-bold text-red-400 hover:text-red-300">
            <i class="fa-solid fa-right-from-bracket w-5"></i>
            <span>Log Out</span>
        </a>
    </div>
</div>
