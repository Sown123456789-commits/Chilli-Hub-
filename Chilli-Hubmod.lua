-- =========================================================
-- LANGUAGE SELECTOR + RUNTIME GUI TRANSLATOR (EN -> VI)
-- Hook GUI, dịch realtime mọi TextLabel/TextButton/TextBox
-- Dữ liệu dịch được chuyển từ Chilli Hub Translator V10.4
-- =========================================================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local SCRIPT_URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"

-- =========================================================
-- TỪ ĐIỂN VIỆT HÓA (Chuyển từ V10.4)
-- =========================================================
local MAP_VI = {
    -- Các Tab Chính
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Egg Finder"] = "Máy Dò Trứng",
    ["Predictor"] = "Soi Trứng",
    ["Progress"] = "Tiến Độ",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Linh Tinh",
    ["Creator"] = "Tác Giả",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",

    -- Dr Scramble Event
    ["Dr Scramble Event"] = "Sự Kiện Dr Scramble",
    ["Auto Hunt Drones"] = "Tự Động Săn Drone",
    ["Kill drones during outbreaks for Samples and Drone Parts"] = "Tiêu diệt drone khi bùng phát để lấy Mẫu Vật và Phụ Tùng",
    ["Hunt Priority"] = "Ưu Tiên Săn",
    ["Most HP First"] = "Nhiều Máu Nhất Trước",
    ["Drone Types"] = "Loại Drone",
    ["Hunt Travel Method"] = "Cách Thức Di Chuyển",
    ["Teleport only to drones within 50 studs, farther ones are tweened"] = "Dịch chuyển nếu dưới 50 studs, xa hơn sẽ dùng Tween bay tới",
    ["Hunt Tween Speed"] = "Tốc Độ Bay (Tween) Săn",
    ["Only Until Vault Parts Found"] = "Dừng Khi Đủ Phụ Tùng Hầm",
    ["Auto Collect Lost Parts"] = "Tự Nhặt Phụ Tùng Rơi",
    ["Collect the 2 Lost Parts for the vault"] = "Thu thập đủ 2 Phụ Tùng Rơi để mở hầm",
    ["Auto Open Vault"] = "Tự Động Mở Hầm Chứa",
    ["Open the vault when all 5 parts are found"] = "Tự mở khóa hầm khi đã thu thập đủ 5 phụ tùng",
    ["Auto Buy Scramble Shop"] = "Tự Động Mua Shop Scramble",
    ["Buy the picked items with Samples"] = "Dùng Mẫu Vật để mua các món đồ đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble",
    ["Keep Samples"] = "Giữ Lại Mẫu Vật (Không mua hết)",
    ["Go To Secret Cave"] = "Đi Đến Hang Động Bí Ẩn (Secret)",

    -- Dr Scramble Mech & Scrambled Mutation
    ["Dr Scramble Mech"] = "Mech Dr Scramble",
    ["Dr Scramble Mech (New)"] = "Mech Dr Scramble (Mới)",
    ["Next Mech portal in"] = "Cổng Mech tiếp theo sau",
    ["Auto Mech Boss"] = "Tự Động Đánh Boss Mech",
    ["Mech Tốc Độ Bay (Tween)"] = "Mech Tốc Độ Bay (Tween)",
    ["Main Weapon Hold"] = "Giữ Vũ Khí Chính",
    ["Scrambler Hold"] = "Giữ Máy Gây Nhiễu",
    ["Swap Two Weapons"] = "Đổi Hai Vũ Khí",
    ["Dodge Attacks"] = "Né Đòn Tấn Công",
    ["Anti Guard"] = "Chống Vệ Sĩ",
    ["Ball And Core Phase"] = "Giai Đoạn Bóng & Lõi",
    ["Leave After Fight"] = "Rời Đi Sau Khi Đánh",
    ["Auto Use Scrambled Mutation"] = "Tự Động Dùng Đột Biến Scrambled",
    ["Idle"] = "Đang Chờ",
    ["Turn it on to start applying Scrambled"] = "Bật lên để bắt đầu áp dụng Scrambled",
    ["Charges"] = "Lượt Sạc",
    ["Eggs"] = "Trứng",
    ["Tries"] = "Lần Thử",
    ["Applied"] = "Đã Áp Dụng",
    ["Mutation Độ Hiếm Tối Thiểu"] = "Độ Hiếm Đột Biến Tối Thiểu",
    ["Only eggs of this rarity and above are used"] = "Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Giá Trị"] = "Giá Trị Đột Biến Tối Thiểu",
    ["Bỏ qua trứng rẻ hơn mức này (0 = Tắt)"] = "Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Mutation Priority"] = "Ưu Tiên Đột Biến",
    ["Giá Trị Cao Nhất"] = "Giá Trị Cao Nhất",
    ["Which egg gets the consumable first"] = "Trứng nào nhận vật phẩm tiêu hao trước",
    ["Mutation Target Eggs"] = "Trứng Mục Tiêu Đột Biến",
    ["Only use the consumable on these eggs (empty = all)"] = "Chỉ dùng vật phẩm này lên những trứng này (Trống = Tất cả)",
    ["Auto Buy Scrambled"] = "Tự Động Mua Scrambled",
    ["Buy another Scrambled from the event shop when you run out"] = "Tự mua thêm Scrambled từ shop sự kiện khi hết",
    ["Any"] = "Bất Kỳ",
    ["All"] = "Tất Cả",
    ["Tắt"] = "Tắt",

    -- Lab & Scrambled
    ["Lab is locked on this account"] = "Lab đã bị khóa trên tài khoản này",
    ["Auto Lab Trade-In"] = "Tự Động Đổi Lab (Trade-In)",
    ["Auto Reroll Lab Recipe"] = "Tự Động Đổi Công Thức Lab",
    ["Place Lab Recipe Trứng"] = "Đặt Trứng Công Thức Lab",
    ["Hatch Lab Recipe Trứng"] = "Ấp Trứng Công Thức Lab",
    ["Tự Động Dùng Đột Biến Scrambled"] = "Tự Động Dùng Đột Biến Scrambled",

    -- Boss, Lab Banners & Scrambled Shop
    ["Boss Đổi Máy Chủ Ngay"] = "Boss Đổi Máy Chủ Ngay",
    ["After each boss, hops to a less crowded server to fight again"] = "Sau mỗi boss, chuyển sang server ít người hơn để đánh tiếp",
    ["Tự Động Nhận Thưởng Mastery"] = "Tự Động Nhận Thưởng Mastery",
    ["Claims Boss Mastery rewards as soon as they unlock"] = "Nhận thưởng Boss Mastery ngay khi mở khóa",
    ["Keep Chuyểnping For"] = "Giữ Chuyển Server Trong",
    ["Keeps fighting every boss it finds and hopping for this long"] = "Tiếp tục đánh mọi boss tìm thấy và chuyển server trong khoảng thời gian này",
    ["Lab Banners"] = "Biểu Ngữ Lab (Lab Banners)",
    ["Only trade and steal for these banners (empty = all)"] = "Chỉ đổi và cướp cho những biểu ngữ này (Trống = Tất cả)",
    ["Tự Động Đổi Lab (Trade-In)"] = "Tự Động Đổi Lab (Trade-In)",
    ["Auto Place Lab Reward Trứng"] = "Tự Động Đặt Trứng Thưởng Lab",
    ["Places the reward eggs from Lab trades"] = "Đặt trứng thưởng nhận được từ giao dịch Lab",
    ["Tự Động Mua Shop Scramble"] = "Tự Động Mua Shop Scramble",
    ["Dùng Mẫu Vật để mua các món đồ đã chọn"] = "Dùng Mẫu Vật để mua các món đồ đã chọn",
    ["Vật Phẩm Cửa Hàng Scramble"] = "Vật Phẩm Cửa Hàng Scramble",
    ["Scrambled Mutation"] = "Đột Biến Scrambled",
    ["Giữ Lại Mẫu Vật (Không mua hết)"] = "Giữ Lại Mẫu Vật (Không mua hết)",
    ["Never spend below this many Samples"] = "Không bao giờ tiêu xuống dưới số Mẫu Vật này",
    ["Need a Scrambled consumable"] = "Cần vật phẩm Scrambled",
    ["Buy Scrambled from the event shop"] = "Mua Scrambled từ shop sự kiện",
    ["Unstable DNA"] = "DNA Không Ổn Định (Unstable DNA)",
    ["needs Toro, Salamander, Crustacia"] = "cần Toro, Salamander, Crustacia",
    ["pity 0/100"] = "bảo hiểm 0/100",
    ["free rerolls 0"] = "lượt quay free 0",
    ["rotates in 38:45"] = "đổi sau 38:45",
    ["Không Chọn"] = "Không Chọn",

    -- Menu điều hướng
    ["Farm Tab > Auto Steal"] = "Tab Cày Cuốc > Tự Động Cướp",
    ["Farm Tab > Auto Place Egg"] = "Tab Cày Cuốc > Tự Đặt Trứng",
    ["Farm Tab > Auto Treadmill"] = "Tab Cày Cuốc > Tự Chạy Máy Tập",
    ["Farm Tab > Auto Hatch & Equip"] = "Tab Cày Cuốc > Tự Ấp & Thay Thú",
    ["Farm Tab > Auto Sell"] = "Tab Cày Cuốc > Tự Động Bán",
    ["Farm Tab > Auto Fuse Machine"] = "Tab Cày Cuốc > Tự Máy Ghép",
    ["Farm Tab > Auto Favorite"] = "Tab Cày Cuốc > Tự Khóa Thú",
    ["Farm Tab > Auto Rift & Boss"] = "Tab Cày Cuốc > Tự Động Rift & Boss",
    ["Player Tab > ESP"] = "Tab Người Chơi > Xuyên Tường (ESP)",
    ["Player Tab > Movement"] = "Tab Người Chơi > Di Chuyển",
    ["Player Tab > Character"] = "Tab Người Chơi > Nhân Vật",
    ["Egg Finder Tab > Egg Finder"] = "Tab Tìm Trứng > Máy Dò Trứng",
    ["Predictor Tab > Discord Webhook"] = "Tab Dự Đoán > Webhook Discord",
    ["Predictor Tab > Egg Predictor"] = "Tab Dự Đoán > Soi Trứng",
    ["Predictor Tab > Fuse Predictor"] = "Tab Dự Đoán > Soi Tỷ Lệ Ghép",
    ["Progress Tab > Auto Progression"] = "Tab Tiến Độ > Tự Động Thăng Tiến",
    ["Server Tab > Server"] = "Tab Máy Chủ > Máy Chủ",
    ["Misc Tab > Performance"] = "Tab Linh Tinh > Hiệu Năng",
    ["Misc Tab > Utility"] = "Tab Linh Tinh > Tiện Ích",
    ["Discord Tab > Creator Event"] = "Tab Discord > Sự Kiện Tác Giả",
    ["Discord Tab > Community"] = "Tab Discord > Cộng Đồng",
    ["Quick & Keys Tab > Quick Access"] = "Tab Phím Tắt > Truy Cập Nhanh",
    ["Quick & Keys Tab > Quick Bar & Keybinds"] = "Tab Phím Tắt > Thanh Nhanh & Gán Phím",
    ["Settings Tab > Interface"] = "Tab Cài Đặt > Giao Diện",
    ["Settings Tab > Defaults"] = "Tab Cài Đặt > Mặc Định",
    ["Config Tab > Config"] = "Tab Cấu Hình > Cấu Hình",
    ["Config Tab > Profiles"] = "Tab Cấu Hình > Hồ Sơ",
    ["Config Tab > Import/Export"] = "Tab Cấu Hình > Nhập/Xuất",

    -- Tính năng
    ["Auto Steal"] = "Tự Động Cướp",
    ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Rarity"] = "Độ Hiếm Tối Thiểu",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng từ độ hiếm đã chọn trở lên",
    ["Min Value To Steal"] = "Giá Trị Cướp Tối Thiểu",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng rẻ hơn mức này (0 = Tắt)",
    ["Target Specific Eggs"] = "Nhắm Trứng Cụ Thể",
    ["Only steal these eggs (empty = all)"] = "Chỉ cướp những trứng này (Trống = Tất cả)",
    ["Prioritize Rift Recipe Eggs"] = "Ưu Tiên Trứng Rift",
    ["Steal eggs the Rift recipe needs first"] = "Cướp trứng cần cho Rift trước",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Highest Value"] = "Giá Trị Cao Nhất",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Anti Guard V1"] = "Chống Vệ Sĩ V1",
    ["Not recommended to use with Auto Steal"] = "Không khuyên dùng cùng Tự Động Cướp",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Priority"] = "Ưu Tiên Đặt Trứng",
    ["Biggest Size"] = "Kích Thước Lớn Nhất",
    ["Always"] = "Luôn Luôn",
    ["Auto Treadmill"] = "Tự Chạy Máy Tập",
    ["Stay On Treadmill"] = "Giữ Trên Máy Tập",
    ["Re-mount the belt whenever the ride drops"] = "Tự trèo lên lại nếu bị rớt",
    ["Auto Hatch & Equip"] = "Tự Ấp & Thay Thú",
    ["Auto Hatch"] = "Tự Động Ấp",
    ["Auto Equip Best"] = "Tự Mặc Đồ Xịn Nhất",
    ["Equip Best when a better pet appears"] = "Tự đổi thú xịn hơn khi có",
    ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Thú",
    ["Sell Pets Now"] = "Bán Thú Ngay",
    ["Sell Pet Rule"] = "Quy Tắc Bán Thú",
    ["Which checks must pass to sell"] = "Điều kiện cần thỏa mãn để bán",
    ["Rarity Only"] = "Chỉ Xét Độ Hiếm",
    ["Pet Max Rarity"] = "Độ Hiếm Thú Tối Đa",
    ["Sell pets at or below this rarity"] = "Bán thú từ độ hiếm này trở xuống",
    ["Pet Value Threshold"] = "Ngưỡng Giá Trị Thú",
    ["Sell pets worth less than this (0 = off)"] = "Bán thú rẻ hơn mức này (0 = Tắt)",
    ["Keep Mutated Pets"] = "Giữ Thú Đột Biến",
    ["Never sell mutated pets"] = "Tuyệt đối không bán thú đột biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen (Không Bán)",
    ["These pets are never sold"] = "Những thú này sẽ không bao giờ bị bán",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi theo luật dưới đây",
    ["Sell Eggs Now"] = "Bán Trứng Ngay",
    ["Sell matching eggs once"] = "Bán trứng đúng điều kiện một lần",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Trứng Tối Đa",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Value Threshold"] = "Ngưỡng Giá Trị Trứng",
    ["Sell eggs worth less than this (0 = off)"] = "Bán trứng rẻ hơn mức này (0 = Tắt)",
    ["Keep Mutated Eggs"] = "Giữ Trứng Đột Biến",
    ["Never sell mutated eggs"] = "Tuyệt đối không bán trứng đột biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Trứng",
    ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Auto Fuse Machine"] = "Tự Động Máy Ghép",
    ["Fuse 3 same pets into an egg, nonstop"] = "Liên tục ghép 3 thú giống nhau",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Ghép",
    ["Lowest Rarity First"] = "Độ Hiếm Thấp Trộn Trước",
    ["Pets To Use"] = "Thú Cưng Sử Dụng",
    ["Lowest To Highest"] = "Từ Thấp Đến Cao",
    ["Max Rarity to Fuse"] = "Độ Hiếm Ghép Tối Đa",
    ["Specific Species to Fuse"] = "Chỉ Ghép Loài Thú Này",
    ["Only fuse these species (empty = all)"] = "Chỉ ghép những loài này (Trống = Tất cả)",
    ["Skip Mutated Pets"] = "Bỏ Qua Thú Đột Biến",
    ["Eject Incomplete Slots"] = "Đẩy Ra Ô Chưa Đủ",
    ["Take out pets that can't make a set"] = "Lấy ra thú không đủ bộ 3 con",
    ["Auto Favorite"] = "Tự Động Khóa Thú",
    ["Auto Favorite Pet"] = "Tự Động Khóa Thú",
    ["Favorite pets matching the rules below"] = "Khóa thú thỏa mãn luật bên dưới",
    ["Favorite Pets Now"] = "Khóa Thú Ngay",
    ["Favorite matching pets once"] = "Khóa thú đúng điều kiện 1 lần",
    ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Pass any check or all checks"] = "Thỏa 1 điều kiện hoặc tất cả",
    ["Match All"] = "Khớp Tất Cả",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min",
    ["Favorite pets of the chosen rarity and every rarity above it"] = "Khóa thú từ độ hiếm này trở lên",
    ["Favorite Mutations"] = "Khóa Thú Đột Biến",
    ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (Trống = Bỏ qua)",
    ["Favorite Min Value"] = "Giá Trị Khóa Min",
    ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = Bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Loài Này",
    ["Always favorite these species"] = "Luôn khóa những loài thú này",
    ["Auto Favorite Equipped"] = "Tự Khóa Thú Đang Dùng",
    ["Keep equipped pets favorited"] = "Giữ thú đang trang bị ở trạng thái khóa",
    ["Auto Unfavorite Equipped"] = "Tự Mở Khóa Thú Đang Dùng",
    ["Unfavorite equipped pets not in the rules"] = "Mở khóa nếu không đúng luật",
    ["Favorite Equipped Now"] = "Khóa Thú Đang Dùng Ngay",
    ["Favorite all equipped pets once"] = "Khóa tất cả thú đang dùng",
    ["Unfavorite Equipped Now"] = "Mở Khóa Thú Đang Dùng Ngay",
    ["Unfavorite all equipped pets once"] = "Mở khóa tất cả thú đang dùng",
    ["Auto Rift & Boss"] = "Tự Động Rift & Boss",
    ["Auto Rift Sacrifice"] = "Tự Động Hiến Tế Rift",
    ["Trade the 3 required pets into the Rift machine"] = "Tự nạp 3 thú yêu cầu vào máy Rift",
    ["Auto Reroll Rift Recipe"] = "Tự Động Đổi Công Thức Rift",
    ["Reroll the recipe when a pet is missing and free rerolls remain"] = "Đổi công thức nếu thiếu thú và còn lượt free",
    ["Auto Claim Boss Mastery"] = "Tự Nhận Thưởng Boss",
    ["Claim milestone rewards as soon as the kill count allows"] = "Nhận mốc thưởng ngay khi đủ điểm hạ gục",
    ["Auto Fight Boss"] = "Tự Động Đánh Boss",
    ["Auto Progression"] = "Tự Động Thăng Tiến",
    ["Auto Buy Trail"] = "Tự Động Mua Vệt Sáng",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Động Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi có tiền",
    ["Auto Upgrade Treadmill"] = "Tự Động Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi có tiền",
    ["Auto Claim"] = "Tự Động Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền offline & thưởng danh mục",
    ["ESP"] = "Xuyên Tường (ESP)",
    ["ESP Eggs"] = "Hiển Thị Trứng",
    ["ESP Fixed Size"] = "Cố Định Kích Cỡ ESP",
    ["ESP Own Base Eggs"] = "Hiển Thị Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiện cả trứng đã đặt trong căn cứ của bạn",
    ["ESP Min Rarity"] = "Độ Hiếm Tối Thiểu ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm này trở lên",
    ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["ESP Min Value"] = "Giá Trị ESP Tối Thiểu",
    ["ESP Egg Size"] = "Kích Cỡ Trứng ESP",
    ["ESP Guards"] = "Hiển Thị Vệ Sĩ",
    ["ESP Guard Size"] = "Kích Cỡ Vệ Sĩ ESP",
    ["ESP Players"] = "Hiển Thị Người Chơi",
    ["ESP Player Info"] = "Thông Tin Người Chơi ESP",
    ["ESP Player Size"] = "Kích Cỡ Người Chơi ESP",
    ["Movement"] = "Di Chuyển",
    ["Speed Boost"] = "Tăng Tốc Di Chuyển",
    ["Boost Speed"] = "Tốc Độ Tăng Cường",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Character"] = "Nhân Vật",
    ["Anti Ragdoll"] = "Chống Ngã (Ragdoll)",
    ["Anti Trap"] = "Chống Bẫy",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không bắt được bạn",
    ["Instant Steal"] = "Cướp Tức Thì",
    ["IDLE"] = "ĐANG CHỜ LỆNH",
    ["Turn on Egg Finder to start hunting"] = "Bật Máy Dò Trứng để bắt đầu săn",
    ["Keep hopping servers until a matching egg is found"] = "Đổi server liên tục tới khi thấy trứng đúng luật",
    ["Link To Auto Steal Filters"] = "Dùng Chung Bộ Lọc Tự Động Cướp",
    ["Share one set of filters with Auto Steal, both sides stay in step"] = "Đồng bộ hóa bộ lọc với tab Tự Động Cướp",
    ["Min Value To Find"] = "Giá Trị Trứng Tối Thiểu",
    ["Hop Only When Rarity Appears"] = "Chỉ Đổi Server Khi Thấy Độ Hiếm Này",
    ["Wait for the chosen rarity to appear, then hop until night"] = "Chờ độ hiếm xuất hiện, sau đó đổi server liên tục",
    ["Rarity That Must Appear"] = "Độ Hiếm Bắt Buộc Xuất Hiện",
    ["Hop starts when this rarity or higher appears"] = "Đổi server khi độ hiếm này xuất hiện",
    ["Hop Delay"] = "Độ Trễ Đổi Server",
    ["Egg Predictor"] = "Soi Trứng (Predictor)",
    ["Sort By"] = "Sắp Xếp Theo",
    ["Value"] = "Giá Trị",
    ["Preview Card"] = "Xem Thẻ Trước",
    ["Search eggs..."] = "Tìm kiếm trứng...",
    ["Tap an egg below to preview it"] = "Chạm vào trứng bên dưới để xem chi tiết",
    ["In inventory"] = "Trong túi",
    ["Hold egg"] = "Đang giữ",
    ["Fuse Predictor"] = "Soi Tỷ Lệ Ghép (Fuse)",
    ["Machine is empty"] = "Máy đang trống",
    ["Load 3 pets of the same species to see the result odds"] = "Cho 3 thú cùng loài vào để xem tỷ lệ kết quả",
    ["Search"] = "Tìm Kiếm",
    ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Least Players"] = "Ít Người Chơi Nhất",
    ["Server Hop"] = "Đổi Server Ngay",
    ["Job ID"] = "ID Máy Chủ (Job ID)",
    ["Paste a server Job ID..."] = "Dán ID máy chủ vào đây...",
    ["Join Job ID"] = "Vào Bằng ID",
    ["Copy Current Job ID"] = "Chép ID Máy Chủ Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Máy Chủ Này",
    ["Join"] = "Vào",
    ["Copy"] = "Chép",
    ["Rejoin"] = "Vào Lại",
    ["Hop"] = "Chuyển",
    ["Performance"] = "Hiệu Năng",
    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa Tối Đa",
    ["Strip shadows, textures and effects for the highest FPS"] = "Tắt bóng, kết cấu và hiệu ứng để đạt FPS cao nhất",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["FPS and Ping Size"] = "Cỡ Chữ FPS & Ping",
    ["Utility"] = "Tiện Ích",
    ["Anti AFK"] = "Chống Treo Máy (AFK)",
    ["Creator Event"] = "Sự Kiện Của Tác Giả",
    ["INVITE LINK"] = "LIÊN KẾT MỜI",
    ["Copy Link"] = "Sao Chép Link",
    ["WHAT YOU GET"] = "BẠN NHẬN ĐƯỢC GÌ",
    ["New Scripts & Updates"] = "Script & Cập Nhật Mới",
    ["Patch notes and new game scripts are posted there first."] = "Chi tiết cập nhật và script game mới được đăng ở đây đầu tiên.",
    ["Giveaways"] = "Tặng Quà (Giveaways)",
    ["Member giveaways and events are announced in the server."] = "Sự kiện và phát quà cho thành viên được thông báo trong server.",
    ["Support"] = "Hỗ Trợ",
    ["Ask for help, report bugs and get answers from the team."] = "Hỏi đáp, báo lỗi và nhận hỗ trợ từ nhóm phát triển.",
    ["Suggestions"] = "Đóng Góp Ý Kiến",
    ["Request features and vote on what gets added next."] = "Yêu cầu tính năng và bình chọn cập nhật tiếp theo.",
    ["Paste the copied link into your browser or the Discord app to join."] = "Dán link vừa chép vào trình duyệt hoặc app Discord để tham gia.",
    ["Copy Discord Link"] = "Chép Link Discord",
    ["Click"] = "Bấm",
    ["Quick Access"] = "Truy Cập Nhanh",
    ["Show Quick Bars"] = "Hiện Thanh Phím Tắt",
    ["Floating quick bars; drag a header to move one"] = "Thanh phím tắt nổi; kéo tiêu đề để di chuyển",
    ["Visible Quick Bars"] = "Các Thanh Đang Hiện",
    ["Quick Bar Size"] = "Kích Cỡ Thanh Phím Tắt",
    ["Quick Bar & Keybinds"] = "Thanh Phím Tắt & Gán Nút",
    ["Reset Quick Access"] = "Đặt Lại Truy Cập Nhanh",
    ["Restore default items, bars and positions"] = "Khôi phục lại vị trí thanh mặc định",
    ["Reset Keybinds"] = "Đặt Lại Nút Gán",
    ["Restore the defaults set in code"] = "Khôi phục lại nút gán mặc định",
    ["Reset"] = "Đặt Lại",
    ["Interface"] = "Giao Diện",
    ["UI Size"] = "Kích Cỡ Giao Diện",
    ["Scales the main window; the corner grip does the same by hand"] = "Đổi cỡ cửa sổ; kéo góc dưới cùng bên phải để đổi thủ công",
    ["Notifications"] = "Bật Thông Báo",
    ["Show notification cards; turning this off hides every notify"] = "Hiện thẻ thông báo; tắt mục này sẽ ẩn toàn bộ",
    ["Open On Launch"] = "Mở Khi Khởi Chạy",
    ["Open the UI automatically when the script starts"] = "Tự động hiện bảng menu khi script bắt đầu",
    ["Defaults"] = "Mặc Định",
    ["Reset to Defaults"] = "Đặt Lại Về Mặc Định",
    ["Reset every feature to its built-in default"] = "Khôi phục mọi tính năng về mặc định gốc",
    ["Turn Off All Toggles"] = "Tắt Tất Cả Công Tắc",
    ["Switch off every enabled toggle in the feature tabs"] = "Tắt mọi công tắc đang bật trong các tab",
    ["Turn Off"] = "Tắt Ngay",
    ["Auto Save Config"] = "Tự Động Lưu Cấu Hình",
    ["Auto Load Config"] = "Tự Động Nạp Cấu Hình",
    ["New Config Name"] = "Tên Cấu Hình Mới",
    ["Create New Config"] = "Tạo Cấu Hình Mới",
    ["Save Config"] = "Lưu Cấu Hình Hiện Tại",
    ["Import Config Text"] = "Nhập Mã Văn Bản Cấu Hình",
    ["Destination"] = "Nơi Nhận Thông Báo",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Notify Egg Finder Match"] = "Báo Khi Máy Dò Khớp Trứng",
    ["Post the egg Egg Finder stops hopping for"] = "Gửi cảnh báo quả trứng mà Máy Dò vừa tìm được",
    ["Notify Stolen Eggs"] = "Báo Khi Cướp Được Trứng",
    ["Post every egg you bring home"] = "Gửi thông báo mỗi khi bạn cướp thành công mang về nhà",
    ["None"] = "Không Chọn",
    ["Off"] = "Tắt",
    ["Filter features..."] = "Lọc tính năng...",
    ["Favorite"] = "Khóa Lại",
    ["Unfavorite"] = "Mở Khóa",
    ["Sell"] = "Bán",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Window Minimized - Click bubble to restore"] = "Cửa sổ đã thu nhỏ - Bấm bong bóng để mở lại",
    ["Let's Chat!"] = "Trò Chuyện Nào!",
    ["Connecting to Global Script Chat..."] = "Đang kết nối chat thế giới...",
    ["Send"] = "Gửi",
    ["Live"] = "Trực Tiếp",
    ["Spoof anti cheat success!"] = "Đã vượt qua Anti-Cheat thành công!",
    ["Fetching..."] = "Đang Tải Dữ Liệu...",
    ["Loaded"] = "Đã Nạp Xong"
}

