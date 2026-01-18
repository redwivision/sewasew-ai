# Sewasew AI (ሰዋሰው AI)

Sewasew AI is a mobile AI assistant designed to work naturally in Amharic, with seamless support for English and bilingual (Amharic + English) conversations.

The app focuses on users who are underserved by existing AI tools due to language barriers, offering an experience that feels local, accessible, and simple.

## Core Purpose

Most AI chat apps prioritize English. Sewasew AI flips that priority by making Amharic a first-class language, not an afterthought.

## Key Features

### 🗣️ Multilingual AI Chat
- Chat naturally in Amharic, English, or both
- Language mode can be switched at any time
- Responses are adapted based on the selected language preference

### 💬 Clean, Focused Chat Experience
- Minimal, distraction-free chat UI
- Typing indicators and smooth message flow
- Designed for clarity and ease of use

### 📚 AI Practice Hub
- **Practice Scenarios**: Launch dynamic roleplays (Markey, Grammar, Quiz).
- **Translations**: Integrated AI translation tools.
- **Progress**: Track your learning journey.

### 🌍 Offline-Friendly Design
- Graceful handling of no-internet situations
- Clear feedback instead of crashes
- Local preferences saved on device

### ⚡ Lightweight & Private
- No accounts required
- No data stored on servers
- Designed for closed testing and personal use
- **Bring Your Own Key**: Configure your own Gemini API key in Settings.

## Technical Info
- **Tech Stack**: Flutter 3.x
- **AI Model**: Gemini 1.5 Flash (via Google Generative AI)
- **State Management**: Provider
- **Storage**: SharedPreferences

## Getting Started
1. Clone the repo.
2. Run `flutter pub get`.
3. Build apk: `flutter build apk --release`.
