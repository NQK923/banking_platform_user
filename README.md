# E-Wallet User App

Flutter client for the E-Wallet digital wallet platform. Users can create a VND wallet, check balances, transfer by email or phone, withdraw with a transaction PIN, review activity, and contact support.

Related repositories: [Backend](https://github.com/NQK923/banking_platform) · [Admin console](https://github.com/NQK923/banking_platform_admin).

## Features

- Registration, login, email OTP password reset, and rotating token sessions.
- Separate six-digit transaction PIN with backend verification and lockout handling.
- Wallet dashboard with balance, recent activity, and pull-to-refresh.
- Transfers with recipient lookup, amount/note entry, PIN confirmation, risk continuations, and asynchronous status polling.
- Idempotent transfer and withdrawal retries, duplicate-submit prevention, and protection against stale responses.
- Paginated history, transaction details, support chat, profile, PIN change, and logout.
- English/Vietnamese localization and responsive layouts.

Registration is VND-only. USD exists in the backend currency seed but is not offered during user registration. Mock funding is an admin/backend operation; this client has no self-service deposit route or implementation. Real payment gateways and FX conversion are outside v1.

## Technology stack

Flutter, Dart, Riverpod, GoRouter, Dio, flutter_secure_storage, Freezed, json_serializable, and `decimal`. Money is decoded from decimal strings and handled without floating-point arithmetic.

## Prerequisites

- Flutter stable with Dart compatible with `^3.12.1`, as declared in `pubspec.yaml`.
- Android SDK and a supported JDK for Android builds.
- macOS and Xcode for iOS builds.
- Chrome for web development.
- A running [E-Wallet API Gateway](https://github.com/NQK923/banking_platform#readme) for live app flows.

Check the local toolchain with `flutter doctor`. Android, iOS, and web project directories are included; iOS release builds have not been validated on the Windows development host.

## Installation

Run commands from this repository's root:

```powershell
flutter pub get
```

Generated DTOs and providers are checked in. Regenerate them after changing their source declarations:

```powershell
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

## Configuration

The gateway origin is supplied at build/run time with `--dart-define`:

| Variable | Default |
| --- | --- |
| `API_BASE_URL` | Android: `http://10.0.2.2:8080`; other targets: `http://localhost:8080` |

The Android default is intended for the standard Android emulator. For a physical device, use a reachable host address or an HTTPS gateway. `localhost` on a device refers to that device. Use HTTPS for deployed environments.

## Run locally

Android emulator:

```powershell
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

Chrome:

```powershell
flutter run -d chrome --web-port=4200 --dart-define=API_BASE_URL=http://localhost:8080
```

Choose a backend CORS-allowed web origin; the gateway includes localhost port `4200` in its development configuration. If multiple devices are connected, select the intended device using `-d <device-id>`.

## Screens

| Route | Purpose |
| --- | --- |
| `/splash` | Initialize session state |
| `/login`, `/register`, `/forgot-password` | Authentication and password reset |
| `/pin` | PIN screen |
| `/home` | Balance, recent activity, and quick actions |
| `/transfer` | Recipient lookup, amount/note, risk continuation, PIN, and polling |
| `/withdraw` | PIN-protected withdrawal |
| `/history`, `/transactions/:id` | Transaction history and details |
| `/profile` | Account details, PIN change, and logout |
| `/support` | Support chat |
| `/support/session/:id` | Existing support session |
| `/history/:id/support` | Support for a transaction |

## Demo workflow

1. Register two VND users with a password and six-digit PIN.
2. Fund the sender using the backend's admin/mock funding operation.
3. Refresh the sender's dashboard and confirm the balance.
4. Look up the recipient by email or phone, enter an amount/note, and confirm with the PIN.
5. Wait for the terminal status, then inspect history and transaction details.
6. Try a withdrawal, verify the updated balance/history, and change the PIN from the profile screen.

## Tests

```powershell
flutter analyze --fatal-infos
flutter test
```

These checks do not require Docker or a live gateway. Coverage includes exact decimal parsing/formatting, auth refresh, transfer/risk state, withdrawal idempotency, history races, profile/PIN, routing, support, and app startup.

`test/money_flow_screen_test.dart` exercises transfer and withdrawal screens through real repositories with a fake HTTP boundary, including narrow/wide layouts. It does not prove live ledger accounting or backend risk enforcement.

### Live integration smoke

The current integration smoke registers a user and checks the wallet home screen against a real gateway. It creates test data and is not a full money-movement E2E suite.

On a connected Android or iOS test target:

```powershell
flutter test integration_test/release_smoke_test.dart -d <device-id> --dart-define=API_BASE_URL=<reachable-gateway-origin>
```

Web integration uses `test_driver/integration_test.dart` with ChromeDriver. The complete workspace's `scripts/release-e2e.ps1` orchestrates this with the admin suite; it starts backend infrastructure unless `-SkipBackendStart` is supplied. The workspace script is maintained separately from this repository.

## Release builds

```powershell
flutter build web --release --dart-define=API_BASE_URL=https://api.example.com
flutter build apk --release --dart-define=API_BASE_URL=https://api.example.com
```

Replace the example gateway with your deployment origin. Web output is written to `build/web/`; the Android APK is written to `build/app/outputs/flutter-apk/app-release.apk`.

The current Android release configuration has no signing key, so the APK is unsigned. Configure release signing before installation or distribution. The main manifest includes Internet permission; store credentials, device hardening, and deployment certificates require separate setup. The web JavaScript build is supported; the secure-storage dependency currently prevents treating a Wasm build as validated.

Run Flutter commands sequentially in this checkout. For Android release builds, allow the normal dependency/plugin metadata refresh: do not use `--no-pub` on SDKs affected by stale integration-test plugin registration. Do not edit `GeneratedPluginRegistrant.java` manually.

## Project structure

```text
lib/
├── core/          # Configuration, network, money, routing, localization, and theme
├── features/
│   ├── auth/
│   ├── wallet/
│   ├── transfer/
│   ├── history/
│   ├── profile/
│   └── support/
├── l10n/          # ARB resources and generated localization
├── shared/        # Reusable widgets
└── main.dart

test/              # Unit and widget tests
integration_test/  # Live gateway smoke test
test_driver/       # Web integration driver
```

## Workspace verification

When all three repositories and the separate workspace scripts are present, run `..\scripts\verify.ps1` from PowerShell for Docker-free backend/admin/Flutter verification. Add `-IncludeAndroid` for an Android release build. These checks exclude container tests and live gateway E2E; consult the workspace release audit for the remaining release gates.
