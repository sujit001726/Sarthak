<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sarthak | Admin Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="action" value="dashboard" />
    </jsp:include>

    <main class="main-wrapper">
        <header class="top-nav">
            <div class="welcome-msg">
                <h1>Good morning, ${adminName != null ? adminName : 'Sujit'}</h1>
                <p>Here's what you need to focus on today</p>
            </div>
            <div class="top-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search for jobs, candidates...">
                </div>
                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Sujit&background=2563eb&color=fff" alt="User">
                    <div class="user-info"><span class="name">Sujit</span></div>
                    <i class="fas fa-chevron-down" style="font-size:0.7rem;color:var(--text-dim);"></i>
                </div>
            </div>
        </header>

        <div class="content-area">
            <section class="stats-container">
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${jobCount}</span>
                        <div class="stat-icon-mini" style="background:#eff6ff;color:#3b82f6;"><i class="fas fa-briefcase"></i></div>
                    </div>
                    <span class="stat-label">All Jobs</span>
                    <a href="admin?action=jobs" class="stat-more">View More <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${userCount}</span>
                        <div class="stat-icon-mini" style="background:#fdf2f8;color:#db2777;"><i class="fas fa-users"></i></div>
                    </div>
                    <span class="stat-label">Total Candidates</span>
                    <a href="admin?action=candidates" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${appCount}</span>
                        <div class="stat-icon-mini" style="background:#f5f3ff;color:#7c3aed;"><i class="fas fa-file-alt"></i></div>
                    </div>
                    <span class="stat-label">Total Applications</span>
                    <a href="admin?action=jobBoard" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${interviewCount}</span>
                        <div class="stat-icon-mini" style="background:#fff7ed;color:#ea580c;"><i class="fas fa-video"></i></div>
                    </div>
                    <span class="stat-label">Total Interviews</span>
                    <a href="admin?action=interviews" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${hiredCount}</span>
                        <div class="stat-icon-mini" style="background:#f0fdf4;color:#16a34a;"><i class="fas fa-check-circle"></i></div>
                    </div>
                    <span class="stat-label">Total Hired</span>
                    <a href="admin?action=shortlisted" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-value">${rejectedCount}</span>
                        <div class="stat-icon-mini" style="background:#fef2f2;color:#dc2626;"><i class="fas fa-times-circle"></i></div>
                    </div>
                    <span class="stat-label">Total Rejected</span>
                    <a href="admin?action=candidates" class="stat-more">More Info <i class="fas fa-arrow-right"></i></a>
                </div>
            </section>

            <div class="dashboard-grid">
                <div class="grid-left">
                    <div class="content-card">
                        <div class="card-header">
                            <h3>Your Job Ads</h3>
                            <div>
                                <button class="btn-sm btn-outline">VIEW ALL</button>
                                <a href="admin?action=addJob" class="btn-sm btn-primary" style="text-decoration:none;">Create Job Ad +</a>
                            </div>
                        </div>
                        <table class="data-table">
                            <thead>
                                <tr><th>Job Title</th><th>New</th><th>Waiting</th><th>Total</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="job" items="${recentJobs}">
                                    <tr>
                                        <td><div class="job-row"><span class="job-title">${job.title}</span><span class="job-meta">W1</span></div></td>
                                        <td><strong>185</strong></td><td>0</td><td><strong>250</strong></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentJobs}">
                                    <tr><td colspan="4" style="text-align:center;color:var(--text-dim);">No job ads found</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="content-card">
                        <div class="card-header"><h3>Top Experience Levels</h3></div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Entry Level</span><span>45%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width:45%;background:#3b82f6;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Intermediate</span><span>30%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width:30%;background:#f59e0b;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Senior</span><span>15%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width:15%;background:#10b981;"></div></div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-info"><span>Expert</span><span>10%</span></div>
                            <div class="progress-bar"><div class="progress-fill" style="width:10%;background:#7c3aed;"></div></div>
                        </div>
                    </div>


                </div>

                <div class="grid-right">
                    <div class="content-card">
                        <div class="card-header"><h3>Total Overview</h3></div>
                        <div class="donut-container">
                            <canvas id="overviewChart"></canvas>
                            <div class="donut-center">
                                <span class="val">12</span>
                                <span class="lbl">Total Candidates</span>
                            </div>
                        </div>
                    </div>

                    <!-- Nepali Calendar -->
                    <div class="content-card" style="padding:0;overflow:hidden;">
                        <div style="background:#1a3a8f;color:#fff;display:flex;justify-content:space-between;align-items:center;padding:8px 12px;">
                            <div id="np-bs-label" style="font-size:1rem;font-weight:700;letter-spacing:0.5px;"></div>
                            <div style="display:flex;align-items:center;gap:6px;">
                                <button onclick="npPrev()" style="background:rgba(255,255,255,0.25);border:none;color:#fff;font-size:1.2rem;cursor:pointer;border-radius:3px;width:26px;height:26px;line-height:1;">&#8249;</button>
                                <span id="np-ad-label" style="font-size:0.78rem;font-weight:600;white-space:nowrap;"></span>
                                <button onclick="npNext()" style="background:rgba(255,255,255,0.25);border:none;color:#fff;font-size:1.2rem;cursor:pointer;border-radius:3px;width:26px;height:26px;line-height:1;">&#8250;</button>
                            </div>
                        </div>
                        <div id="np-day-hdr" style="display:grid;grid-template-columns:repeat(7,1fr);background:#2952c4;"></div>
                        <div id="np-grid" style="display:grid;grid-template-columns:repeat(7,1fr);border-left:1px solid #d0d8f0;"></div>
                        <div id="np-strip" style="background:#eef2ff;text-align:center;font-size:0.72rem;color:#1a3a8f;padding:4px;font-weight:600;border-top:1px solid #d0d8f0;"></div>
                    </div>


                </div>
            </div>
        </div>
    </main>

    <script>
    // ── Nepali BS Calendar ────────────────────────────────────────────────────
    const NPD = {
        2000:[30,32,31,32,31,30,30,30,29,30,29,31],2001:[31,31,32,31,31,31,30,29,30,29,30,30],
        2002:[31,31,32,32,31,30,30,29,30,29,30,30],2003:[31,32,31,32,31,30,30,30,29,29,30,31],
        2004:[30,32,31,32,31,30,30,30,29,30,29,31],2005:[31,31,32,31,31,31,30,29,30,29,30,30],
        2006:[31,31,32,32,31,30,30,29,30,29,30,30],2007:[31,32,31,32,31,30,30,30,29,29,30,31],
        2008:[31,31,31,32,31,31,29,30,30,29,29,31],2009:[31,31,32,31,31,31,30,29,30,29,30,30],
        2010:[31,31,32,32,31,30,30,29,30,29,30,30],2011:[31,32,31,32,31,30,30,30,29,29,30,31],
        2012:[31,31,31,32,31,31,29,30,30,29,30,30],2013:[31,31,32,31,31,31,30,29,30,29,30,30],
        2014:[31,31,32,32,31,30,30,29,30,29,30,30],2015:[31,32,31,32,31,30,30,30,29,29,30,31],
        2016:[31,31,31,32,31,31,29,30,30,29,30,30],2017:[31,31,32,31,31,31,30,29,30,29,30,30],
        2018:[31,31,32,32,31,30,30,29,30,29,30,30],2019:[31,32,31,32,31,30,30,30,29,29,30,31],
        2020:[31,31,31,32,31,31,30,29,30,29,30,30],2021:[31,31,32,31,31,31,30,29,30,29,30,30],
        2022:[31,31,32,32,31,30,30,29,30,29,30,30],2023:[31,32,31,32,31,30,30,30,29,29,30,31],
        2024:[31,31,31,32,31,31,30,29,30,29,30,30],2025:[31,31,32,31,31,31,30,29,30,29,30,30],
        2026:[31,31,32,32,31,30,30,29,30,29,30,30],2027:[31,32,31,32,31,30,30,30,29,29,30,32],
        2028:[30,32,31,32,31,30,30,30,29,30,29,31],2029:[31,31,32,31,31,31,30,29,30,29,30,30],
        2030:[31,31,32,32,31,30,30,29,30,29,30,30],2031:[31,32,31,32,31,30,30,30,29,29,30,31],
        2032:[30,32,31,32,31,30,30,30,29,30,29,31],2033:[31,31,32,31,31,31,30,29,30,29,30,30],
        2034:[31,31,32,32,31,30,30,29,30,29,30,30],2035:[31,32,31,32,31,30,30,30,29,29,30,31],
        2036:[30,32,31,32,31,31,29,30,30,29,29,31],2037:[31,31,32,31,31,31,30,29,30,29,30,30],
        2038:[31,31,32,32,31,30,30,29,30,29,30,30],2039:[31,32,31,32,31,30,30,30,29,29,30,31],
        2040:[31,31,31,32,31,31,29,30,30,29,30,30],2041:[31,31,32,31,31,31,30,29,30,29,30,30],
        2042:[31,31,32,32,31,30,30,29,30,29,30,30],2043:[31,32,31,32,31,30,30,30,29,29,30,31],
        2044:[30,32,31,32,31,30,30,30,29,30,29,31],2045:[31,31,32,31,31,31,30,29,30,29,30,30],
        2046:[31,31,32,32,31,30,30,29,30,29,30,30],2047:[31,32,31,32,31,30,30,30,29,29,30,31],
        2048:[30,32,31,32,31,31,29,30,29,30,29,31],2049:[31,31,32,31,31,31,30,29,30,29,30,30],
        2050:[31,31,32,32,31,30,30,29,30,29,30,30],2051:[31,32,31,32,31,30,30,30,29,29,30,31],
        2052:[31,31,31,32,31,31,29,30,30,29,30,30],2053:[31,31,32,31,31,31,30,29,30,29,30,30],
        2054:[31,31,32,32,31,30,30,29,30,29,30,30],2055:[31,32,31,32,31,30,30,30,29,29,30,31],
        2056:[30,32,31,32,31,30,30,30,29,30,29,31],2057:[31,31,32,31,31,31,30,29,30,29,30,30],
        2058:[31,31,32,32,31,30,30,29,30,29,30,30],2059:[31,32,31,32,31,30,30,30,29,29,30,31],
        2060:[30,32,31,32,31,31,29,30,30,29,29,31],2061:[31,31,32,31,31,31,30,29,30,29,30,30],
        2062:[31,31,32,32,31,30,30,29,30,29,30,30],2063:[31,32,31,32,31,30,30,30,29,29,30,31],
        2064:[30,32,31,32,31,30,30,30,29,30,29,31],2065:[31,31,32,31,31,31,30,29,30,29,30,30],
        2066:[31,31,32,32,31,30,30,29,30,29,30,30],2067:[31,32,31,32,31,30,30,30,29,29,30,31],
        2068:[31,31,31,32,31,31,29,30,30,29,30,30],2069:[31,31,32,31,31,31,30,29,30,29,30,30],
        2070:[31,31,32,32,31,30,30,29,30,29,30,30],2071:[31,32,31,32,31,30,30,30,29,29,30,31],
        2072:[31,31,31,32,31,31,29,30,30,29,30,30],2073:[31,31,32,31,31,31,30,29,30,29,30,30],
        2074:[31,31,32,32,31,30,30,29,30,29,30,30],2075:[31,32,31,32,31,30,30,30,29,29,30,31],
        2076:[30,32,31,32,31,30,30,30,29,30,29,31],2077:[31,31,32,31,31,31,30,29,30,29,30,30],
        2078:[31,31,32,32,31,30,30,29,30,29,30,30],2079:[31,32,31,32,31,30,30,30,29,29,30,31],
        2080:[31,31,31,32,31,31,30,29,30,29,30,30],2081:[31,31,32,31,31,31,30,29,30,29,30,30],
        2082:[31,31,32,32,31,30,30,29,30,29,30,30],2083:[31,32,31,32,31,30,30,30,29,29,30,31],
        2084:[31,31,31,32,31,31,29,30,30,29,30,30],2085:[31,31,32,31,31,31,30,29,30,29,30,30],
        2086:[31,31,32,32,31,30,30,29,30,29,30,30],2087:[31,32,31,32,31,30,30,30,29,29,30,31],
        2088:[30,32,31,32,31,30,30,30,29,30,29,31],2089:[31,31,32,31,31,31,30,29,30,29,30,30]
    };

    const NP_M_DEV = ['बैशाख','जेठ','असार','श्रावण','भाद्र','आश्विन','कार्तिक','मंसिर','पुष','माघ','फाल्गुन','चैत्र'];
    const NP_M_EN  = ['Baisakh','Jestha','Ashadh','Shrawan','Bhadra','Ashwin','Kartik','Mangsir','Poush','Magh','Falgun','Chaitra'];
    const AD_OVERLAP = ['Apr/May','May/Jun','Jun/Jul','Jul/Aug','Aug/Sep','Sep/Oct','Oct/Nov','Nov/Dec','Dec/Jan','Jan/Feb','Feb/Mar','Mar/Apr'];
    const NP_DAYS_DEV = ['आईतवार','सोमवार','मंगलवार','बुधवार','बिहीवार','शुक्रवार','शनिवार'];
    const NP_DIG = ['०','१','२','३','४','५','६','७','८','९'];

    function toNep(n) { return String(n).split('').map(c=>NP_DIG[+c]||c).join(''); }

    function adToBS(y,m,d) {
        const ref = new Date(1943,3,14);
        let days = Math.floor((new Date(y,m,d)-ref)/86400000);
        let bY=2000,bM=0,bD=1;
        outer: for(let yr=2000;yr<=2089;yr++){
            const mo=NPD[yr]; if(!mo) break;
            for(let mn=0;mn<12;mn++){
                if(days<mo[mn]){bY=yr;bM=mn;bD=days+1;break outer;}
                days-=mo[mn];
            }
        }
        return {year:bY,month:bM,day:bD};
    }

    function bsStartAD(bY,bM) {
        const ref = new Date(1943,3,14);
        let days=0;
        for(let y=2000;y<bY;y++){if(!NPD[y])break;NPD[y].forEach(d=>days+=d);}
        for(let m=0;m<bM;m++) days+=NPD[bY][m];
        return new Date(ref.getTime()+days*86400000);
    }

    const todayAD = new Date();
    const todayBS = adToBS(todayAD.getFullYear(),todayAD.getMonth(),todayAD.getDate());
    let npCur = {year:todayBS.year, month:todayBS.month};

    function renderNP() {
        const {year,month} = npCur;
        const total = NPD[year][month];
        const firstAD = bsStartAD(year,month);
        const startDay = firstAD.getDay(); // 0=Sun

        // Header
        document.getElementById('np-bs-label').textContent = NP_M_DEV[month]+' '+toNep(year);
        document.getElementById('np-ad-label').textContent = AD_OVERLAP[month]+' '+firstAD.getFullYear();

        // Day headers
        const hdr = document.getElementById('np-day-hdr');
        hdr.innerHTML='';
        NP_DAYS_DEV.forEach((d,i)=>{
            const el=document.createElement('div');
            el.style.cssText='color:'+(i===6?'#ffaaaa':'#cce')+';font-size:0.6rem;font-weight:600;text-align:center;padding:4px 1px;border-right:1px solid rgba(255,255,255,0.1);';
            el.textContent=d;
            hdr.appendChild(el);
        });

        // Grid
        const grid = document.getElementById('np-grid');
        grid.innerHTML='';
        let adCursor = new Date(firstAD);

        for(let col=0; col < startDay+total; col++){
            const cell=document.createElement('div');
            const isSat=(col%7===6);
            const isBlank=(col<startDay);
            cell.style.cssText='border-right:1px solid #d0d8f0;border-bottom:1px solid #d0d8f0;min-height:48px;padding:2px 3px;position:relative;box-sizing:border-box;';

            if(!isBlank){
                const bsDay=col-startDay+1;
                const adDay=adCursor.getDate();
                const isToday=(bsDay===todayBS.day&&month===todayBS.month&&year===todayBS.year);

                if(isToday) cell.style.background='#1a3a8f';

                // Large BS numeral (Devanagari)
                const big=document.createElement('div');
                big.style.cssText='font-size:1.25rem;font-weight:700;line-height:1.1;color:'+(isToday?'#fff':(isSat?'#cc0000':'#111'))+';';
                big.textContent=toNep(bsDay);

                // Small AD date bottom-right
                const small=document.createElement('div');
                small.style.cssText='font-size:0.62rem;color:'+(isToday?'#aac':'#2952c4')+';position:absolute;bottom:2px;right:3px;font-weight:600;';
                small.textContent=adDay;

                if(!isToday){
                    cell.onmouseover=()=>cell.style.background='#eef2ff';
                    cell.onmouseout=()=>cell.style.background='';
                }
                cell.appendChild(big);
                cell.appendChild(small);
                adCursor.setDate(adCursor.getDate()+1);
            }
            grid.appendChild(cell);
        }

        // Today strip
        document.getElementById('np-strip').textContent=
            'आज: '+NP_M_DEV[todayBS.month]+' '+toNep(todayBS.day)+', '+toNep(todayBS.year)+
            '  |  Today: '+todayAD.toDateString();
    }

    window.npPrev=()=>{npCur.month--;if(npCur.month<0){npCur.month=11;npCur.year--;}renderNP();};
    window.npNext=()=>{npCur.month++;if(npCur.month>11){npCur.month=0;npCur.year++;}renderNP();};
    renderNP();

    // Chart
    const ctx = document.getElementById('overviewChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Recommended','Shortlisted','Applicants','Interview','Rejected','Hired'],
            datasets: [{
                data: [5,2,2,2,1,0],
                backgroundColor: ['#2563eb','#3b82f6','#0ea5e9','#f59e0b','#ef4444','#10b981'],
                borderWidth: 0,
                cutout: '80%'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } }
        }
    });
    </script>
</body>
</html>
