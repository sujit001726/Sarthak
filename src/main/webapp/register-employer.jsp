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
    <meta name="description" content="Join Sarthak as an Employer. Post jobs and find top talent in Nepal.">
    <title>Employer Registration — Sarthak</title>
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
                        Connect with the Best Talent in Nepal.
                    </p>
                    <p class="text-white/70 text-sm max-w-[300px]">
                        Empower your team with high-quality hires through Sarthak.
                    </p>
                </div>

                <div class="text-white/30 text-[0.7rem]">
                    &copy; 2026 Sarthak Job Portal. All rights reserved.
                </div>
            </div>
        </div>

        <!-- Right Side: Registration Form -->
        <div class="flex-1 bg-white p-10 md:p-16 flex flex-col justify-center overflow-y-auto">
            <div class="max-w-[460px] mx-auto w-full">
                <h1 class="text-3xl font-extrabold text-[#1a1a1a] mb-2">Register Company</h1>
                <p class="text-gray-500 font-medium mb-8 text-sm">
                    <a href="${pageContext.request.contextPath}/register.jsp" class="flex items-center gap-2 hover:text-primary transition-colors w-fit">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                        Join Sarthak to hire top talent
                    </a>
                </p>

                <c:if test="${not empty requestScope.error}">
                    <div class="bg-red-50 border border-red-200 text-red-600 rounded-xl p-3 text-xs mb-6 animate-fadeIn">${requestScope.error}</div>
                </c:if>
                <c:if test="${not empty requestScope.successMessage or not empty sessionScope.successMessage}">
                    <div class="bg-green-50 border border-green-200 text-green-600 rounded-xl p-3 text-xs mb-6 animate-fadeIn">
                        ${not empty requestScope.successMessage ? requestScope.successMessage : sessionScope.successMessage}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">
                    <input type="hidden" name="role" value="employer">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="fullName" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Company Name</label>
                            <input type="text" id="fullName" name="fullName" value="<c:out value='${fullName}'/>" class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="John Doe" required>
                        </div>
                        <div>
                            <label for="website" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Website (Optional)</label>
                            <input type="url" id="website" name="website" class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="https://tech.com">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="email" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Business Email</label>
                        <input type="email" id="email" name="email" value="<c:out value='${email}'/>" class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="hr@company.com" required>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="password" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Password</label>
                            <input type="password" id="password" name="password" class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="6+ characters" required>
                        </div>
                        <div>
                            <label for="confirmPassword" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300" placeholder="Repeat password" required>
                        </div>
                    </div>

                    <p class="text-[0.7rem] text-gray-400 text-center py-2">
                        By clicking Agree & Join, you agree to the Sarthak <a href="#" class="text-primary hover:underline font-bold">User Agreement</a>.
                    </p>

                    <button type="submit" class="w-fit px-12 py-4 bg-primary text-white rounded-xl font-bold text-sm hover:bg-secondary transition-all shadow-lg shadow-primary/20 active:scale-[0.98] mx-auto block">Agree & Join</button>
                </form>

                <div class="text-center mt-6">
                    <p class="text-gray-600 text-sm">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" class="text-primary font-bold hover:underline">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
