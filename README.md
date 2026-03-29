# QBank (Question Paper Bank)

A lightweight Flutter + Firebase app for college students to share previous year question papers using **external PDF links** (Google Drive, etc.).

## Features

- Email/Password authentication (Firebase Auth)
- Upload paper metadata + PDF link to Cloud Firestore
- Filter papers by course, semester, and subject
- View papers list and open PDF links externally
- Search papers by subject/keyword
- Like and report actions (stored in Firestore)
- Dark mode support
- Bottom navigation
- Beginner-friendly code structure

## Project Structure

```text
qbank/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── models/
│   │   └── paper_model.dart
│   ├── providers/
│   │   └── auth_provider.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── firestore_service.dart
│   ├── utils/
│   │   └── validators.dart
│   ├── widgets/
│   │   └── paper_card.dart
│   └── screens/
│       ├── auth/
│       │   ├── auth_gate.dart
│       │   ├── login_screen.dart
│       │   └── register_screen.dart
│       ├── home/
│       │   ├── home_screen.dart
│       │   └── main_nav_screen.dart
│       ├── papers/
│       │   └── papers_list_screen.dart
│       ├── search/
│       │   └── search_screen.dart
│       └── upload/
│           └── upload_screen.dart
├── pubspec.yaml
└── README.md
```

## Setup Instructions (Step by Step)

### 1) Install Flutter
- Install Flutter SDK: https://docs.flutter.dev/get-started/install
- Verify:

```bash
flutter --version
flutter doctor
```

### 2) Create Firebase Project (Free tier)
1. Open Firebase Console and create project `qbank`.
2. Add **Android app** (and iOS optionally).
3. Enable **Authentication → Email/Password**.
4. Create **Cloud Firestore** in test mode first (then secure with rules).
5. No Firebase Storage is needed.

### 3) Connect Flutter to Firebase
1. Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

2. Run from project root:

```bash
flutterfire configure
```

3. This generates/updates `lib/firebase_options.dart` with real values.

### 4) Install dependencies

```bash
flutter pub get
```

### 5) Android setup for URL opening
Ensure `android/app/src/main/AndroidManifest.xml` allows internet access:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### 6) Run app

```bash
flutter run
```

---

## Firestore Data Model

Collection: `papers`

Example document:

```json
{
  "subject": "DBMS",
  "semester": 4,
  "course": "BSc CS",
  "year": "2024",
  "college": "ABC College",
  "pdfUrl": "https://drive.google.com/file/d/.../view",
  "likes": 0,
  "reportCount": 0,
  "reported": false,
  "keywords": ["dbms", "bsc", "cs", "2024", "abc", "college"],
  "userId": "firebase_uid",
  "createdAt": "server timestamp"
}
```

## Firestore Rules (Starter)

Use strict production rules based on your needs. Basic starter:

```txt
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /papers/{paperId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update: if request.auth != null;
      allow delete: if false;
    }
  }
}
```

## Notes for Beginners

- Use test users while developing.
- Search uses `keywords` array in each document.
- Keep all links in HTTPS format.
- Like/report are simple counter updates for learning.

