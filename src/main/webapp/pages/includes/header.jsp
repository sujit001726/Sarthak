<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="top-nav">
    <div class="mobile-menu-toggle" id="mobileMenuToggle" onclick="toggleMobileSidebar()">
        <i class="fas fa-bars"></i>
    </div>
    <div class="welcome-msg">
        <h1>${param.title != null ? param.title : 'Admin Dashboard'}</h1>
        <p>${param.subtitle != null ? param.subtitle : 'Welcome back'}</p>
    </div>

    <script>
        function toggleMobileSidebar() {
            document.body.classList.toggle('sidebar-open');
        }
        
        // Close sidebar when clicking outside on mobile overlay (added via CSS)
        document.addEventListener('click', function(e) {
            const sidebar = document.querySelector('.sidebar');
            const toggle = document.getElementById('mobileMenuToggle');
            if (document.body.classList.contains('sidebar-open') && 
                !sidebar.contains(e.target) && 
                !toggle.contains(e.target)) {
                document.body.classList.remove('sidebar-open');
            }
        });
    </script>
    <div class="top-actions">
        <!-- Notifications -->
        <div style="display: flex; align-items: center;">
            <jsp:include page="/includes/notification-dropdown.jsp" />
        </div>
        
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="adminSearchInput" placeholder="Search for jobs, candidates..." autocomplete="off">
            <div id="adminSearchResults" class="search-results-dropdown"></div>
        </div>

        <script>
            (function() {
                const searchInput = document.getElementById('adminSearchInput');
                const resultsDropdown = document.getElementById('adminSearchResults');
                let debounceTimer;

                if (!searchInput || !resultsDropdown) return;

                searchInput.addEventListener('input', () => {
                    const query = searchInput.value.toLowerCase().trim();
                    
                    // 1. Local Table Filtering, Highlighting & Reordering
                    const tables = document.querySelectorAll('.data-table');
                    tables.forEach(table => {
                        const tbody = table.querySelector('tbody');
                        if (!tbody) return;
                        
                        const rows = Array.from(tbody.querySelectorAll('tr'));
                        if (rows.length <= 1 && rows[0].textContent.includes('No')) return;

                        const matchingRows = [];
                        const nonMatchingRows = [];

                        rows.forEach(row => {
                            const text = row.textContent.toLowerCase();
                            const isMatch = text.includes(query);
                            
                            if (query === "") {
                                row.style.display = '';
                                removeHighlights(row);
                                nonMatchingRows.push(row);
                            } else {
                                if (isMatch) {
                                    row.style.display = '';
                                    highlightText(row, query);
                                    matchingRows.push(row);
                                } else {
                                    row.style.display = 'none';
                                    removeHighlights(row);
                                    nonMatchingRows.push(row);
                                }
                            }
                        });

                        // Reorder: Matches first
                        if (query !== "") {
                            tbody.innerHTML = '';
                            matchingRows.forEach(r => tbody.appendChild(r));
                            nonMatchingRows.forEach(r => tbody.appendChild(r));
                        } else {
                            // Restore original order if needed (though stable sort usually keeps it)
                            tbody.innerHTML = '';
                            rows.forEach(r => tbody.appendChild(r));
                        }

                        // Visual feedback for sections
                        const card = table.closest('.content-card');
                        if (card && query !== "") {
                            card.style.opacity = matchingRows.length > 0 ? '1' : '0.4';
                        } else if (card) {
                            card.style.opacity = '1';
                        }
                    });

                    // 2. Global Search Dropdown
                    clearTimeout(debounceTimer);
                    if (query.length < 2) {
                        resultsDropdown.classList.remove('active');
                        return;
                    }

                    debounceTimer = setTimeout(() => {
                        fetch('${pageContext.request.contextPath}/admin/search?q=' + encodeURIComponent(query))
                            .then(res => res.json())
                            .then(data => {
                                renderResults(data, query);
                            })
                            .catch(err => console.error('Search error:', err));
                    }, 300);
                });

                function highlightText(row, query) {
                    removeHighlights(row);
                    if (query === "") return;
                    
                    const cells = row.querySelectorAll('td');
                    cells.forEach(cell => {
                        // Skip cells with buttons or complex forms to avoid breaking them
                        if (cell.querySelector('button') || cell.querySelector('form')) {
                             // Only highlight the text nodes if possible
                        }
                        
                        innerHighlight(cell, query);
                    });
                }

                function innerHighlight(node, query) {
                    const regex = new RegExp('(' + query + ')', 'gi');
                    const skipTags = /^(script|style|button|form|input|i|mark)$/i;
                    
                    if (node.nodeType === 3) { // Text node
                        if (node.nodeValue.toLowerCase().includes(query)) {
                            const span = document.createElement('span');
                            span.innerHTML = node.nodeValue.replace(regex, '<mark style="background: #fde047; color: #000; padding: 2px 4px; border-radius: 4px; font-weight: bold; box-shadow: 0 2px 4px rgba(0,0,0,0.1)">$1</mark>');
                            node.parentNode.replaceChild(span, node);
                        }
                    } else if (node.nodeType === 1 && !skipTags.test(node.tagName)) { // Element node
                        for (let i = 0; i < node.childNodes.length; i++) {
                            innerHighlight(node.childNodes[i], query);
                        }
                    }
                }

                function removeHighlights(row) {
                    const marks = row.querySelectorAll('mark');
                    marks.forEach(mark => {
                        const text = document.createTextNode(mark.textContent);
                        const span = mark.parentNode;
                        if (span && span.tagName === 'SPAN' && span.childNodes.length === 1) {
                            span.parentNode.replaceChild(text, span);
                        } else {
                            mark.parentNode.replaceChild(text, mark);
                        }
                    });
                }

                function renderResults(data, query) {
                    resultsDropdown.innerHTML = '';
                    let hasResults = false;

                    if (data.jobs && data.jobs.length > 0) {
                        hasResults = true;
                        const title = document.createElement('div');
                        title.className = 'search-section-title';
                        title.innerHTML = '<i class="fas fa-briefcase"></i> Global Jobs';
                        resultsDropdown.appendChild(title);

                        data.jobs.forEach(job => {
                            const item = createResultItem(job.title, job.company, 'fas fa-external-link-alt', '${pageContext.request.contextPath}/admin?action=jobs');
                            resultsDropdown.appendChild(item);
                        });
                    }

                    if (data.candidates && data.candidates.length > 0) {
                        hasResults = true;
                        const title = document.createElement('div');
                        title.className = 'search-section-title';
                        title.innerHTML = '<i class="fas fa-user-graduate"></i> Global Candidates';
                        resultsDropdown.appendChild(title);

                        data.candidates.forEach(cand => {
                            const item = createResultItem(cand.name, cand.email, 'fas fa-external-link-alt', '${pageContext.request.contextPath}/admin?action=candidates');
                            resultsDropdown.appendChild(item);
                        });
                    }

                    if (!hasResults) {
                        resultsDropdown.innerHTML = '<div class="no-results">No global matches for "' + query + '"</div>';
                    }

                    resultsDropdown.classList.add('active');
                }

                function createResultItem(name, meta, icon, link) {
                    const a = document.createElement('a');
                    a.href = link;
                    a.className = 'search-result-item';
                    a.innerHTML = 
                        '<div class="search-result-info">' +
                            '<span class="search-result-name">' + name + '</span>' +
                            '<span class="search-result-meta"><i class="' + icon + '"></i> ' + meta + '</span>' +
                        '</div>';
                    return a;
                }

                searchInput.addEventListener('keydown', (e) => {
                    if (e.key === 'Enter') {
                        const firstItem = resultsDropdown.querySelector('.search-result-item');
                        if (firstItem) firstItem.click();
                    }
                });

                document.addEventListener('click', (e) => {
                    if (!searchInput.contains(e.target) && !resultsDropdown.contains(e.target)) {
                        resultsDropdown.classList.remove('active');
                    }
                });
            })();
        </script>

        <div class="user-profile">
            <img src="https://ui-avatars.com/api/?name=Admin&background=1D3E35&color=fff" alt="User">
            <div class="user-info"><span class="name">Admin</span></div>
            <i class="fas fa-chevron-down" style="font-size:0.7rem;color:var(--text-dim);"></i>
        </div>
    </div>
</header>
