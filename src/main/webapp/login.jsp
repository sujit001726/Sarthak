<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Redirect if already logged in --%>
<c:if test="${not empty sessionScope.userId}">
    <c:choose>
        <c:when test="${sessionScope.userRole == 'admin'}">
            <c:redirect url="/admin?action=dashboard"/>
        </c:when>
        <c:when test="${sessionScope.userRole == 'employer'}">
            <c:redirect url="/employer/dashboard"/>
        </c:when>
        <c:otherwise>
            <c:redirect url="/jobseeker/dashboard"/>
        </c:otherwise>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1D3E35',
                        secondary: '#4E7A6E',
                        dark: '#0F211C'
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

    <div class="w-full max-w-[1100px] min-h-[480px] bg-white rounded-3xl overflow-hidden shadow-[0_30px_100px_rgba(29,62,53,0.15)] flex flex-col md:flex-row animate-fadeIn">

        <!-- Left Side: Brand -->
        <div class="md:w-[45%] h-[180px] md:h-auto relative overflow-hidden group">
            <div class="absolute inset-0 bg-primary/80 z-10"></div>
            <img src="${pageContext.request.contextPath}/images/auth-side.png" alt="Sarthak"
                 class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700">
            <div class="relative z-20 h-full p-8 md:p-12 flex flex-col justify-between">
                <div>
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak"
                             class="h-14 w-auto brightness-0 invert">
                    </a>
                </div>
                <div class="hidden md:block animate-slideInLeft" style="animation-delay:0.2s;">
                    <p class="text-white text-[1.6rem] font-extrabold leading-tight mb-4">
                        Nepal's Trusted Career Platform.
                    </p>
                    <p class="text-white/70 text-sm max-w-[300px]">
                        Connect employers and job seekers across Nepal.
                    </p>
                </div>
                <div class="text-white/30 text-[0.7rem]">&copy; 2026 Sarthak Job Portal. All rights reserved.</div>
            </div>
        </div>

        <!-- Right Side: Login Form -->
        <div class="flex-1 bg-white p-10 md:p-16 flex flex-col justify-center">
            <div class="max-w-[420px] mx-auto w-full">
                <h1 class="text-3xl font-extrabold text-[#1a1a1a] mb-2">Welcome back</h1>
                <p class="text-gray-500 text-sm mb-8">Sign in to your Sarthak account</p>

                <c:if test="${not empty requestScope.error}">
                    <div class="bg-red-50 border border-red-200 text-red-600 rounded-xl p-3 text-xs mb-6">
                        ${requestScope.error}
                    </div>
                </c:if>

                <c:if test="${param.logout == 'true'}">
                    <div class="bg-green-50 border border-green-200 text-green-600 rounded-xl p-3 text-xs mb-6">
                        You have been successfully logged out.
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">

                    <div>
                        <label for="email" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Email Address</label>
                        <input type="email" id="email" name="email"
                               class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300"
                               placeholder="you@example.com" required autofocus>
                    </div>

                    <div>
                        <label for="password" class="block text-xs font-bold text-[#333] mb-1.5 uppercase tracking-wider">Password</label>
                        <input type="password" id="password" name="password"
                               class="w-full px-4 py-3.5 border border-gray-200 rounded-xl text-sm focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all placeholder:text-gray-300"
                               placeholder="••••••••" required>
                    </div>

                    <button type="submit"
                            class="w-full py-4 bg-primary text-white rounded-xl font-bold text-sm hover:bg-secondary transition-all shadow-lg shadow-primary/20 active:scale-[0.98]">
                        Sign In
                    </button>
                </form>

                <div class="text-center mt-8">
                    <p class="text-gray-600 text-sm">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/register.jsp" class="text-primary font-bold hover:underline">Register here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<!-- commit iteration 2: Add login form UI structure -->

<!-- commit iteration 7: Add PasswordUtil with BCrypt hashing -->

<!-- commit iteration 12: Implement register-employer JSP template -->

<!-- commit iteration 17: Add navbar styling to header.jsp -->

<!-- commit iteration 22: Optimize session management in LogoutServlet -->
