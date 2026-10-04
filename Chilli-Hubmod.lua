-- =========================================================
-- CHILLI HUB TRANSLATOR V10.8 (POLLING-BASED - CHỐNG LAG)
-- Không hook GetPropertyChangedSignal → dùng polling 0.5s
-- =========================================================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local SCRIPT_URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"

-- =========================================================
-- TỪ ĐIỂN VIỆT HÓA
-- =========================================================
local DICT = {
    -- Tab chính
    ["Main"]="Chính", ["Home"]="Trang chủ", ["Player"]="Người chơi", ["Players"]="Người chơi",
    ["Visuals"]="Hình ảnh", ["Combat"]="Chiến đấu", ["Misc"]="Khác",
    ["Settings"]="Cài đặt", ["Config"]="Cấu hình", ["Scripts"]="Kịch bản",
    ["Teleport"]="Dịch chuyển", ["Movement"]="Di chuyển", ["World"]="Thế giới",
    ["Character"]="Nhân vật", ["Utility"]="Tiện ích", ["Others"]="Khác",
    ["Shop"]="Cửa hàng", ["Trade"]="Giao dịch", ["Toggle"]="Bật/Tắt",
    ["Enable"]="Bật", ["Disable"]="Tắt", ["Enabled"]="Đã bật", ["Disabled"]="Đã tắt",
    ["On"]="Bật", ["Off"]="Tắt", ["Close"]="Đóng", ["Open"]="Mở",
    ["Confirm"]="Xác nhận", ["Cancel"]="Huỷ", ["Apply"]="Áp dụng",
    ["Reset"]="Đặt lại", ["Save"]="Lưu", ["Load"]="Tải", ["Select"]="Chọn",
    ["Copy"]="Sao chép", ["Execute"]="Thực thi", ["Start"]="Bắt đầu",
    ["Stop"]="Dừng", ["Refresh"]="Làm mới", ["Search"]="Tìm kiếm",
    ["Filter"]="Lọc", ["Sort"]="Sắp xếp", ["Speed"]="Tốc độ",
    ["Jump"]="Nhảy", ["Fly"]="Bay", ["Walk Speed"]="Tốc độ đi",
    ["Jump Power"]="Lực nhảy", ["God Mode"]="Bất tử", ["Infinite"]="Vô hạn",
    ["Health"]="Máu", ["Ammo"]="Đạn", ["Kill"]="Giết", ["Kill All"]="Giết tất cả",
    ["Aimbot"]="Ngắm tự động", ["Wallhack"]="Xuyên tường",
    ["Auto Farm"]="Tự động cày", ["Auto"]="Tự động", ["Farm"]="Cày",
    ["Noclip"]="Xuyên vật thể", ["Anti Ban"]="Chống ban", ["Anti AFK"]="Chống AFK",
    ["Full Bright"]="Ánh sáng đầy", ["No Fog"]="Không sương mù", ["FOV"]="Tầm nhìn",
    ["Hitbox"]="Vùng va chạm", ["Invisible"]="Tàng hình", ["Damage"]="Sát thương",
    ["Range"]="Phạm vi", ["Radius"]="Bán kính", ["Amount"]="Số lượng",
    ["Value"]="Giá trị", ["Time"]="Thời gian", ["Delay"]="Độ trễ",
    ["Cooldown"]="Hồi chiêu", ["Loading"]="Đang tải", ["Loaded"]="Đã tải",
    ["Please wait"]="Vui lòng đợi", ["Error"]="Lỗi", ["Success"]="Thành công",
    ["Failed"]="Thất bại", ["Warning"]="Cảnh báo", ["Notice"]="Thông báo",
    ["Language"]="Ngôn ngữ", ["Vietnamese"]="Tiếng Việt", ["English"]="Tiếng Anh",
    ["Copy Link"]="Sao chép liên kết", ["Made by"]="Được tạo bởi",
    ["Version"]="Phiên bản", ["Key"]="Khoá", ["Active"]="Kích hoạt",

    -- Chilli Hub V10.4
    ["Egg Finder"]="Máy Dò Trứng", ["Predictor"]="Soi Trứng", ["Progress"]="Tiến Độ",
    ["Server"]="Máy Chủ", ["Creator"]="Tác Giả", ["Quick & Keys"]="Phím Tắt",
    ["Dr Scramble Event"]="Sự Kiện Dr Scramble",
    ["Auto Hunt Drones"]="Tự Động Săn Drone",
    ["Kill drones during outbreaks for Samples and Drone Parts"]="Tiêu diệt drone khi bùng phát để lấy Mẫu Vật và Phụ Tùng",
    ["Hunt Priority"]="Ưu Tiên Săn", ["Most HP First"]="Nhiều Máu Nhất Trước",
    ["Drone Types"]="Loại Drone", ["Hunt Travel Method"]="Cách Thức Di Chuyển",
    ["Teleport only to drones within 50 studs, farther ones are tweened"]="Dịch chuyển nếu dưới 50 studs, xa hơn sẽ dùng Tween bay tới",
    ["Hunt Tween Speed"]="Tốc Độ Bay (Tween) Săn",
    ["Only Until Vault Parts Found"]="Dừng Khi Đủ Phụ Tùng Hầm",
    ["Auto Collect Lost Parts"]="Tự Nhặt Phụ Tùng Rơi",
    ["Collect the 2 Lost Parts for the vault"]="Thu thập đủ 2 Phụ Tùng Rơi để mở hầm",
    ["Auto Open Vault"]="Tự Động Mở Hầm Chứa",
    ["Open the vault when all 5 parts are found"]="Tự mở khóa hầm khi đã thu thập đủ 5 phụ tùng",
    ["Auto Buy Scramble Shop"]="Tự Động Mua Shop Scramble",
    ["Buy the picked items with Samples"]="Dùng Mẫu Vật để mua các món đồ đã chọn",
    ["Scramble Shop Items"]="Vật Phẩm Cửa Hàng Scramble",
    ["Keep Samples"]="Giữ Lại Mẫu Vật (Không mua hết)",
    ["Go To Secret Cave"]="Đi Đến Hang Động Bí Ẩn (Secret)",
    ["Dr Scramble Mech"]="Mech Dr Scramble", ["Dr Scramble Mech (New)"]="Mech Dr Scramble (Mới)",
    ["Next Mech portal in"]="Cổng Mech tiếp theo sau",
    ["Auto Mech Boss"]="Tự Động Đánh Boss Mech",
    ["Mech Tốc Độ Bay (Tween)"]="Mech Tốc Độ Bay (Tween)",
    ["Main Weapon Hold"]="Giữ Vũ Khí Chính", ["Scrambler Hold"]="Giữ Máy Gây Nhiễu",
    ["Swap Two Weapons"]="Đổi Hai Vũ Khí", ["Dodge Attacks"]="Né Đòn Tấn Công",
    ["Anti Guard"]="Chống Vệ Sĩ", ["Ball And Core Phase"]="Giai Đoạn Bóng & Lõi",
    ["Leave After Fight"]="Rời Đi Sau Khi Đánh",
    ["Auto Use Scrambled Mutation"]="Tự Động Dùng Đột Biến Scrambled",
    ["Idle"]="Đang Chờ", ["Turn it on to start applying Scrambled"]="Bật lên để bắt đầu áp dụng Scrambled",
    ["Charges"]="Lượt Sạc", ["Eggs"]="Trứng", ["Tries"]="Lần Thử", ["Applied"]="Đã Áp Dụng",
    ["Mutation Độ Hiếm Tối Thiểu"]="Độ Hiếm Đột Biến Tối Thiểu",
    ["Only eggs of this rarity and above are used"]="Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Giá Trị"]="Giá Trị Đột Biến Tối Thiểu",
    ["Bỏ qua trứng rẻ hơn mức này (0 = Tắt)"]="Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Mutation Priority"]="Ưu Tiên Đột Biến", ["Giá Trị Cao Nhất"]="Giá Trị Cao Nhất",
    ["Which egg gets the consumable first"]="Trứng nào nhận vật phẩm tiêu hao trước",
    ["Mutation Target Eggs"]="Trứng Mục Tiêu Đột Biến",
    ["Only use the consumable on these eggs (empty = all)"]="Chỉ dùng vật phẩm này lên những trứng này (Trống = Tất cả)",
    ["Auto Buy Scrambled"]="Tự Động Mua Scrambled",
    ["Buy another Scrambled from the event shop when you run out"]="Tự mua thêm Scrambled từ shop sự kiện khi hết",
    ["Any"]="Bất Kỳ", ["All"]="Tất Cả",
    ["Lab is locked on this account"]="Lab đã bị khóa trên tài khoản này",
    ["Auto Lab Trade-In"]="Tự Động Đổi Lab (Trade-In)",
    ["Auto Reroll Lab Recipe"]="Tự Động Đổi Công Thức Lab",
    ["Place Lab Recipe Trứng"]="Đặt Trứng Công Thức Lab",
    ["Hatch Lab Recipe Trứng"]="Ấp Trứng Công Thức Lab",
    ["Boss Đổi Máy Chủ Ngay"]="Boss Đổi Máy Chủ Ngay",
    ["After each boss, hops to a less crowded server to fight again"]="Sau mỗi boss, chuyển sang server ít người hơn để đánh tiếp",
    ["Tự Động Nhận Thưởng Mastery"]="Tự Động Nhận Thưởng Mastery",
    ["Claims Boss Mastery rewards as soon as they unlock"]="Nhận thưởng Boss Mastery ngay khi mở khóa",
    ["Keep Chuyểnping For"]="Giữ Chuyển Server Trong",
    ["Keeps fighting every boss it finds and hopping for this long"]="Tiếp tục đánh mọi boss tìm thấy và chuyển server trong khoảng thời gian này",
    ["Lab Banners"]="Biểu Ngữ Lab (Lab Banners)",
    ["Only trade and steal for these banners (empty = all)"]="Chỉ đổi và cướp cho những biểu ngữ này (Trống = Tất cả)",
    ["Auto Place Lab Reward Trứng"]="Tự Động Đặt Trứng Thưởng Lab",
    ["Places the reward eggs from Lab trades"]="Đặt trứng thưởng nhận được từ giao dịch Lab",
    ["Tự Động Mua Shop Scramble"]="Tự Động Mua Shop Scramble",
    ["Dùng Mẫu Vật để mua các món đồ đã chọn"]="Dùng Mẫu Vật để mua các món đồ đã chọn",
    ["Vật Phẩm Cửa Hàng Scramble"]="Vật Phẩm Cửa Hàng Scramble",
    ["Scrambled Mutation"]="Đột Biến Scrambled",
    ["Giữ Lại Mẫu Vật (Không mua hết)"]="Giữ Lại Mẫu Vật (Không mua hết)",
    ["Never spend below this many Samples"]="Không bao giờ tiêu xuống dưới số Mẫu Vật này",
    ["Need a Scrambled consumable"]="Cần vật phẩm Scrambled",
    ["Buy Scrambled from the event shop"]="Mua Scrambled từ shop sự kiện",
    ["Unstable DNA"]="DNA Không Ổn Định (Unstable DNA)",
    ["Không Chọn"]="Không Chọn",

    -- Menu điều hướng
    ["Farm Tab > Auto Steal"]="Tab Cày Cuốc > Tự Động Cướp",
    ["Farm Tab > Auto Place Egg"]="Tab Cày Cuốc > Tự Đặt Trứng",
    ["Farm Tab > Auto Treadmill"]="Tab Cày Cuốc > Tự Chạy Máy Tập",
    ["Farm Tab > Auto Hatch & Equip"]="Tab Cày Cuốc > Tự Ấp & Thay Thú",
    ["Farm Tab > Auto Sell"]="Tab Cày Cuốc > Tự Động Bán",
    ["Farm Tab > Auto Fuse Machine"]="Tab Cày Cuốc > Tự Máy Ghép",
    ["Farm Tab > Auto Favorite"]="Tab Cày Cuốc > Tự Khóa Thú",
    ["Farm Tab > Auto Rift & Boss"]="Tab Cày Cuốc > Tự Động Rift & Boss",
    ["Player Tab > ESP"]="Tab Người Chơi > Xuyên Tường (ESP)",
    ["Player Tab > Movement"]="Tab Người Chơi > Di Chuyển",
    ["Player Tab > Character"]="Tab Người Chơi > Nhân Vật",
    ["Egg Finder Tab > Egg Finder"]="Tab Tìm Trứng > Máy Dò Trứng",
    ["Predictor Tab > Discord Webhook"]="Tab Dự Đoán > Webhook Discord",
    ["Predictor Tab > Egg Predictor"]="Tab Dự Đoán > Soi Trứng",
    ["Predictor Tab > Fuse Predictor"]="Tab Dự Đoán > Soi Tỷ Lệ Ghép",
    ["Progress Tab > Auto Progression"]="Tab Tiến Độ > Tự Động Thăng Tiến",
    ["Server Tab > Server"]="Tab Máy Chủ > Máy Chủ",
    ["Misc Tab > Performance"]="Tab Linh Tinh > Hiệu Năng",
    ["Misc Tab > Utility"]="Tab Linh Tinh > Tiện Ích",
    ["Discord Tab > Creator Event"]="Tab Discord > Sự Kiện Tác Giả",
    ["Discord Tab > Community"]="Tab Discord > Cộng Đồng",
    ["Quick & Keys Tab > Quick Access"]="Tab Phím Tắt > Truy Cập Nhanh",
    ["Quick & Keys Tab > Quick Bar & Keybinds"]="Tab Phím Tắt > Thanh Nhanh & Gán Phím",
    ["Settings Tab > Interface"]="Tab Cài Đặt > Giao Diện",
    ["Settings Tab > Defaults"]="Tab Cài Đặt > Mặc Định",
    ["Config Tab > Config"]="Tab Cấu Hình > Cấu Hình",
    ["Config Tab > Profiles"]="Tab Cấu Hình > Hồ Sơ",
    ["Config Tab > Import/Export"]="Tab Cấu Hình > Nhập/Xuất",

    -- Tính năng
    ["Auto Steal"]="Tự Động Cướp", ["Target Areas"]="Khu Vực Mục Tiêu",
    ["Min Rarity"]="Độ Hiếm Tối Thiểu",
    ["Steal eggs of the chosen rarity and every rarity above it"]="Cướp trứng từ độ hiếm đã chọn trở lên",
    ["Min Value To Steal"]="Giá Trị Cướp Tối Thiểu",
    ["Skip eggs worth less than this (0 = off)"]="Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Target Specific Eggs"]="Nhắm Trứng Cụ Thể",
    ["Only steal these eggs (empty = all)"]="Chỉ cướp những trứng này (Trống = Tất cả)",
    ["Prioritize Rift Recipe Eggs"]="Ưu Tiên Trứng Rift",
    ["Steal eggs the Rift recipe needs first"]="Cướp trứng cần cho Rift trước",
    ["Steal Priority"]="Ưu Tiên Cướp", ["Highest Value"]="Giá Trị Cao Nhất",
    ["Tween Speed"]="Tốc Độ Bay (Tween)", ["Anti Guard V1"]="Chống Vệ Sĩ V1",
    ["Auto Place Egg"]="Tự Động Đặt Trứng", ["Place Egg Rule"]="Quy Tắc Đặt Trứng",
    ["Place Egg Priority"]="Ưu Tiên Đặt Trứng", ["Biggest Size"]="Kích Thước Lớn Nhất",
    ["Always"]="Luôn Luôn", ["Auto Treadmill"]="Tự Chạy Máy Tập",
    ["Stay On Treadmill"]="Giữ Trên Máy Tập",
    ["Auto Hatch & Equip"]="Tự Ấp & Thay Thú", ["Auto Hatch"]="Tự Động Ấp",
    ["Auto Equip Best"]="Tự Mặc Đồ Xịn Nhất",
    ["Auto Sell"]="Tự Động Bán", ["Auto Sell Pet"]="Tự Động Bán Thú",
    ["Sell Pets Now"]="Bán Thú Ngay", ["Sell Pet Rule"]="Quy Tắc Bán Thú",
    ["Rarity Only"]="Chỉ Xét Độ Hiếm", ["Pet Max Rarity"]="Độ Hiếm Thú Tối Đa",
    ["Pet Value Threshold"]="Ngưỡng Giá Trị Thú",
    ["Keep Mutated Pets"]="Giữ Thú Đột Biến",
    ["Blacklist Sell Pets"]="Danh Sách Đen (Không Bán)",
    ["Auto Sell Egg"]="Tự Động Bán Trứng",
    ["Sell Eggs Now"]="Bán Trứng Ngay",
    ["Sell Egg Rule"]="Quy Tắc Bán Trứng", ["Egg Max Rarity"]="Độ Hiếm Trứng Tối Đa",
    ["Egg Value Threshold"]="Ngưỡng Giá Trị Trứng",
    ["Keep Mutated Eggs"]="Giữ Trứng Đột Biến",
    ["Blacklist Sell Eggs"]="Danh Sách Đen Trứng",
    ["Auto Fuse Machine"]="Tự Động Máy Ghép",
    ["Fuse Priority Mode"]="Chế Độ Ưu Tiên Ghép",
    ["Lowest Rarity First"]="Độ Hiếm Thấp Trộn Trước",
    ["Pets To Use"]="Thú Cưng Sử Dụng", ["Lowest To Highest"]="Từ Thấp Đến Cao",
    ["Max Rarity to Fuse"]="Độ Hiếm Ghép Tối Đa",
    ["Skip Mutated Pets"]="Bỏ Qua Thú Đột Biến",
    ["Auto Favorite"]="Tự Động Khóa Thú", ["Auto Favorite Pet"]="Tự Động Khóa Thú",
    ["Favorite Pets Now"]="Khóa Thú Ngay",
    ["Favorite Rule"]="Quy Tắc Khóa",
    ["Match All"]="Khớp Tất Cả", ["Favorite Min Rarity"]="Độ Hiếm Khóa Min",
    ["Favorite Mutations"]="Khóa Thú Đột Biến",
    ["Favorite Min Value"]="Giá Trị Khóa Min",
    ["Always Favorite Species"]="Luôn Khóa Loài Này",
    ["Auto Favorite Equipped"]="Tự Khóa Thú Đang Dùng",
    ["Auto Unfavorite Equipped"]="Tự Mở Khóa Thú Đang Dùng",
    ["Favorite Equipped Now"]="Khóa Thú Đang Dùng Ngay",
    ["Unfavorite Equipped Now"]="Mở Khóa Thú Đang Dùng Ngay",
    ["Auto Rift & Boss"]="Tự Động Rift & Boss",
    ["Auto Rift Sacrifice"]="Tự Động Hiến Tế Rift",
    ["Auto Reroll Rift Recipe"]="Tự Động Đổi Công Thức Rift",
    ["Auto Claim Boss Mastery"]="Tự Nhận Thưởng Boss",
    ["Auto Fight Boss"]="Tự Động Đánh Boss", ["Auto Progression"]="Tự Động Thăng Tiến",
    ["Auto Buy Trail"]="Tự Động Mua Vệt Sáng",
    ["Auto Upgrade Base"]="Tự Động Nâng Cấp Căn Cứ",
    ["Auto Upgrade Treadmill"]="Tự Động Nâng Cấp Máy Tập",
    ["Auto Claim"]="Tự Động Nhận Thưởng",
    ["ESP"]="Xuyên Tường (ESP)", ["ESP Eggs"]="Hiển Thị Trứng",
    ["ESP Fixed Size"]="Cố Định Kích Cỡ ESP",
    ["ESP Own Base Eggs"]="Hiển Thị Trứng Căn Cứ Mình",
    ["ESP Min Rarity"]="Độ Hiếm Tối Thiểu ESP",
    ["ESP Show Info"]="Hiện Thông Tin ESP", ["ESP Min Value"]="Giá Trị ESP Tối Thiểu",
    ["ESP Egg Size"]="Kích Cỡ Trứng ESP", ["ESP Guards"]="Hiển Thị Vệ Sĩ",
    ["ESP Guard Size"]="Kích Cỡ Vệ Sĩ ESP", ["ESP Players"]="Hiển Thị Người Chơi",
    ["ESP Player Info"]="Thông Tin Người Chơi ESP",
    ["ESP Player Size"]="Kích Cỡ Người Chơi ESP",
    ["Speed Boost"]="Tăng Tốc Di Chuyển", ["Boost Speed"]="Tốc Độ Tăng Cường",
    ["Infinite Jump"]="Nhảy Vô Hạn", ["Anti Ragdoll"]="Chống Ngã (Ragdoll)",
    ["Anti Trap"]="Chống Bẫy", ["Instant Steal"]="Cướp Tức Thì",
    ["IDLE"]="ĐANG CHỜ LỆNH",
    ["Turn on Egg Finder to start hunting"]="Bật Máy Dò Trứng để bắt đầu săn",
    ["Link To Auto Steal Filters"]="Dùng Chung Bộ Lọc Tự Động Cướp",
    ["Min Value To Find"]="Giá Trị Trứng Tối Thiểu",
    ["Hop Only When Rarity Appears"]="Chỉ Đổi Server Khi Thấy Độ Hiếm Này",
    ["Rarity That Must Appear"]="Độ Hiếm Bắt Buộc Xuất Hiện",
    ["Hop Delay"]="Độ Trễ Đổi Server",
    ["Egg Predictor"]="Soi Trứng (Predictor)", ["Sort By"]="Sắp Xếp Theo",
    ["Preview Card"]="Xem Thẻ Trước", ["Search eggs..."]="Tìm kiếm trứng...",
    ["Tap an egg below to preview it"]="Chạm vào trứng bên dưới để xem chi tiết",
    ["In inventory"]="Trong túi", ["Hold egg"]="Đang giữ",
    ["Fuse Predictor"]="Soi Tỷ Lệ Ghép (Fuse)", ["Machine is empty"]="Máy đang trống",
    ["Load 3 pets of the same species to see the result odds"]="Cho 3 thú cùng loài vào để xem tỷ lệ kết quả",
    ["Auto Load Script"]="Tự Động Nạp Script",
    ["Server Hop Mode"]="Chế Độ Đổi Server",
    ["Least Players"]="Ít Người Chơi Nhất", ["Server Hop"]="Đổi Server Ngay",
    ["Job ID"]="ID Máy Chủ (Job ID)",
    ["Paste a server Job ID..."]="Dán ID máy chủ vào đây...",
    ["Join Job ID"]="Vào Bằng ID",
    ["Copy Current Job ID"]="Chép ID Máy Chủ Hiện Tại",
    ["Rejoin Server"]="Vào Lại Máy Chủ Này", ["Join"]="Vào",
    ["Rejoin"]="Vào Lại", ["Hop"]="Chuyển",
    ["Performance"]="Hiệu Năng", ["FPS Cap"]="Giới Hạn FPS",
    ["Optimizer"]="Tối Ưu Hóa Tối Đa",
    ["FPS and Ping"]="Hiện FPS & Ping",
    ["FPS and Ping Size"]="Cỡ Chữ FPS & Ping",
    ["Anti AFK"]="Chống Treo Máy (AFK)",
    ["Creator Event"]="Sự Kiện Của Tác Giả", ["INVITE LINK"]="LIÊN KẾT MỜI",
    ["WHAT YOU GET"]="BẠN NHẬN ĐƯỢC GÌ",
    ["New Scripts & Updates"]="Script & Cập Nhật Mới",
    ["Giveaways"]="Tặng Quà (Giveaways)",
    ["Support"]="Hỗ Trợ", ["Suggestions"]="Đóng Góp Ý Kiến",
    ["Copy Discord Link"]="Chép Link Discord", ["Click"]="Bấm",
    ["Quick Access"]="Truy Cập Nhanh", ["Show Quick Bars"]="Hiện Thanh Phím Tắt",
    ["Visible Quick Bars"]="Các Thanh Đang Hiện",
    ["Quick Bar Size"]="Kích Cỡ Thanh Phím Tắt",
    ["Quick Bar & Keybinds"]="Thanh Phím Tắt & Gán Nút",
    ["Reset Quick Access"]="Đặt Lại Truy Cập Nhanh",
    ["Reset Keybinds"]="Đặt Lại Nút Gán",
    ["Interface"]="Giao Diện", ["UI Size"]="Kích Cỡ Giao Diện",
    ["Notifications"]="Bật Thông Báo",
    ["Open On Launch"]="Mở Khi Khởi Chạy",
    ["Defaults"]="Mặc Định", ["Reset to Defaults"]="Đặt Lại Về Mặc Định",
    ["Turn Off All Toggles"]="Tắt Tất Cả Công Tắc",
    ["Turn Off"]="Tắt Ngay", ["Auto Save Config"]="Tự Động Lưu Cấu Hình",
    ["Auto Load Config"]="Tự Động Nạp Cấu Hình",
    ["New Config Name"]="Tên Cấu Hình Mới",
    ["Create New Config"]="Tạo Cấu Hình Mới",
    ["Save Config"]="Lưu Cấu Hình Hiện Tại",
    ["Import Config Text"]="Nhập Mã Văn Bản Cấu Hình",
    ["Destination"]="Nơi Nhận Thông Báo", ["Webhook URL"]="Đường Dẫn Webhook",
    ["Notify Egg Finder Match"]="Báo Khi Máy Dò Khớp Trứng",
    ["Notify Stolen Eggs"]="Báo Khi Cướp Được Trứng",
    ["None"]="Không Chọn", ["Filter features..."]="Lọc tính năng...",
    ["Favorite"]="Khóa Lại", ["Unfavorite"]="Mở Khóa", ["Sell"]="Bán",
    ["Mythic"]="Thần Thoại (Mythic)", ["Secret"]="Bí Ẩn (Secret)",
    ["Divine"]="Thánh Thần (Divine)", ["Eternal"]="Vĩnh Cửu (Eternal)",
    ["Cosmic"]="Vũ Trụ (Cosmic)", ["Legendary"]="Huyền Thoại (Legendary)",
    ["Let's Chat!"]="Trò Chuyện Nào!", ["Send"]="Gửi", ["Live"]="Trực Tiếp",
    ["Fetching..."]="Đang Tải Dữ Liệu...", ["Loaded"]="Đã Nạp Xong"
}

