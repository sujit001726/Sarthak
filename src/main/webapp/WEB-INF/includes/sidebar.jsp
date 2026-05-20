<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="hidden lg:flex lg:flex-col lg:w-64 bg-[#0f1724] text-white min-h-screen">
  <div class="flex items-center h-16 px-4 border-b border-[#0b1220]">
    <div class="text-lg font-semibold">Employer Hub</div>
  </div>
  <nav class="flex-1 px-2 py-6 space-y-1">
    <a href="${pageContext.request.contextPath}/" class="flex items-center px-3 py-2 rounded hover:bg-[#0b1426]">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-300" viewBox="0 0 20 20" fill="currentColor"><path d="M10.707 1.293a1 1 0 00-1.414 0L1 9.586V17a1 1 0 001 1h5v-5h4v5h5a1 1 0 001-1V9.586l-8.293-8.293z"/></svg>
      <span class="ml-3">Dashboard</span>
    </a>
    <a href="#" class="flex items-center px-3 py-2 rounded hover:bg-[#0b1426]">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-300" viewBox="0 0 20 20" fill="currentColor"><path d="M6 2a1 1 0 00-1 1v12a1 1 0 001 1h8a1 1 0 001-1V3a1 1 0 00-1-1H6z"/></svg>
      <span class="ml-3">My Jobs</span>
    </a>
    <a href="#" class="flex items-center px-3 py-2 rounded bg-[#0b1426]">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-200" viewBox="0 0 20 20" fill="currentColor"><path d="M2 5a2 2 0 012-2h12a2 2 0 012 2v2H2V5zM2 9h16v6a2 2 0 01-2 2H4a2 2 0 01-2-2V9z"/></svg>
      <span class="ml-3">Applications</span>
    </a>
    <a href="#" class="flex items-center px-3 py-2 rounded hover:bg-[#0b1426]">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-300" viewBox="0 0 20 20" fill="currentColor"><path d="M6 2a1 1 0 000 2h8a1 1 0 100-2H6zM4 6a2 2 0 00-2 2v8a2 2 0 002 2h12a2 2 0 002-2V8a2 2 0 00-2-2H4z"/></svg>
      <span class="ml-3">Interviews</span>
    </a>
    <a href="#" class="flex items-center px-3 py-2 rounded hover:bg-[#0b1426]">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-slate-300" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M11.3 1.046a1 1 0 00-2.6 0l-.2.8a8.02 8.02 0 00-1.5.7l-.7-.3a1 1 0 00-1.2.6l-.5 1.1a1 1 0 00.2 1.1l.8.8a8.06 8.06 0 000 1.8l-.8.8a1 1 0 00-.2 1.1l.5 1.1a1 1 0 001.2.6l.7-.3c.5.3 1 .6 1.5.7l.2.8a1 1 0 001.3.7l1.2-.6c.4 0 .8 0 1.2 0l1.2.6a1 1 0 001.3-.7l.2-.8c.5-.1 1-.4 1.5-.7l.7.3a1 1 0 001.2-.6l.5-1.1a1 1 0 00-.2-1.1l-.8-.8a8.06 8.06 0 000-1.8l.8-.8a1 1 0 00.2-1.1l-.5-1.1a1 1 0 00-1.2-.6l-.7.3c-.5-.3-1-.6-1.5-.7l-.2-.8a1 1 0 00-1.3-.7l-1.2.6a6.02 6.02 0 00-1.2 0L11.3 1.046z" clip-rule="evenodd"/></svg>
      <span class="ml-3">Settings</span>
    </a>
  </nav>
  <div class="px-4 py-4 border-t border-[#0b1220]">
    <div class="flex items-center space-x-3">
      <div class="w-10 h-10 rounded-full sidebar-avatar flex items-center justify-center text-white">KK</div>
      <div>
        <div class="text-sm font-medium">${employerName}</div>
        <div class="text-xs text-slate-400">HR Director</div>
      </div>
    </div>
  </div>
</aside>
