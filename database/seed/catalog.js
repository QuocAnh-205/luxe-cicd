// Dữ liệu danh mục + sản phẩm LUXE. Mô tả được viết theo đúng ảnh trong
// frontend/public/images/products/<slug>-<n>.webp (mỗi sản phẩm 2–4 góc chụp).
// Sửa file này rồi chạy: node database/seed/generate.js  => sinh lại database/init/02-seed.sql

const categories = [
  { slug: 'dam-vay', name: 'Đầm & Váy', description: 'Đầm dạ hội, đầm xoè, đầm midi và maxi cho mọi dịp' },
  { slug: 'ao-so-mi', name: 'Áo sơ mi', description: 'Sơ mi caro, flannel và Hawaii cho phái mạnh' },
  { slug: 'tui-xach', name: 'Túi xách', description: 'Túi tote, hobo, satchel và balo da' },
  { slug: 'giay-cao-got', name: 'Giày cao gót', description: 'Pump mũi nhọn, stiletto và sandal cao gót' },
  { slug: 'sneaker', name: 'Sneaker', description: 'Sneaker cổ cao, cổ thấp và giày thể thao' },
  { slug: 'dong-ho', name: 'Đồng hồ', description: 'Đồng hồ cơ, chronograph và moonphase' },
  { slug: 'kinh-mat', name: 'Kính mắt', description: 'Kính râm aviator, clubmaster và gọng thời trang' },
  { slug: 'trang-suc', name: 'Trang sức', description: 'Bông tai pha lê và acrylic thủ công' },
];

const CLOTHING = 'S,M,L,XL';
const DRESS = 'XS,S,M,L';
const MEN_SHOES = '39,40,41,42,43,44';
const WOMEN_SHOES = '35,36,37,38,39';

