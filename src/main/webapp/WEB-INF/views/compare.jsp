<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Đối Chiếu Văn Hóa Tết Ba Miền - Bắc • Trung • Nam'}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root {
            --tet-red: #b71c1c;
            --tet-red-dark: #7f0000;
            --tet-gold: #f59e0b;
            --tet-cream: #fffdfa;
            --north-color: #b91c1c;
            --central-color: #d97706;
            --south-color: #047857;
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: linear-gradient(135deg, #fffaf5 0%, #fff1eb 50%, #fff9f0 100%);
            color: #1f2937;
            min-height: 100vh;
        }

        .font-serif {
            font-family: 'Playfair Display', serif;
        }

        /* Navbar Tết Theme */
        .tet-navbar {
            background: linear-gradient(90deg, #991b1b 0%, #b91c1c 50%, #7f1d1d 100%);
            box-shadow: 0 4px 20px rgba(185, 28, 28, 0.25);
            border-bottom: 2px solid var(--tet-gold);
        }

        .tet-logo {
            font-size: 1.4rem;
            font-weight: 700;
            color: #fff !important;
        }

        .nav-link.custom-nav {
            color: rgba(255, 255, 255, 0.88) !important;
            font-weight: 500;
            padding: 8px 16px !important;
            border-radius: 999px;
            transition: all 0.25s ease;
        }

        .nav-link.custom-nav:hover, .nav-link.custom-nav.active {
            color: #fff !important;
            background: rgba(245, 158, 11, 0.25);
            border: 1px solid var(--tet-gold);
        }

        /* Control Card */
        .control-panel {
            background: #ffffff;
            border-radius: 18px;
            border: 1px solid #fed7aa;
            box-shadow: 0 4px 20px rgba(249, 115, 22, 0.08);
            padding: 20px 24px;
        }

        .btn-mode-toggle {
            border: 1px solid #fecaca;
            color: #6b7280;
            font-weight: 600;
            padding: 8px 18px;
            border-radius: 999px;
            transition: all 0.25s ease;
        }

        .btn-mode-toggle.active {
            background: var(--tet-red);
            color: #ffffff;
            border-color: var(--tet-red);
            box-shadow: 0 4px 12px rgba(185, 28, 28, 0.25);
        }

        /* Bảng So Sánh (Comparison Table) */
        .comparison-table-wrapper {
            background: #ffffff;
            border-radius: 20px;
            border: 2px solid #fee2e2;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(183, 28, 28, 0.06);
        }

        .table-compare {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table-compare thead th {
            background: linear-gradient(135deg, #fff5f5 0%, #fffbeb 100%);
            border-bottom: 2px solid #fecaca;
            padding: 18px 20px;
            font-weight: 700;
            font-size: 1.05rem;
            vertical-align: middle;
        }

        .th-category {
            width: 22%;
            background: #fef2f2 !important;
            color: #991b1b;
        }

        .th-north {
            width: 26%;
            color: var(--north-color);
            border-top: 4px solid var(--north-color);
        }

        .th-central {
            width: 26%;
            color: var(--central-color);
            border-top: 4px solid var(--central-color);
        }

        .th-south {
            width: 26%;
            color: var(--south-color);
            border-top: 4px solid var(--south-color);
        }

        .table-compare tbody td {
            padding: 18px 20px;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
            font-size: 0.95rem;
            line-height: 1.55;
            transition: background-color 0.2s ease;
        }

        .table-compare tbody tr:hover td {
            background-color: #fffaf0;
        }

        .td-category-title {
            font-weight: 600;
            color: #1f2937;
            background: #fafafa;
        }

        /* Chế độ Cột Song Song (Side-by-side Cards) */
        .region-column-card {
            background: #ffffff;
            border-radius: 20px;
            border: 2px solid #f3f4f6;
            box-shadow: 0 8px 24px rgba(0,0,0,0.04);
            height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .region-column-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 30px rgba(0,0,0,0.08);
        }

        .region-column-card.card-north { border-top: 6px solid var(--north-color); }
        .region-column-card.card-central { border-top: 6px solid var(--central-color); }
        .region-column-card.card-south { border-top: 6px solid var(--south-color); }

        .column-header {
            padding: 20px 24px;
            border-bottom: 1px solid #f3f4f6;
        }

        .card-north .column-header { background: #fff5f5; }
        .card-central .column-header { background: #fffbeb; }
        .card-south .column-header { background: #f0fdf4; }

        .column-body {
            padding: 20px 24px;
            flex-grow: 1;
        }

        .section-mini-title {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .feature-item-pill {
            background: #fafafa;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 10px 14px;
            margin-bottom: 10px;
            font-size: 0.9rem;
        }

        /* Spinner & Utilities */
        .tet-spinner {
            color: var(--tet-red);
            width: 3rem;
            height: 3rem;
        }

        @media print {
            .tet-navbar, .control-panel, .btn-print, footer {
                display: none !important;
            }
            body {
                background: #ffffff;
            }
            .comparison-table-wrapper {
                box-shadow: none;
                border: 1px solid #000;
            }
        }
    </style>
</head>
<body>

    <!-- 1. Thanh điều hướng chính (Navbar) -->
    <nav class="navbar navbar-expand-lg tet-navbar sticky-top">
        <div class="container-fluid px-lg-5">
            <a class="navbar-brand tet-logo d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/">
                <span class="fs-4">🌸</span>
                <div>
                    <span class="font-serif">Bản Đồ Tết Việt</span>
                    <span class="badge bg-warning text-dark ms-2 fw-semibold" style="font-size: 0.7rem;">Đề Tài C05</span>
                </div>
            </a>
            
            <button class="navbar-toggler text-white border-white" type="button" data-bs-toggle="collapse" data-bs-target="#compareNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="compareNavbar">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center gap-2">
                    <li class="nav-item">
                        <a class="nav-link custom-nav" href="${pageContext.request.contextPath}/">
                            <i class="bi bi-geo-alt-fill me-1 text-warning"></i> Bản Đồ Tương Tác
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link custom-nav active" href="${pageContext.request.contextPath}/compare">
                            <i class="bi bi-layout-split me-1 text-warning"></i> So Sánh Ba Miền
                        </a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light btn-sm rounded-pill px-3">
                            <i class="bi bi-arrow-left me-1"></i> Trở Về Bản Đồ
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 2. Bảng điều khiển & Tùy chọn so sánh -->
    <div class="container-fluid px-lg-5 py-4">
        <div class="control-panel mb-4">
            <div class="row align-items-center gy-3">
                <div class="col-lg-5">
                    <h1 class="h3 fw-bold text-danger font-serif mb-1">
                        <i class="bi bi-columns-gap text-warning me-2"></i>Đối Chiếu Văn Hóa Tết Ba Miền
                    </h1>
                    <p class="text-muted small mb-0">
                        Bảng so sánh chi tiết các nét đặc trưng Tết cổ truyền giữa Bắc Bộ, Trung Bộ và Nam Bộ.
                    </p>
                </div>

                <!-- Lọc vùng miền & Chuyển chế độ hiển thị -->
                <div class="col-lg-7 text-lg-end d-flex flex-wrap gap-3 justify-content-lg-end align-items-center">
                    
                    <!-- Checkbox chọn vùng so sánh -->
                    <div class="d-inline-flex align-items-center gap-2 bg-light p-2 rounded-pill border">
                        <span class="small fw-semibold text-secondary px-2">Vùng:</span>
                        <div class="form-check form-check-inline mb-0 me-1">
                            <input class="form-check-input region-checkbox" type="checkbox" id="chkNorth" value="NORTH" checked onchange="onRegionFilterChanged()">
                            <label class="form-check-label small fw-semibold text-danger" for="chkNorth">Miền Bắc</label>
                        </div>
                        <div class="form-check form-check-inline mb-0 me-1">
                            <input class="form-check-input region-checkbox" type="checkbox" id="chkCentral" value="CENTRAL" checked onchange="onRegionFilterChanged()">
                            <label class="form-check-label small fw-semibold text-warning-emphasis" for="chkCentral">Miền Trung</label>
                        </div>
                        <div class="form-check form-check-inline mb-0 me-2">
                            <input class="form-check-input region-checkbox" type="checkbox" id="chkSouth" value="SOUTH" checked onchange="onRegionFilterChanged()">
                            <label class="form-check-label small fw-semibold text-success" for="chkSouth">Miền Nam</label>
                        </div>
                    </div>

                    <!-- Nút chuyển chế độ: Bảng (Table) vs Cột (Cards) -->
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-mode-toggle active" id="btnModeTable" onclick="switchViewMode('table')">
                            <i class="bi bi-table me-1"></i> Dạng Bảng
                        </button>
                        <button type="button" class="btn btn-mode-toggle" id="btnModeCards" onclick="switchViewMode('cards')">
                            <i class="bi bi-layout-three-columns me-1"></i> Cột Song Song
                        </button>
                    </div>

                    <!-- Nút In / Xuất tài liệu -->
                    <button type="button" class="btn btn-outline-secondary rounded-pill btn-print" onclick="window.print()">
                        <i class="bi bi-printer me-1"></i> In
                    </button>

                </div>
            </div>
        </div>

        <!-- 3. Khu vực hiển thị kết quả so sánh -->
        <div id="comparisonContainer">
            <!-- Loading Spinner -->
            <div class="text-center py-5" id="compareSpinner">
                <div class="spinner-border tet-spinner" role="status">
                    <span class="visually-hidden">Đang tải dữ liệu so sánh...</span>
                </div>
                <p class="text-muted mt-3 mb-0">Đang tổng hợp dữ liệu phong tục Tết ba miền từ API...</p>
            </div>
            
            <!-- Chế độ 1: BẢNG MA TRẬN SO SÁNH (Table View) -->
            <div id="tableView" class="d-none">
                <div class="comparison-table-wrapper">
                    <div class="table-responsive">
                        <table class="table table-compare table-hover align-middle">
                            <thead>
                                <tr>
                                    <th class="th-category">
                                        <i class="bi bi-bookmark-star-fill text-danger me-1"></i> Tiêu Chí Văn Hóa
                                    </th>
                                    <th class="th-north" id="thNorth">
                                        🌸 Miền Bắc (Bắc Bộ)
                                    </th>
                                    <th class="th-central" id="thCentral">
                                        ☀️ Miền Trung (Trung Bộ)
                                    </th>
                                    <th class="th-south" id="thSouth">
                                        🌿 Miền Nam (Nam Bộ)
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="comparisonTableBody">
                                <!-- Dữ liệu so sánh từ API sẽ được nạp vào đây -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Chế độ 2: CỘT SONG SONG (Side-by-side Columns) -->
            <div id="cardsView" class="d-none">
                <div class="row g-4" id="cardsColumnsRow">
                    <!-- Các cột Bắc, Trung, Nam sẽ được nạp vào đây -->
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center py-3 text-muted small border-top bg-white mt-5">
        <div class="container">
            <p class="mb-0">
                🌸 Dự án <strong>Bản Đồ Tết Việt (Mã Đề Tài: C05)</strong> — Spring Boot JSP, Bootstrap 5 & Leaflet.js
            </p>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script Xử lý API So Sánh và Render Giao Diện -->
    <script>
        const CONTEXT_PATH = "${pageContext.request.contextPath}";
        let currentMode = 'table'; // 'table' hoặc 'cards'
        let cachedCompareData = null;

        // 1. Lấy danh sách vùng đang được tick chọn
        function getSelectedRegions() {
            const checkboxes = document.querySelectorAll('.region-checkbox:checked');
            const selected = [];
            checkboxes.forEach(cb => selected.push(cb.value));
            return selected.length > 0 ? selected.join(',') : 'NORTH,CENTRAL,SOUTH';
        }

        // Sự kiện khi người dùng thay đổi checkbox lọc vùng miền
        function onRegionFilterChanged() {
            fetchCompareData();
        }

        // Chuyển đổi giữa chế độ Bảng và Cột song song
        function switchViewMode(mode) {
            currentMode = mode;
            if (mode === 'table') {
                document.getElementById('btnModeTable').classList.add('active');
                document.getElementById('btnModeCards').classList.remove('active');
                document.getElementById('tableView').classList.remove('d-none');
                document.getElementById('cardsView').classList.add('d-none');
            } else {
                document.getElementById('btnModeCards').classList.add('active');
                document.getElementById('btnModeTable').classList.remove('active');
                document.getElementById('cardsView').classList.remove('d-none');
                document.getElementById('tableView').classList.add('d-none');
            }
        }

        // 2. Gọi API GET /api/v1/tet-map/compare?regions=...
        function fetchCompareData() {
            const regions = getSelectedRegions();
            const spinner = document.getElementById('compareSpinner');
            const tableView = document.getElementById('tableView');
            const cardsView = document.getElementById('cardsView');

            spinner.classList.remove('d-none');
            tableView.classList.add('d-none');
            cardsView.classList.add('d-none');

            const apiUrl = CONTEXT_PATH + '/api/v1/tet-map/compare?regions=' + encodeURIComponent(regions);

            fetch(apiUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Lỗi tải dữ liệu: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    cachedCompareData = data;
                    renderComparisonUI(data);
                    spinner.classList.add('d-none');
                    switchViewMode(currentMode);
                })
                .catch(error => {
                    console.error('Lỗi khi fetch API compare:', error);
                    // Dữ liệu dự phòng
                    const fallbackData = getFallbackCompareData(regions);
                    cachedCompareData = fallbackData;
                    renderComparisonUI(fallbackData);
                    spinner.classList.add('d-none');
                    switchViewMode(currentMode);
                });
        }

        // 3. Render giao diện đối chiếu (Cả Table và Side-by-side Cards)
        function renderComparisonUI(data) {
            const requested = data.requestedRegions || ['NORTH', 'CENTRAL', 'SOUTH'];
            const matrix = data.matrix || [];
            const details = data.regionsDetail || {};

            // Ẩn/Hiện cột trong Table tùy thuộc vào vùng được chọn
            const showNorth = requested.includes('NORTH');
            const showCentral = requested.includes('CENTRAL');
            const showSouth = requested.includes('SOUTH');

            document.getElementById('thNorth').style.display = showNorth ? '' : 'none';
            document.getElementById('thCentral').style.display = showCentral ? '' : 'none';
            document.getElementById('thSouth').style.display = showSouth ? '' : 'none';

            // --- A. Render TABLE VIEW ---
            let tableRowsHtml = '';
            matrix.forEach(item => {
                tableRowsHtml += `
                    <tr>
                        <td class="td-category-title">
                            <i class="bi \${item.icon || 'bi-stars'} text-danger me-2"></i>
                            <strong>\${item.category}</strong>
                        </td>
                        \${showNorth ? `<td>\${item.north || '-'}</td>` : ''}
                        \${showCentral ? `<td>\${item.central || '-'}</td>` : ''}
                        \${showSouth ? `<td>\${item.south || '-'}</td>` : ''}
                    </tr>
                `;
            });
            document.getElementById('comparisonTableBody').innerHTML = tableRowsHtml;

            // --- B. Render CARDS VIEW (Side-by-side) ---
            let cardsHtml = '';
            const colWidth = requested.length === 1 ? 'col-12' : (requested.length === 2 ? 'col-md-6' : 'col-lg-4');

            requested.forEach(code => {
                const reg = details[code] || {};
                let cardClass = 'card-north';
                let headerIcon = '🌸';
                let headerTextClass = 'text-danger';

                if (code === 'CENTRAL') {
                    cardClass = 'card-central';
                    headerIcon = '☀️';
                    headerTextClass = 'text-warning-emphasis';
                } else if (code === 'SOUTH') {
                    cardClass = 'card-south';
                    headerIcon = '🌿';
                    headerTextClass = 'text-success';
                }

                // Danh sách món ăn
                let foodsListHtml = '';
                if (reg.foods && reg.foods.length > 0) {
                    reg.foods.forEach(f => {
                        foodsListHtml += `
                            <div class="feature-item-pill">
                                <strong>\${f.name}</strong>: <span class="text-secondary small">\${f.description}</span>
                            </div>
                        `;
                    });
                }

                // Danh sách phong tục
                let customsListHtml = '';
                if (reg.customs && reg.customs.length > 0) {
                    reg.customs.forEach(c => {
                        customsListHtml += `
                            <div class="feature-item-pill">
                                <strong>\${c.title}</strong>: <span class="text-secondary small">\${c.description}</span>
                            </div>
                        `;
                    });
                }

                // Danh sách kiêng kỵ
                let taboosListHtml = '';
                if (reg.taboos && reg.taboos.length > 0) {
                    reg.taboos.forEach(t => {
                        taboosListHtml += `
                            <div class="feature-item-pill border-danger-subtle bg-danger-subtle text-danger">
                                <i class="bi bi-x-circle-fill me-1"></i>
                                <strong>\${t.title}</strong>: <span class="small text-dark">\${t.description}</span>
                            </div>
                        `;
                    });
                }

                cardsHtml += `
                    <div class="\${colWidth}">
                        <div class="region-column-card \${cardClass}">
                            <div class="column-header">
                                <span class="badge bg-white \${headerTextClass} border px-3 py-1 rounded-pill mb-2">
                                    \${reg.regionCode || code}
                                </span>
                                <h3 class="h4 fw-bold mb-1 \${headerTextClass} font-serif">
                                    \${headerIcon} \${reg.regionName || code}
                                </h3>
                                <p class="small text-muted mb-0">\${reg.subTitle || ''}</p>
                            </div>
                            <div class="column-body">
                                
                                <div class="mb-4">
                                    <div class="section-mini-title text-danger">
                                        <i class="bi bi-flower1"></i> Biểu trưng & Khí hậu
                                    </div>
                                    <div class="feature-item-pill">
                                        <strong>Hoa:</strong> \${reg.flower || 'Chưa rõ'}<br>
                                        <strong>Khí hậu:</strong> \${reg.weather || 'Chưa rõ'}
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="section-mini-title text-danger">
                                        <i class="bi bi-egg-fried"></i> Món ăn truyền thống
                                    </div>
                                    \${foodsListHtml}
                                </div>

                                <div class="mb-4">
                                    <div class="section-mini-title text-warning-emphasis">
                                        <i class="bi bi-lantern"></i> Phong tục tập quán
                                    </div>
                                    \${customsListHtml}
                                </div>

                                <div>
                                    <div class="section-mini-title text-danger">
                                        <i class="bi bi-shield-exclamation"></i> Điều kiêng kỵ
                                    </div>
                                    \${taboosListHtml}
                                </div>

                            </div>
                        </div>
                    </div>
                `;
            });

            document.getElementById('cardsColumnsRow').innerHTML = cardsHtml;
        }

        // Dữ liệu dự phòng khi API chưa sẵn sàng
        function getFallbackCompareData(regionsParam) {
            const requested = regionsParam.split(',').map(s => s.trim().toUpperCase());
            return {
                requestedRegions: requested,
                matrix: [
                    {
                        category: "Hoa biểu trưng ngày Tết",
                        icon: "bi-flower1",
                        north: "Hoa Đào hồng thắm xua đuổi tà khí, đón vượng khí và may mắn",
                        central: "Hoa Mai vàng tươi tắn, cúc vạn thọ tượng trưng sự trường thọ",
                        south: "Hoa Mai vàng rực rỡ 5-9 cánh, biểu tượng phú quý, giàu sang"
                    },
                    {
                        category: "Bánh truyền thống",
                        icon: "bi-box2-heart",
                        north: "Bánh Chưng vuông vắn gói lá dong tượng trưng cho Đất mẹ",
                        central: "Bánh Tét trụ dài gói lá chuối buộc lạt chặt, đượm vị mộc mạc",
                        south: "Bánh Tét đa sắc nhân thịt mỡ trứng muối hoặc nhân chuối ngọt"
                    },
                    {
                        category: "Mâm ngũ quả",
                        icon: "bi-basket",
                        north: "Chuộng thuyết Ngũ Hành: Chuối xanh, bưởi vàng, đào, hồng, quất",
                        central: "Thành tâm mộc mạc: Chuối, thanh long, mãng cầu, dưa hấu...",
                        south: "Chơi chữ ước vọng: Cầu - Sung - Vừa - Đủ - Xoài"
                    },
                    {
                        category: "Món ăn 'linh hồn'",
                        icon: "bi-cup-hot",
                        north: "Thịt đông, dưa hành muối chua cay, giò thủ, canh măng móng giò",
                        central: "Thịt ngâm nước mắm, tôm chua xứ Huế, dưa món giòn rụm",
                        south: "Thịt kho nước dừa hột vịt (thịt kho tàu), canh khổ qua nhồi thịt"
                    },
                    {
                        category: "Điều kiêng kỵ hàng đầu",
                        icon: "bi-shield-exclamation",
                        north: "Kiêng quét nhà mùng 1 làm mất tài lộc, kiêng cho lửa cho nước",
                        central: "Kiêng ăn cá mè, thịt vịt, trứng lộn; kiêng mặc đồ trắng đen",
                        south: "Kiêng để cối xay rỗng sợ đói kém, kiêng quét rác ra cửa"
                    }
                ],
                regionsDetail: {
                    'NORTH': {
                        regionCode: 'NORTH', regionName: 'Miền Bắc', subTitle: 'Cổ Kính & Thanh Lịch',
                        flower: 'Hoa Đào thắm', weather: 'Se lạnh, mưa phùn',
                        foods: [{ name: 'Bánh Chưng', description: 'Gạo nếp, đậu xanh, thịt mỡ gói lá dong' }],
                        customs: [{ title: 'Xông đất đầu năm', description: 'Chọn người hợp tuổi xông nhà' }],
                        taboos: [{ title: 'Kiêng quét nhà mùng 1', description: 'Tránh quét tài lộc ra ngoài' }]
                    },
                    'CENTRAL': {
                        regionCode: 'CENTRAL', regionName: 'Miền Trung', subTitle: 'Đậm Đà & Tinh Tế',
                        flower: 'Hoa Mai vàng & Cúc vạn thọ', weather: 'Nắng nhẹ hoặc se lạnh',
                        foods: [{ name: 'Bánh Tét', description: 'Gói lá chuối xanh nhân mỡ tiêu nồng' }],
                        customs: [{ title: 'Cúng giao thừa chu đáo', description: 'Lễ trừ tịch trang nghiêm' }],
                        taboos: [{ title: 'Kiêng ăn thịt vịt, cá mè', description: 'Sợ xui xẻo lẹt đẹt' }]
                    },
                    'SOUTH': {
                        regionCode: 'SOUTH', regionName: 'Miền Nam', subTitle: 'Phóng Khoáng & Phù Sa',
                        flower: 'Hoa Mai vàng rực rỡ', weather: 'Nắng vàng ấm áp',
                        foods: [{ name: 'Thịt kho tàu nước dừa', description: 'Ninh nước dừa hột vịt béo ngậy' }],
                        customs: [{ title: 'Mâm ngũ quả Cầu Sung Vừa Đủ Xài', description: 'Gửi gắm ước vọng năm mới' }],
                        taboos: [{ title: 'Kiêng để cối xay rỗng', description: 'Sợ thiếu thốn mùa tới' }]
                    }
                }
            };
        }

        // Tự động tải dữ liệu ban đầu
        document.addEventListener('DOMContentLoaded', function () {
            fetchCompareData();
        });
    </script>
</body>
</html>
