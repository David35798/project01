USE govshop;

-- Users
INSERT INTO user (name, email, password_hash, role, phone)
VALUES 
('김노인', 'elder@example.com', '$2a$10$examplehashELDER', 'ELDER', '010-1111-1111'),
('홍보호자', 'guardian@example.com', '$2a$10$examplehashGUARD', 'GUARDIAN', '010-2222-2222'),
('관리자', 'admin@example.com', '$2a$10$examplehashADMIN', 'ADMIN', '010-3333-3333');

-- Guardian link
INSERT INTO guardian_link (elder_id, guardian_id, status)
VALUES (1, 2, 'APPROVED');

-- Guardian policy (limit 30,000, MANUAL approval)
INSERT INTO guardian_policy (guardian_id, spending_limit, approval_mode, notify_channel)
VALUES (2, 30000.00, 'MANUAL', 'SMS');

-- Categories
INSERT INTO category (name, parent_id, depth) VALUES 
('사무/소모품', NULL, 0),
('복사용지', 1, 1),
('프린터 토너', 1, 1);

-- Products
INSERT INTO product (category_id, name, brand, unit, origin, price, stock, rating, image_url, description)
VALUES
(2, 'A4 복사용지 80g (500매)', '한솔', 'BOX', 'KR', 5500.00, 1000, 4.5, 'https://example.com/a4.png', '표준 A4 용지'),
(3, '레이저 프린터 토너 1100', '삼성', 'EA', 'KR', 32000.00, 200, 4.2, 'https://example.com/toner.png', '레이저 토너');

-- Address
INSERT INTO address (user_id, receiver_name, phone, zipcode, addr1, addr2, is_default)
VALUES (1, '김노인', '010-1111-1111', '04524', '서울 중구 세종대로 110', '정부서울청사', TRUE);

-- Order (awaiting approval)
INSERT INTO orders (user_id, address_id, total_amount, status)
VALUES (1, 1, 0.00, 'AWAITING_APPROVAL');

-- Order items
INSERT INTO order_item (order_id, product_id, quantity, unit_price, subtotal)
VALUES 
(1, 1, 2, 5500.00, 11000.00),
(1, 2, 1, 32000.00, 32000.00);

-- Update order total
UPDATE orders 
SET total_amount = (SELECT SUM(subtotal) FROM order_item WHERE order_id = 1)
WHERE id = 1;

-- Approval request (waiting)
INSERT INTO approval_request (order_id, guardian_id, status)
VALUES (1, 2, 'WAITING');

-- Payment (pending)
INSERT INTO payment (order_id, amount, status)
VALUES (1, 43000.00, 'PENDING');