// src = id ảnh gốc (DummyJSON) đã tải về; images = số ảnh của sản phẩm
const products = [
  // ---------------- Đầm & Váy ----------------
  {
    src: 177, images: 4, category: 'dam-vay', slug: 'dam-da-hoi-tre-vai-hoa', name: 'Đầm dạ hội trễ vai họa tiết hoa',
    price: 1890000, original_price: 2290000, sizes: DRESS, color: 'Đen hoa', material: 'Lụa satin in kỹ thuật số',
    gender: 'nu', featured: true, stock: 18, sold: 64,
    description: 'Đầm dạ hội dáng dài chấm gót với phần cúp ngực và dải vai đen trễ vai thanh lịch. Nền đen sâu in hoạ tiết hoa hồng, tím mộng mơ và lá xanh ngọc rực rỡ, chân váy suông rủ mềm tạo dáng cao ráo khi di chuyển.',
    highlights: ['Cổ trễ vai với dải viền đen ôm khít', 'Hoạ tiết hoa nhiều màu trên nền đen', 'Dáng dài chấm gót, chân váy rủ mềm', 'Khoá kéo ẩn sau lưng'],
  },
  {
    src: 178, images: 4, category: 'dam-vay', slug: 'dam-corset-da-do', name: 'Đầm corset da đỏ chân váy dài',
    price: 2150000, sizes: DRESS, color: 'Đỏ', material: 'Da PU bóng mờ',
    gender: 'nu', featured: true, isNew: true, stock: 12, sold: 31,
    description: 'Đầm cúp ngực với phần thân trên kiểu corset bằng da đỏ tươi ôm sát, chia mảnh định hình eo. Chân váy dài cùng tông đỏ rủ thành những nếp gấp tự nhiên, nổi bật cho tiệc tối và sự kiện.',
    highlights: ['Thân trên corset chia mảnh tôn eo', 'Cúp ngực không dây', 'Chân váy dài xếp nếp tự nhiên', 'Tông đỏ đồng bộ toàn thân'],
  },
  {
    src: 179, images: 4, category: 'dam-vay', slug: 'dam-corset-da-den', name: 'Đầm corset da đen dáng dài',
    price: 2150000, sizes: DRESS, color: 'Đen', material: 'Da PU bóng mờ',
    gender: 'nu', stock: 15, sold: 42,
    description: 'Phiên bản đen huyền bí của dòng đầm corset: thân trên cúp ngực bằng da đen ôm dáng, chân váy dài chấm đất rủ nếp mềm. Tối giản, quyền lực và dễ phối cùng trang sức kim loại.',
    highlights: ['Corset cúp ngực ôm dáng', 'Chân váy dài chấm đất', 'Màu đen dễ phối phụ kiện', 'Khoá kéo ẩn phía sau'],
  },
  {
    src: 180, images: 4, category: 'dam-vay', slug: 'dam-xoe-cham-bi-no', name: 'Đầm xoè chấm bi đính nơ retro',
    price: 990000, original_price: 1190000, sizes: DRESS, color: 'Trắng chấm bi đỏ', material: 'Cotton pha, lót tafta',
    gender: 'nu', stock: 26, sold: 88,
    description: 'Đầm cúp ngực nền trắng in chấm bi đỏ nhỏ, viền mép đỏ tinh tế. Nơ bản to cùng chất liệu đính bên eo, chân váy xoè bồng nhiều lớp mang đúng tinh thần retro thập niên 50.',
    highlights: ['Nơ lớn đính eo', 'Chân váy xoè bồng có lót', 'Viền đỏ ở cổ và gấu váy', 'Phong cách vintage thập niên 50'],
  },
  {
    src: 181, images: 4, category: 'dam-vay', slug: 'dam-suong-phoi-mau-color-block', name: 'Đầm suông dài phối màu color-block',
    price: 1250000, sizes: CLOTHING, color: 'Đỏ đô / Đen / Hồng / Trắng', material: 'Crepe co giãn nhẹ',
    gender: 'nu', isNew: true, stock: 20, sold: 17,
    description: 'Đầm suông dáng dài cổ tròn viền cam đào, phối khối màu táo bạo: mặt trước đỏ đô (burgundy), mặt sau đen, một tay hồng fuchsia và một tay trắng kem. Thiết kế mang hơi hướng runway, hợp phong cách cá tính.',
    highlights: ['Phối 4 khối màu bất đối xứng', 'Tay dài hai màu khác nhau', 'Cổ tròn viền cam đào', 'Dáng suông dài qua gối'],
  },
  {
    src: 162, images: 4, category: 'dam-vay', slug: 'dam-xoe-tay-canh-tien-cham-tron', name: 'Đầm xoè tay cánh tiên chấm tròn xanh',
    price: 690000, sizes: DRESS, color: 'Xanh baby', material: 'Cotton lụa',
    gender: 'nu', stock: 35, sold: 120,
    description: 'Đầm xoè ngang gối nền xanh baby in chấm tròn nhiều kích cỡ màu xanh dương và tím lavender. Tay cánh tiên ngắn bồng nhẹ, eo chiết và chân váy xoè rộng cho vẻ ngoài trẻ trung, nữ tính.',
    highlights: ['Tay cánh tiên bồng nhẹ', 'Hoạ tiết chấm tròn xanh – tím', 'Chân váy xoè ngang gối', 'Cổ tròn dễ mặc'],
  },
  {
    src: 163, images: 4, category: 'dam-vay', slug: 'dam-maxi-hai-day-la-co', name: 'Đầm maxi hai dây trễ vai lá cọ',
    price: 790000, sizes: DRESS, color: 'Trắng / Đen', material: 'Voan lụa',
    gender: 'nu', featured: true, stock: 28, sold: 95,
    description: 'Đầm maxi dáng dài suông với dây mảnh và lớp bèo trễ vai nhún nhẹ. Nền trắng in hoạ tiết lá cọ đen đồ hoạ, rất hợp đi biển, du lịch hay dạo phố ngày hè.',
    highlights: ['Hai dây mảnh kết hợp bèo trễ vai', 'Hoạ tiết lá cọ đen trắng', 'Dáng maxi suông thoải mái', 'Chất voan nhẹ, thoáng mát'],
  },
  {
    src: 164, images: 4, category: 'dam-vay', slug: 'dam-midi-sat-nach-be-dinh-cuc', name: 'Đầm midi sát nách màu be đính cúc',
    price: 850000, sizes: CLOTHING, color: 'Be xám', material: 'Linen pha cotton',
    gender: 'nu', stock: 30, sold: 73,
    description: 'Đầm midi sát nách tông be xám trung tính, cổ tròn với hàng cúc nhỏ chạy dọc thân trước. Đai vải rút eo tạo dáng, lưng khoét chữ U nhẹ – lựa chọn thanh lịch cho công sở lẫn cuối tuần.',
    highlights: ['Hàng cúc nhỏ dọc thân trước', 'Đai vải thắt eo', 'Lưng khoét chữ U', 'Chất linen thoáng, đứng form'],
  },
  {
    src: 165, images: 4, category: 'dam-vay', slug: 'dam-cup-nguc-xanh-mint-tang', name: 'Đầm cúp ngực xanh mint tầng bèo',
    price: 920000, original_price: 1090000, sizes: DRESS, color: 'Xanh mint xám', material: 'Cotton twill',
    gender: 'nu', isNew: true, stock: 22, sold: 39,
    description: 'Đầm cúp ngực màu xanh mint pha xám dịu mắt, nơ to thắt ngang eo. Chân váy hai tầng xoè trên gối tạo độ bồng nhẹ nhàng, phù hợp tiệc ngoài trời và dạo phố.',
    highlights: ['Cúp ngực ôm vừa', 'Nơ vải thắt eo', 'Chân váy hai tầng xoè', 'Độ dài trên gối'],
  },
  {
    src: 166, images: 4, category: 'dam-vay', slug: 'dam-caro-tartan-no-satin', name: 'Đầm caro tartan thắt nơ satin đen',
    price: 760000, sizes: DRESS, color: 'Caro đen – trắng – xám', material: 'Cotton dệt caro, đai satin',
    gender: 'nu', stock: 32, sold: 58,
    description: 'Đầm sát nách hoạ tiết caro tartan đen – trắng – xám, phần eo nhấn đai satin đen thắt nơ bản lớn phía sau lưng. Chân váy xoè, cổ tròn – phong cách preppy cổ điển.',
    highlights: ['Caro tartan đơn sắc', 'Đai satin đen thắt nơ lớn', 'Chân váy xoè ngang gối', 'Sát nách, cổ tròn'],
  },

  // ---------------- Áo sơ mi ----------------
  {
    src: 83, images: 4, category: 'ao-so-mi', slug: 'so-mi-caro-gingham-xanh-duong', name: 'Sơ mi caro gingham xanh dương',
    price: 459000, original_price: 540000, sizes: CLOTHING, color: 'Xanh dương / Trắng', material: 'Cotton poplin',
    gender: 'nam', featured: true, stock: 60, sold: 210,
    description: 'Sơ mi nam tay dài kẻ caro gingham phối xanh dương, xanh navy và trắng. Cổ bẻ, nẹp nút giữa, túi ngực trái và măng-sét cài nút – vừa vặn cho đi làm lẫn đi chơi.',
    highlights: ['Caro gingham xanh – trắng', 'Túi ngực trái', 'Măng-sét cài nút', 'Form regular dễ mặc'],
  },
  {
    src: 85, images: 4, category: 'ao-so-mi', slug: 'so-mi-flannel-caro-do-den', name: 'Sơ mi flannel caro đỏ đen',
    price: 529000, sizes: CLOTHING, color: 'Đỏ / Đen', material: 'Flannel cotton chải',
    gender: 'nam', stock: 45, sold: 165,
    description: 'Sơ mi flannel kẻ caro buffalo đỏ – đen to bản đặc trưng phong cách lumberjack. Vải cotton chải dày ấm, cổ bẻ với hàng nút trắng tương phản, có thể mặc như áo khoác nhẹ.',
    highlights: ['Caro buffalo đỏ đen', 'Vải flannel dày, mềm ấm', 'Nút trắng tương phản', 'Mặc riêng hoặc khoác ngoài'],
  },
  {
    src: 86, images: 4, category: 'ao-so-mi', slug: 'so-mi-hawaii-hoa-dam-but', name: 'Sơ mi Hawaii hoạ tiết hoa dâm bụt',
    price: 399000, sizes: CLOTHING, color: 'Xanh cobalt', material: 'Rayon mát',
    gender: 'nam', isNew: true, stock: 50, sold: 98,
    description: 'Sơ mi tay ngắn nền xanh cobalt in hoa dâm bụt trắng xen lá nhiệt đới xanh nhạt. Cổ bẻ thoáng, chất rayon rủ mát – chiếc áo không thể thiếu cho những chuyến đi biển.',
    highlights: ['Hoạ tiết hoa dâm bụt nhiệt đới', 'Tay ngắn, cổ bẻ', 'Rayon mềm, thoáng mát', 'Phong cách resort'],
  },
  {
    src: 87, images: 4, category: 'ao-so-mi', slug: 'so-mi-caro-tartan-xanh-reu', name: 'Sơ mi caro tartan xanh rêu',
    price: 489000, sizes: CLOTHING, color: 'Xanh rêu / Xanh ngọc', material: 'Cotton oxford',
    gender: 'nam', stock: 40, sold: 76,
    description: 'Sơ mi tay dài kẻ caro tartan phối xanh rêu, xám và xanh ngọc nhạt trên nền trắng. Cổ button-down đính nút, măng-sét bo gọn – dễ phối cùng quần chino hoặc jeans.',
    highlights: ['Caro tartan tông xanh lạnh', 'Cổ button-down', 'Cotton oxford bền màu', 'Tay dài, măng-sét cài nút'],
  },

  // ---------------- Túi xách ----------------
  {
    src: 174, images: 3, category: 'tui-xach', slug: 'tui-xach-saffiano-xanh-ngoc', name: 'Túi xách tay da saffiano xanh ngọc',
    price: 2490000, original_price: 2890000, sizes: null, color: 'Xanh ngọc pastel', material: 'Da bò vân saffiano',
    gender: 'nu', featured: true, stock: 10, sold: 47,
    description: 'Túi xách tay dáng thang đứng form màu xanh ngọc pastel, bề mặt da vân saffiano chống xước. Hai quai xách tròn, thẻ tag da treo bên hông và logo tam giác kim loại phía trước.',
    highlights: ['Da vân saffiano chống xước', 'Hai quai xách và thẻ tag treo', 'Dáng thang đứng form', 'Ngăn chính rộng, khoá kéo'],
  },
  {
    src: 173, images: 3, category: 'tui-xach', slug: 'tui-hobo-da-nau-cognac', name: 'Túi hobo da nâu cognac',
    price: 1690000, sizes: null, color: 'Nâu cognac', material: 'Da bò nappa',
    gender: 'nu', stock: 16, sold: 63,
    description: 'Túi hobo dáng mềm màu nâu cognac ấm áp, hai quai cong ôm vai. Mặt trước có ngăn khoá kéo, hai bên hông nhấn phụ kiện kim loại vàng – sang trọng mà vẫn thoải mái hằng ngày.',
    highlights: ['Dáng hobo mềm mại', 'Ngăn khoá kéo mặt trước', 'Phụ kiện kim loại vàng', 'Da nappa mềm tay'],
  },
  {
    src: 176, images: 3, category: 'tui-xach', slug: 'tui-satchel-da-den-dai-khoa', name: 'Túi satchel da đen đai khoá vàng',
    price: 1590000, sizes: null, color: 'Đen', material: 'Da bò trơn',
    gender: 'nu', isNew: true, stock: 18, sold: 52,
    description: 'Túi satchel đen dáng hộp với hai quai xách, mặt trước nhấn đai da ngang cùng khoá kim loại vàng. Hai bên hông gấp xếp kiểu accordion giúp túi mở rộng, đựng vừa laptop 13 inch.',
    highlights: ['Đai da khoá vàng mặt trước', 'Hông gấp xếp mở rộng', 'Dáng hộp đứng form', 'Vừa laptop 13 inch'],
  },
  {
    src: 172, images: 3, category: 'tui-xach', slug: 'tui-tote-da-xanh-navy', name: 'Túi tote da xanh navy',
    price: 1450000, sizes: null, color: 'Xanh navy', material: 'Da bò trơn',
    gender: 'nu', stock: 20, sold: 44,
    description: 'Túi tote dáng chữ nhật đứng form màu xanh navy đậm, hai quai xách tròn chắc chắn. Thân túi chia mảnh với đường chỉ nổi dọc thân, tối giản và thanh lịch cho dân công sở.',
    highlights: ['Dáng tote chữ nhật', 'Đường chỉ nổi dọc thân', 'Quai tròn chắc chắn', 'Màu navy dễ phối đồ'],
  },
  {
    src: 175, images: 3, category: 'tui-xach', slug: 'balo-da-trang-nap-gap', name: 'Balo da trắng nắp gập dây rút',
    price: 890000, sizes: null, color: 'Trắng', material: 'Da PU cao cấp',
    gender: 'nu', stock: 25, sold: 81,
    description: 'Balo mini màu trắng tinh với nắp gập trang trí thanh kim loại vàng, miệng túi dây rút. Hai quai đeo vai điều chỉnh độ dài bằng khoá kim loại, quai xách nhỏ phía trên tiện lợi.',
    highlights: ['Nắp gập viền kim loại vàng', 'Miệng túi dây rút', 'Quai đeo điều chỉnh được', 'Kích thước mini gọn nhẹ'],
  },

  // ---------------- Giày cao gót ----------------
  {
    src: 188, images: 4, category: 'giay-cao-got', slug: 'giay-stiletto-da-bong-den', name: 'Giày stiletto da bóng đen đế đỏ',
    price: 1390000, sizes: WOMEN_SHOES, color: 'Đen', material: 'Da bóng, lót da',
    gender: 'nu', featured: true, stock: 22, sold: 140,
    description: 'Giày stiletto mũi nhọn bằng da bóng đen, gót nhọn 12cm thanh mảnh. Lót trong màu nude, đế ngoài đỏ nổi bật – món đồ kinh điển cho những buổi tiệc tối.',
    highlights: ['Gót nhọn 12cm', 'Mũi nhọn thon dài', 'Đế ngoài màu đỏ', 'Lót da nude êm chân'],
  },
  {
    src: 187, images: 4, category: 'giay-cao-got', slug: 'giay-cao-got-anh-kim-champagne', name: 'Giày cao gót ánh kim champagne',
    price: 1150000, original_price: 1350000, sizes: WOMEN_SHOES, color: 'Vàng champagne', material: 'Da ánh kim',
    gender: 'nu', isNew: true, stock: 18, sold: 56,
    description: 'Giày pump mũi nhọn phủ da ánh kim vàng champagne lấp lánh, gót stiletto 10cm. Đế ngoài màu đỏ, đường cắt thân giày thấp khoe mu bàn chân thon gọn.',
    highlights: ['Da ánh kim vàng champagne', 'Gót stiletto 10cm', 'Đế ngoài đỏ', 'Cổ giày khoét thấp'],
  },
  {
    src: 186, images: 4, category: 'giay-cao-got', slug: 'sandal-cao-got-quai-ban-to', name: 'Sandal cao gót quai bản to đen',
    price: 1290000, sizes: WOMEN_SHOES, color: 'Đen', material: 'Da bóng',
    gender: 'nu', stock: 15, sold: 37,
    description: 'Sandal cao gót mũi hở với quai ngang bản rộng phía trước và quai cổ chân dạng ống in chữ trắng. Da bóng đen, gót nhọn 10cm – hiện đại, cá tính.',
    highlights: ['Quai ngang bản to', 'Quai cổ chân dạng ống', 'Gót nhọn 10cm', 'Mũi hở thoáng'],
  },
  {
    src: 185, images: 4, category: 'giay-cao-got', slug: 'giay-pump-mui-nhon-da-den', name: 'Giày pump mũi nhọn da đen mờ',
    price: 890000, sizes: WOMEN_SHOES, color: 'Đen', material: 'Da bò mờ, lót da nâu',
    gender: 'nu', stock: 30, sold: 155,
    description: 'Giày pump công sở da đen mờ mũi nhọn, gót nhọn 9cm vừa phải. Lót trong da nâu cognac êm chân, thiết kế trơn tối giản đi cùng mọi trang phục.',
    highlights: ['Da đen mờ sang trọng', 'Gót 9cm dễ đi', 'Lót da nâu cognac', 'Phù hợp công sở'],
  },
  {
    src: 189, images: 4, category: 'giay-cao-got', slug: 'giay-cao-got-satin-do', name: 'Giày cao gót satin đỏ cherry',
    price: 950000, sizes: WOMEN_SHOES, color: 'Đỏ cherry', material: 'Satin bóng',
    gender: 'nu', stock: 20, sold: 67,
    description: 'Giày cao gót bọc satin đỏ cherry bóng mượt, mũi nhọn bo nhẹ và gót nhọn 8cm. Gam đỏ rực điểm nhấn cho trang phục đen hoặc trắng.',
    highlights: ['Satin đỏ cherry bóng', 'Gót 8cm vừa phải', 'Mũi nhọn bo nhẹ', 'Lót đệm êm'],
  },

  // ---------------- Sneaker ----------------
  {
    src: 88, images: 4, category: 'sneaker', slug: 'sneaker-co-cao-do-trang-den', name: 'Sneaker cổ cao đỏ – trắng – đen',
    price: 2890000, sizes: MEN_SHOES, color: 'Đỏ / Trắng / Đen', material: 'Da bò, đế cao su',
    gender: 'unisex', featured: true, stock: 25, sold: 230,
    description: 'Sneaker cổ cao phong cách bóng rổ cổ điển: mũi và gót da đỏ, thân trắng, logo đen bên hông, cổ giày và dây đen. Mảng da đỏ phía sau chần trám tạo điểm nhấn.',
    highlights: ['Cổ cao ôm mắt cá', 'Phối màu đỏ – trắng – đen', 'Da chần trám ở gót', 'Đế cao su bám tốt'],
  },
  {
    src: 91, images: 4, category: 'sneaker', slug: 'sneaker-co-thap-mui-ten-do', name: 'Sneaker cổ thấp hoạ tiết mũi tên đỏ',
    price: 2390000, original_price: 2690000, sizes: MEN_SHOES, color: 'Trắng kem / Đỏ', material: 'Da bò, đế cao su',
    gender: 'unisex', isNew: true, stock: 20, sold: 112,
    description: 'Sneaker cổ thấp da trắng kem, nổi bật hoạ tiết mũi tên đỏ bên hông. Gót và lót cổ giày màu đỏ, viền đế đỏ – phong cách streetwear dễ phối.',
    highlights: ['Mũi tên đỏ bên hông', 'Gót và lót cổ màu đỏ', 'Da trắng kem dễ vệ sinh', 'Đế cao su viền đỏ'],
  },
  {
    src: 90, images: 4, category: 'sneaker', slug: 'sneaker-retro-runner-phoi-mau', name: 'Sneaker retro runner phối màu',
    price: 1790000, sizes: MEN_SHOES, color: 'Xanh / Đỏ / Vàng', material: 'Lưới, da lộn, đế EVA',
    gender: 'unisex', stock: 30, sold: 97,
    description: 'Sneaker chạy bộ phong cách retro thập niên 80 với các mảng xanh dương, đỏ, vàng chanh và kem. Đế bánh mì trắng có rãnh, dây trắng, lớp lưới thoáng khí.',
    highlights: ['Phối màu retro rực rỡ', 'Đế EVA nhẹ, êm', 'Mũ giày lưới thoáng khí', 'Phong cách chạy bộ cổ điển'],
  },
  {
    src: 89, images: 4, category: 'sneaker', slug: 'giay-dinh-bong-chay-trang-xanh', name: 'Giày đinh bóng chày trắng – xanh rêu',
    price: 1990000, sizes: MEN_SHOES, color: 'Trắng / Xanh rêu', material: 'Da tổng hợp, đế đinh kim loại',
    gender: 'nam', stock: 14, sold: 28,
    description: 'Giày thể thao cổ lửng thân trắng phối da xanh lục đậm, logo bên hông. Đế đinh kim loại bám sân cỏ, lưỡi gà đệm dày – dành cho bóng chày và các môn sân cỏ.',
    highlights: ['Đế đinh kim loại bám sân', 'Cổ lửng ổn định mắt cá', 'Phối trắng – xanh rêu', 'Lưỡi gà đệm dày'],
  },

  // ---------------- Đồng hồ ----------------
  {
    src: 98, images: 3, category: 'dong-ho', slug: 'dong-ho-lan-mat-den-vanh-xoay', name: 'Đồng hồ lặn mặt đen vành xoay',
    price: 11900000, original_price: 13500000, sizes: null, color: 'Đen / Demi vàng', material: 'Thép 316L, kính sapphire',
    gender: 'nam', featured: true, stock: 8, sold: 23,
    description: 'Đồng hồ lặn mặt đen với vành xoay một chiều chia phút, cọc số dạ quang và lịch ngày có mắt lens phóng to ở vị trí 3 giờ. Dây kim loại phối demi vàng – thép, chống nước 200m.',
    highlights: ['Vành xoay chia phút', 'Cọc số dạ quang', 'Lịch ngày có lens phóng đại', 'Chống nước 200m'],
  },
  {
    src: 96, images: 3, category: 'dong-ho', slug: 'dong-ho-moonphase-mat-trang-vang-hong', name: 'Đồng hồ moonphase mặt trắng vỏ vàng hồng',
    price: 9500000, sizes: null, color: 'Vàng hồng / Nâu', material: 'Thép mạ vàng hồng, dây da bê',
    gender: 'nam', isNew: true, stock: 9, sold: 19,
    description: 'Mặt số trắng ngà tinh tế với đĩa lịch tuần trăng xanh lapis ở vị trí 6 giờ, kim và cọc vàng hồng. Vỏ vàng hồng bóng, dây da nâu sẫm chỉ khâu trắng.',
    highlights: ['Lịch tuần trăng (moonphase)', 'Vỏ vàng hồng bóng', 'Dây da nâu chỉ trắng', 'Máy cơ automatic'],
  },
  {
    src: 93, images: 3, category: 'dong-ho', slug: 'dong-ho-chronograph-vo-vang-day-da', name: 'Đồng hồ chronograph vỏ vàng dây da nâu',
    price: 8900000, sizes: null, color: 'Vàng / Nâu', material: 'Thép mạ vàng, dây da vân cá sấu',
    gender: 'nam', stock: 11, sold: 34,
    description: 'Chronograph mặt trắng với số Ả Rập, kim xanh blued cổ điển, ba mặt phụ và lịch tuần trăng. Vỏ vàng, dây da nâu vân cá sấu với khoá gập triển khai.',
    highlights: ['Ba mặt phụ chronograph', 'Kim xanh blued', 'Dây da vân cá sấu', 'Khoá gập triển khai'],
  },
  {
    src: 94, images: 3, category: 'dong-ho', slug: 'dong-ho-chronograph-mat-den-day-thep', name: 'Đồng hồ chronograph mặt đen dây thép',
    price: 8500000, sizes: null, color: 'Bạc / Đen', material: 'Thép không gỉ 316L',
    gender: 'nam', stock: 12, sold: 29,
    description: 'Mặt số đen số La Mã kèm cửa sổ thứ – tháng và lịch tuần trăng, ba mặt phụ chronograph. Vỏ và dây thép không gỉ mắt xích, khoá bướm chắc chắn.',
    highlights: ['Cửa sổ thứ và tháng', 'Số La Mã cổ điển', 'Dây thép mắt xích', 'Khoá bướm an toàn'],
  },
  {
    src: 97, images: 3, category: 'dong-ho', slug: 'dong-ho-demi-vanh-khia-mat-xam', name: 'Đồng hồ demi vành khía mặt xám',
    price: 10500000, sizes: null, color: 'Demi vàng – thép / Xám', material: 'Thép 316L mạ vàng',
    gender: 'unisex', featured: true, stock: 10, sold: 41,
    description: 'Vành khía (fluted) vàng ôm mặt số xám than với cọc số La Mã và lịch ngày ở vị trí 3 giờ. Dây jubilee 5 hàng mắt phối vàng và thép – biểu tượng thanh lịch vượt thời gian.',
    highlights: ['Vành khía fluted mạ vàng', 'Dây jubilee demi', 'Lịch ngày vị trí 3 giờ', 'Hợp cả nam và nữ'],
  },
  {
    src: 95, images: 3, category: 'dong-ho', slug: 'dong-ho-vo-vang-hong-mat-den', name: 'Đồng hồ vỏ vàng hồng mặt đen dây da',
    price: 7900000, sizes: null, color: 'Vàng hồng / Đen', material: 'Thép mạ vàng hồng, dây da bê',
    gender: 'nam', stock: 13, sold: 22,
    description: 'Mặt số đen sâu với kim và cọc vàng hồng, mặt phụ hiển thị ngày bên phải. Vỏ vàng hồng dáng tròn cổ điển, dây da đen lót da sáng màu.',
    highlights: ['Mặt đen kim vàng hồng', 'Mặt phụ hiển thị ngày', 'Dây da đen lót sáng', 'Vỏ tròn cổ điển'],
  },
  {
    src: 190, images: 3, category: 'dong-ho', slug: 'dong-ho-automatic-thep-mat-den', name: 'Đồng hồ automatic thép mặt đen',
    price: 6900000, sizes: null, color: 'Bạc / Đen', material: 'Thép không gỉ chải xước',
    gender: 'unisex', stock: 15, sold: 38,
    description: 'Đồng hồ automatic vỏ và dây thép bạc chải xước, mặt đen với cọc vạch dạ quang và kim lá thanh mảnh. Thiết kế thể thao – thanh lịch, đeo được mọi hoàn cảnh.',
    highlights: ['Máy automatic', 'Cọc vạch dạ quang', 'Thép chải xước', 'Dây mắt xích 3 hàng'],
  },
  {
    src: 193, images: 3, category: 'dong-ho', slug: 'dong-ho-nu-mat-xanh-day-vang', name: 'Đồng hồ nữ mặt xanh dây kim loại vàng',
    price: 3900000, original_price: 4500000, sizes: null, color: 'Vàng / Xanh navy', material: 'Thép mạ vàng PVD',
    gender: 'nu', isNew: true, stock: 20, sold: 46,
    description: 'Mặt số xanh navy với cọc số La Mã và kim giây đỏ nổi bật. Vỏ và dây mắt xích mạ vàng PVD bền màu – món phụ kiện nữ tính và sang trọng.',
    highlights: ['Mặt xanh navy số La Mã', 'Kim giây màu đỏ', 'Mạ vàng PVD bền màu', 'Máy quartz chính xác'],
  },
  {
    src: 194, images: 2, category: 'dong-ho', slug: 'dong-ho-toi-gian-mat-den', name: 'Đồng hồ tối giản mặt đen dây thép',
    price: 2900000, sizes: null, color: 'Bạc / Đen', material: 'Thép không gỉ',
    gender: 'unisex', stock: 25, sold: 64,
    description: 'Mặt số đen trơn tối giản với cọc vạch mảnh và lịch ngày ở vị trí 6 giờ. Vỏ và dây thép mắt xích 5 hàng sáng bóng, mỏng nhẹ khi đeo.',
    highlights: ['Thiết kế tối giản', 'Lịch ngày vị trí 6 giờ', 'Dây thép 5 hàng mắt', 'Vỏ mỏng nhẹ'],
  },

  // ---------------- Kính mắt ----------------
  {
    src: 154, images: 3, category: 'kinh-mat', slug: 'kinh-clubmaster-doi-moi', name: 'Kính râm clubmaster đồi mồi',
    price: 590000, sizes: null, color: 'Đồi mồi / Vàng', material: 'Acetate, kim loại',
    gender: 'unisex', featured: true, stock: 40, sold: 175,
    description: 'Kính clubmaster với viền trên nhựa vân đồi mồi nâu, nửa dưới gọng kim loại vàng mảnh. Tròng xanh rêu G-15 chống tia UV400, giữ màu sắc tự nhiên.',
    highlights: ['Viền trên vân đồi mồi', 'Gọng dưới kim loại vàng', 'Tròng xanh rêu G-15', 'Chống UV400'],
  },
  {
    src: 155, images: 3, category: 'kinh-mat', slug: 'kinh-phi-cong-trong-gradient-xanh', name: 'Kính phi công tròng gradient xanh',
    price: 650000, sizes: null, color: 'Vàng / Xanh khói', material: 'Kim loại, tròng polycarbonate',
    gender: 'unisex', stock: 35, sold: 132,
    description: 'Kính aviator gọng kim loại vàng mảnh với cầu đôi kinh điển. Tròng giọt nước gradient xanh khói nhạt dần từ trên xuống, chống UV400.',
    highlights: ['Dáng aviator giọt nước', 'Cầu đôi kim loại', 'Tròng gradient xanh khói', 'Chống UV400'],
  },
  {
    src: 156, images: 3, category: 'kinh-mat', slug: 'kinh-phi-cong-trong-xanh-la', name: 'Kính phi công tròng xanh lá',
    price: 620000, sizes: null, color: 'Đen / Xanh lá', material: 'Kim loại, tròng polycarbonate',
    gender: 'unisex', isNew: true, stock: 30, sold: 54,
    description: 'Kính gọng kim loại đen cầu đôi, tròng lục giác bo góc màu xanh ngọc lá trong trẻo. Biến thể hiện đại của dáng phi công, nhẹ và thời thượng.',
    highlights: ['Tròng xanh lá trong', 'Gọng kim loại đen', 'Dáng lục giác bo góc', 'Siêu nhẹ'],
  },
  {
    src: 158, images: 3, category: 'kinh-mat', slug: 'kinh-gong-trong-suot-oversize', name: 'Kính gọng trong suốt oversize',
    price: 520000, sizes: null, color: 'Trong suốt', material: 'Acetate trong',
    gender: 'unisex', stock: 28, sold: 61,
    description: 'Kính gọng acetate trong suốt to bản, dáng vuông với cạnh vát góc cá tính. Đinh tán vàng ở bản lề, tròng trong suốt – có thể thay tròng cận.',
    highlights: ['Gọng acetate trong suốt', 'Dáng oversize cạnh vát', 'Đinh tán vàng bản lề', 'Lắp được tròng cận'],
  },
  {
    src: 157, images: 3, category: 'kinh-mat', slug: 'kinh-pixel-8-bit', name: 'Kính pixel 8-bit tròng hồng',
    price: 190000, sizes: null, color: 'Đen / Hồng', material: 'Nhựa ABS',
    gender: 'unisex', stock: 60, sold: 210,
    description: 'Kính party gọng nhựa đen tạo hình pixel 8-bit, tròng hồng điểm ô pixel trắng. Món phụ kiện vui nhộn cho tiệc tùng, chụp ảnh và lễ hội.',
    highlights: ['Hình pixel 8-bit vui nhộn', 'Tròng hồng có ô pixel', 'Nhựa ABS siêu nhẹ', 'Phụ kiện tiệc & chụp ảnh'],
  },

  // ---------------- Trang sức ----------------
  {
    src: 182, images: 3, category: 'trang-suc', slug: 'bong-tai-giot-pha-le-xanh-luc', name: 'Bông tai giọt pha lê xanh lục bảo',
    price: 690000, sizes: null, color: 'Xanh lục / Vàng', material: 'Đồng mạ vàng 18K, pha lê',
    gender: 'nu', featured: true, stock: 30, sold: 88,
    description: 'Bông tai móc khoá chữ U mạ vàng, đính đá tròn xanh lục nhỏ, nối chụp vàng với mặt pha lê giọt nước giác cắt xanh lục bảo lấp lánh.',
    highlights: ['Pha lê giọt nước giác cắt', 'Móc khoá chữ U an toàn', 'Mạ vàng 18K', 'Hợp dự tiệc'],
  },
  {
    src: 183, images: 3, category: 'trang-suc', slug: 'bong-tai-vong-tron-caro-xanh', name: 'Bông tai vòng tròn caro xanh – kem',
    price: 290000, sizes: null, color: 'Xanh ngọc / Kem', material: 'Acrylic, chốt bạc 925',
    gender: 'nu', isNew: true, stock: 45, sold: 70,
    description: 'Khuyên nụ tròn màu xanh ngọc treo mặt vòng tròn rỗng hoạ tiết caro gợn sóng xanh ngọc – kem. Chất liệu acrylic siêu nhẹ, chốt bạc 925 không gây kích ứng.',
    highlights: ['Hoạ tiết caro gợn sóng', 'Acrylic siêu nhẹ', 'Chốt bạc 925', 'Phong cách retro'],
  },
  {
    src: 184, images: 3, category: 'trang-suc', slug: 'bong-tai-la-monstera-vang', name: 'Bông tai lá monstera vàng nghệ',
    price: 320000, sizes: null, color: 'Vàng nghệ', material: 'Acrylic, khuyên kim loại mạ vàng',
    gender: 'nu', stock: 40, sold: 58,
    description: 'Khuyên nụ tròn kim loại vàng treo mặt lá monstera tạo hình bằng acrylic vàng nghệ. Thiết kế nhiệt đới nổi bật, nhẹ tai khi đeo cả ngày.',
    highlights: ['Tạo hình lá monstera', 'Màu vàng nghệ ấm', 'Khuyên nụ mạ vàng', 'Nhẹ, đeo cả ngày'],
  },
];

module.exports = { categories, products };
