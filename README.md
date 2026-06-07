# 🏦 E-Wallet — Flutter User App

This is the mobile client for E-Wallet, targeted at end-users on iOS and Android. Built with Flutter, this application follows feature-first Clean Architecture, uses Riverpod for state management, GoRouter for declarative routing, and Dio for secure HTTP operations.

---

## 🚀 Key Features

### Milestone 1: Authentication & Project Foundation
- **Scaffold & Theme**: Material 3 light/dark mode design system, layout shell with bottom navigation (`Home`, `History`, `Profile`).
- **Secure Authentication**: Register and Login with server-side validations, JWT rotation, and token persistence in `flutter_secure_storage`.
- **401 Interceptor**: Outbound calls attach Bearer tokens. Concurrent 401s queue requests and perform a single-flight token refresh call, retrying once or logging out on refresh failure.
- **6-Digit transaction PIN**: Configurable during registration, validated server-side.
- **Precision Money representation**: Wraps `Decimal` (no floats or doubles) for monetary operations and rounds formatting to currency scale (VND: 0 decimals, USD: 2 decimals).

### Milestone 2: Wallet Home & Transaction History
- **Home Dashboard**: Displays account balance, currency unit, recent transactions preview (last 5), pull-to-refresh, and quick-action buttons.
- **Transaction History**: Infinite scrolling paginated list of transactions with direction indicator, counterparty info, status chip, and timestamp.
- **Transaction Detail**: Inspects full status, both parties, amount, note, created/updated timestamps, and failure reason.
- **Status Mapping**: Real-time styling mapping for transaction states (`PENDING`, `PROCESSING`, `COMPLETED`, `FAILED`, `CANCELLED`, `COMPENSATING`).

### Milestone 3: Real-Time / Async Transfers
- **Step-by-step Transfer Wizard**:
  - **Recipient Lookup**: Live email/phone query to confirm recipient name or display error (not found, self-transfer).
  - **Amount Entry**: Real-time validation against the user's available balance and decimal precision checks.
  - **Confirmation & PIN**: Secure verification via 6-digit transaction PIN.
- **Idempotency Protection**: Inbound requests include a client-generated UUID v4 to guarantee transaction safety upon retries.
- **Async Polling State**: Handles background Saga processing with progressive polling retry, backoff, timeout, and manual retry options.

### Milestone 4: Mock Deposit/Withdraw & Polish
- **Mock Deposit**: Instantly deposit mocked funds through `/api/accounts/{id}/deposit` (synchronous API) with an idempotency key to test inflows and live balance updating.
- **Mock Withdraw**: Safely withdraw mock funds through `/api/accounts/{id}/withdraw` after validation ensures the amount does not exceed the current balance.
- **Profile Screen**: Inspect name, email, masked phone number, perform simulated PIN changes, and secure logout.
- **Polish & UX**: Fully wired quick actions, success snackbars, accessible tap targets, loading overlays, empty states, and optimized system light/dark theme compatibility.

---

## 📱 Full Screen List (Danh sách Màn hình)

1. **Màn hình Chào (`/splash`)**: Hiển thị logo premium và tiến trình khởi tạo cấu hình phiên đăng nhập của ứng dụng.
2. **Đăng nhập (`/login`)**: Cho phép người dùng đăng nhập bằng Email/SĐT và mật khẩu.
3. **Đăng ký (`/register`)**: Hỗ trợ đăng ký thông tin cá nhân, cài đặt mã PIN giao dịch và lựa chọn đơn vị tiền tệ chính (VND/USD).
4. **Trang chủ (`/home`)**: Dashboard chính hiển thị số dư ví, danh sách 5 giao dịch gần đây nhất, và các hành động nhanh (Gửi tiền, Nạp tiền, Rút tiền, Lịch sử).
5. **Lịch sử giao dịch (`/history`)**: Danh sách toàn bộ các giao dịch đã thực hiện dạng phân trang vô hạn (Infinite scroll), hiển thị rõ hướng dòng tiền và trạng thái.
6. **Chi tiết giao dịch (`/transactions/:id`)**: Biên lai giao dịch chi tiết hiển thị đầy đủ thông tin hai bên gửi/nhận, số tiền, mã bút toán, thời gian và lí do thất bại nếu có.
7. **Chuyển tiền (`/transfer`)**: Form chuyển tiền thông minh từng bước (Tìm kiếm người nhận -> Nhập số tiền & ghi chú -> Xác nhận mã PIN -> Polling kết quả Saga thời gian thực).
8. **Nạp tiền (`/deposit`)**: Nhập số tiền và xác nhận nạp tiền thử nghiệm trực tiếp vào tài khoản.
9. **Rút tiền (`/withdraw`)**: Nhập số tiền rút với bộ xác thực số dư hiện tại của ví.
10. **Thông tin cá nhân (`/profile`)**: Hiển thị thông tin tài khoản (ẩn một phần số điện thoại bảo mật), hỗ trợ đổi mã PIN và đăng xuất.

---

## 📝 Kịch Bản Demo Ứng Dụng (Demo Script)

1. **Đăng ký tài khoản mới**:
   - Mở ứng dụng, chọn **Đăng ký** tại màn hình đăng nhập.
   - Nhập Email (ví dụ `test@gmail.com`), Số điện thoại (`0912345678`), Mật khẩu, và mã PIN giao dịch (`123456`). Chọn loại tiền tệ VND.
   - Bấm **Đăng ký**, tài khoản được khởi tạo thành công và tự động đăng nhập đưa người dùng tới trang chủ.
