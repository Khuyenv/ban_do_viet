package com.example.ban_do_viet.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * REST API Controller cung cấp dữ liệu văn hóa Tết Việt theo vùng miền
 * Hỗ trợ các endpoint:
 * 1. GET /api/v1/tet-map/region/{regionCode}
 * 2. GET /api/v1/tet-map/compare?regions=NORTH,CENTRAL,SOUTH
 */
@RestController
@RequestMapping("/api/v1/tet-map")
@CrossOrigin(origins = "*")
public class TetMapApiController {

    private static final Map<String, Map<String, Object>> REGION_DATA = new LinkedHashMap<>();

    static {
        // --- 1. MIỀN BẮC (NORTH) ---
        Map<String, Object> north = new HashMap<>();
        north.put("regionCode", "NORTH");
        north.put("regionName", "Miền Bắc");
        north.put("subTitle", "Nét Đẹp Cổ Kính, Trầm Mặc & Thanh Lịch");
        north.put("flower", "Hoa Đào thắm & Quất cảnh sai trĩu quả");
        north.put("weather", "Thời tiết se lạnh, lất phất mưa xuân phùn");
        north.put("color", "#c62828");

        List<Map<String, String>> northFoods = Arrays.asList(
            Map.of(
                "name", "Bánh Chưng xanh",
                "description", "Hình vuông tượng trưng cho Đất, gói lá dong xanh mướt, bên trong là gạo nếp dẻo thơm, đậu xanh vàng ươm và thịt lợn ba chỉ ướp tiêu thơm nồng.",
                "meaning", "Biểu tượng lòng hiếu kính tổ tiên và đạo lý uống nước nhớ nguồn.",
                "badge", "Món linh hồn"
            ),
            Map.of(
                "name", "Thịt đông",
                "description", "Món ăn kinh điển trong mùa đông - xuân xứ Bắc, làm từ thịt chân giò, bì lợn, mộc nhĩ và hạt tiêu đen, ninh nhừ rồi để đông trong suốt tự nhiên.",
                "meaning", "Gắn kết tình thân, mong ước vạn vật trong trẻo, hòa thuận và êm ấm.",
                "badge", "Độc đáo khí hậu"
            ),
            Map.of(
                "name", "Dưa hành muối",
                "description", "Hành củ muối chua thanh, vị cay nồng vừa phải, ăn kèm thịt mỡ bánh chưng giúp cân bằng vị giác và giải ngấy hoàn hảo.",
                "meaning", "Khai thông ngũ tạng, mang lại sự thông thoáng, hanh thông cả năm.",
                "badge", "Khai vị"
            ),
            Map.of(
                "name", "Canh măng khô móng giò",
                "description", "Măng khô (măng nứa hoặc măng lưỡi lợn) ngâm kỹ, ninh nhừ với móng giò thơm béo ngậy, rắc hành hoa tươi rói bên trên bát canh bốc khói.",
                "meaning", "Cầu chúc một năm mới no đủ, sung túc và ấm áp gia đình.",
                "badge", "Món canh"
            ),
            Map.of(
                "name", "Giò thủ & Giò lụa",
                "description", "Giò lụa giã tay mịn màng, thơm mùi lá chuối tươi; giò xào (giò thủ) giòn sần sật với tai mũi lưỡi lợn và nấm mèo.",
                "meaning", "Hình khối tròn trịa gửi gắm ước nguyện 'trong ấm ngoài êm', phúc lộc vẹn toàn.",
                "badge", "Món truyền thống"
            )
        );

        List<Map<String, String>> northCustoms = Arrays.asList(
            Map.of(
                "title", "Chơi cành đào thắm & cây quất cảnh",
                "description", "Hoa đào đỏ thắm xua đuổi tà ma và rước phúc khí vào nhà; chậu quất xum xuê trĩu quả vàng mọng tượng trưng cho tài lộc nảy nở."
            ),
            Map.of(
                "title", "Tục xông đất đầu năm",
                "description", "Gia chủ chọn người hợp tuổi, tính tình xởi lởi, phúc đức để bước vào nhà đầu tiên ngay sau khoảnh khắc giao thừa."
            ),
            Map.of(
                "title", "Bày mâm ngũ quả theo thuyết Ngũ Hành",
                "description", "Mâm ngũ quả xứ Bắc phối màu hài hòa Kim - Mộc - Thủy - Hỏa - Thổ: chuối xanh nâng đỡ, bưởi vàng chính giữa, ớt đỏ, quất vàng, hồng chín."
            ),
            Map.of(
                "title", "Khai bút & xin chữ đầu xuân",
                "description", "Người dân thường đến Văn Miếu - Quốc Tử Giám hoặc các thầy đồ để xin chữ 'Tâm', 'Phúc', 'Lộc', 'An', 'Trí' mong cầu đỗ đạt và trí tuệ khai sáng."
            )
        );

        List<Map<String, String>> northTaboos = Arrays.asList(
            Map.of(
                "title", "Kiêng quét nhà, đổ rác ngày mùng 1",
                "description", "Dân gian quan niệm quét nhà ngày đầu năm sẽ quét mất Thần Tài và tiêu tán tài lộc. Rác thường chỉ gom vào một góc nhà."
            ),
            Map.of(
                "title", "Kiêng làm vỡ bát đĩa, ly tách",
                "description", "Sự đổ vỡ biểu trưng cho việc chia lìa, bất hòa, rạn nứt tình cảm và trắc trở trong suốt một năm mới."
            ),
            Map.of(
                "title", "Kiêng cho lửa, cho nước đầu năm",
                "description", "Lửa đỏ tượng trưng cho may mắn cát tường; nước là nguồn sinh sôi tài lộc ('tiền vào như nước'). Việc đem cho người khác coi như tán lộc gia đình."
            ),
            Map.of(
                "title", "Kiêng may vá hoặc cầm kim chỉ mùng 1",
                "description", "Người xưa quan niệm kim nhọn tượng trưng cho điều vất vả, chông gai, đâm chọc nên cất kỹ trong ba ngày Tết."
            )
        );

        north.put("foods", northFoods);
        north.put("customs", northCustoms);
        north.put("taboos", northTaboos);
        REGION_DATA.put("NORTH", north);

        // --- 2. MIỀN TRUNG (CENTRAL) ---
        Map<String, Object> central = new HashMap<>();
        central.put("regionCode", "CENTRAL");
        central.put("regionName", "Miền Trung");
        central.put("subTitle", "Đậm Đà Nghĩa Tình, Chắt Chiu & Tinh Tế");
        central.put("flower", "Hoa Mai vàng tươi rực & Cúc vạn thọ");
        central.put("weather", "Nắng ấm nhẹ, tiết trời dịu dàng hoặc se se lạnh");
        central.put("color", "#d97706");

        List<Map<String, String>> centralFoods = Arrays.asList(
            Map.of(
                "name", "Bánh Tét miền Trung",
                "description", "Được gói tròn dài bằng lá chuối, nếp dẻo thơm ninh kỹ, nhân thịt mỡ tiêu cay nồng hoặc nhân đậu xanh hạt bùi.",
                "meaning", "Biểu trưng cho sự gắn kết ruột thịt và tình mẫu tử bao bọc.",
                "badge", "Món chủ đạo"
            ),
            Map.of(
                "name", "Thịt ngâm nước mắm",
                "description", "Thịt ba chỉ heo hoặc bắp bò luộc chín tới, ngâm trong hỗn hợp nước mắm ngon nấu đường phèn, tiêu sọ, tỏi ớt nhiều ngày cho thấm giòn đậm vị.",
                "meaning", "Thể hiện tài khéo léo chắt chiu, tích lũy hương vị đậm đà ngày xuân.",
                "badge", "Đặc sản"
            ),
            Map.of(
                "name", "Dưa món miền Trung",
                "description", "Củ kiệu, đu đủ xanh, cà rốt, su hào phơi khô kiệt dưới nắng gió miền Trung rồi ngâm nước mắm đường sánh đặc, giòn rụm khó quên.",
                "meaning", "Hòa hợp ngũ vị đắng cay ngọt bùi, kiên cường vượt khó.",
                "badge", "Món kèm"
            ),
            Map.of(
                "name", "Nem chua & Tré Huế",
                "description", "Nem chua hồng hào gói lá ổi, cùng tré thơm lừng mè rang, tỏi cay và củ riềng thái chỉ mỏng tang, vị chua cay mặn ngọt nồng nàn.",
                "meaning", "May mắn hanh thông, mang lại không khí vui tươi rộn rã trong chén rượu đãi khách.",
                "badge", "Đặc sắc Huế"
            ),
            Map.of(
                "name", "Bánh tổ & Bánh thuẫn",
                "description", "Bánh tổ dẻo quánh từ mật mía và gừng tươi nướng thơm lừng xứ Quảng; bánh thuẫn nở hoa vàng xốp thơm phức mùi trứng gà.",
                "meaning", "Cầu mong tổ tiên phù hộ gia đạo nở hoa rực rỡ như hoa bánh.",
                "badge", "Bánh ngọt"
            )
        );

        List<Map<String, String>> centralCustoms = Arrays.asList(
            Map.of(
                "title", "Lễ cúng giao thừa chu đáo trong - ngoài",
                "description", "Người miền Trung đặc biệt coi trọng lễ cúng trừ tịch với mâm cúng trang trọng kính bái Trời Phật, gia tiên và chư vị tiền hiền lập làng."
            ),
            Map.of(
                "title", "Chưng cúc vạn thọ và mai vàng",
                "description", "Trước hiên nhà luôn rực rỡ sắc vàng của chậu mai và hàng cúc vạn thọ tượng trưng cho sự trường thọ, bền bỉ và bình an vững chãi."
            ),
            Map.of(
                "title", "Ăn chay thanh tịnh sáng mùng Một",
                "description", "Nhiều gia đình ở Huế, Đà Nẵng, Quảng Nam giữ nếp ăn bữa cơm chay sáng đầu năm để gột rửa tâm hồn, cầu bình an cho muôn loài."
            ),
            Map.of(
                "title", "Viếng nghĩa trang gia tộc cuối năm (Chạp mả)",
                "description", "Khoảng 20 - 25 tháng Chạp, con cháu tề tựu dọn dẹp, đắp mộ và thắp hương rước ông bà về ăn Tết với con cháu."
            )
        );

        List<Map<String, String>> centralTaboos = Arrays.asList(
            Map.of(
                "title", "Kiêng ăn món xui rủi (thịt vịt, cá mè, trứng lộn)",
                "description", "Quan niệm người miền Trung kiêng ăn thịt vịt (sợ lẹt đẹt, đen đủi), cá mè (sợ mè nheo), trứng vịt lộn (sợ đảo lộn may mắn)."
            ),
            Map.of(
                "title", "Kiêng mặc đồ màu trắng toát hoặc đen tuyền",
                "description", "Hai gam màu gợi đến tang chế, chia buồn. Thay vào đó chuộng màu sắc tươi vui như đỏ tươi, vàng tươi, hồng thắm."
            ),
            Map.of(
                "title", "Kiêng trả giá, kỳ kèo khi mua mở hàng",
                "description", "Đi chợ Tết sớm mùng 1, mùng 2 mua muối ('đầu năm mua muối') tuyệt đối không mặc cả để giữ thảo thơm và duyên lành cho người bán."
            ),
            Map.of(
                "title", "Kiêng động thổ, cuốc xới đất vườn",
                "description", "Ba ngày Tết để đất đai nghỉ ngơi, không chọc cuốc xới đất làm động mạch ngầm tài lộc của thổ địa gia đình."
            )
        );

        central.put("foods", centralFoods);
        central.put("customs", centralCustoms);
        central.put("taboos", centralTaboos);
        REGION_DATA.put("CENTRAL", central);

        // --- 3. MIỀN NAM (SOUTH) ---
        Map<String, Object> south = new HashMap<>();
        south.put("regionCode", "SOUTH");
        south.put("regionName", "Miền Nam");
        south.put("subTitle", "Phóng Khoáng, Rạng Rỡ & Đậm Chất Phù Sa");
        south.put("flower", "Hoa Mai vàng cánh đại 5-9 cánh phú quý");
        south.put("weather", "Nắng vàng rực rỡ, trời trong xanh ấm áp");
        south.put("color", "#047857");

        List<Map<String, String>> southFoods = Arrays.asList(
            Map.of(
                "name", "Thịt kho nước dừa (Thịt kho tàu)",
                "description", "Miếng thịt ba rọi vuông lớn ninh cùng trứng vịt tròn vo trong nước dừa xiêm tươi, vàng óng ả sóng sánh ánh mỡ béo ngậy.",
                "meaning", "Hình vuông miếng thịt hòa cùng quả trứng tròn biểu trưng cho sự 'vuông tròn trọn vẹn', viên mãn cả năm.",
                "badge", "Món linh hồn"
            ),
            Map.of(
                "name", "Canh khổ qua nhồi thịt",
                "description", "Trái khổ qua (mướp đắng) lấy sạch ruột, nhồi thịt nạc băm nấm mèo, hầm chín mềm cùng nước dùng ngọt thanh rắc hành ngò tiêu sọ.",
                "meaning", "Mong muốn mọi nỗi 'khổ' cực, cay đắng của năm cũ sẽ 'qua' đi, đón mừng niềm vui hạnh phúc mới.",
                "badge", "Ý nghĩa sâu sắc"
            ),
            Map.of(
                "name", "Bánh Tét nhân chuối & hột vịt muối",
                "description", "Biến tấu đa dạng với bánh tét nếp trộn nước cốt dừa béo ngậy, nhân chuối xiêm chín đỏ hồng hoặc nhân thịt mỡ trứng muối thơm lừng.",
                "meaning", "Thể hiện sự trù phú của vùng đồng bằng sông nước Cửu Long màu mỡ.",
                "badge", "Bánh truyền thống"
            ),
            Map.of(
                "name", "Củ kiệu tôm khô & trứng bắc thảo",
                "description", "Củ kiệu ngâm chua ngọt giòn sần sật, ăn kèm tôm khô loại một đỏ hồng và trứng bách thảo bổ dưỡng trên bàn nhậu tiếp khách phương Nam.",
                "meaning", "Sang trọng, may mắn, mồi nhậu tri kỷ ngày hội tụ bạn bè xuân sang.",
                "badge", "Món nhậu Tết"
            ),
            Map.of(
                "name", "Lạp xưởng tươi & Mứt dừa non",
                "description", "Lạp xưởng tươi Cai Lậy lăn nước dừa vàng ươm, cùng mứt dừa non dẻo mềm đủ vị lá dứa, hoa đậu biếc, cà phê thơm phức.",
                "meaning", "Sắc đỏ lạp xưởng tượng trưng cho sợi chỉ đỏ may mắn kéo dài suốt năm.",
                "badge", "Món ngọt ngày xuân"
            )
        );

        List<Map<String, String>> southCustoms = Arrays.asList(
            Map.of(
                "title", "Chưng mâm ngũ quả 'Cầu - Sung - Vừa - Đủ - Xài'",
                "description", "Nghệ thuật chơi chữ Nam Bộ: Mãng Cầu, Sung, Dừa (vừa), Đu Đủ, Xoài (xài). Kiêng chuối (sợ chúi nhủi), cam (quýt làm cam chịu), lê (lê lết)."
            ),
            Map.of(
                "title", "Chơi cành mai vàng rực rỡ đón lộc",
                "description", "Sắc vàng hoa mai tượng trưng cho giàu sang, phú quý. Nếu mai nở rộ đúng giao thừa và mùng Một là điềm đại cát đại lợi."
            ),
            Map.of(
                "title", "Phong bao lì xì đỏ may mắn",
                "description", "Tập tục chúc Tết xôm tụ, con cháu mừng tuổi ông bà cha mẹ trường thọ, người lớn trao bao lì xì đỏ tươi lấy may cho trẻ nhỏ."
            ),
            Map.of(
                "title", "Hương vị sông nước đi chùa đầu năm",
                "description", "Người dân rủ nhau đi viếng các cảnh chùa linh thiêng (Chùa Bà Chúa Xứ, Chùa Ông...) cầu phúc lộc và hái lộc đầu xuân."
            )
        );

        List<Map<String, String>> southTaboos = Arrays.asList(
            Map.of(
                "title", "Kiêng để cối xay rỗng trong nhà",
                "description", "Người Nam quan niệm để cối xay bột rỗng đồng nghĩa với sự thất bát, thiếu thốn lương thực mùa vụ năm tới."
            ),
            Map.of(
                "title", "Kiêng đóng kín cửa nhà ngày Tết",
                "description", "Cửa nẻo luôn phải mở rộng thênh thang để đón nắng ấm, không khí xuân và Thần Tài ghé thăm mang phúc khí dồi dào."
            ),
            Map.of(
                "title", "Kiêng cúng chuối, cam, táo, lê",
                "description", "Tránh từ đồng âm mang ý nghĩa xui xẻo: chuối (chúi đầu chúi mũi thất bại), cam (cam chịu bẽ bàng), lê (lê lết vất vả)."
            ),
            Map.of(
                "title", "Kiêng quét nhà hất rác ra khỏi ngưỡng cửa",
                "description", "Chỉ gom rác vào góc kín sau cửa để giữ vận tài lộc trong nhà suốt ba ngày mùng Tết."
            )
        );

        south.put("foods", southFoods);
        south.put("customs", southCustoms);
        south.put("taboos", southTaboos);
        REGION_DATA.put("SOUTH", south);
    }

