<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><c:out value="${pageTitle != null ? pageTitle : 'Employer Hub'}"/></title>
<!-- Inter font + Tailwind CSS via CDN -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
<script>
	tailwind.config = {
		theme: {
			extend: {
				colors: {
					brand: {
						DEFAULT: '#2563eb',
						50: '#eef6ff',
						100: '#dbeafe',
						200: '#bfdbfe'
					},
					panel: '#f8fafc'
				},
				fontFamily: {
					sans: ['Inter', 'ui-sans-serif', 'system-ui']
				}
			}
		}
	}
</script>
<script src="https://cdn.tailwindcss.com"></script>
<style>
	body { font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }
	/* small helper to ensure sidebar avatar placeholder fits */
	.sidebar-avatar { background-color: rgba(255,255,255,0.06); }
</style>
