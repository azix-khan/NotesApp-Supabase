# Flutter Notes App Using Supabase

A modern, full-stack Notes application built with **Flutter** and **Supabase**. This project demonstrates how to implement a robust authentication flow, real-time database updates, and cloud storage for image attachments.

## 🚀 Features

- **Supabase Authentication**: Secure Email & Password sign-up and login.
- **Real-time Database**: Automatic UI updates whenever notes are added, edited, or deleted.
- **Image Attachments**: Upload and host images using Supabase Storage.
- **Clean Architecture**: Organized into Models, Services, and Auth Gates for scalability.
- **Responsive UI**: Built with Flutter for a smooth cross-platform experience.

## 🛠️ Tech Stack

- **Frontend**: Flutter
- **Backend-as-a-Service**: [Supabase](https://supabase.com/)
- **State Management**: StreamBuilder (Real-time updates)
- **Media**: Image Picker for gallery/camera access

## 📋 Prerequisites

- Flutter SDK (latest version)
- A Supabase account

## ⚙️ Setup Instructions

### 1. Supabase Backend Setup

#### Database Table
Create a table named `notes` with the following schema:
- `id`: int8 (Primary Key, Auto-increment)
- `content`: text (Required)
- `image_url`: text (Optional)
- `created_at`: timestamptz (Default: now())

#### Storage Bucket
Create a **Public** storage bucket named `images` to host note attachments.

#### Enable Realtime
Ensure you go to **Database > Replication** and enable the `notes` table for the `supabase_realtime` publication.

### 2. Configure Your App
Update `lib/main.dart` with your unique Supabase credentials:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### 3. iOS Configuration
Add the following keys to your `ios/Runner/Info.plist`:
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Allow access to photos to upload images to notes</string>
<key>NSCameraUsageDescription</key>
<string>Allow access to camera to capture images for notes</string>
```

## 🏗️ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/notes_supabase.git
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Connect with Me

I'm **Azix Khan**, a passionate Flutter Developer specialized in building high-performance, real-time applications with Supabase. If you're looking for a developer who can transform complex ideas into seamless mobile experiences, let's talk!

- **Portfolio**: [azix-khan.github.io](https://azix-khan.github.io)
- **LinkedIn**: [linkedin.com/in/azixkhan](https://www.linkedin.com/in/azixkhan)
- **Email**: [azixkhan.55@gmailcom](azixkhan.55@gmailcom)

*Whether it's a new project, a collaboration opportunity, or just a technical chat about Flutter—feel free to reach out!*
