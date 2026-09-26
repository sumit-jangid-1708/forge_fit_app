# ForgeFit App 🏋️‍♂️

ForgeFit is a modern, high-performance fitness and activity tracking application built with Flutter. It helps users monitor their daily activity, set fitness goals, and track their progress with a clean and intuitive interface.

## 🚀 Key Features

*   **Secure Authentication**:
    *   Email & Password sign-in/sign-up.
    *   **Google Sign-In** integration for quick access.
    *   Multi-step Forgot Password flow.
*   **Activity Tracking**:
    *   Real-time **Step Counter** with goal progress.
    *   Calculates distance covered (KM), calories burned (Kcal), and active time (Min).
    *   Hourly activity charts for detailed analysis.
*   **Personalization**:
    *   Custom onboarding to set fitness goals.
    *   Adjustable daily step goals.
*   **Modern Architecture**:
    *   State management and routing using **GetX**.
    *   Fast local data persistence using **Hive**.
    *   Clean UI with custom-built widgets and consistent design tokens.

## 🛠 Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/)
*   **State Management**: [GetX](https://pub.dev/packages/get)
*   **Backend/Auth**: [Firebase](https://firebase.google.com/) (Auth, Core, Messaging)
*   **Local Database**: [Hive](https://pub.dev/packages/hive)
*   **UI Components**: Pinput, Custom Painters, GetX Localization.

## ⚙️ Setup Instructions

### Prerequisites
*   Flutter SDK (^3.11.5)
*   Firebase Project

### Installation
1.  **Clone the repo**:
    ```bash
    git clone https://github.com/your-username/forge_fit_app.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Firebase Setup**:
    *   Add your `google-services.json` to `android/app/`.
    *   Enable **Email/Password** and **Google** providers in Firebase Authentication.
    *   Add your **SHA-1** fingerprint to Firebase Project Settings for Google Sign-In to work.
4.  **Run the app**:
    ```bash
    flutter run
    ```

## 📸 Screenshots
*(Add your screenshots here)*

## 📄 License
This project is for private use as part of the ForgeFit development.
