Chat Application

## 🚀 Getting Started

This is a real-time chat application built with Flutter, allowing users to engage in private (one-to-one) and group chats. The app supports user authentication, real-time message updates, and a clean, responsive UI. It uses Supabase as the backend for data storage and real-time subscriptions, Riverpod for state management, and GoRouter for navigation.

## 🔧 Prerequisites

Flutter SDK: Version 3.0.0 or higher (tested with 3.22.2).
Dart: Included with Flutter (tested with Dart 3.4.3).
Supabase Account: Create a free account at Supabase and set up a project.
Git: To clone the repository.
A Code Editor: VS Code or Android Studio recommended.
A Device/Emulator: Android, iOS, or web emulator to run the app.

## 🛠️ Setup Instructions

1. Clone the Repository
Clone the public GitHub repository to your local machine:
git clone (https://github.com/sonika1206/chatApplication)
cd chat-app

2. Install Dependencies
Install the required Flutter packages:
flutter pub get

3. Configure Supabase

In your Supabase project, create the following tables:

  users:id (uuid, primary key)
  username (text, nullable)
  profile_photo_url (text, nullable)
  
  chats:id (uuid, primary key)
  chat_type (text, 'private' or 'group')
  name (text, nullable)

  chat_participants:chat_id (uuid, foreign key to chats.id)
  user_id (uuid, foreign key to users.id)
  
  messages:id (uuid, primary key)
  chat_id (uuid, foreign key to chats.id)
  sender_id (uuid, foreign key to users.id)
  content (text, nullable)
  timestamp (timestamp with time zone)
  
  Enable Row-Level Security (RLS) on all tables and set appropriate policies to allow authenticated users to read/write their own data.
  Copy your Supabase URL and Anon Key from the Supabase dashboard.
  Create a lib/config/supabase_config.dart file and add your credentials:const String supabaseUrl = 'your-supabase-url';
  const String supabaseAnonKey = 'your-supabase-anon-key';


4. Run the App

Ensure a device or emulator is connected.
Run the app:flutter run


The app will launch on your device/emulator. Sign up or log in to start chatting.

## 🧠 Architectural Decisions

  1. Framework: Flutter
  
  Reason: Flutter allows for cross-platform development with a single codebase, enabling the app to run on Android, iOS, and web. Its widget-based architecture makes building a responsive UI straightforward.
  Benefit: Faster development and consistent UI across platforms.
  
  2. State Management: Riverpod Generator
  
  Reason: Riverpod provides a robust, type-safe way to manage state in Flutter. It’s reactive and integrates well with Flutter’s widget tree, making it ideal for handling real-time data (e.g., chat messages, user data).
  Implementation:
  auth_provider.dart: Manages user authentication state.
  chat_provider.dart: Provides streams for chats, messages, and user details.
  Benefit: Simplifies state management and ensures the UI updates automatically when data changes.
  
  3. Backend: Supabase
  
  Reason: Supabase offers a PostgreSQL database with real-time subscriptions, authentication, and a simple REST API. It’s a great fit for a chat app requiring real-time updates and user management.
  Implementation:
  Real-time subscriptions for chats and messages using supabase.stream.
  Authentication using Supabase Auth for user sign-up/login.
  Benefit: Eliminates the need to build a custom backend, provides real-time capabilities out of the box.
  
  4. Navigation: GoRouter
  
  Reason: GoRouter provides a declarative routing system for Flutter, supporting deep linking, parameter passing, and navigation stack management.
  Implementation:
  Routes defined in router.dart (e.g., /login, /chat/:chatId).
  Passes Chat objects via the extra parameter to avoid redundant data fetching.
  Benefit: Clean navigation logic and easy route management.

## 📁 Folder Structure

  Structure:lib/
  ├── auth/
  │   ├── logic/
  │   │   └── auth_provider.dart
  |   |── model/
  │   │   └── auth_model.dart
  │   └── ui/
  │       ├── login_page.dart
  │       └── signup_page.dart
  ├── chat/
  │   ├── logic/
  │   │   ├── chat_provider.dart
  │   │   └── chat_service.dart
  │   ├── model/
  │   │   ├── chat_model.dart
  │   │   ├── message_model.dart
  │   │   └── user_details.dart
  │   └── ui/
  │       ├── widgets/
  |       |── profile_page.dart
  │       ├── chat_page.dart
  │       ├── chats_page.dart
  │       └── add_chat_page.dart
  ├── main.dart
  └── router.dart


Reason: Organizes code by feature (auth, chat) and separates logic, UI, and models for better maintainability.
Benefit: Scalable structure, easy to navigate and extend.

## ✅ Features
  
  🔐 User Authentication (Email + Password)
  🗨️ One-on-One Private Messaging
  👥 Group chatting
  🌙 Dark Mode Toggle
  🖼️ Chat Wallpapers (Per Chat Background Themes)
  ✏️ Editable Profile (Username, Bio, Profile Picture)
  📅 Timestamps for Each Message
  
## 🧑‍💻 Developer Features

  🧱 Modular Code Architecture with Riverpod & GoRouter
  🔄 Supabase Realtime Integration
  🗂️ Feature-Based Folder Structure
  🔐 Secure Auth with Supabase
  🧪 Unit and Widget Tests

## Future Improvements

  🔔 Push Notifications via Firebase Cloud Messaging (FCM)
  📷 Voice messaging
  🔴 Improve error handling for network failures.
  🧪 Add unit tests for providers and services.

## 🔗 Repository URL
The project is hosted on (https://github.com/sonika1206/chatApplication)

