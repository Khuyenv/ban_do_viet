<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Bản Đồ Tết Việt - Khám Phá Văn Hóa Ba Miền'}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Fonts: Be Vietnam Pro & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,700;1,600&display=swap" rel="stylesheet">
    <!-- Leaflet.js CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>

    <style>
        :root {
            --tet-red: #b71c1c;
            --tet-red-dark: #7f0000;
            --tet-gold: #f59e0b;
            --tet-gold-light: #fef3c7;
            --tet-gold-border: #fcd34d;
            --tet-cream: #fffdfa;
            --text-dark: #1f2937;
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: linear-gradient(135deg, #fff9f5 0%, #fff2eb 50%, #fff8f0 100%);
            color: var(--text-dark);
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
            font-size: 1.45rem;
            font-weight: 700;
            color: #fff !important;
            letter-spacing: 0.5px;
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
            transform: translateY(-1px);
        }

        /* Header Banner Mini */
        .tet-header-strip {
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40"><path d="M20,0 L40,20 L20,40 L0,20 Z" fill="%23f59e0b" fill-opacity="0.08"/></svg>');
            padding: 1.25rem 0;
            border-bottom: 1px dashed #fcd34d;
        }

        /* Map Card Container */
        .map-card {
            border: 2px solid #fee2e2;
            border-radius: 20px;
            overflow: hidden;
            background: #ffffff;
            box-shadow: 0 10px 30px rgba(183, 28, 28, 0.08);
            transition: all 0.3s ease;
        }

        #vietnamMap {
            height: 580px;
            width: 100%;
            border-radius: 0 0 18px 18px;
            z-index: 10;
        }

        /* Leaflet Popups & Tooltips */
        .leaflet-popup-content-wrapper {
            border-radius: 14px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            border: 2px solid var(--tet-gold);
            background: #fffdf8;
        }

        .leaflet-popup-content {
            font-family: 'Be Vietnam Pro', sans-serif;
            margin: 12px 14px;
            line-height: 1.4;
        }

        .region-badge-pill {
            cursor: pointer;
            padding: 8px 18px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.25s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: 2px solid transparent;
        }

        .region-badge-pill:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }

        .region-badge-pill.active {
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.45);
        }

        .pill-north { background: #fee2e2; color: #991b1b; border-color: #fca5a5; }
        .pill-north.active { background: #991b1b; color: #ffffff; }

        .pill-central { background: #fef3c7; color: #b45309; border-color: #fcd34d; }
        .pill-central.active { background: #d97706; color: #ffffff; }

        .pill-south { background: #d1fae5; color: #047857; border-color: #6ee7b7; }
        .pill-south.active { background: #047857; color: #ffffff; }

        /* Custom Information Card */
        .custom-card-wrapper {
            background: #ffffff;
            border-radius: 20px;
            border: 2px solid #fee2e2;
            box-shadow: 0 10px 30px rgba(183, 28, 28, 0.08);
            min-height: 580px;
            display: flex;
            flex-direction: column;
        }

        .region-header-box {
            background: linear-gradient(135deg, #fff5f5 0%, #fffbeb 100%);
            padding: 18px 24px;
            border-radius: 18px 18px 0 0;
            border-bottom: 2px solid #fecaca;
        }

        /* Nav Tabs Custom */
        .tet-tabs {
            border-bottom: 2px solid #fecaca;
            background: #fafafa;
            padding: 8px 14px 0 14px;
        }

        .tet-tabs .nav-link {
            border: none;
            border-bottom: 3px solid transparent;
            color: #6b7280;
            font-weight: 600;
            padding: 12px 18px;
            border-radius: 0;
            transition: all 0.25s ease;
        }

        .tet-tabs .nav-link:hover {
            color: var(--tet-red);
            border-color: #fca5a5;
        }

        .tet-tabs .nav-link.active {
            color: var(--tet-red);
            background: transparent;
            border-bottom: 3px solid var(--tet-red);
        }

        /* Tab Content Items */
        .item-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #f3f4f6;
            box-shadow: 0 3px 12px rgba(0,0,0,0.03);
            padding: 16px 18px;
            margin-bottom: 14px;
            transition: all 0.25s ease;
            position: relative;
            overflow: hidden;
        }

        .item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(185, 28, 28, 0.08);
            border-color: #fecaca;
        }

        .item-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: var(--tet-red);
            opacity: 0;
            transition: opacity 0.2s ease;
        }

        .item-card:hover::before {
            opacity: 1;
        }

        .taboo-card {
            background: #fffafa;
            border-left: 4px solid #ef4444;
        }

        .taboo-card:hover {
            border-color: #fca5a5;
            border-left: 4px solid #dc2626;
        }

        .badge-food {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            font-weight: 500;
        }

        .meaning-box {
            background: #fffbeb;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 0.88rem;
            color: #92400e;
            border-left: 3px solid var(--tet-gold);
            margin-top: 8px;
        }

        /* Loader */
        .tet-spinner {
            color: var(--tet-red);
            width: 3rem;
            height: 3rem;
        }

        /* Quick Floating Sovereign Badge for Hoang Sa & Truong Sa */
        .sovereignty-badge {
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid #fca5a5;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            color: #991b1b;
            box-shadow: 0 2px 6px rgba(0,0,0,0.12);
        }

        /* Scrollable Tab Pane */
        .tab-scroll-container {
            max-height: 480px;
            overflow-y: auto;
            padding: 16px 20px;
        }

        .tab-scroll-container::-webkit-scrollbar {
            width: 6px;
        }
        .tab-scroll-container::-webkit-scrollbar-thumb {
            background: #fca5a5;
            border-radius: 10px;
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
                    <span class="badge bg-warning text-dark ms-2 fw-semibold fs-7" style="font-size: 0.7rem;">Đề Tài C05</span>
                </div>
            </a>
            
            <button class="navbar-toggler text-white border-white" type="button" data-bs-toggle="collapse" data-bs-target="#tetNavbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="tetNavbarContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center gap-2">
                    <li class="nav-item">
                        <a class="nav-link custom-nav active" href="${pageContext.request.contextPath}/">
                            <i class="bi bi-geo-alt-fill me-1 text-warning"></i> Bản Đồ Tương Tác
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link custom-nav" href="${pageContext.request.contextPath}/compare">
                            <i class="bi bi-layout-split me-1 text-warning"></i> So Sánh Ba Miền
                        </a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <span class="badge bg-danger border border-warning text-light py-2 px-3 rounded-pill fw-normal">
                            🏮 Chúc Mừng Năm Mới
                        </span>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 2. Header giới thiệu & Nút chọn nhanh vùng miền -->
    <section class="tet-header-strip">
        <div class="container-fluid px-lg-5">
            <div class="row align-items-center gy-3">
                <div class="col-md-6">
                    <h1 class="h4 fw-bold mb-1 text-danger font-serif">
                        <i class="bi bi-compass text-warning me-2"></i>Không Gian Văn Hóa Tết Ba Miền
                    </h1>
                    <p class="text-muted small mb-0">
                        Nhấp chuột vào từng vùng miền trên bản đồ để khám phá phong vị ẩm thực, phong tục tập quán và nét kiêng kỵ đặc trưng.
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="d-inline-flex flex-wrap gap-2 align-items-center">
                        <span class="small fw-semibold text-secondary me-1">Chọn nhanh:</span>
                        <button type="button" class="region-badge-pill pill-north active" onclick="selectRegion('NORTH')">
                            🌸 Miền Bắc
                        </button>
                        <button type="button" class="region-badge-pill pill-central" onclick="selectRegion('CENTRAL')">
                            ☀️ Miền Trung
                        </button>
                        <button type="button" class="region-badge-pill pill-south" onclick="selectRegion('SOUTH')">
                            🌿 Miền Nam
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 3. Khu vực Bản Đồ & Thẻ Phong Tục (Custom Cards) -->
    <main class="container-fluid px-lg-5 py-4">
        <div class="row g-4">
            
            <!-- CỘT TRÁI: BẢN ĐỒ TƯƠNG TÁC LEAFLET.JS -->
            <div class="col-lg-6 col-xl-5">
                <div class="map-card">
                    <div class="p-3 bg-white border-bottom d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-map-fill text-danger fs-5"></i>
                            <span class="fw-bold text-dark">Bản đồ Địa lý Văn hóa</span>
                        </div>
                        <div class="small text-muted">
                            <i class="bi bi-hand-index-thumb me-1"></i>Chạm vào vùng để xem
                        </div>
                    </div>
                    <!-- Vùng vẽ bản đồ Leaflet -->
                    <div id="vietnamMap"></div>
                    <div class="p-2 text-center bg-light small text-secondary border-top">
                        <i class="bi bi-shield-check text-success me-1"></i>
                        Khẳng định chủ quyền trọn vẹn: <strong>Quần đảo Hoàng Sa & Quần đảo Trường Sa</strong>
                    </div>
                </div>
            </div>

            <!-- CỘT PHẢI: THẺ PHONG TỤC (CUSTOM CARDS VỚI 3 TAB) -->
            <div class="col-lg-6 col-xl-7">
                <div class="custom-card-wrapper">
                    
                    <!-- Header động của vùng được chọn -->
                    <div class="region-header-box" id="regionHeader">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="badge bg-danger text-white mb-2 px-3 py-1 rounded-pill" id="badgeRegionCode">
                                    VÙNG MIỀN: BẮC BỘ
                                </span>
                                <h2 class="h3 fw-bold text-danger font-serif mb-1" id="regionTitle">
                                    Văn Hóa Tết Miền Bắc
                                </h2>
                                <p class="text-secondary small mb-2" id="regionSubtitle">
                                    Nét Đẹp Cổ Kính, Trầm Mặc & Thanh Lịch
                                </p>
                            </div>
                            <a href="${pageContext.request.contextPath}/compare" class="btn btn-sm btn-outline-danger rounded-pill px-3 shadow-sm d-none d-sm-inline-block">
                                <i class="bi bi-arrow-left-right me-1"></i> So sánh 3 miền
                            </a>
                        </div>
                        <div class="d-flex flex-wrap gap-2 mt-2" id="regionQuickFacts">
                            <span class="badge bg-white text-danger border border-danger-subtle px-3 py-2 rounded-pill fw-normal" id="factFlower">
                                <i class="bi bi-flower1 me-1 text-danger"></i> <strong>Hoa biểu trưng:</strong> Hoa Đào thắm
                            </span>
                            <span class="badge bg-white text-primary border border-primary-subtle px-3 py-2 rounded-pill fw-normal" id="factWeather">
                                <i class="bi bi-cloud-sun me-1 text-primary"></i> <strong>Khí hậu:</strong> Se lạnh, mưa phùn
                            </span>
                        </div>
                    </div>

                    <!-- Danh sách 3 Tabs Bootstrap -->
                    <ul class="nav nav-tabs tet-tabs" id="tetTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="foods-tab" data-bs-toggle="tab" data-bs-target="#tab-foods" type="button" role="tab">
                                <i class="bi bi-egg-fried me-1 text-danger"></i> Món Ăn Ngày Tết
                                <span class="badge bg-danger-subtle text-danger rounded-pill ms-1" id="countFoods">0</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="customs-tab" data-bs-toggle="tab" data-bs-target="#tab-customs" type="button" role="tab">
                                <i class="bi bi-fire me-1 text-warning"></i> Phong Tục Đặc Trưng
                                <span class="badge bg-warning-subtle text-warning-emphasis rounded-pill ms-1" id="countCustoms">0</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="taboos-tab" data-bs-toggle="tab" data-bs-target="#tab-taboos" type="button" role="tab">
                                <i class="bi bi-shield-exclamation me-1 text-danger"></i> Điều Kiêng Kỵ
                                <span class="badge bg-danger-subtle text-danger rounded-pill ms-1" id="countTaboos">0</span>
                            </button>
                        </li>
                    </ul>

                    <!-- Nội dung các tab (Hiển thị dữ liệu từ AJAX) -->
                    <div class="tab-content flex-grow-1" id="tetTabsContent">
                        
                        <!-- TAB 1: MÓN ĂN NGÀY TẾT -->
                        <div class="tab-pane fade show active tab-scroll-container" id="tab-foods" role="tabpanel">
                            <div id="foodsContainer">
                                <!-- AJAX Content sẽ được inject vào đây -->
                            </div>
                        </div>

                        <!-- TAB 2: PHONG TỤC ĐẶC TRƯNG -->
                        <div class="tab-pane fade tab-scroll-container" id="tab-customs" role="tabpanel">
                            <div id="customsContainer">
                                <!-- AJAX Content sẽ được inject vào đây -->
                            </div>
                        </div>

                        <!-- TAB 3: ĐIỀU KIÊNG KỴ -->
                        <div class="tab-pane fade tab-scroll-container" id="tab-taboos" role="tabpanel">
                            <div id="taboosContainer">
                                <!-- AJAX Content sẽ được inject vào đây -->
                            </div>
                        </div>

                    </div>

                    <!-- Footer Thẻ: Nút điều hướng chuyển nhanh -->
                    <div class="p-3 bg-light border-top d-flex justify-content-between align-items-center rounded-bottom-4">
                        <span class="small text-muted">
                            <i class="bi bi-info-circle me-1"></i>Dữ liệu cập nhật theo phong tục cổ truyền
                        </span>
                        <a href="${pageContext.request.contextPath}/compare" class="btn btn-danger btn-sm rounded-pill px-4 shadow-sm">
                            Xem Bảng So Sánh Chi Tiết <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </main>

    <!-- Footer bản quyền -->
    <footer class="text-center py-3 text-muted small border-top bg-white mt-4">
        <div class="container">
            <p class="mb-0">
                🌸 Dự án <strong>Bản Đồ Tết Việt (Mã Đề Tài: C05)</strong> — Công nghệ: Spring Boot JSP, Bootstrap 5 & Leaflet.js
            </p>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS (Popper included) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Leaflet.js -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>

    <!-- Script Tương tác Bản Đồ & Fetch AJAX API -->
    <script>
        // Cấu hình URL ngữ cảnh (Context Path)
        const CONTEXT_PATH = "${pageContext.request.contextPath}";
        let currentRegion = 'NORTH';
        let mapInstance = null;
        let regionLayers = {};

        // Tọa độ và thông số các miền
        const REGION_CONFIG = {
            'NORTH': {
                center: [21.0285, 105.8542],
                zoom: 7,
                name: 'Miền Bắc',
                color: '#b91c1c',
                coords: [
                    [23.393, 105.321], [22.8, 106.7], [21.5, 107.5], 
                    [20.0, 106.0], [20.0, 104.5], [21.5, 103.0], 
                    [22.5, 103.5]
                ]
            },
            'CENTRAL': {
                center: [16.0544, 108.2022],
                zoom: 7,
                name: 'Miền Trung',
                color: '#d97706',
                coords: [
                    [20.0, 106.0], [18.0, 106.5], [16.5, 107.5], 
                    [14.0, 109.2], [11.5, 109.0], [12.0, 107.5], 
                    [15.0, 107.8], [18.5, 105.5]
                ]
            },
            'SOUTH': {
                center: [10.8231, 106.6297],
                zoom: 7,
                name: 'Miền Nam',
                color: '#047857',
                coords: [
                    [11.5, 106.0], [12.0, 107.5], [11.0, 108.5], 
                    [10.2, 107.2], [8.5, 105.0], [9.5, 104.5], 
                    [10.5, 105.0]
                ]
            }
        };

        // 1. Khởi tạo Bản đồ Leaflet
        function initLeafletMap() {
            // Tọa độ trung tâm Việt Nam
            mapInstance = L.map('vietnamMap', {
                scrollWheelZoom: false
            }).setView([16.0544, 107.5], 6);

            // Sử dụng TileLayer đẹp và sáng từ CartoDB Positron / OSM
            L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
                maxZoom: 18,
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
            }).addTo(mapInstance);

            // Vẽ các vùng miền Bắc - Trung - Nam
            Object.keys(REGION_CONFIG).forEach(code => {
                const conf = REGION_CONFIG[code];

                // Vẽ Polygon trực quan cho vùng
                const polygon = L.polygon(conf.coords, {
                    color: conf.color,
                    weight: 2,
                    fillColor: conf.color,
                    fillOpacity: 0.25
                }).addTo(mapInstance);

                // Thêm Marker biểu tượng tại trung tâm vùng
                const marker = L.circleMarker(conf.center, {
                    radius: 10,
                    fillColor: conf.color,
                    color: '#ffffff',
                    weight: 3,
                    opacity: 1,
                    fillOpacity: 0.9
                }).addTo(mapInstance);

                const popupHtml = `
                    <div class="text-center p-1">
                        <strong style="color: ${conf.color}; font-size: 1.1rem;">🌸 ${conf.name}</strong><br>
                        <span class="small text-muted">Nhấp chuột để khám phá văn hóa</span><br>
                        <button class="btn btn-sm btn-danger mt-2 py-0 px-2 rounded-pill" onclick="selectRegion('${code}')">
                            Xem chi tiết
                        </button>
                    </div>
                `;

                polygon.bindPopup(popupHtml);
                marker.bindPopup(popupHtml);

                // Hiệu ứng hover
                polygon.on('mouseover', function () {
                    this.setStyle({ fillOpacity: 0.5, weight: 3 });
                });
                polygon.on('mouseout', function () {
                    if (currentRegion !== code) {
                        this.setStyle({ fillOpacity: 0.25, weight: 2 });
                    }
                });

                // Sự kiện click chọn vùng
                polygon.on('click', () => selectRegion(code));
                marker.on('click', () => selectRegion(code));

                regionLayers[code] = { polygon, marker };
            });

            // Đánh dấu chủ quyền Quần đảo Hoàng Sa và Trường Sa
            const hoangSaMarker = L.marker([16.5, 112.0], {
                icon: L.divIcon({
                    className: 'sovereignty-badge',
                    html: '<i class="bi bi-geo-alt-fill text-danger"></i> Quần đảo Hoàng Sa (Đà Nẵng)',
                    iconSize: [180, 24],
                    iconAnchor: [90, 12]
                })
            }).addTo(mapInstance);

            const truongSaMarker = L.marker([9.5, 114.5], {
                icon: L.divIcon({
                    className: 'sovereignty-badge',
                    html: '<i class="bi bi-geo-alt-fill text-danger"></i> Quần đảo Trường Sa (Khánh Hòa)',
                    iconSize: [180, 24],
                    iconAnchor: [90, 12]
                })
            }).addTo(mapInstance);
        }

        // 2. Hàm kích hoạt chọn miền (Gọi API AJAX & Cập nhật UI)
        function selectRegion(regionCode) {
            currentRegion = regionCode;

            // Cập nhật trạng thái nút chọn nhanh
            document.querySelectorAll('.region-badge-pill').forEach(pill => {
                pill.classList.remove('active');
            });
            if (regionCode === 'NORTH') document.querySelector('.pill-north').classList.add('active');
            if (regionCode === 'CENTRAL') document.querySelector('.pill-central').classList.add('active');
            if (regionCode === 'SOUTH') document.querySelector('.pill-south').classList.add('active');

            // Cập nhật phong cách polygon bản đồ
            Object.keys(regionLayers).forEach(code => {
                if (code === regionCode) {
                    regionLayers[code].polygon.setStyle({ fillOpacity: 0.55, weight: 3.5 });
                } else {
                    regionLayers[code].polygon.setStyle({ fillOpacity: 0.2, weight: 1.5 });
                }
            });

            // Smooth Pan / Fly to vùng được chọn
            if (mapInstance && REGION_CONFIG[regionCode]) {
                mapInstance.flyTo(REGION_CONFIG[regionCode].center, 6.5, {
                    animate: true,
                    duration: 0.8
                });
            }

            // Gọi API AJAX để lấy dữ liệu phong tục vùng
            fetchRegionData(regionCode);
        }

        // 3. Hàm gọi Fetch API lấy dữ liệu vùng
        function fetchRegionData(regionCode) {
            showLoadingState();

            const apiUrl = CONTEXT_PATH + '/api/v1/tet-map/region/' + regionCode;

            fetch(apiUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Mã lỗi mạng: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    renderRegionUI(data);
                })
                .catch(error => {
                    console.error('Lỗi khi gọi API:', error);
                    // Dữ liệu dự phòng (Fallback) nếu server chưa chạy API
                    renderFallbackData(regionCode);
                });
        }

        // Hiển thị trạng thái đang tải (Loading Spinner)
        function showLoadingState() {
            const spinnerHtml = `
                <div class="text-center py-5">
                    <div class="spinner-border tet-spinner" role="status">
                        <span class="visually-hidden">Đang tải...</span>
                    </div>
                    <p class="text-muted mt-3 mb-0">Đang chuẩn bị mâm cỗ và phong tục ngày Tết...</p>
                </div>
            `;
            document.getElementById('foodsContainer').innerHTML = spinnerHtml;
            document.getElementById('customsContainer').innerHTML = spinnerHtml;
            document.getElementById('taboosContainer').innerHTML = spinnerHtml;
        }

        // 4. Render dữ liệu nhận được từ API vào Thẻ Phong Tục
        function renderRegionUI(data) {
            // Cập nhật Header Thẻ
            document.getElementById('badgeRegionCode').textContent = 'VÙNG MIỀN: ' + (data.regionName || data.regionCode);
            document.getElementById('regionTitle').textContent = 'Văn Hóa Tết ' + (data.regionName || '');
            document.getElementById('regionSubtitle').textContent = data.subTitle || 'Phong vị Tết cổ truyền ngàn năm';
            
            document.getElementById('factFlower').innerHTML = `<i class="bi bi-flower1 me-1 text-danger"></i> <strong>Hoa biểu trưng:</strong> ` + (data.flower || 'Hoa mai / đào');
            document.getElementById('factWeather').innerHTML = `<i class="bi bi-cloud-sun me-1 text-primary"></i> <strong>Khí hậu:</strong> ` + (data.weather || 'Tiết trời mùa xuân');

            // Cập nhật số lượng huy hiệu trên Tabs
            document.getElementById('countFoods').textContent = data.foods ? data.foods.length : 0;
            document.getElementById('countCustoms').textContent = data.customs ? data.customs.length : 0;
            document.getElementById('countTaboos').textContent = data.taboos ? data.taboos.length : 0;

            // Render TAB 1: Món ăn ngày Tết
            let foodsHtml = '';
            if (data.foods && data.foods.length > 0) {
                data.foods.forEach(food => {
                    foodsHtml += `
                        <div class="item-card">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h5 class="fw-bold text-danger mb-0 fs-6">
                                    <i class="bi bi-check-circle-fill text-warning me-2"></i>\${food.name}
                                </h5>
                                \${food.badge ? `<span class="badge badge-food rounded-pill px-2 py-1">\${food.badge}</span>` : ''}
                            </div>
                            <p class="text-secondary small mb-2">\${food.description}</p>
                            \${food.meaning ? `
                                <div class="meaning-box">
                                    <i class="bi bi-stars text-warning me-1"></i>
                                    <strong>Ý nghĩa cát tường:</strong> \${food.meaning}
                                </div>
                            ` : ''}
                        </div>
                    `;
                });
            } else {
                foodsHtml = `<div class="text-center py-4 text-muted">Chưa có dữ liệu món ăn.</div>`;
            }
            document.getElementById('foodsContainer').innerHTML = foodsHtml;

            // Render TAB 2: Phong tục đặc trưng
            let customsHtml = '';
            if (data.customs && data.customs.length > 0) {
                data.customs.forEach(custom => {
                    customsHtml += `
                        <div class="item-card">
                            <div class="d-flex align-items-center mb-2">
                                <div class="bg-warning-subtle text-warning-emphasis p-2 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                                    <i class="bi bi-lantern-fill fs-6 text-danger"></i>
                                </div>
                                <h5 class="fw-bold text-dark mb-0 fs-6">\${custom.title}</h5>
                            </div>
                            <p class="text-secondary small mb-0 ps-5">\${custom.description}</p>
                        </div>
                    `;
                });
            } else {
                customsHtml = `<div class="text-center py-4 text-muted">Chưa có dữ liệu phong tục.</div>`;
            }
            document.getElementById('customsContainer').innerHTML = customsHtml;

            // Render TAB 3: Điều kiêng kỵ
            let taboosHtml = '';
            if (data.taboos && data.taboos.length > 0) {
                data.taboos.forEach(taboo => {
                    taboosHtml += `
                        <div class="item-card taboo-card">
                            <div class="d-flex align-items-center mb-2">
                                <div class="bg-danger-subtle text-danger p-2 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;">
                                    <i class="bi bi-exclamation-triangle-fill fs-6"></i>
                                </div>
                                <h5 class="fw-bold text-danger mb-0 fs-6">\${taboo.title}</h5>
                            </div>
                            <p class="text-secondary small mb-0 ps-5">\${taboo.description}</p>
                        </div>
                    `;
                });
            } else {
                taboosHtml = `<div class="text-center py-4 text-muted">Chưa có dữ liệu điều kiêng kỵ.</div>`;
            }
            document.getElementById('taboosContainer').innerHTML = taboosHtml;
        }

        // Dữ liệu Fallback phòng khi API tạm thời không phản hồi
        function renderFallbackData(code) {
            console.warn('Đang sử dụng dữ liệu dự phòng cục bộ cho miền:', code);
            const fallbackMap = {
                'NORTH': {
                    regionName: 'Miền Bắc',
                    subTitle: 'Nét Đẹp Cổ Kính, Trầm Mặc & Thanh Lịch',
                    flower: 'Hoa Đào thắm & Quất cảnh',
                    weather: 'Se lạnh, mưa phùn',
                    foods: [
                        { name: 'Bánh Chưng xanh', description: 'Bánh vuông gói lá dong tượng trưng cho Đất, nếp dẻo thịt mỡ tiêu thơm ngậy.', meaning: 'Lòng hiếu thảo với tổ tiên và cội nguồn.', badge: 'Món linh hồn' },
                        { name: 'Thịt đông', description: 'Đặc sản mùa đông xuân xứ Bắc, làm từ thịt chân giò, mộc nhĩ đông trong suốt tự nhiên.', meaning: 'Sự hòa thuận, trong trẻo và gắn kết gia đình.', badge: 'Khí hậu độc đáo' },
                        { name: 'Dưa hành muối', description: 'Hành muối chua giòn khai vị, ăn kèm thịt mỡ bánh chưng chống ngấy.', meaning: 'Khai thông ngũ tạng, đón điều may mắn hanh thông.', badge: 'Món kèm' }
                    ],
                    customs: [
                        { title: 'Tục xông đất đầu năm', description: 'Chọn người hợp tuổi, vía lành bước vào nhà đầu tiên ngay sau giao thừa.' },
                        { title: 'Xin chữ đầu xuân', description: 'Đến Văn Miếu xin chữ Nho (Tâm, Phúc, An, Lộc) cầu may mắn học vấn.' }
                    ],
                    taboos: [
                        { title: 'Kiêng quét nhà ngày mùng 1', description: 'Sợ quét đổ mất tài lộc và may mắn của cả năm ra khỏi cửa.' },
                        { title: 'Kiêng làm vỡ bát đĩa', description: 'Sự đổ vỡ biểu trưng cho chia cắt, bất hòa trong năm mới.' }
                    ]
                },
                'CENTRAL': {
                    regionName: 'Miền Trung',
                    subTitle: 'Đậm Đà Nghĩa Tình, Chắt Chiu & Tinh Tế',
                    flower: 'Hoa Mai vàng tươi & Cúc vạn thọ',
                    weather: 'Nắng nhẹ hoặc se lạnh',
                    foods: [
                        { name: 'Bánh Tét miền Trung', description: 'Gói trụ tròn dài lá chuối xanh, chắc nịch đượm đà nhân thịt mỡ đậu xanh.', meaning: 'Sự đùm bọc yêu thương của ruột thịt.', badge: 'Món chủ đạo' },
                        { name: 'Thịt ngâm nước mắm', description: 'Thịt ba chỉ heo ngâm mắm đường phèn tiêu ớt đậm đà, thái lát mỏng cuốn bánh tráng rau sống.', meaning: 'Sự tích lũy, trân quý hương vị mặn mòi quê hương.', badge: 'Đặc sản' }
                    ],
                    customs: [
                        { title: 'Lễ cúng trừ tịch chu đáo', description: 'Mâm cúng ngoài trời và trong nhà kính cáo thần linh, tiền hiền khai làng lập ấp.' },
                        { title: 'Ăn chay sáng mùng 1', description: 'Nhiều gia đình ăn chay để thanh lọc tâm hồn, cầu năm mới an lành.' }
                    ],
                    taboos: [
                        { title: 'Kiêng ăn thịt vịt, cá mè, trứng lộn', description: 'Sợ đen đủi lẹt đẹt, mè nheo và đảo lộn vận may.' }
                    ]
                },
                'SOUTH': {
                    regionName: 'Miền Nam',
                    subTitle: 'Phóng Khoáng, Rạng Rỡ & Đậm Chất Phù Sa',
                    flower: 'Hoa Mai vàng 5-9 cánh phú quý',
                    weather: 'Nắng ấm chan hòa rực rỡ',
                    foods: [
                        { name: 'Thịt kho hột vịt nước dừa', description: 'Thịt ba rọi miếng vuông hầm trứng vịt tròn vo cùng nước dừa xiêm béo ngậy.', meaning: 'Biểu trưng vuông tròn vẹn toàn, ấm no suốt năm.', badge: 'Món linh hồn' },
                        { name: 'Canh khổ qua nhồi thịt', description: 'Mướp đắng nhồi thịt nạc băm hầm mềm nước dùng thanh ngọt.', meaning: 'Mong mọi nỗi khổ cực của năm cũ qua đi để đón niềm vui.', badge: 'Ý nghĩa sâu sắc' }
                    ],
                    customs: [
                        { title: 'Mâm ngũ quả Cầu Sung Dừa Đủ Xoài', description: 'Cách chơi chữ Nam Bộ cầu mong cuộc sống vừa đủ sung túc, không thiếu thốn.' },
                        { title: 'Đi chùa hái lộc đầu xuân', description: 'Cùng gia đình viếng cảnh chùa linh thiêng cầu may mắn, tài lộc.' }
                    ],
                    taboos: [
                        { title: 'Kiêng để cối xay rỗng', description: 'Tượng trưng cho sự thiếu thốn, đói kém mùa vụ mới.' },
                        { title: 'Kiêng cúng chuối, cam, lê', description: 'Tránh các từ đồng âm: chuối (chúi nhủi), cam (cam chịu).' }
                    ]
                }
            };

            if (fallbackMap[code]) {
                renderRegionUI(fallbackMap[code]);
            }
        }

        // Tự động khởi chạy khi tài liệu tải xong
        document.addEventListener('DOMContentLoaded', function () {
            initLeafletMap();
            // Khởi tạo mặc định với Miền Bắc
            selectRegion('NORTH');
        });
    </script>
</body>
</html>