    /**
     * API 1: Lấy chi tiết món ăn, phong tục, kiêng kỵ theo miền
     * GET /api/v1/tet-map/region/{regionCode}
     * Ví dụ: NORTH, CENTRAL, SOUTH
     */
    @GetMapping("/region/{regionCode}")
    public ResponseEntity<?> getRegionData(@PathVariable("regionCode") String regionCode) {
        String code = regionCode.trim().toUpperCase();
        if (!REGION_DATA.containsKey(code)) {
            return ResponseEntity.status(404).body(Map.of(
                "status", 404,
                "message", "Không tìm thấy dữ liệu cho mã miền: " + regionCode + ". Hãy thử: NORTH, CENTRAL, SOUTH"
            ));
        }
        return ResponseEntity.ok(REGION_DATA.get(code));
    }

    /**
     * API 2: Lấy dữ liệu đối chiếu, so sánh phong tục Tết giữa các miền
     * GET /api/v1/tet-map/compare?regions=NORTH,CENTRAL,SOUTH
     */
    @GetMapping("/compare")
    public ResponseEntity<?> compareRegions(
            @RequestParam(name = "regions", defaultValue = "NORTH,CENTRAL,SOUTH") String regionsParam) {

        String[] requestedCodes = regionsParam.split(",");
        List<String> validCodes = new ArrayList<>();
        for (String c : requestedCodes) {
            String clean = c.trim().toUpperCase();
            if (REGION_DATA.containsKey(clean)) {
                validCodes.add(clean);
            }
        }
        if (validCodes.isEmpty()) {
            validCodes.addAll(List.of("NORTH", "CENTRAL", "SOUTH"));
        }

        // Tạo dữ liệu dạng ma trận so sánh các tiêu chí chính
        List<Map<String, Object>> comparisonMatrix = Arrays.asList(
            Map.of(
                "category", "Hoa biểu trưng ngày Tết",
                "icon", "bi-flower1",
                "north", "Hoa Đào hồng thắm xua đuổi tà khí, đón vượng khí và may mắn",
                "central", "Hoa Mai vàng tươi tắn, hoa cúc vạn thọ tượng trưng sự trường thọ",
                "south", "Hoa Mai vàng rực rỡ 5-9 cánh, biểu tượng phú quý, giàu sang tột đỉnh"
            ),
            Map.of(
                "category", "Bánh truyền thống ngày Tết",
                "icon", "bi-box2-heart",
                "north", "Bánh Chưng vuông vắn gói lá dong tượng trưng cho Đất mẹ, nhân thịt mỡ tiêu thơm",
                "central", "Bánh Tét trụ dài gói lá chuối buộc lạt chặt, đượm vị mộc mạc và gắn kết",
                "south", "Bánh Tét đa sắc nhân thịt mỡ trứng muối hoặc nhân chuối xiêm ngọt béo ngậy"
            ),
            Map.of(
                "category", "Mâm ngũ quả dâng cúng",
                "icon", "bi-basket",
                "north", "Chuộng thuyết Ngũ Hành (Kim-Mộc-Thủy-Hỏa-Thổ): Chuối xanh, bưởi vàng, đào, hồng, quất",
                "central", "Thành tâm và mộc mạc, có gì cúng nấy: Chuối, thanh long, mãng cầu, dưa hấu...",
                "south", "Chơi chữ gửi gắm ước vọng: 'Cầu - Sung - Vừa - Đủ - Xoài', tránh chuối và cam lê"
            ),
            Map.of(
                "category", "Món ăn 'linh hồn' mâm cỗ",
                "icon", "bi-cup-hot",
                "north", "Thịt đông trong suốt, dưa hành muối chua cay, giò thủ, canh măng móng giò",
                "central", "Thịt ngâm nước mắm đường, tôm chua xứ Huế, dưa món giòn rụm, tré riềng tỏi",
                "south", "Thịt kho nước dừa hột vịt (thịt kho tàu), canh khổ qua nhồi thịt, củ kiệu tôm khô"
            ),
            Map.of(
                "category", "Khí hậu thời tiết dịp Tết",
                "icon", "bi-cloud-sun",
                "north", "Tiết trời se lạnh, lất phất mưa xuân phùn mang lại nét thi vị trầm lắng",
                "central", "Khí hậu dịu mát, nắng ửng hoặc se lạnh đượm đà chất duyên dáng miền Trung",
                "south", "Nắng vàng rực rỡ, trời ấm áp trong vắt chan hòa sức sống phương Nam"
            ),
            Map.of(
                "category", "Phong tục văn hóa tiêu biểu",
                "icon", "bi-stars",
                "north", "Xông đất đầu năm, đi xin chữ thầy đồ tại Văn Miếu, lễ chùa hái lộc lúc giao thừa",
                "central", "Chạp mả viếng mộ tổ tiên, cúng giao thừa trong ngoài chu đáo, ăn chay mùng 1",
                "south", "Mở rộng cửa đón khách, lì xì rôm rả, du xuân hội chợ hoa và thăm viếng chùa linh"
            ),
            Map.of(
                "category", "Điều kiêng kỵ hàng đầu",
                "icon", "bi-shield-exclamation",
                "north", "Kiêng quét nhà mùng 1 làm mất tài lộc, kiêng cho lửa cho nước, kiêng làm vỡ bát đĩa",
                "central", "Kiêng ăn cá mè mè nheo, thịt vịt lẹt đẹt, trứng lộn; kiêng mặc đồ trắng đen tang tóc",
                "south", "Kiêng để cối xay rỗng sợ đói kém, kiêng quét rác ra cửa, kiêng chưng quả chuối hay cam"
            )
        );

        // Chi tiết từng miền theo danh sách chọn
        Map<String, Object> regionsDetail = new LinkedHashMap<>();
        for (String code : validCodes) {
            regionsDetail.put(code, REGION_DATA.get(code));
        }

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("requestedRegions", validCodes);
        result.put("matrix", comparisonMatrix);
        result.put("regionsDetail", regionsDetail);

        return ResponseEntity.ok(result);
    }
}
