NoteApp

A modern Flutter note-taking application designed to provide a simple, secure, and customizable experience for creating and managing notes.

About The Project

NoteApp is a Flutter-based note-taking application integrated with Firebase for reliable cloud data management.

The application focuses on providing a clean, simple, and eye-friendly user interface while maintaining a structured and scalable codebase.

Users can create and manage notes, attach images, record and play audio, search through their notes, protect notes with a PIN, customize the application theme, change the application language, and share their notes.

The project was also structured using Clean Architecture principles to improve separation of concerns, maintainability, and scalability.

Features
Create, edit, and delete notes
Firebase Firestore integration
Firebase Storage integration
Image attachments
Image upload and management
Audio recording
Audio playback
Search notes
Share notes
PIN protection
Secure local storage
Multiple language support
Light, Dark, and Sepia themes
Custom fonts using Google Fonts
Clean and modular UI
Reusable widgets
Feature-based project structure
Separation of presentation, domain, and data layers
Technologies & Packages
Core
Flutter
Dart
Flutter Localizations
Intl
Firebase
Firebase Core
Cloud Firestore
Firebase Storage
State Management
Provider
Media
Image Picker
Record
AudioPlayers
Just Audio
Path Provider
Storage & Sharing
Flutter Secure Storage
Share Plus
Networking
HTTP
UI & Design
Google Fonts
Custom Themes
Responsive and user-friendly UI
Architecture

The project follows a feature-based Clean Architecture approach.

Each major feature is separated into:

Presentation
    ↓
Domain
    ↓
Data

This separation helps keep the UI, business logic, and data access independent from each other.

Project Structure
lib/
│
├── core/
│   ├── constant/
│   ├── localization/
│   ├── routes/
│   ├── theme/
│   ├── utils/
│   └── widget/
│
├── data/
│   └── services/
│
├── features/
│   │
│   ├── addNote/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── repositories/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── provider/
│   │
│   ├── language/
│   │   └── presentation/
│   │
│   ├── noteDetails/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── notes/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── pinscreen/
│   │   └── presentation/
│   │
│   ├── search/
│   │   └── presentation/
│   │
│   ├── setting/
│   │   └── presentation/
│   │
│   ├── splashScreen/
│   │   └── presentation/
│   │
│   └── theme/
│       └── presentation/
│
├── app.dart
├── firebase_options.dart
└── main.dart
UI & Design

The application follows a simple and eye-friendly design philosophy.

The interface was designed to:

Keep the user experience simple and intuitive
Reduce visual complexity
Maintain consistent spacing and typography
Provide clear navigation
Support multiple themes
Provide comfortable light, dark, and sepia modes
Security

NoteApp uses Flutter Secure Storage for storing sensitive local information such as PIN-related data.

Firebase is used for cloud-based note and media management.

Getting Started
Prerequisites

Make sure you have:

Flutter SDK
Dart SDK
Android Studio or VS Code
A Firebase project
Installation

Clone the repository:

git clone https://github.com/Rawan-Rizk-Ali/NoteApp.git

Navigate to the project:

cd NoteApp

Install dependencies:

flutter pub get

Run the application:

flutter run
GitHub

View the source code

License

This project was created as a Flutter application for learning, development, and portfolio purposes.