-- =========================================================
-- HÀM DỊCH (CACHE + SKIP TEXT ĐỘNG)
-- =========================================================
local sortedKeys = {}
for k in pairs(DICT) do table.insert(sortedKeys, k) end
table.sort(sortedKeys, function(a,b) return #a > #b end)

local escapePattern = function(s)
    return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

local translateCache = {}

local SKIP_PATTERNS = {
    "^[%d%p%s]+$",
    "^%$[%d%.]+[KMBT]?$",
    "^%d+[KMBT]?$",
    "^[+%-]%$[%d%.]+[KMBT]?$",
    "^%d+%.%d+s$",
    "^%d+/%d+$",
}

local function shouldSkip(text)
    for _, pat in ipairs(SKIP_PATTERNS) do
        if text:match(pat) then return true end
    end
    return false
end

local function translateText(text)
    if type(text) ~= "string" or text == "" then return text end
    
    local cached = translateCache[text]
    if cached ~= nil then return cached end
    
    local result = DICT[text]
    if result then
        translateCache[text] = result
        return result
    end
    
    if shouldSkip(text) then
        translateCache[text] = text
        return text
    end
    
    local out = text
    for _, en in ipairs(sortedKeys) do
        local vi = DICT[en]
        if vi ~= en then
            local pat = "%f[%w]" .. escapePattern(en) .. "%f[%W]"
            out = out:gsub(pat, vi)
        end
    end
    
    translateCache[text] = out
    return out
end

-- =========================================================
-- POLLING ENGINE (KHÔNG HOOK GetPropertyChangedSignal)
-- =========================================================
local translating = false
local trackedObjects = {} -- {obj = <GuiObject>, lastText = <string>}

local IGNORE_GUI_NAMES = {
    ["Chat"] = true, ["Backpack"] = true, ["PlayerList"] = true,
    ["BubbleChat"] = true, ["TouchGui"] = true, ["TouchControlFrame"] = true,
    ["ControlFrame"] = true, ["Topbar"] = true, ["StarterGui"] = true,
    ["LangSelector"] = true,
}

-- Đăng ký object vào danh sách theo dõi (KHÔNG hook event)
local function registerObject(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
    if obj:GetAttribute("ChilliTracked") then return end
    obj:SetAttribute("ChilliTracked", true)
    
    table.insert(trackedObjects, {
        obj = obj,
        lastText = nil, -- Chưa dịch lần nào
    })
end

-- Quét 1 GUI, đăng ký tất cả descendants
local function scanGui(gui)
    if not gui:IsA("ScreenGui") then return end
    if IGNORE_GUI_NAMES[gui.Name] then return end
    
    local descendants = gui:GetDescendants()
    for i, d in ipairs(descendants) do
        registerObject(d)
        if i % 30 == 0 then task.wait() end
    end
end

-- =========================================================
-- VÒNG LẶP POLLING: quét toàn bộ object đã đăng ký
-- =========================================================
local POLL_INTERVAL = 0.5 -- Quét mỗi 0.5 giây

local function pollingLoop()
    while true do
        task.wait(POLL_INTERVAL)
        
        if translating then continue end
        translating = true
        
        -- Duyệt ngược để xóa object đã bị destroy
        for i = #trackedObjects, 1, -1 do
            local entry = trackedObjects[i]
            local obj = entry.obj
            
            if not obj or not obj.Parent then
                table.remove(trackedObjects, i)
                continue
            end
            
            -- Đọc text hiện tại
            local ok, cur = pcall(function() return obj.Text end)
            if ok and type(cur) == "string" and cur ~= "" and cur ~= entry.lastText then
                local new = translateText(cur)
                if new ~= cur then
                    pcall(function() obj.Text = new end)
                    entry.lastText = new
                else
                    entry.lastText = cur
                end
            end
        end
        
        translating = false
    end
end

-- =========================================================
-- WATCHER: Chờ Chilli Hub load rồi quét tất cả GUI
-- =========================================================
local function startWatching()
    task.wait(3) -- Chờ Chilli Hub load xong
    
    local targets = {
        CoreGui,
        Players.LocalPlayer:WaitForChild("PlayerGui")
    }
    
    for _, container in ipairs(targets) do
        if container then
            -- Quét GUI hiện có
            for _, gui in ipairs(container:GetChildren()) do
                if gui:IsA("ScreenGui") and not IGNORE_GUI_NAMES[gui.Name] then
                    task.spawn(function() scanGui(gui) end)
                end
            end
            
            -- Lắng nghe ScreenGui mới
            container.DescendantAdded:Connect(function(d)
                if d:IsA("ScreenGui") and not IGNORE_GUI_NAMES[d.Name] then
                    task.defer(function() scanGui(d) end)
                elseif d:IsA("GuiObject") and d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    task.defer(function() registerObject(d) end)
                end
            end)
        end
    end
end

-- =========================================================
-- HÀM TẢI SCRIPT
-- =========================================================
local function fetchScript(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and type(res) == "string" and #res > 0 then return res end
    
    for _, name in ipairs({"request","http_request","syn_request"}) do
        local fn = _G[name]
        if type(fn) == "function" then
            local ok2, r = pcall(fn, {Url = url, Method = "GET"})
            if ok2 and r and r.Body and #r.Body > 0 then
                return r.Body
            end
        end
    end
    return nil
end

-- =========================================================
-- UI CHỌN NGÔN NGỮ
-- =========================================================
local gui = Instance.new("ScreenGui")
gui.Name = "LangSelector"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
do
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 220)
frame.Position = UDim2.new(0.5, -190, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(85, 85, 110)

local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "Chọn ngôn ngữ / Select Language"
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local holder = Instance.new("Frame", frame)
holder.Size = UDim2.new(1, -40, 0, 60)
holder.Position = UDim2.new(0, 20, 0, 65)
holder.BackgroundTransparency = 1
local lay = Instance.new("UIListLayout", holder)
lay.FillDirection = Enum.FillDirection.Horizontal
lay.Padding = UDim.new(0, 10)
lay.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function makeBtn(text, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.5, -5, 1, 0)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(240, 240, 240)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 15
    b.Parent = holder
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    return b
end

local btnVI = makeBtn("🇻🇳 Tiếng Việt", Color3.fromRGB(200, 40, 40))
local btnEN = makeBtn("🇺🇸 English", Color3.fromRGB(40, 90, 200))

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -40, 0, 26)
status.Position = UDim2.new(0, 20, 1, -40)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(180, 180, 180)
status.Font = Enum.Font.Gotham
status.TextSize = 12

-- =========================================================
-- CHẠY
-- =========================================================
local loading = false
local function run(lang)
    if loading then return end
    loading = true
    
    status.Text = (lang == "vi") and "Đang tải script..." or "Loading script..."
    btnVI:Destroy()
    btnEN:Destroy()
    
    task.spawn(function()
        local src = fetchScript(SCRIPT_URL)
        if not src then
            status.Text = (lang == "vi") and "❌ Không tải được script!" or "❌ Failed!"
            loading = false
            return
        end
        
        status.Text = (lang == "vi") and "▶️ Đang chạy..." or "▶️ Running..."
        task.wait(0.3)
        gui:Destroy()
        
        local loader = loadstring or load
        local fn, err = loader(src)
        if not fn then
            warn("[LangSel] loadstring error: " .. tostring(err))
            return
        end
        
        -- Chạy script chính trong coroutine riêng
        task.spawn(fn)
        
        if lang == "vi" then
            -- Bắt đầu watcher (đăng ký object, không hook event)
            task.spawn(startWatching)
            -- Bắt đầu vòng lặp polling (1 vòng duy nhất cho toàn bộ)
            task.spawn(pollingLoop)
        end
        -- Nếu chọn EN: không chạy watcher/polling → text giữ nguyên tiếng Anh
    end)
end

btnVI.MouseButton1Click:Connect(function() run("vi") end)
btnEN.MouseButton1Click:Connect(function() run("en") end)
