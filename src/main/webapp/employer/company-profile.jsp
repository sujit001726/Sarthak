<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Company Profile</title>
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
                        <h1 class="text-3xl font-black text-dark italic tracking-tighter uppercase border-l-8 border-primary pl-6">Company Profile</h1>
                        <p class="text-sm font-bold text-gray-400 mt-2 pl-8">Showcase your brand and attract top talent</p>
                    </div>
                    <button id="save-profile-btn" class="bg-primary text-white px-8 py-3 rounded-xl text-sm font-bold hover:bg-opacity-90 shadow-lg shadow-primary/20">Save Changes</button>
                </div>

                <!-- Form Section -->
                <div class="bg-white rounded-[2rem] p-8 border border-gray-100 shadow-sm max-w-4xl">
                    <div class="flex items-center gap-8 mb-8 border-b border-gray-100 pb-8">
                        <div onclick="document.getElementById('logo-upload').click();" class="w-24 h-24 bg-surface rounded-2xl flex items-center justify-center text-gray-400 border-2 border-dashed border-gray-300 relative group cursor-pointer overflow-hidden">
                            <img id="logo-preview" src="${pageContext.request.contextPath}/image?userId=${sessionScope.userId}&type=profile&t=${System.currentTimeMillis()}" alt="Company Logo" class="w-full h-full object-cover">
                            <div class="absolute inset-0 bg-black/40 rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center text-white text-sm">
                                <i class="fa-solid fa-camera text-xl"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="font-bold text-dark text-lg">Company Logo</h3>
                            <p class="text-xs text-gray-400 mt-1">Recommended size 512x512px. PNG or JPG.</p>
                            <button onclick="document.getElementById('logo-upload').click();" class="mt-3 text-sm text-primary font-bold hover:underline">Upload Image</button>
                            <input type="file" id="logo-upload" accept="image/*" class="hidden">
                        </div>
                    </div>
                    
                    <form id="company-profile-form" class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Name</label>
                                <input type="text" name="companyName" value="<c:out value='${companyName}'/>" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" required>
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Industry</label>
                                <select name="industry" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    <option value="Technology & Software" ${industry == 'Technology & Software' ? 'selected' : ''}>Technology & Software</option>
                                    <option value="Finance" ${industry == 'Finance' ? 'selected' : ''}>Finance</option>
                                    <option value="Healthcare" ${industry == 'Healthcare' ? 'selected' : ''}>Healthcare</option>
                                    <option value="Education" ${industry == 'Education' ? 'selected' : ''}>Education</option>
                                    <option value="Manufacturing" ${industry == 'Manufacturing' ? 'selected' : ''}>Manufacturing</option>
                                    <option value="Other" ${industry == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="space-y-2">
                            <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Website URL</label>
                            <input type="url" name="websiteUrl" value="<c:out value='${websiteUrl}'/>" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" placeholder="https://example.com">
                        </div>
                        
                        <div class="space-y-2">
                            <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Description</label>
                            <textarea name="description" rows="4" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-medium text-dark focus:ring-2 focus:ring-primary" placeholder="Describe your company..."><c:out value='${description}'/></textarea>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-4 border-t border-gray-100">
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Company Size</label>
                                <select name="companySize" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary">
                                    <option value="1-50 Employees" ${companySize == '1-50 Employees' ? 'selected' : ''}>1-50 Employees</option>
                                    <option value="51-200 Employees" ${companySize == '51-200 Employees' ? 'selected' : ''}>51-200 Employees</option>
                                    <option value="201-500 Employees" ${companySize == '201-500 Employees' ? 'selected' : ''}>201-500 Employees</option>
                                    <option value="500+ Employees" ${companySize == '500+ Employees' ? 'selected' : ''}>500+ Employees</option>
                                </select>
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Founded Year</label>
                                <input type="number" name="foundedYear" value="<c:out value='${foundedYear}'/>" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" placeholder="e.g. 2015">
                            </div>
                            <div class="space-y-2">
                                <label class="text-xs font-black text-gray-500 uppercase tracking-wider">Location</label>
                                <input type="text" name="location" value="<c:out value='${location}'/>" class="w-full bg-surface border-none rounded-xl py-3 px-4 font-bold text-dark focus:ring-2 focus:ring-primary" placeholder="e.g. Kathmandu, Nepal">
                            </div>
                        </div>
                    </form>
                </div>
            </main>
            <div class="bg-[#1D3E35] pb-20">
                <%@ include file="/includes/footer.jsp" %>
            </div>
        </div>
    </div>

    <!-- Toast / Notification container -->
    <div id="toast-container" class="fixed bottom-5 right-5 z-50 flex flex-col gap-2"></div>

    <script>
        // Custom premium toast notification
        function showToast(title, message, isError = false) {
            const container = document.getElementById('toast-container');
            const toast = document.createElement('div');
            toast.className = `flex items-center gap-3 min-w-[300px] p-4 rounded-xl shadow-lg border text-sm transition-all duration-300 transform translate-y-2 opacity-0 ${
                isError 
                    ? 'bg-red-50 text-red-800 border-red-200' 
                    : 'bg-green-50 text-green-800 border-green-200'
            }`;
            toast.innerHTML = `
                <i class="fa-solid ${isError ? 'fa-circle-exclamation text-red-500' : 'fa-circle-check text-green-500'} text-lg"></i>
                <div class="flex-1">
                    <p class="font-bold">${title}</p>
                    <p class="text-xs opacity-90">${message}</p>
                </div>
            `;
            container.appendChild(toast);
            
            // Trigger animation
            setTimeout(() => {
                toast.classList.remove('translate-y-2', 'opacity-0');
            }, 10);

            // Remove toast
            setTimeout(() => {
                toast.classList.add('opacity-0', 'translate-y-2');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }

        // Image resizing function
        function resizeImageForUpload(file, maxSize, quality) {
            return new Promise((resolve, reject) => {
                if (!file.type || !file.type.startsWith('image/')) {
                    reject(new Error('Only image files are allowed.'));
                    return;
                }

                const img = new Image();
                const objectUrl = URL.createObjectURL(file);
                img.onload = function() {
                    URL.revokeObjectURL(objectUrl);

                    let width = img.width;
                    let height = img.height;
                    const largestSide = Math.max(width, height);
                    if (largestSide > maxSize) {
                        const scale = maxSize / largestSide;
                        width = Math.round(width * scale);
                        height = Math.round(height * scale);
                    }

                    const canvas = document.createElement('canvas');
                    canvas.width = width;
                    canvas.height = height;
                    const ctx = canvas.getContext('2d');
                    ctx.drawImage(img, 0, 0, width, height);

                    canvas.toBlob(blob => {
                        if (!blob) {
                            reject(new Error('Could not prepare image for upload.'));
                            return;
                        }
                        resolve(blob);
                    }, 'image/jpeg', quality);
                };
                img.onerror = function() {
                    URL.revokeObjectURL(objectUrl);
                    reject(new Error('Could not read selected image.'));
                };
                img.src = objectUrl;
            });
        }

        // Upload Logo Handling
        document.getElementById('logo-upload').addEventListener('change', async function(e) {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                
                // Instantly preview
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('logo-preview').src = e.target.result;
                    // Update header avatar if it exists
                    const headerAvatar = document.querySelector('img[alt="Avatar"]');
                    if (headerAvatar) {
                        headerAvatar.src = e.target.result;
                    }
                }
                reader.readAsDataURL(file);

                const formData = new FormData();
                try {
                    const resizedBlob = await resizeImageForUpload(file, 512, 0.9);
                    formData.append('image', resizedBlob, 'logo.jpg');
                    formData.append('type', 'profile');

                    const response = await fetch('${pageContext.request.contextPath}/upload-image', {
                        method: 'POST',
                        body: formData
                    });
                    
                    const text = await response.text();
                    let data;
                    try {
                        data = text ? JSON.parse(text) : {};
                    } catch (e) {
                        throw new Error(text || 'Upload failed');
                    }

                    if (response.ok && data.success) {
                        showToast('Success', 'Company logo uploaded and saved successfully.');
                        // Update preview and avatar URLs with the absolute database-backed URL
                        document.getElementById('logo-preview').src = data.imageUrl;
                        const headerAvatar = document.querySelector('img[alt="Avatar"]');
                        if (headerAvatar) {
                            headerAvatar.src = data.imageUrl;
                        }
                    } else {
                        showToast('Upload Error', data.message || 'Failed to save logo.', true);
                    }
                } catch (err) {
                    console.error('Error during image upload:', err);
                    showToast('Upload Error', err.message || 'Failed to upload logo.', true);
                }
            }
        });

        // Save Profile Details Handling
        document.getElementById('save-profile-btn').addEventListener('click', function(e) {
            e.preventDefault();
            const form = document.getElementById('company-profile-form');
            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            const formData = new URLSearchParams(new FormData(form));

            fetch('${pageContext.request.contextPath}/employer/company-profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData.toString()
            })
            .then(async response => {
                const text = await response.text();
                let data;
                try {
                    data = text ? JSON.parse(text) : {};
                } catch (e) {
                    throw new Error(text || 'Failed to save profile.');
                }
                if (!response.ok || !data.success) {
                    throw new Error(data.message || 'Failed to save profile.');
                }
                return data;
            })
            .then(data => {
                showToast('Success', 'Company profile details updated successfully.');
                // Update header greeting dynamic name if elements exist
                const greetingName = document.querySelector('.greeting-name');
                if (greetingName) {
                    greetingName.textContent = form.companyName.value;
                }
            })
            .catch(error => {
                console.error('Error saving company profile:', error);
                showToast('Error', error.message || 'Failed to update company profile details.', true);
            });
        });
    </script>
</body>
</html>
