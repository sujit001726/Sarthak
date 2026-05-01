<%@ page contentType="text/html; charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error — Sarthak Job Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1D3E35',
                        secondary: '#4E7A6E',
                        dark: '#0F211C',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');
    @layer base {
      body { @apply font-sans text-gray-900 bg-white; }
    }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-[#fcfdfd] relative overflow-hidden">
    <!-- Subtle Background Pattern -->
    <div class="absolute inset-0 z-0 opacity-5 pointer-events-none" style="background-image: url('https://www.toptal.com/designers/subtlepatterns/uploads/double_lined.png');"></div>
    <div class="absolute top-0 left-0 w-full h-[3px] bg-gradient-to-r from-primary to-secondary"></div>

    <div class="text-center p-8 max-w-[550px] relative z-10">
        <!-- Logo -->
        <div class="mb-12">
            <a href="${pageContext.request.contextPath}/index.jsp" class="inline-block hover:scale-105 transition-transform duration-300">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Sarthak" class="h-16 w-auto mx-auto">
            </a>
        </div>

        <!-- Error Illustration/Icon -->
        <div class="mb-8 relative inline-block">
            <div class="absolute inset-0 bg-primary/10 blur-3xl rounded-full scale-150"></div>
            <div class="relative w-32 h-32 bg-primary/5 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-primary animate-bounce">
                    <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/>
                    <line x1="12" y1="9" x2="12" y2="13"/>
                    <line x1="12" y1="17" x2="12.01" y2="17"/>
                </svg>
            </div>
            <!-- Error Code -->
            <h1 class="text-[8rem] font-black leading-none text-primary/10 absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 select-none z-[-1]">
                ${pageContext.errorData.statusCode != 0 ? pageContext.errorData.statusCode : '404'}
            </h1>
        </div>

        <h2 class="text-[2rem] lg:text-[2.5rem] font-black text-[#0f1a17] leading-tight mb-4">
            Oops! Something <span class="text-secondary">Went Wrong</span>
        </h2>
        
        <p class="text-gray-500 text-lg mb-10 max-w-[400px] mx-auto font-medium">
            The page you're looking for doesn't exist or an unexpected error occurred.
        </p>

        <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
            <a href="${pageContext.request.contextPath}/index.jsp" class="w-full sm:w-auto px-10 py-4 bg-primary text-white rounded-2xl font-bold hover:bg-secondary transition-all shadow-xl shadow-primary/20 flex items-center justify-center gap-2 group">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="group-hover:-translate-x-1 transition-transform"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                Back to Home
            </a>
            <a href="#" class="w-full sm:w-auto px-10 py-4 border-2 border-primary/10 text-primary rounded-2xl font-bold hover:bg-primary/5 transition-all flex items-center justify-center gap-2">
                Report Issue
            </a>
        </div>

        <!-- Footer Note -->
        <p class="mt-16 text-gray-400 text-xs font-bold uppercase tracking-widest">
            &copy; 2026 Sarthak Job Portal. Nepal's Trusted Career Partner.
        </p>
    </div>

    <!-- Decorative Elements -->
    <div class="absolute -bottom-24 -left-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl"></div>
    <div class="absolute -top-24 -right-24 w-64 h-64 bg-secondary/5 rounded-full blur-3xl"></div>
</body>
</html>
