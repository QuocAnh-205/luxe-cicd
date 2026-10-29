-- 03-demo-orders.sql — FILE TỰ SINH bởi database/seed/generate.js, đừng sửa tay.
-- 20 khách hàng mẫu (mật khẩu chung: Khach@123) và lịch sử đơn hàng để xem trên trang Admin.
-- Chạy lại nhiều lần an toàn: khách UPSERT theo email, đơn chỉ tạo cho khách chưa có đơn nào.
SET NAMES utf8mb4;

INSERT INTO users (full_name, email, password_hash, phone, address, role, created_at) VALUES
  ('Nguyễn Minh Anh', 'minhanh.nguyen@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0905123401', '18 Bạch Đằng, Hải Châu, Đà Nẵng', 'customer', NOW() - INTERVAL 180 DAY),
  ('Trần Thu Hà', 'thuha.tran@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0912345602', '72 Trần Phú, Hải Châu, Đà Nẵng', 'customer', NOW() - INTERVAL 177 DAY),
  ('Lê Quốc Bảo', 'quocbao.le@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0935678903', '9 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng', 'customer', NOW() - INTERVAL 174 DAY),
  ('Phạm Ngọc Lan', 'ngoclan.pham@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0987654304', '120 Lê Lợi, Quận 1, TP.HCM', 'customer', NOW() - INTERVAL 171 DAY),
  ('Hoàng Gia Huy', 'giahuy.hoang@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0903456705', '25 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', 'customer', NOW() - INTERVAL 168 DAY),
  ('Võ Thanh Trúc', 'thanhtruc.vo@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0978123406', '56 Võ Văn Tần, Quận 3, TP.HCM', 'customer', NOW() - INTERVAL 165 DAY),
  ('Đặng Khánh Linh', 'khanhlinh.dang@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0934567807', '14 Hùng Vương, Huế', 'customer', NOW() - INTERVAL 162 DAY),
  ('Bùi Đức Thịnh', 'ducthinh.bui@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0965432108', '88 Nguyễn Trãi, Thanh Xuân, Hà Nội', 'customer', NOW() - INTERVAL 159 DAY),
  ('Đỗ Mai Phương', 'maiphuong.do@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0919876509', '3 Phan Chu Trinh, Hội An, Quảng Nam', 'customer', NOW() - INTERVAL 156 DAY),
  ('Huỳnh Tấn Phát', 'tanphat.huynh@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0941234510', '47 Ngô Quyền, Sơn Trà, Đà Nẵng', 'customer', NOW() - INTERVAL 153 DAY),
  ('Ngô Bảo Châu', 'baochau.ngo@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0908765411', '201 Điện Biên Phủ, Bình Thạnh, TP.HCM', 'customer', NOW() - INTERVAL 150 DAY),
  ('Dương Thảo Vy', 'thaovy.duong@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0932109812', '66 Lê Đình Lý, Thanh Khê, Đà Nẵng', 'customer', NOW() - INTERVAL 147 DAY),
  ('Lý Hoàng Nam', 'hoangnam.ly@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0977654313', '31 Trần Hưng Đạo, Ninh Kiều, Cần Thơ', 'customer', NOW() - INTERVAL 144 DAY),
  ('Phan Yến Nhi', 'yennhi.phan@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0916543214', '5 Nguyễn Thị Minh Khai, Nha Trang, Khánh Hoà', 'customer', NOW() - INTERVAL 141 DAY),
  ('Vũ Hải Đăng', 'haidang.vu@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0989012315', '150 Cầu Giấy, Cầu Giấy, Hà Nội', 'customer', NOW() - INTERVAL 138 DAY),
  ('Trịnh Kim Ngân', 'kimngan.trinh@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0923456716', '22 Lý Thường Kiệt, Hải Châu, Đà Nẵng', 'customer', NOW() - INTERVAL 135 DAY),
  ('Mai Xuân Trường', 'xuantruong.mai@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0938765417', '77 Pasteur, Quận 1, TP.HCM', 'customer', NOW() - INTERVAL 132 DAY),
  ('Cao Thị Hồng Nhung', 'hongnhung.cao@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0967890118', '40 Lạch Tray, Ngô Quyền, Hải Phòng', 'customer', NOW() - INTERVAL 129 DAY),
  ('Tạ Minh Khoa', 'minhkhoa.ta@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0904321019', '12 Tôn Đức Thắng, Liên Chiểu, Đà Nẵng', 'customer', NOW() - INTERVAL 126 DAY),
  ('Lâm Ngọc Hân', 'ngochan.lam@example.com', '$2a$10$BuGXIKWqpjMMwXsqQ0Y4O.dTyvCYO3u14OnSKr9vczOcvg.Q7UbYm', '0945678920', '98 Nguyễn Huệ, Quy Nhơn, Bình Định', 'customer', NOW() - INTERVAL 123 DAY)
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

