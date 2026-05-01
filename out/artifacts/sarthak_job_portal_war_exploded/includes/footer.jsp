<footer class="bg-primary py-8 text-white relative overflow-hidden">
    <!-- Subtle decorative blur -->
    <div class="absolute top-0 right-0 w-[160px] h-[160px] bg-secondary/10 rounded-full blur-[70px] -mr-16 -mt-16 pointer-events-none"></div>

    <div class="max-w-[1280px] mx-auto px-8 lg:px-16">

        <!-- Main Row -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-8 mb-12">

            <!-- Brand -->
            <div class="flex flex-col gap-4">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="${pageContext.request.contextPath}/images/logo.png"
                         alt="Sarthak" class="h-10 md:h-[60px] w-auto brightness-0 invert">
                </a>
                <p class="text-white/50 text-sm leading-relaxed max-w-[280px]">
                    Nepal's premier job portal connecting top talent with visionary employers across the country.
                </p>
                <div class="flex gap-4 mt-2">
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center hover:bg-secondary transition-all">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center hover:bg-secondary transition-all">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center hover:bg-secondary transition-all">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/></svg>
                    </a>
                </div>
            </div>

            <!-- Links: Job Seekers -->
            <div class="lg:pl-8">
                <h4 class="text-sm font-bold uppercase tracking-widest text-white mb-6">Job Seekers</h4>
                <ul class="space-y-4">
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Browse All Jobs</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Job Alerts</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Resume Builder</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Career Advice</a></li>
                </ul>
            </div>

            <!-- Links: Employers -->
            <div>
                <h4 class="text-sm font-bold uppercase tracking-widest text-white mb-6">Employers</h4>
                <ul class="space-y-4">
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Post a Job</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Talent Search</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Hiring Solutions</a></li>
                    <li><a href="#" class="text-white/50 hover:text-white text-sm transition-colors">Pricing Plans</a></li>
                </ul>
            </div>

            <!-- Newsletter -->
            <div class="flex flex-col">
                <h4 class="text-sm font-bold uppercase tracking-widest text-white mb-6">Newsletter</h4>
                <p class="text-white/50 text-sm mb-6 leading-relaxed">Stay updated with the latest job openings in your area.</p>
                <div class="flex items-center bg-white/5 rounded-xl border border-white/10 group focus-within:border-white/30 transition-all p-1 w-full overflow-hidden">
                    <input type="email" placeholder="Email address"
                           class="bg-transparent border-none outline-none pl-4 pr-2 py-2.5 text-sm flex-1 text-white placeholder:text-white/20 min-w-0">
                    <button class="bg-white text-primary px-6 py-2.5 rounded-lg text-xs font-bold hover:bg-secondary hover:text-white transition-all shrink-0">
                        Join
                    </button>
                </div>
            </div>
        </div>

        <!-- Bottom bar -->
        <div class="pt-5 border-t border-white/10 flex flex-col sm:flex-row justify-between items-center gap-3">
            <p class="text-white/35 text-xs">&copy; 2026 Sarthak Job Portal. All rights reserved.</p>
            <div class="flex gap-6">
                <a href="#" class="text-white/35 hover:text-white text-xs transition-colors">Privacy Policy</a>
                <a href="#" class="text-white/35 hover:text-white text-xs transition-colors">Terms of Service</a>
                <a href="#" class="text-white/35 hover:text-white text-xs transition-colors">Cookies</a>
            </div>
        </div>

    </div>
</footer>