-- =========================================================
-- REGEX XỬ LÝ CHUỖI ĐỘNG (Chuyển từ V10.4)
-- =========================================================
local DYNAMIC_PATTERNS = {
    { 
        pattern = "^Next Mech portal in (.-)$", 
        format = function(lang, timeStr) 
            if lang == "VI" then return "Cổng Mech tiếp theo sau " .. timeStr end 
            return "Next Mech portal in " .. timeStr 
        end 
    },
    { 
        pattern = "^Unstable DNA %- needs (.-) %- pity (%d+)%/(%d+) %- free rerolls (%d+) %- rotates in (.-)$", 
        format = function(lang, needs, pity1, pity2, reroll, timeStr) 
            if lang == "VI" then 
                return "DNA Không Ổn Định - cần " .. needs .. " - bảo hiểm " .. pity1 .. "/" .. pity2 .. " - lượt quay free " .. reroll .. " - đổi sau " .. timeStr 
            end 
            return "Unstable DNA - needs " .. needs .. " - pity " .. pity1 .. "/" .. pity2 .. " - free rerolls " .. reroll .. " - rotates in " .. timeStr 
        end 
    },
    { 
        pattern = "^Samples (%d+) %- Lost (%d+)/(%d+) Drone (.-) %- Outbreak in (.-)$", 
        format = function(lang, s, l1, l2, d, t) 
            if lang == "VI" then return "Mẫu vật " .. s .. " - Đã rơi " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Bùng phát sau " .. t end 
            return "Samples " .. s .. " - Lost " .. l1 .. "/" .. l2 .. " - Drone " .. d .. " - Outbreak in " .. t 
        end 
    },
    { 
        pattern = "^Lost Parts on map (%d+)/(%d+) %- Collected (%d+)/(%d+)$", 
        format = function(lang, m1, m2, c1, c2) 
            if lang == "VI" then return "Phụ Tùng Rơi trên map " .. m1 .. "/" .. m2 .. " - Đã nhặt " .. c1 .. "/" .. c2 end 
            return "Lost Parts on map " .. m1 .. "/" .. m2 .. " - Collected " .. c1 .. "/" .. c2 
        end 
    },
    { 
        pattern = "^(%d+) selected$", 
        format = function(lang, count) 
            if lang == "VI" then return "Đã chọn " .. count end 
            return count .. " selected" 
        end 
    },
    { 
        pattern = "^IN INVENTORY %((%d+)%)$", 
        format = function(lang, count) 
            if lang == "VI" then return "TRONG TÚI ĐỒ (" .. count .. ")" end 
            return "IN INVENTORY (" .. count .. ")" 
        end 
    },
    { 
        pattern = "^Eggs placed (%d+)%/(%d+) %- (%d+)%/(%d+) pets equipped, (%d+) in bag$", 
        format = function(lang, e1, e2, p1, p2, b1) 
            if lang == "VI" then return "Đã đặt " .. e1 .. "/" .. e2 .. " trứng - " .. p1 .. "/" .. p2 .. " thú trang bị, " .. b1 .. " trong túi" end 
            return "Eggs placed " .. e1 .. "/" .. e2 .. " - " .. p1 .. "/" .. p2 .. " pets equipped, " .. b1 .. " in bag" 
        end 
    },
    { 
        pattern = "^Pet matches %- (%d+) pets for %$(.-)$", 
        format = function(lang, count, val) 
            if lang == "VI" then return "Thú khớp lệnh - " .. count .. " thú, tổng giá $" .. val end 
            return "Pet matches - " .. count .. " pets for $" .. val 
        end 
    },
    { 
        pattern = "^Egg matches %- (%d+) eggs for %$(.-)$", 
        format = function(lang, count, val) 
            if lang == "VI" then return "Trứng khớp lệnh - " .. count .. " trứng, tổng giá $" .. val end 
            return "Egg matches - " .. count .. " eggs for $" .. val 
        end 
    },
    { 
        pattern = "^Next fuse %- (%d+) (.-) for %$(.-)$", 
        format = function(lang, count, name, val) 
            if lang == "VI" then return "Ghép tiếp theo - " .. count .. " " .. name .. " tốn $" .. val end 
            return "Next fuse - " .. count .. " " .. name .. " for $" .. val 
        end 
    },
    { 
        pattern = "^Favorite matches %- (%d+) pets, (%d+) to mark %| (%d+) favorited$", 
        format = function(lang, mCount, mark, fav) 
            if lang == "VI" then return "Khớp khóa thú - " .. mCount .. " con, " .. mark .. " cần khóa | " .. fav .. " đã khóa" end 
            return "Favorite matches - " .. mCount .. " pets, " .. mark .. " to mark | " .. fav .. " favorited" 
        end 
    },
    { 
        pattern = "^Riftborn %- needs (.-) %- pity (%d+)%/(%d+) %- free rerolls (%d+) %- rotates in (.-) %- boss portal (.-)$", 
        format = function(lang, needs, pity1, pity2, reroll, timeStr, status) 
            if lang == "VI" then return "Riftborn - Cần: " .. needs .. " - Bảo hiểm: " .. pity1 .. "/" .. pity2 .. " - Quay free: " .. reroll .. " - Đổi sau " .. timeStr .. " - Cổng Boss: " .. (status == "closed" and "Đóng" or "Mở") end 
            return "Riftborn - needs " .. needs .. " - pity " .. pity1 .. "/" .. pity2 .. " - free rerolls " .. reroll .. " - rotates in " .. timeStr .. " - boss portal " .. status 
        end 
    },
    { 
        pattern = "^(%d+) eggs %- (%d+) ready %- (%d+) growing %- (%d+) in bag %- Total (.-)$", 
        format = function(lang, e1, r1, g1, b1, t1) 
            if lang == "VI" then return e1 .. " trứng - " .. r1 .. " xong - " .. g1 .. " đang lớn - " .. b1 .. " trong túi - Tổng " .. t1 end 
            return e1 .. " eggs - " .. r1 .. " ready - " .. g1 .. " growing - " .. b1 .. " in bag - Total " .. t1 
        end 
    },
    { 
        pattern = "^Players (%d+)%/(%d+)$", 
        format = function(lang, p1, p2) 
            if lang == "VI" then return "Người chơi: " .. p1 .. "/" .. p2 end 
            return "Players " .. p1 .. "/" .. p2 
        end 
    }
}