-- Nguyễn Minh Anh
SET @uid = (SELECT id FROM users WHERE email = 'minhanh.nguyen@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Nguyễn Minh Anh', '0905123401', 2890000, 0, 'shipping', 'cod', '18 Bạch Đằng, Hải Châu, Đà Nẵng', 'Gói quà giúp mình nhé', NOW() - INTERVAL 0 DAY - INTERVAL 22 HOUR, NOW() - INTERVAL 0 DAY - INTERVAL 22 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 44, 1, NULL, 290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 82, 2, NULL, 1190000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 70, 1, NULL, 220000 FROM DUAL WHERE @oid IS NOT NULL;

-- Trần Thu Hà
SET @uid = (SELECT id FROM users WHERE email = 'thuha.tran@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Trần Thu Hà', '0912345602', 5800000, 0, 'completed', 'cod', '72 Trần Phú, Hải Châu, Đà Nẵng', NULL, NOW() - INTERVAL 81 DAY - INTERVAL 7 HOUR, NOW() - INTERVAL 81 DAY - INTERVAL 7 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 37, 1, NULL, 2900000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 18, 2, NULL, 1450000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Trần Thu Hà', '0912345602', 4700000, 0, 'completed', 'cod', '72 Trần Phú, Hải Châu, Đà Nẵng', 'Gọi trước khi giao', NOW() - INTERVAL 19 DAY - INTERVAL 19 HOUR, NOW() - INTERVAL 19 DAY - INTERVAL 19 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 25, 1, '39', 2890000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 82, 1, NULL, 1190000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 40, 1, NULL, 620000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Trần Thu Hà', '0912345602', 748000, 30000, 'pending', 'cod', '72 Trần Phú, Hải Châu, Đà Nẵng', 'Giao buổi tối sau 18h', NOW() - INTERVAL 1 DAY - INTERVAL 10 HOUR, NOW() - INTERVAL 1 DAY - INTERVAL 10 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 11, 1, 'S', 459000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 95, 1, NULL, 259000 FROM DUAL WHERE @oid IS NOT NULL;

-- Lê Quốc Bảo
SET @uid = (SELECT id FROM users WHERE email = 'quocbao.le@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lê Quốc Bảo', '0935678903', 1408000, 0, 'pending', 'cod', '9 Nguyễn Văn Linh, Thanh Khê, Đà Nẵng', 'Giao giờ hành chính giúp mình', NOW() - INTERVAL 0 DAY - INTERVAL 22 HOUR, NOW() - INTERVAL 0 DAY - INTERVAL 22 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 12, 2, 'S', 529000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 46, 1, 'XL', 350000 FROM DUAL WHERE @oid IS NOT NULL;

-- Phạm Ngọc Lan
SET @uid = (SELECT id FROM users WHERE email = 'ngoclan.pham@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Phạm Ngọc Lan', '0987654304', 2179000, 0, 'completed', 'bank', '120 Lê Lợi, Quận 1, TP.HCM', 'Giao giờ hành chính giúp mình', NOW() - INTERVAL 28 DAY - INTERVAL 10 HOUR, NOW() - INTERVAL 28 DAY - INTERVAL 10 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 92, 1, NULL, 189000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 28, 1, '39', 1990000 FROM DUAL WHERE @oid IS NOT NULL;

-- Hoàng Gia Huy
SET @uid = (SELECT id FROM users WHERE email = 'giahuy.hoang@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Hoàng Gia Huy', '0903456705', 3860000, 0, 'cancelled', 'cod', '25 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', NULL, NOW() - INTERVAL 12 DAY - INTERVAL 0 HOUR, NOW() - INTERVAL 12 DAY - INTERVAL 0 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 66, 1, '30', 380000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 15, 1, NULL, 2490000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 4, 1, 'M', 990000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Hoàng Gia Huy', '0903456705', 5270000, 0, 'completed', 'bank', '25 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', NULL, NOW() - INTERVAL 8 DAY - INTERVAL 11 HOUR, NOW() - INTERVAL 8 DAY - INTERVAL 11 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 49, 2, 'L', 550000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 27, 1, '39', 1790000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 82, 2, NULL, 1190000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Hoàng Gia Huy', '0903456705', 1950000, 0, 'cancelled', 'cod', '25 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', 'Giao giờ hành chính giúp mình', NOW() - INTERVAL 12 DAY - INTERVAL 7 HOUR, NOW() - INTERVAL 12 DAY - INTERVAL 7 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 10, 1, 'M', 760000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 78, 1, '38', 1190000 FROM DUAL WHERE @oid IS NOT NULL;

-- Võ Thanh Trúc
SET @uid = (SELECT id FROM users WHERE email = 'thanhtruc.vo@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Võ Thanh Trúc', '0978123406', 10500000, 0, 'completed', 'cod', '56 Võ Văn Tần, Quận 3, TP.HCM', NULL, NOW() - INTERVAL 25 DAY - INTERVAL 10 HOUR, NOW() - INTERVAL 25 DAY - INTERVAL 10 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 33, 1, NULL, 10500000 FROM DUAL WHERE @oid IS NOT NULL;

-- Đặng Khánh Linh
SET @uid = (SELECT id FROM users WHERE email = 'khanhlinh.dang@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Đặng Khánh Linh', '0934567807', 4340000, 0, 'completed', 'bank', '14 Hùng Vương, Huế', NULL, NOW() - INTERVAL 84 DAY - INTERVAL 0 HOUR, NOW() - INTERVAL 84 DAY - INTERVAL 0 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 97, 1, NULL, 3990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 46, 1, 'XL', 350000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Đặng Khánh Linh', '0934567807', 1980000, 0, 'completed', 'bank', '14 Hùng Vương, Huế', 'Giao buổi tối sau 18h', NOW() - INTERVAL 37 DAY - INTERVAL 11 HOUR, NOW() - INTERVAL 37 DAY - INTERVAL 11 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 99, 1, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 43, 1, NULL, 690000 FROM DUAL WHERE @oid IS NOT NULL;

-- Bùi Đức Thịnh
SET @uid = (SELECT id FROM users WHERE email = 'ducthinh.bui@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Bùi Đức Thịnh', '0965432108', 880000, 30000, 'completed', 'bank', '88 Nguyễn Trãi, Thanh Xuân, Hà Nội', NULL, NOW() - INTERVAL 4 DAY - INTERVAL 19 HOUR, NOW() - INTERVAL 4 DAY - INTERVAL 19 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 8, 1, 'S', 850000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Bùi Đức Thịnh', '0965432108', 2179000, 0, 'completed', 'bank', '88 Nguyễn Trãi, Thanh Xuân, Hà Nội', 'Gọi trước khi giao', NOW() - INTERVAL 67 DAY - INTERVAL 22 HOUR, NOW() - INTERVAL 67 DAY - INTERVAL 22 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 59, 2, 'L', 890000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 13, 1, 'XL', 399000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Bùi Đức Thịnh', '0965432108', 4890000, 0, 'cancelled', 'bank', '88 Nguyễn Trãi, Thanh Xuân, Hà Nội', 'Gọi trước khi giao', NOW() - INTERVAL 28 DAY - INTERVAL 22 HOUR, NOW() - INTERVAL 28 DAY - INTERVAL 22 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 38, 1, NULL, 590000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 3, 2, 'L', 2150000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Bùi Đức Thịnh', '0965432108', 3419000, 0, 'completed', 'bank', '88 Nguyễn Trãi, Thanh Xuân, Hà Nội', 'Gói quà giúp mình nhé', NOW() - INTERVAL 64 DAY - INTERVAL 7 HOUR, NOW() - INTERVAL 64 DAY - INTERVAL 7 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 66, 1, '29', 380000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 11, 1, 'L', 459000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 87, 2, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL;

-- Đỗ Mai Phương
SET @uid = (SELECT id FROM users WHERE email = 'maiphuong.do@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Đỗ Mai Phương', '0919876509', 289000, 30000, 'cancelled', 'cod', '3 Phan Chu Trinh, Hội An, Quảng Nam', NULL, NOW() - INTERVAL 52 DAY - INTERVAL 0 HOUR, NOW() - INTERVAL 52 DAY - INTERVAL 0 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 95, 1, NULL, 259000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Đỗ Mai Phương', '0919876509', 6310000, 0, 'completed', 'bank', '3 Phan Chu Trinh, Hội An, Quảng Nam', 'Gọi trước khi giao', NOW() - INTERVAL 30 DAY - INTERVAL 14 HOUR, NOW() - INTERVAL 30 DAY - INTERVAL 14 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 82, 2, NULL, 1190000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 54, 2, 'L', 320000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 89, 1, NULL, 3290000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Đỗ Mai Phương', '0919876509', 7900000, 0, 'cancelled', 'cod', '3 Phan Chu Trinh, Hội An, Quảng Nam', 'Giao giờ hành chính giúp mình', NOW() - INTERVAL 33 DAY - INTERVAL 13 HOUR, NOW() - INTERVAL 33 DAY - INTERVAL 13 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 34, 1, NULL, 7900000 FROM DUAL WHERE @oid IS NOT NULL;

-- Huỳnh Tấn Phát
SET @uid = (SELECT id FROM users WHERE email = 'tanphat.huynh@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Huỳnh Tấn Phát', '0941234510', 13190000, 0, 'paid', 'bank', '47 Ngô Quyền, Sơn Trà, Đà Nẵng', 'Gói quà giúp mình nhé', NOW() - INTERVAL 5 DAY - INTERVAL 20 HOUR, NOW() - INTERVAL 5 DAY - INTERVAL 20 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 30, 1, NULL, 9500000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 78, 1, '37', 1190000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 5, 2, 'S', 1250000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Huỳnh Tấn Phát', '0941234510', 2749000, 0, 'completed', 'bank', '47 Ngô Quyền, Sơn Trà, Đà Nẵng', NULL, NOW() - INTERVAL 85 DAY - INTERVAL 5 HOUR, NOW() - INTERVAL 85 DAY - INTERVAL 5 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 39, 2, NULL, 650000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 21, 1, '37', 1150000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 94, 1, NULL, 299000 FROM DUAL WHERE @oid IS NOT NULL;

-- Ngô Bảo Châu
SET @uid = (SELECT id FROM users WHERE email = 'baochau.ngo@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Ngô Bảo Châu', '0908765411', 4220000, 0, 'completed', 'bank', '201 Điện Biên Phủ, Bình Thạnh, TP.HCM', NULL, NOW() - INTERVAL 16 DAY - INTERVAL 6 HOUR, NOW() - INTERVAL 16 DAY - INTERVAL 6 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 54, 2, 'L', 320000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 26, 1, '44', 2390000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 82, 1, NULL, 1190000 FROM DUAL WHERE @oid IS NOT NULL;

-- Dương Thảo Vy
SET @uid = (SELECT id FROM users WHERE email = 'thaovy.duong@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Dương Thảo Vy', '0932109812', 4170000, 0, 'completed', 'cod', '66 Lê Đình Lý, Thanh Khê, Đà Nẵng', 'Giao giờ hành chính giúp mình', NOW() - INTERVAL 49 DAY - INTERVAL 3 HOUR, NOW() - INTERVAL 49 DAY - INTERVAL 3 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 60, 2, 'M', 1290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 17, 1, NULL, 1590000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Dương Thảo Vy', '0932109812', 7280000, 0, 'paid', 'bank', '66 Lê Đình Lý, Thanh Khê, Đà Nẵng', 'Gói quà giúp mình nhé', NOW() - INTERVAL 0 DAY - INTERVAL 19 HOUR, NOW() - INTERVAL 0 DAY - INTERVAL 19 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 87, 1, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 86, 1, NULL, 5990000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Dương Thảo Vy', '0932109812', 2540000, 0, 'completed', 'cod', '66 Lê Đình Lý, Thanh Khê, Đà Nẵng', NULL, NOW() - INTERVAL 32 DAY - INTERVAL 5 HOUR, NOW() - INTERVAL 32 DAY - INTERVAL 5 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 61, 1, 'S', 1150000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 20, 1, '38', 1390000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Dương Thảo Vy', '0932109812', 3000000, 0, 'completed', 'cod', '66 Lê Đình Lý, Thanh Khê, Đà Nẵng', NULL, NOW() - INTERVAL 14 DAY - INTERVAL 10 HOUR, NOW() - INTERVAL 14 DAY - INTERVAL 10 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 68, 1, NULL, 220000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 15, 1, NULL, 2490000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 55, 1, 'M', 290000 FROM DUAL WHERE @oid IS NOT NULL;

-- Lý Hoàng Nam
SET @uid = (SELECT id FROM users WHERE email = 'hoangnam.ly@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lý Hoàng Nam', '0977654313', 15070000, 0, 'completed', 'cod', '31 Trần Hưng Đạo, Ninh Kiều, Cần Thơ', 'Gói quà giúp mình nhé', NOW() - INTERVAL 49 DAY - INTERVAL 5 HOUR, NOW() - INTERVAL 49 DAY - INTERVAL 5 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 98, 1, NULL, 12990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 7, 1, 'XS', 790000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 87, 1, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lý Hoàng Nam', '0977654313', 10710000, 0, 'cancelled', 'cod', '31 Trần Hưng Đạo, Ninh Kiều, Cần Thơ', NULL, NOW() - INTERVAL 26 DAY - INTERVAL 3 HOUR, NOW() - INTERVAL 26 DAY - INTERVAL 3 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 47, 1, 'M', 590000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 30, 1, NULL, 9500000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 40, 1, NULL, 620000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lý Hoàng Nam', '0977654313', 280000, 30000, 'completed', 'cod', '31 Trần Hưng Đạo, Ninh Kiều, Cần Thơ', 'Gói quà giúp mình nhé', NOW() - INTERVAL 26 DAY - INTERVAL 18 HOUR, NOW() - INTERVAL 26 DAY - INTERVAL 18 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 53, 1, 'M', 250000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lý Hoàng Nam', '0977654313', 3230000, 0, 'completed', 'cod', '31 Trần Hưng Đạo, Ninh Kiều, Cần Thơ', 'Gọi trước khi giao', NOW() - INTERVAL 87 DAY - INTERVAL 0 HOUR, NOW() - INTERVAL 87 DAY - INTERVAL 0 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 91, 1, NULL, 2990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 58, 1, 'M', 240000 FROM DUAL WHERE @oid IS NOT NULL;

-- Phan Yến Nhi
SET @uid = (SELECT id FROM users WHERE email = 'yennhi.phan@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Phan Yến Nhi', '0916543214', 21780000, 0, 'completed', 'bank', '5 Nguyễn Thị Minh Khai, Nha Trang, Khánh Hoà', 'Gọi trước khi giao', NOW() - INTERVAL 11 DAY - INTERVAL 14 HOUR, NOW() - INTERVAL 11 DAY - INTERVAL 14 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 32, 1, NULL, 8500000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 55, 1, 'M', 290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 98, 1, NULL, 12990000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Phan Yến Nhi', '0916543214', 12670000, 0, 'pending', 'cod', '5 Nguyễn Thị Minh Khai, Nha Trang, Khánh Hoà', NULL, NOW() - INTERVAL 0 DAY - INTERVAL 14 HOUR, NOW() - INTERVAL 0 DAY - INTERVAL 14 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 86, 1, NULL, 5990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 8, 2, 'M', 850000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 90, 2, NULL, 2490000 FROM DUAL WHERE @oid IS NOT NULL;

-- Vũ Hải Đăng
SET @uid = (SELECT id FROM users WHERE email = 'haidang.vu@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Vũ Hải Đăng', '0989012315', 628000, 30000, 'paid', 'cod', '150 Cầu Giấy, Cầu Giấy, Hà Nội', 'Giao buổi tối sau 18h', NOW() - INTERVAL 5 DAY - INTERVAL 6 HOUR, NOW() - INTERVAL 5 DAY - INTERVAL 6 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 94, 2, NULL, 299000 FROM DUAL WHERE @oid IS NOT NULL;

-- Trịnh Kim Ngân
SET @uid = (SELECT id FROM users WHERE email = 'kimngan.trinh@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Trịnh Kim Ngân', '0923456716', 2580000, 0, 'completed', 'cod', '22 Lý Thường Kiệt, Hải Châu, Đà Nẵng', 'Giao buổi tối sau 18h', NOW() - INTERVAL 81 DAY - INTERVAL 19 HOUR, NOW() - INTERVAL 81 DAY - INTERVAL 19 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 60, 2, 'S', 1290000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Trịnh Kim Ngân', '0923456716', 24780000, 0, 'completed', 'cod', '22 Lý Thường Kiệt, Hải Châu, Đà Nẵng', 'Giao buổi tối sau 18h', NOW() - INTERVAL 50 DAY - INTERVAL 8 HOUR, NOW() - INTERVAL 50 DAY - INTERVAL 8 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 98, 1, NULL, 12990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 80, 1, '35', 2290000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 30, 1, NULL, 9500000 FROM DUAL WHERE @oid IS NOT NULL;

-- Mai Xuân Trường
SET @uid = (SELECT id FROM users WHERE email = 'xuantruong.mai@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Mai Xuân Trường', '0938765417', 5130000, 0, 'completed', 'bank', '77 Pasteur, Quận 1, TP.HCM', NULL, NOW() - INTERVAL 75 DAY - INTERVAL 13 HOUR, NOW() - INTERVAL 75 DAY - INTERVAL 13 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 84, 1, '6', 890000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 91, 1, NULL, 2990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 5, 1, 'L', 1250000 FROM DUAL WHERE @oid IS NOT NULL;

-- Cao Thị Hồng Nhung
SET @uid = (SELECT id FROM users WHERE email = 'hongnhung.cao@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Cao Thị Hồng Nhung', '0967890118', 250000, 30000, 'completed', 'bank', '40 Lạch Tray, Ngô Quyền, Hải Phòng', 'Gọi trước khi giao', NOW() - INTERVAL 89 DAY - INTERVAL 15 HOUR, NOW() - INTERVAL 89 DAY - INTERVAL 15 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 57, 1, 'M', 220000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Cao Thị Hồng Nhung', '0967890118', 1940000, 0, 'completed', 'cod', '40 Lạch Tray, Ngô Quyền, Hải Phòng', 'Gọi trước khi giao', NOW() - INTERVAL 4 DAY - INTERVAL 2 HOUR, NOW() - INTERVAL 4 DAY - INTERVAL 2 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 39, 1, NULL, 650000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 87, 1, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL;

-- Tạ Minh Khoa
SET @uid = (SELECT id FROM users WHERE email = 'minhkhoa.ta@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Tạ Minh Khoa', '0904321019', 2239000, 0, 'paid', 'cod', '12 Tôn Đức Thắng, Liên Chiểu, Đà Nẵng', NULL, NOW() - INTERVAL 6 DAY - INTERVAL 1 HOUR, NOW() - INTERVAL 6 DAY - INTERVAL 1 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 13, 1, 'S', 399000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 49, 1, 'M', 550000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 87, 1, NULL, 1290000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Tạ Minh Khoa', '0904321019', 4120000, 0, 'completed', 'bank', '12 Tôn Đức Thắng, Liên Chiểu, Đà Nẵng', NULL, NOW() - INTERVAL 13 DAY - INTERVAL 1 HOUR, NOW() - INTERVAL 13 DAY - INTERVAL 1 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 28, 1, '40', 1990000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 16, 1, NULL, 1690000 FROM DUAL WHERE @oid IS NOT NULL
  UNION ALL
  SELECT @oid, 70, 2, NULL, 220000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Tạ Minh Khoa', '0904321019', 350000, 30000, 'completed', 'cod', '12 Tôn Đức Thắng, Liên Chiểu, Đà Nẵng', NULL, NOW() - INTERVAL 23 DAY - INTERVAL 4 HOUR, NOW() - INTERVAL 23 DAY - INTERVAL 4 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 67, 1, 'L', 320000 FROM DUAL WHERE @oid IS NOT NULL;

-- Lâm Ngọc Hân
SET @uid = (SELECT id FROM users WHERE email = 'ngochan.lam@example.com');
SET @fresh = NOT EXISTS (SELECT 1 FROM orders WHERE user_id = @uid);
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lâm Ngọc Hân', '0945678920', 880000, 30000, 'completed', 'cod', '98 Nguyễn Huệ, Quy Nhơn, Bình Định', 'Gọi trước khi giao', NOW() - INTERVAL 26 DAY - INTERVAL 18 HOUR, NOW() - INTERVAL 26 DAY - INTERVAL 18 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 8, 1, 'M', 850000 FROM DUAL WHERE @oid IS NOT NULL;
INSERT INTO orders (user_id, full_name, phone, total_amount, shipping_fee, status, payment_method, shipping_address, note, created_at, updated_at)
  SELECT @uid, 'Lâm Ngọc Hân', '0945678920', 489000, 30000, 'completed', 'bank', '98 Nguyễn Huệ, Quy Nhơn, Bình Định', 'Gọi trước khi giao', NOW() - INTERVAL 36 DAY - INTERVAL 7 HOUR, NOW() - INTERVAL 36 DAY - INTERVAL 7 HOUR FROM DUAL WHERE @fresh;
SET @oid = IF(ROW_COUNT() > 0, LAST_INSERT_ID(), NULL);
INSERT INTO order_items (order_id, product_id, quantity, size, unit_price)
  SELECT @oid, 11, 1, 'L', 459000 FROM DUAL WHERE @oid IS NOT NULL;
