# 🩺 Prenatal Care App

A comprehensive Flutter application for prenatal care management with support for iOS & Android, multi-language support (Arabic & English), and dual role support for patients and healthcare providers.

## 📋 Features

### Patient Features
- **Pregnancy Tracking**: Monitor gestational age, EDD, and trimester progression
- **Prenatal Visits**: Track 11 scheduled prenatal visits following Barwon Health Protocol
- **Health Metrics**: BMI tracking, weight monitoring, vital signs recording
- **Investigation Results**: Store and view lab test results with clinical advice
- **Birth Planning**: Create and track birth plan preferences
- **Postpartum Care**: Track postpartum health and recovery

### Doctor Features
- **Patient Management**: View and manage assigned patients
- **Visit Scheduling**: Schedule and track prenatal visits
- **Investigation Tracking**: Record and review patient test results
- **Clinical Advice**: Provide recommendations based on pregnancy stage
- **Birth Records**: Document delivery details and APGAR scores

## 🏗️ Architecture

```
prenal_care_app/
├── lib/
│ ├── core/
│ │ ├── models/           # Data models
│ │ ├── constants/        # App constants & visit schedules
│ │ ├── utils/            # Utilities (pregnancy calculator)
│ │ └── services/         # Firebase & API services
│ ├── features/           # Feature modules
│ │ ├── auth/
│ │ ├── home/
│ │ ├── prenatal/
│ │ ├── birth/
│ │ ├── postpartum/
│ │ ├── alerts/
│ │ └── profile/
│ ├── shared/             # Shared widgets & theme
│ └── l10n/               # Localization files
```

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0+
- Dart 3.0+
- iOS 12.0+ / Android API 21+

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/prenatal_care_app.git
cd prenatal_care_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
   - Add `google-services.json` (Android)
   - Add `GoogleService-Info.plist` (iOS)

4. **Run the app**
```bash
flutter run
```

## 📦 Core Models

### PatientModel
- Patient demographics and medical history
- Pregnancy tracking (LMP, EDD, gestational age)
- BMI calculation and health metrics
- Doctor assignment

### DoctorModel
- Provider details and specialty
- Clinic information
- Assigned patient list

### VisitModel
- Prenatal visit scheduling and tracking
- Investigation results storage
- Clinical advice and notes

### BirthModel
- Labour and delivery details
- APGAR scoring
- Baby vitals (weight, length)
- Birth type documentation

## 📐 Key Utilities

### PregnancyCalculator
- Gestational age calculation from LMP
- EDD (Estimated Due Date) computation using Naegele's rule
- BMI and weight gain recommendations
- Trimester determination
- Date formatting utilities

## 🌍 Localization

Supported languages:
- 🇺🇸 English
- 🇸🇦 Arabic

Add more languages by creating `.arb` files in `lib/l10n/`

## 🎨 Theming

- Primary Color: Deep Purple
- Trimester-specific colors (Green, Blue, Orange)
- Status indicators (Success, Warning, Error, Info)
- BMI category colors (Underweight, Normal, Overweight, Obese)

## 🔧 Technology Stack

- **Flutter**: UI Framework
- **Firebase**: Backend & Authentication
- **Provider**: State Management
- **Firestore**: Database
- **Intl**: Localization
- **Table Calendar**: Calendar widget
- **FL Chart**: Charts & graphs

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📧 Contact

For questions or support, please contact [your-email@example.com]

---

**Branch**: initial-setup
**Created**: 2026-05-08
