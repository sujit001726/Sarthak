<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Redirect if already logged in --%>
<c:if test="${not empty sessionScope.userId}">
    <c:redirect url="/index.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Choose your account type on Sarthak — Nepal's Professional Job Portal.">
    <title>Join Sarthak — Choose Account Type</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { 
                        primary: '#1D3E35', 
                        secondary: '#4E7A6E', 
                        dark: '#0F211C',
                        accent: '#2563EB'
                    },
                    fontFamily: { sans: ['Inter', 'sans-serif'] },
                    keyframes: {
                        fadeIn: { '0%': { opacity: '0' }, '100%': { opacity: '1' } },
                        slideInLeft: { '0%': { transform: 'translateX(-20px)', opacity: '0' }, '100%': { transform: 'translateX(0)', opacity: '1' } }
                    },
                    animation: {
                        fadeIn: 'fadeIn 0.8s ease-out forwards',
                        slideInLeft: 'slideInLeft 0.6s ease-out forwards'
                    }
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
    @layer base { body { @apply font-sans text-gray-900 bg-[#F0F4F3]; } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 md:p-8">

    <div class="w-full max-w-[1200px] min-h-[500px] bg-white rounded-3xl overflow-hidden shadow-[0_30px_100px_rgba(29,62,53,0.15)] flex flex-col md:flex-row animate-fadeIn">
        
        <!-- Left Side: Brand Image (Deep Green Theme) -->
        <div class="md:w-[45%] h-[200px] md:h-auto relative overflow-hidden group">
            <!-- Background Image with Overlay -->
            <div class="absolute inset-0 bg-primary/80 z-10"></div>
            <img src="${pageContext.request.contextPath}/images/auth-side.png" alt="Sarthak" class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700">
            
            <div class="relative z-20 h-full p-8 md:p-12 flex flex-col justify-between">
                <div>
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-16 w-auto brightness-0 invert">
                    </a>
                </div>

                <div class="hidden md:block animate-slideInLeft" style="animation-delay: 0.2s;">
                    <p class="text-white text-[1.6rem] font-extrabold leading-tight mb-4">
                        Join the Professional Community of Nepal.
                    </p>
                    <p class="text-white/70 text-sm max-w-[300px]">
                        Choose your path and start your journey with Sarthak today.
                    </p>
                </div>

                <div class="text-white/30 text-[0.7rem]">
                    &copy; 2026 Sarthak Job Portal. All rights reserved.
                </div>
            </div>
        </div>

        <!-- Right Side: Choice Cards -->
        <div class="flex-1 bg-white p-10 md:p-16 flex flex-col justify-center overflow-y-auto">
            <div class="max-w-[500px] mx-auto w-full text-center">
                <h1 class="text-3xl font-extrabold text-primary mb-2">How do you want to use Sarthak?</h1>
                <p class="text-gray-500 font-medium mb-10 text-sm">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="flex items-center gap-2 hover:text-primary transition-colors w-fit mx-auto">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                        Select the account type that fits your needs
                    </a>
                </p>

                <div class="grid grid-cols-1 gap-6">
                    
                    <!-- Job Seeker Card -->
                    <a href="${pageContext.request.contextPath}/register-seeker.jsp" class="group bg-gray-50 p-6 rounded-2xl border-2 border-transparent hover:border-primary hover:bg-white hover:shadow-xl transition-all duration-300 flex items-center gap-6 text-left">
                        <div class="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform text-primary">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        </div>
                        <div>
                            <h2 class="text-xl font-bold text-[#1a1a1a] mb-1">Job Seeker</h2>
                            <p class="text-gray-500 text-sm">Find your dream job and build your profile.</p>
                        </div>
                        <div class="ml-auto text-primary opacity-0 group-hover:opacity-100 transition-opacity">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
                        </div>
                    </a>

                    <!-- Employer Card -->
                    <a href="${pageContext.request.contextPath}/register-employer.jsp" class="group bg-gray-50 p-6 rounded-2xl border-2 border-transparent hover:border-primary hover:bg-white hover:shadow-xl transition-all duration-300 flex items-center gap-6 text-left">
                        <div class="w-16 h-16 bg-secondary/10 rounded-full flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform text-secondary">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg>
                        </div>
                        <div>
                            <h2 class="text-xl font-bold text-[#1a1a1a] mb-1">Employer</h2>
                            <p class="text-gray-500 text-sm">Post jobs and find top talent in Nepal.</p>
                        </div>
                        <div class="ml-auto text-primary opacity-0 group-hover:opacity-100 transition-opacity">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
                        </div>
                    </a>

                </div>

                <p class="mt-10 text-gray-500 text-sm">
                    Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" class="text-primary font-bold hover:underline">Login</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>

<!-- commit iteration 3: Add register page skeleton -->