2. **Nạp tiền (Deposit)**:
   - Tại Trang chủ, nhấn nút **Nạp tiền**.
   - Nhập số tiền muốn nạp (ví dụ `500,000` VND). Bấm **Xác nhận**.
   - Màn hình thông báo Nạp tiền thành công, số dư tại Trang chủ lập tức được cập nhật thêm 500,000 VND.
3. **Xem Lịch sử giao dịch**:
   - Bấm chuyển qua tab **Lịch sử** hoặc nhấn nút **Lịch sử** tại Trang chủ.
   - Danh sách giao dịch hiển thị dòng tiền vào (màu xanh lá) cho khoản nạp tiền vừa thực hiện.
4. **Chuyển tiền cho người khác (Transfer)**:
   - Tại Trang chủ, nhấn nút **Gửi tiền**.
   - **Bước 1**: Nhập email hoặc số điện thoại của người nhận (Ví dụ tài khoản của Admin hoặc người dùng khác đã có trên hệ thống). Ứng dụng sẽ tìm kiếm và hiển thị tên người nhận.
   - **Bước 2**: Nhập số tiền chuyển và ghi chú (ví dụ `100,000` VND, ghi chú "Trả tiền nước").
   - **Bước 3**: Xem lại thông tin giao dịch, xác nhận bằng cách nhập mã PIN 6 số.
   - Màn hình sẽ hiển thị trạng thái xử lý giao dịch thời gian thực (hỗ trợ bất đồng bộ qua Saga). Sau khi hoàn thành, màn hình kết quả Chuyển tiền thành công sẽ hiển thị.
5. **Rút tiền (Withdraw)**:
   - Tại Trang chủ, nhấn nút **Rút tiền**.
   - Nhập số tiền rút (Ví dụ `50,000` VND). Ứng dụng tự động kiểm tra số tiền rút không vượt quá số dư hiện tại.
   - Bấm **Xác nhận**, tiền được trừ trực tiếp khỏi tài khoản và giao dịch rút tiền hiển thị trong lịch sử.
6. **Thay đổi mã PIN & Đăng xuất**:
   - Chuyển sang tab **Cá nhân** (Profile).
   - Hiển thị thông tin tên, email, và số điện thoại đã được ẩn một phần bảo mật (masked phone).
   - Chọn **Đổi mã PIN**. Nhập mã PIN cũ (`123456`) và mã PIN mới. Hệ thống sẽ xác thực và cập nhật mã PIN mô phỏng cục bộ.
   - Bấm **Đăng xuất** để xóa phiên làm việc và quay về màn hình đăng nhập.

---

## 🛠 Tech Stack & Conventions
- **Flutter** 3.x stable, **Dart 3**, null-safety.
- **State Management**: [Riverpod](https://pub.dev/packages/flutter_riverpod) using code generation (`riverpod_generator`).
- **Routing**: [go_router](https://pub.dev/packages/go_router).
- **HTTP client**: [Dio](https://pub.dev/packages/dio).
- **Secure Storage**: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) (never SharedPreferences for tokens).
- **Freezed & JSON Serializers**: [freezed](https://pub.dev/packages/freezed), [json_serializable](https://pub.dev/packages/json_serializable) for robust DTOs.
- **Decimal Math**: [decimal](https://pub.dev/packages/decimal) for precision financial math.

---

## 📂 Project Structure
```
lib/
├── core/
│   ├── config/       # Environment & Flavor configs
│   ├── error/        # Exception classes & error mapping
│   ├── money/        # Money value object (Decimal-based)
│   ├── network/      # API client & auth/refresh interceptor
│   ├── router/       # Router config, redirects & navigation shell
│   └── theme/        # Material 3 light/dark themes
├── features/
│   ├── auth/         # Login, Register & PIN setup/verification
│   ├── wallet/       # Wallet/Home, Deposit & Withdraw features
│   ├── transfer/     # Async Saga step-by-step money transfers
│   ├── history/      # Infinite scrolling transaction history & details
│   └── profile/      # User details, Pin simulated wizard & logout
├── shared/
│   └── widgets/      # PrimaryButton, MoneyField, LoadingOverlay, ErrorView, StatusChip
└── main.dart         # Entrypoint
```

---

## ⚙️ Setup & Configuration

### Environment Variables
The API endpoint is injected via `--dart-define` during compilation.

| Variable Name | Default Value | Description |
|---|---|---|
| `API_BASE_URL` | `http://localhost:8080` | Root URL of the Spring Boot backend service |

---

## 💻 Commands

### 1. Download Dependencies
```bash
flutter pub get
```

### 2. Generate Files (Freezed & Riverpod)
Run the builder to generate models and provider files:
```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (automatic updates on save)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 3. Run the App
To start the app on a simulator or device pointing to the local backend:
```bash
# Android Emulator (points to host via 10.0.2.2)
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080

# iOS Simulator or General
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

### 4. Run Tests
Verify units, widget rendering, and state transition logic:
```bash
flutter test
```

---

## 🧪 Included Test Modules
- [money_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/money_test.dart): Verifies exact decimal math, VND/USD displays, and currency addition checks.
- [auth_notifier_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/auth_notifier_test.dart): Validates Riverpod `AuthNotifier` state machine flows (Login, Register, Logout, Initial checks).
- [profile_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/profile_test.dart): Verifies simulated PIN storage, verification overrides, and original fallback safety.
- [wallet_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/wallet_test.dart): Validates state machines for mock deposit and withdrawal submissions.
- [transfer_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/transfer_test.dart): Tests recipient lookups and async status polling loops with progressive backoff.
- [widget_test.dart](file:///c:/Users/nqk09/IdeaProjects/E_Wallet/banking_platform_user/test/widget_test.dart): Smoke tests application startup loading sequence.
