NoteApp

A modern Flutter note-taking application designed to provide a simple, secure, and customizable way to create and manage notes.

About The Project

NoteApp is a Flutter-based note-taking application integrated with Firebase for storing and managing user notes.

The app provides a simple and eye-friendly user interface with multiple languages and customizable themes. It also includes additional features such as PIN protection, image attachments, image upload, audio recording, audio playback, note search, secure local storage, and note sharing.

The project follows a feature-based Clean Architecture structure to improve code organization, separation of concerns, maintainability, and scalability.

Features
Create, edit, and delete notes
Firebase Firestore integration
Firebase Storage integration
Multiple language support
Light, Dark, and Sepia themes
PIN protection for notes
Image picker and image attachments
Image upload and management
Audio recording
Audio playback
Secure local storage
Search notes
Share notes
Custom fonts using Google Fonts
Clean and eye-friendly UI
Reusable widgets
Feature-based project structure
Separation of presentation, domain, and data layers
Technologies
Flutter
Dart
Flutter Localizations
Intl
Firebase Core
Cloud Firestore
Firebase Storage
Provider
Google Fonts
Image Picker
Record
AudioPlayers
Just Audio
Path Provider
Flutter Secure Storage
Share Plus
HTTP
Project Structure
lib/
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
Architecture

The project follows a feature-based Clean Architecture approach.

Each feature is organized into three main layers:

Presentation
      ↓
Domain
      ↓
Data

This structure helps separate the user interface, business logic, and data sources, making the application easier to maintain, test, and scale.

UI & Design

The application follows a simple and eye-friendly design approach.

The UI focuses on:

Simple and intuitive user experience
Clean layouts
Consistent spacing and typography
Clear navigation
Reusable components
Light, Dark, and Sepia themes
Comfortable and customizable visual experience
Security

NoteApp uses Flutter Secure Storage to securely store sensitive local information such as PIN-related data.

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