-- =========================================================
-- HÀM DỊCH (từ V10.4, chuyển sang dùng cho script mới)
-- =========================================================
local sortedKeys = {}
for k in pairs(MAP_VI) do
    table.insert(sortedKeys, k)
end
table.sort(sortedKeys, function(a,b) return #a > #b end)

local escapePattern = function(s)
    return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

local function safeReplace(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    if startIdx then
        return str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
    end
    return str
end

local translateText = function(text)
    if type(text) ~= "string" or text == "" then return text end
    
    -- Check exact match
    if MAP_VI[text] then return MAP_VI[text] end
    
    -- Check dynamic patterns
    for _, item in ipairs(DYNAMIC_PATTERNS) do
        local matches = {text:match(item.pattern)}
        if #matches > 0 then
            return item.format("VI", unpack(matches))
        end
    end
    
    -- Fallback: replace known phrases (longest first)
    local out = text
    for _, en in ipairs(sortedKeys) do
        local vi = MAP_VI[en]
        local pat = "%f[%w]" .. escapePattern(en) .. "%f[%W]"
        out = out:gsub(pat, vi)
    end
    return out
end

-- =========================================================
-- HOOK GUI (giữ nguyên logic script mới)
-- =========================================================
local translating = false

local function hookObject(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
    
    local function apply()
        if translating then return end
        translating = true
        
        local ok, cur = pcall(function() return obj.Text end)
        if ok and type(cur) == "string" then
            local new = translateText(cur)
            if new ~= cur then
                pcall(function() obj.Text = new end)
            end
        end
        
        -- PlaceholderText cho TextBox
        if obj:IsA("TextBox") then
            local ok2, ph = pcall(function() return obj.PlaceholderText end)
            if ok2 and type(ph) == "string" and ph ~= "" then
                local new = translateText(ph)
                if new ~= ph then
                    pcall(function() obj.PlaceholderText = new end)
                end
            end
        end
        
        translating = false
    end
    
    apply()
    obj:GetPropertyChangedSignal("Text"):Connect(apply)
    if obj:IsA("TextBox") then
        obj:GetPropertyChangedSignal("PlaceholderText"):Connect(apply)
    end
end

local function watchGui(gui)
    if not gui:IsA("ScreenGui") and not gui:IsA("GuiObject") then return end
    for _, d in ipairs(gui:GetDescendants()) do
        hookObject(d)
    end
    gui.DescendantAdded:Connect(function(d)
        task.defer(hookObject, d)
    end)
end

-- =========================================================
-- HOOK MỌI CONTAINER (CoreGui / PlayerGui / gethui nếu có)
-- =========================================================
local containers = { CoreGui, Players.LocalPlayer:WaitForChild("PlayerGui") }
if gethui then
    local ok, h = pcall(gethui)
    if ok and h then table.insert(containers, h) end
end

for _, cont in ipairs(containers) do
    if cont then
        for _, d in ipairs(cont:GetDescendants()) do
            if d:IsA("ScreenGui") or d:IsA("GuiObject") then
                watchGui(d)
            end
        end
        cont.DescendantAdded:Connect(function(d)
            if d:IsA("ScreenGui") then
                task.defer(watchGui, d)
            elseif d:IsA("GuiObject") then
                task.defer(hookObject, d)
            end
        end)
    end
end

-- =========================================================
-- HÀM TẢI SCRIPT (giữ nguyên logic script mới)
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
-- UI CHỌN NGÔN NGỮ (giữ nguyên logic script mới)
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

-- Kéo thả
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
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
-- CHẠY (giữ nguyên logic script mới)
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
            status.Text = (lang == "vi") and "❌ Không tải được script!" or "❌ Failed to fetch script!"
            loading = false
            return
        end
        
        status.Text = (lang == "vi") and "▶️ Đang chạy + dịch..." or "▶️ Running..."
        task.wait(0.3)
        gui:Destroy()
        
        local loader = loadstring or load
        local fn, err = loader(src)
        if not fn then
            warn("[LangSel] loadstring error: " .. tostring(err))
            return
        end
        
        -- Nếu chọn English => tạm tắt hook dịch
        if lang == "en" then
            translating = true -- khóa vĩnh viễn apply()
        end
        
        local ok, err2 = pcall(fn)
        if not ok then
            warn("[LangSel] runtime error: " .. tostring(err2))
        end
    end)
end

btnVI.MouseButton1Click:Connect(function() run("vi") end)
btnEN.MouseButton1Click:Connect(function() run("en") end)
