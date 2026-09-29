# 💸 MoneyPilot Mobile

> **Take Command of Every Rupee.**  
> A modern, elegant personal finance and expense tracking mobile application built with Flutter & Dart, powered by Riverpod state management and GoRouter.

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![State Management](https://img.shields.io/badge/Riverpod-3.4+-blueviolet?style=for-the-badge)](https://riverpod.dev)
[![Navigation](https://img.shields.io/badge/GoRouter-18.0+-orange?style=for-the-badge)](https://pub.dev/packages/go_router)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Tech Stack & Architecture](#-tech-stack--architecture)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Getting Started & Setup](#-getting-started--setup)
  - [1. Clone Repository](#1-clone-repository)
  - [2. Install Dependencies](#2-install-dependencies)
  - [3. Verify Flutter Environment](#3-verify-flutter-environment)
  - [4. Run the Application](#4-run-the-application)
- [Backend API Configuration](#-backend-api-configuration)
- [Running Tests & Code Quality](#-running-tests--code-quality)
- [Building Production Artifacts](#-building-production-artifacts)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

---

## 🌟 Overview

**MoneyPilot** helps users track expenses, establish monthly budget thresholds, monitor financial goals, and visualize spending trends with a clean, fintech-grade interface. 

The application works out-of-the-box with built-in mock seed data for seamless testing and demonstration, and includes a production-ready **Dio HTTP Client** configured with JWT authentication interceptors to connect with any standard REST backend.

---

## ✨ Key Features

### 🔐 1. Authentication & Security
- **Registration & Login Flows**: Clean form validation for onboarding and returning pilots.
- **Encrypted Local Storage**: Uses `flutter_secure_storage` to persist JWT tokens and user session data in encrypted storage (KeyStore on Android / Keychain on iOS).
- **Navigation Guard**: Automatic redirection based on authentication state and onboarding completion.

### 💳 2. Transactions & Ledger
- **Income & Expense Tracking**: Record transactions with category, payment method, amount, date, and notes.
- **Dynamic Filtering**: One-tap toggle between All, Expenses, and Income.
- **Instant Search**: Real-time transaction filtering by title, category, or note.
- **Automatic Summary**: Live balance, monthly expense, and monthly income computations.

### 📊 3. Budgets & Spending Limits
- **Overall Monthly Target**: Set a monthly ceiling and monitor percentage utilized.
- **Category-Specific Limits**: Set custom budgets across 12 distinct categories (Food & Dining, Transport, Shopping, Bills & Utilities, Entertainment, Healthcare, etc.).
- **Dynamic Visual Alerts**:
  - 🟢 **Normal**: Under 80% usage
  - 🟡 **Warning**: 80% - 100% usage
  - 🔴 **Overbudget**: Exceeded allocated limit

### 🎯 4. Financial Goals
- **Savings Milestones**: Create dedicated goals with target amounts and completion dates.
- **Progress Tracking**: Real-time progress bars indicating percentage saved and remaining balances.

### 📈 5. Reports & Analytics
- **Visual Breakdown**: Interactive charts powered by `fl_chart`.
- **Spending Distribution**: Analyze spending proportions across categories.

### 🎨 6. Polished UI & Design System
- Modern Emerald Green brand palette (`#005C46`).
- Plus Jakarta Sans & Inter typography via `google_fonts`.
- Responsive layouts with light & dark theme capabilities.

---

## 🛠 Tech Stack & Architecture

| Layer | Technology | Purpose |
|---|---|---|
| **Framework** | [Flutter 3.x](https://flutter.dev) (Dart SDK `^3.13.3`) | Cross-platform UI toolkit |
| **State Management** | [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod) `^3.4.3` | Reactive, decoupled dependency injection & state management |
| **Routing** | [GoRouter](https://pub.dev/packages/go_router) `^18.0.1` | Declarative routing, nested shells, deep linking & auth guards |
| **Networking** | [Dio](https://pub.dev/packages/dio) `^5.11.1` | HTTP client with request/response interceptors & token injection |
| **Security** | [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) `^11.1.1` | Encrypted keychain / keystore storage for auth tokens |
| **Charts** | [FL Chart](https://pub.dev/packages/fl_chart) `^1.2.0` | Performant interactive charting & financial visualization |
| **Formatting** | [Intl](https://pub.dev/packages/intl) `^0.20.3` | Currency, number, and date localization |

### Architecture Pattern: Feature-First (Modular)

```
lib/
├── app.dart                   # Root MaterialApp with theme & router bindings
├── main.dart                  # Application entry point with ProviderScope
├── core/                      # Global foundations & core utilities
│   ├── constants/             # AppColors, ApiEndpoints, Category definitions
│   ├── network/               # ApiClient & AuthInterceptor
│   ├── routing/               # GoRouter routing table & route guards
│   ├── storage/               # SecureStorage wrapper for credentials
│   ├── theme/                 # Light & Dark theme definitions
│   └── utils/                 # Currency & date formatters
├── features/                  # Domain-driven feature modules
│   ├── auth/                  # Login, Register, Auth State Notifier
│   ├── budgets/               # Budget models, providers, and UI screens
│   ├── dashboard/             # Home view, balance overview & quick actions
│   ├── goals/                 # Savings goals model, providers & screens
│   ├── navigation/            # Bottom navigation bar shell scaffold
│   ├── onboarding/            # First-run onboarding slides
│   ├── profile/               # User profile, diagnostics & app settings
│   ├── reports/               # Spending analytics & charts
│   └── transactions/          # Transaction models, providers & add/list screens
└── shared/                    # Reusable widgets (CustomButton, CustomTextField, etc.)
```

---

## 📋 Prerequisites

Before running the application, ensure you have the following installed on your machine:

1. **Flutter SDK**: Version `3.13.3` or later ([Install Flutter](https://docs.flutter.dev/get-started/install))
2. **Dart SDK**: Bundled with Flutter
3. **Android Studio** or **VS Code** with the following extensions:
   - Flutter extension
   - Dart extension
4. **Android SDK / Emulator** (or physical Android/iOS device enabled for USB debugging)
5. **Git** ([Install Git](https://git-scm.com/))

---

## 🚀 Getting Started & Setup

### 1. Clone Repository

```bash
git clone https://github.com/Thidas03/Money_Pilot_Sample.git
cd Money_Pilot_Sample
```

### 2. Install Dependencies

Fetch all required Dart and Flutter packages:

```bash
flutter pub get
```

### 3. Verify Flutter Environment

Check that all development tools and dependencies are properly configured:

```bash
flutter doctor
```

Make sure at least one target device (Android Emulator, iOS Simulator, Chrome, or Windows) is available:

```bash
flutter devices
```

### 4. Run the Application

#### Run on Connected Device / Default Emulator:
```bash
flutter run
```

#### Run on a Specific Device:
```bash
# List available device IDs
flutter devices

# Run specifying device ID
flutter run -d <DEVICE_ID>

# Example: Run on Android Emulator
flutter run -d emulator-5554

# Example: Run in Chrome Browser
flutter run -d chrome

# Example: Run as Windows Desktop Application
flutter run -d windows
```

#### Hot Reload & Hot Restart:
- Press `r` in the terminal to **Hot Reload** (instant state-preserving UI update).
- Press `R` in the terminal to **Hot Restart** (resets state and re-executes `main()`).
- Press `q` to quit the running session.

---

## 🌐 Backend API Configuration

The app operates seamlessly in **offline/standalone mode** using seed data, and is also fully wired to connect to a MoneyPilot REST API server.

### Default Platform Endpoints

Defined in [`lib/core/constants/api_endpoints.dart`](file:///lib/core/constants/api_endpoints.dart):

| Platform | Default Base URL | Note |
|---|---|---|
| **Android Emulator** | `http://10.0.2.2:5000` | Resolves to host machine's `localhost` |
| **iOS Simulator** | `http://127.0.0.1:5000` | Standard local loopback |
| **Web / Desktop** | `http://127.0.0.1:5000` | Localhost |
| **Physical Device** | `http://<YOUR_LAN_IP>:5000` | Replace with your computer's local Wi-Fi IP |

### Overriding the Base URL at Runtime

You can dynamically update the backend endpoint in code:

```dart
import 'package:moneypilot_mobile/core/constants/api_endpoints.dart';

// Set custom API host
ApiEndpoints.setBaseUrl('https://api.moneypilot.example.com');
```

---

## 🧪 Running Tests & Code Quality

### Run All Unit and Widget Tests

MoneyPilot comes with automated test suites covering currency formatters, category mappers, budget operations, and end-to-end tab navigation:

```bash
flutter test
```

### Run Static Analysis

Ensure code follows Flutter linting rules and best practices:

```bash
flutter analyze
```

---

## 📦 Building Production Artifacts

### Android

#### Build Release APK:
```bash
flutter build apk --release
```
The output APK will be generated at:  
`build/app/outputs/flutter-apk/app-release.apk`

#### Build Release App Bundle (Google Play Store):
```bash
flutter build appbundle --release
```
The output bundle will be generated at:  
`build/app/outputs/bundle/release/app-release.aab`

### Web

```bash
flutter build web --release
```
The output web files will be generated at: `build/web/`

### Windows Desktop

```bash
flutter build windows --release
```

---

## 🔧 Troubleshooting

<details>
<summary><b>1. Android Emulator cannot reach local backend</b></summary>

Android emulators cannot connect to `http://localhost:5000` directly. Always use `http://10.0.2.2:5000` which maps to your host machine's loopback interface. If using a physical device, make sure both your computer and phone are connected to the same Wi-Fi network, and use your computer's LAN IP (e.g. `http://192.168.1.50:5000`).
</details>

<details>
<summary><b>2. Dependencies conflict or stale build cache</b></summary>

Run the following commands to clean the build cache and fetch dependencies afresh:
```bash
flutter clean
flutter pub get
```
</details>

<details>
<summary><b>3. Missing Android SDK or licenses</b></summary>

Accept Android licenses by executing:
```bash
flutter doctor --android-licenses
```
</details>

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
