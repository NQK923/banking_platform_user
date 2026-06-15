# E-Wallet - Flutter User App

Mobile client for end users on iOS and Android. The app uses Flutter, Riverpod, GoRouter, Dio, Freezed, and `decimal` for exact money handling.

## Key Features

### Authentication
- Register and login with server-side validation.
- Short-lived access JWT plus rotating refresh token.
- Refresh requests send only the refresh token; user identity is resolved server-side.
- Six-digit transaction PIN with backend verification and lockout handling.
- v1 registration is VND-only. USD remains a future-ready backend currency seed, but the user app does not expose USD registration.

### Wallet
- Home dashboard with balance, wallet id, recent activity, pull-to-refresh, and quick actions.
- Withdraw flow with PIN verification and idempotency key.
- Mock deposit is intentionally not exposed as a normal user quick action for release. It is an admin/demo operation until a PSP or controlled funding adapter is implemented.

### Transfers
- Recipient lookup by email or phone.
- Lookup responses include account id, status, currency, email, and phone so submit can reuse the matched identifier safely.
- Step-by-step amount, note, confirmation, and PIN flow.
- Client-generated UUID v4 idempotency key for transfer retries.
- Async Saga polling for pending, completed, failed, compensating, cancelled, timeout, and manual retry states.

### History And Support
- Paginated transaction history with direction, counterparty, status, timestamp, and details.
- Support chat and profile screens.
- PIN change and logout from profile.

## Screens

1. Splash (`/splash`): loads app/session state.
2. Login (`/login`): email/phone and password login.
3. Register (`/register`): email, optional phone, password, transaction PIN, VND currency.
4. Home (`/home`): balance, recent transactions, send, withdraw, and support actions.
5. History (`/history`): paginated transaction history.
6. Transaction detail (`/transactions/:id`): receipt-style transaction details.
7. Transfer (`/transfer`): recipient lookup, amount/note, PIN confirmation, and polling.
8. Withdraw (`/withdraw`): withdraw funds with PIN verification.
9. Profile (`/profile`): account details, PIN change, and logout.
10. Support (`/support`): user support chat.

The `/deposit` screen may exist for demo builds, but production release navigation should not expose it to standard users.

## Demo Script

1. Register two VND users with email, optional phone, password, and six-digit transaction PIN.
2. Use the admin backend/admin UI to create a mock deposit for the sender.
3. Open the user app and verify the sender balance.
4. Start a transfer, lookup the recipient by email or phone, enter amount and note, then confirm with PIN.
5. Wait for polling to show the final transfer status.
6. Review the transaction history and detail screens.
7. Try a withdraw with the correct PIN and verify balance/history updates.
8. Change PIN from profile, then log out.

## Tech Stack

- Flutter 3.x stable and Dart 3.
- Riverpod with code generation.
- GoRouter for routing.
- Dio for HTTP and auth retry handling.
- flutter_secure_storage for tokens.
- Freezed and json_serializable for DTOs.
- decimal for money values. Do not use `double` for money.

## Project Structure

```text
lib/
├── core/
│   ├── config/
│   ├── error/
│   ├── localization/
│   ├── money/
│   ├── network/
│   ├── router/
│   └── theme/
├── features/
│   ├── auth/
│   ├── wallet/
│   ├── transfer/
│   ├── history/
│   ├── profile/
│   └── support/
├── shared/
│   └── widgets/
└── main.dart
```

## Configuration

The backend URL is injected with `--dart-define`.

| Variable | Default | Description |
|---|---|---|
| `API_BASE_URL` | Android emulator: `http://10.0.2.2:8080`; other dev targets: `http://localhost:8080` | API Gateway base URL. |

## Commands

Install dependencies:

```bash
flutter pub get
```

Generate Freezed/Riverpod files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run locally:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

Run tests:

```bash
flutter test
```

## Tests

- `money_test.dart`: exact decimal math and currency formatting.
- `auth_notifier_test.dart`: auth state transitions.
- `auth_interceptor_test.dart`: single-flight refresh and retry behavior.
- `wallet_test.dart`: deposit/withdraw state machines and idempotency keys.
- `transfer_test.dart`: recipient lookup, transfer submit, risk continuations, and polling.
- `profile_test.dart`: profile and PIN behavior.
- `support_chat_screen_test.dart`: support chat UI.
- `widget_test.dart`: app startup smoke test.
