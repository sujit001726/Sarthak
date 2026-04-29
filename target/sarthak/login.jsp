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
    <meta name="description" content="Log in to Sarthak — Nepal's Professional Job Portal.">
    <title>Log in — Sarthak</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { 
                        primary: '#1D3E35', // Logo Green
                        secondary: '#4E7A6E', 
                        dark: '#0F211C',
                        accent: '#2563EB' // Blue for buttons like reference
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

    <div class="w-full max-w-[1200px] min-h-[500px] bg-white rounded-3xl overflow-hidden shadow-[0_30px_100px_rgba(0,0,0,0.3)] flex flex-col md:flex-row animate-fadeIn">
        
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
                        Empowering Nepal's Talent to Reach New Heights.
                    </p>
                    <p class="text-white/70 text-sm max-w-[300px]">
                        Join thousands of professionals finding their dream careers through Sarthak.
                    </p>
                </div>

                <div class="text-white/30 text-[0.7rem]">
                    &copy; 2026 Sarthak Job Portal. All rights reserved.
                </div>
            </div>
        </div>

        <!-- Right Side: Login Form (White) -->
        <div class="flex-1 bg-white p-12 md:p-20 flex flex-col justify-center">
            <div class="max-w-[400px] mx-auto w-full">
                <h1 class="text-4xl font-extrabold text-[#1a1a1a] mb-2">Sarthak login</h1>
                <p class="text-gray-500 font-medium mb-10">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="flex items-center gap-2 hover:text-primary transition-colors w-fit">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                        Log in to get started
                    </a>
                </p>

                <%-- Alerts --%>
                <c:if test="${not empty requestScope.error}">
                    <div class="bg-red-50 border border-red-200 text-red-600 rounded-xl p-4 text-sm mb-6 animate-fadeIn">${requestScope.error}</div>
                </c:if>
                <c:if test="${not empty requestScope.successMessage or not empty sessionScope.successMessage}">
                    <div class="bg-green-50 border border-green-200 text-green-600 rounded-xl p-4 text-sm mb-6 animate-fadeIn">
                        ${not empty requestScope.successMessage ? requestScope.successMessage : sessionScope.successMessage}
                    </div>
                    <c:if test="${not empty sessionScope.successMessage}">
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6">
                    <div>
                        <label for="email" class="block text-sm font-bold text-[#333] mb-2">Email ID or User name</label>
                        <input type="text" id="email" name="email" class="w-full px-5 py-4 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="yourname@email.com" required>
                    </div>

                    <div class="relative">
                        <label for="password" class="block text-sm font-bold text-[#333] mb-2">Password</label>
                        <input type="password" id="password" name="password" class="w-full px-5 py-4 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="Enter your password" required>
                        <button type="button" onclick="togglePw(this)" class="absolute right-5 top-[52px] text-primary text-xs font-bold hover:underline">Show</button>
                    </div>

                    <div class="flex justify-start">
                    </div>

                    <button type="submit" class="w-fit px-12 py-4 bg-primary text-white rounded-xl font-bold text-sm hover:bg-secondary transition-all shadow-lg shadow-primary/20 active:scale-[0.98] mx-auto block">Log in now</button>
                </form>

                <div class="text-center mt-8">
                    <p class="text-gray-600 text-sm">Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="text-primary font-bold hover:underline">Signup here</a></p>
                </div>

                <div class="relative my-8 flex items-center gap-4">
                    <div class="flex-1 h-px bg-gray-100"></div>
                    <span class="text-gray-300 text-[0.6rem] uppercase font-bold">or</span>
                    <div class="flex-1 h-px bg-gray-100"></div>
                </div>

                <button type="button" class="w-full py-4 border border-gray-100 rounded-xl flex items-center justify-center gap-3 text-sm font-bold hover:bg-gray-50 transition-all text-[#333]">
                    <img src="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png" alt="Google" class="h-4 w-auto">
                    Continue with Google
                </button>
            </div>
        </div>
    </div>

    <script>
        function togglePw(btn) {
            var field = document.getElementById('password');
            if (field.type === 'password') { field.type = 'text'; btn.textContent = 'Hide'; }
            else { field.type = 'password'; btn.textContent = 'Show'; }
        }
    </script>
</body>
</html>
