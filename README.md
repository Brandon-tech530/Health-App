# 🏥 Health App

A cross-platform **Flutter healthcare companion** that centralizes emergency services, real-time location sharing, appointment tracking, medical provider discovery, and personal profile tools.

Designed for **Android, iOS, Web, and Desktop**, the app uses **Provider** state management, **Flutter Map** for geolocation visualization, and integrates tightly with device capabilities such as telephony, GPS, and emergency workflows.

---

## 📑 Table of Contents
- [Features](#features)
- [Architecture Overview](#architecture-overview)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
  - [Running Tests](#running-tests)
- [Key Workflows](#key-workflows)
  - [Navigating the App](#navigating-the-app)
  - [Working with Location Services](#working-with-location-services)
  - [Triggering Emergency Workflows](#triggering-emergency-workflows)
  - [Managing Bookings](#managing-bookings)
- [Configuration Notes](#configuration-notes)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## ✅ Features

### Core Modules
- Five primary modules accessible via a curved bottom navigation bar:
  - Map
  - Emergency
  - Home Dashboard
  - Bookings
  - Settings

### Real-Time Geolocation & Reporting
- Requests location permissions
- Retrieves user location via `geolocator`
- Displays OpenStreetMap tiles using `flutter_map`
- Allows users to report their current coordinates

### Emergency Assistance Center
- Central glowing “Emergency Alert”
- Quick-access actions for:
  - Medical help
  - Ambulance
  - Police
  - Fire services
- Direct calling via `url_launcher`

### Care Discovery Dashboard
- Displays doctor on duty
- Searchable medical services
- Notification panel
- Direct-call tools
- Scrollable services catalog

### Appointment Tracking
- Bookings stored in a Provider-backed database
- Displayed as cards with interaction options
- Empty state advertises hospital slots

### Patient Profile & Settings
- View/edit details
- Toggle dark mode
- Notification and privacy settings

---

## 🏗 Architecture Overview

- **State Management:** Provider (`ChangeNotifier`)
- **Modules:** Map, Home, Emergency, Bookings, Settings, Profile
- **Reusable Components:** Alerts, search bars, cards, calendars
- **Native Integrations:**  
  - `geolocator` — device location  
  - `flutter_map` — map rendering  
  - `url_launcher` — external calls  
  - `avatar_glow` — UI feedback

 
---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK **3.7+**
- Dart SDK ^3.7.0
- IDE: VS Code / Android Studio
- Platform tooling:
  - Android → SDK 33+
  - iOS → Xcode 15+
  - Web/Desktop → Chrome or supported OS

---

### Installation

```bash
git clone <repo-url>
cd Health-App
flutter pub get


The architecture separates presentation, components, and state for increased maintainability and testing.

---

## 📁 Project Structure

