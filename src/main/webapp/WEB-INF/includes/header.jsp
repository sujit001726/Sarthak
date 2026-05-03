<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="bg-white border-b">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex justify-between h-16 items-center">
      <div class="flex items-center lg:hidden">
        <button id="mobile-menu-btn" class="p-2 rounded-md text-slate-700 hover:bg-slate-100">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/></svg>
        </button>
      </div>

      <div class="flex items-center gap-4">
        <form action="${pageContext.request.contextPath}/search" method="get" class="flex items-center border rounded-lg px-3 py-1 bg-white">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-400" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-4.35-4.35M10.5 18a7.5 7.5 0 100-15 7.5 7.5 0 000 15z"/></svg>
          <input type="text" name="q" placeholder="Search applications, candidates, or jobs..." class="ml-2 outline-none text-sm w-80"/>
        </form>
      </div>

      <div class="flex items-center space-x-4">
        <button class="p-2 rounded-md hover:bg-slate-100" title="Notifications">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-600" viewBox="0 0 24 24" fill="none" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
        </button>

        <a href="${pageContext.request.contextPath}/employer/post-job" class="hidden sm:inline-flex items-center bg-brand text-white px-3 py-2 rounded-md text-sm">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd"/></svg>
          Post New Job
        </a>

        <div class="flex items-center gap-3">
          <div class="text-sm text-slate-700">Kasmira Karki</div>
          <img src="${pageContext.request.contextPath}/resources/img/avatar.png" alt="avatar" class="w-8 h-8 rounded-full"/>
        </div>
      </div>
    </div>
  </div>
</header>
