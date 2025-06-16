# Ser Manos - Voluntariado App

![App Logo](assets/images/ser_manos.png) 

## Table of Contents

* [1. Introduction](#1-introduction)
* [2. Project Objective and Structure](#2-project-objective-and-structure)
* [3. Features Implemented](#3-features-implemented)
    * [3.1. Core Functional Requirements](#31-core-functional-requirements)
    * [3.2. Special Features](#32-special-features)
* [4. Technical Specifications and Decisions](#4-technical-specifications-and-decisions)
    * [4.1. Architecture and State Management](#41-architecture-and-state-management)
    * [4.2. Deep Links and Routing](#42-deep-links-and-routing)
    * [4.3. Backend Integration](#43-backend-integration)
    * [4.4. Testing Strategy](#44-testing-strategy)
    * [4.5. Monitoring and Events](#45-monitoring-and-events)
    * [4.6. Security and Portability](#46-security-and-portability)
    * [4.7. Data Models](#47-data-models)
    * [4.8. Project Structure](#48-project-structure)
    * [4.9. Dependencies (pubspec.yaml)](#49-dependencies-pubspecyaml)
* [5. Installation and Setup](#5-installation-and-setup)
* [6. Running the Application](#6-running-the-application)
* [7. Development Team](#7-development-team)
* [8. Acknowledgements](#8-acknowledgements)
* [9. License](#9-license)

---

## 1. Introduction

This repository contains the source code for **Ser Manos**, a cross-platform mobile application developed for the *73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma* course at ITBA. The application aims to connect users with volunteer opportunities near their location, allowing them to browse, search, and apply for volunteer activities.

## 2. Project Objective and Structure

The primary objective of Ser Manos is to develop a user-friendly cross-platform mobile application that enables users to easily find and apply for volunteer opportunities based on their location and interests, following robust UX/UI design patterns.


## 3. Features Implemented

### 3.1. Core Functional Requirements

The application includes the following core functionalities:

* **User Authentication:** Users can register and log in using their email and password.
* **Cross-Platform Compatibility:** The app functions correctly on both Android and iOS devices, ensuring a consistent user experience across platforms.
* **Volunteer Opportunity Exploration:** Users can browse available volunteer opportunities. Each opportunity includes:
    * An image
    * Volunteer type (e.g., social action)
    * Title
    * Mission/Purpose
    * Activity details
    * Geographical coordinates for location
    * Address
    * Rich text requirements for participation (supporting Markdown)
    * Creation date
    * Available slots
    * Opportunities are ordered by proximity to the user (if location access is granted) and by creation date (newest to oldest).
    * Users can mark volunteer opportunities as favorites, which are persisted in the backend.
    * Location icons within volunteer cards can open Google Maps via a deep link with the selected coordinates.
    * Volunteer opportunities can be searched by title, mission/purpose, and activity details.
* **Volunteer Opportunity Details:** Users can view detailed information about each volunteer opportunity. There is a tappable map widget that will open the device's native map application with the selected coordinates. 
* **Volunteer Application:** Users can apply for volunteer opportunities of interest. Applications are only possible if the user's profile is complete, they are not currently applied to another volunteer opportunity, and there are available slots.
* **User Profile:** Users can view and complete their profile.
* **News Section:** Users can view a list of news items, ordered by creation date. News items can be shared, including the news image and subtitle.
* **Maps Integration:** Users can access directions on how to get to the volunteer location using the users native maps application.

### 3.2. Special Features

As per the assignment, our group implemented the following two special functionalities:

* **3.2.1. Real-Time Updates:**
    * **Description:** The application receives real-time updates. The UI is updated immediately to reflect these changes. This ensures users always see the most accurate information regarding availability.
    * **Technical Implementation and Decisions:**
        * **Technology Choice:** We opted to use **Cloud Firestore** for real-time updates. Firestore's real-time listeners provide an efficient and scalable way to subscribe to changes in the database without complex server-side implementation for push notifications or WebSockets. This aligns with Flutter's reactive programming paradigm.
        * **Integration:** We set up listeners on relevant Firestore collections (e.g., `voluntariados`) to detect changes in the `vacantes` field. When a change occurs, the UI components observing this data are automatically rebuilt. This same pattern is followed through the entire app.
        * **Observations:** We ensured no runtime polling is done so that the application does not overload the users device with tasks.

* **3.2.2. Push Notifications:**
    * **Description:** The application implements foreground push notifications with deep links for specific use cases:
        * Changes in volunteer application status (acceptance or rejection), linking to the volunteer opportunity details.
        * New news items, linking to the news detail.
    * **Technical Implementation and Decisions:**
        * **Technology Choice:** We leveraged **Firebase Cloud Messaging (FCM)** for sending push notifications and **`flutter_local_notifications`** for handling and displaying notifications in the foreground.
        * **Deep Linking:** We configured `go_router` to handle incoming deep links from the notifications. This allows users to directly navigate to the relevant screen within the app when they tap a notification.
        * **Implementation Details:**
            * FCM was set up to send messages from the backend (or a simulation for demonstration) when an application status changes or a new news item is published.
            * `flutter_local_notifications` intercepts these messages while the app is in the foreground and displays them as native-style notifications.
            * Custom payloads in the FCM messages contain the deep link path, which is then parsed by `go_router` to navigate to the correct screen.
        * **Argumentation:** FCM is the industry standard for push notifications with Firebase, offering reliability and scalability. 

Additionally, to get ahead of future workloads we also implemented Camera functionality

* **3.2.3. Camera:**
    * **Description:** The application allows users to update their profile picture using the native device camera or by selecting an image from the device’s file system. This provides a personalized user experience and aligns with modern app standards where profile customization is expected.
    * **Technical Implementation and Decisions:**
        * **Technology Choice:** We utilized the `image_picker` Flutter plugin, which provides a unified API for accessing both the device camera and gallery across iOS and Android platforms.
        * **Integration:** A modal bottom sheet is presented when the user opts to update their profile picture. It gives the option to either take a new photo using the camera or choose an existing one from the gallery. Upon selection, the image is compressed and uploaded to Firebase Storage, and the resulting download URL is saved to the user's profile document in Cloud Firestore.
        * **Implementation Details:**
            * Permissions for camera and storage access are handled gracefully, using platform-specific permission prompts.
            * The selected image is previewed before confirmation, giving users the opportunity to cancel or retake.
            * After upload, the app updates the UI reactively using Riverpod to reflect the new profile image.


## 4. Technical Specifications and Decisions

This section outlines the technical architecture, key decisions, and libraries used in the development of Ser Manos.

### 4.1. Architecture and State Management

* **Decision:** We adopted a **Riverpod-based architecture** for state management, combined with `flutter_hooks` for managing widget lifecycle and local state. This aligns with the requirement to implement a state management system using libraries seen in class.
* **Argumentation:** Riverpod was chosen over other state management solutions for its compile-time safety, explicit dependency declaration, and testability. It eliminates common pitfalls associated with `BuildContext` and allows for robust, scalable state management throughout the application. `flutter_hooks` complements Riverpod by simplifying widget logic and reducing boilerplate.

### 4.2. Deep Links and Routing

* **Decision:** We implemented a comprehensive routing system using **`go_router`**. This library facilitates both internal navigation and external deep linking capabilities. This fulfills the requirement to implement a routing system for correct deep linking usage.
* **Argumentation:** `go_router` was selected for its declarative routing approach, support for nested routes, and its excellent integration with deep linking. This allowed us to easily handle incoming links from notifications and other external sources, providing a seamless user experience.

### 4.3. Backend Integration

* **Decision:** The application integrates with a **Firebase backend**, specifically utilizing **Firebase Authentication**, **Cloud Firestore**, and **Firebase Storage**. This meets the requirement for integration with a backend containing information about volunteers, news, users, and their interactions.
* **Argumentation:** Firebase was chosen for its comprehensive suite of services that align perfectly with the application's requirements (user authentication, real-time database, file storage). Its ease of integration with Flutter via official SDKs significantly accelerated development.
    * **Firebase Authentication** handles user registration and login securely.
    * **Cloud Firestore** persists volunteer opportunities, user profiles, news, and user interactions (e.g., favorites). It also powers the real-time updates for volunteer vacancies.
    * **Firebase Storage** is used for storing images associated with volunteer opportunities and user profile pictures.

### 4.4. Testing Strategy

* **Decision:** The project incorporates both **unit tests** and **golden tests**. This fulfills the requirement to write both unit and golden tests for delivery.
* **Argumentation:**
    * **Unit Tests:** Unit tests were implemented to validate models, JSON converters, Riverpod providers, and Firebase-integrated services. These tests cover key business logic such as postulations, likes, login functionality, and provider state changes. Firebase behavior was simulated using mock and fake libraries including `fake_cloud_firestore`, `firebase_auth_mocks`, and `firebase_storage_mocks`. According to the LCOV report, the test suite achieves 68% total coverage. Specifically, models and converters reached 100%, Firebase services approximately 71%, and providers around 52%.
    * **Golden Tests:** Implemented to verify the visual integrity of UI components across different platforms and screen sizes. This ensures a consistent user experience and adherence to the design system.

### 4.5. Monitoring and Events

### 4.5. Monitoring and Events

* **Decision:**  
  The application integrates **Firebase Crashlytics** and **Firebase Analytics** to ensure robust error monitoring and comprehensive user behavior tracking.

* **Argumentation:**
    * **Firebase Crashlytics:**  
      Provides real-time crash reporting, enabling the development team to detect, investigate, and resolve issues that occur in production. With crash data (e.g., `app_exception`, `auth_error`), we can prioritize bug fixes based on frequency and impact, significantly improving app stability and user experience.
    * **Firebase Analytics:**  
      Enables the collection of detailed insights into user interactions and navigation flows throughout the app. By tracking custom and automatic events, we are able to better understand what users do, how they engage with key features, and where they may drop off. The following user actions are being tracked as key indicators of engagement and feature usage:
        1. **Volunteer Application**  
           Tracks when a user successfully applies for a volunteer opportunity.  
           This helps assess engagement with the core functionality of the platform and identify which types of opportunities users respond to the most.

        2. **Screen View**  
           Automatically records when a user navigates to a screen (e.g., `EntryScreen`, `VolunteeringsTab`, `ProfileTab`).  
           This data is used to analyze user flows, discover which features are most accessed, and improve the visibility or UX of underutilized sections.

        3. **Like Toggle Count**  
           Logs every time a user taps the like button on a volunteering opportunity.  
           These interactions reflect user preferences, allowing us to surface popular content and enhance recommendation strategies in the future.

### 4.6. Security and Portability

* **Security:** The application utilizes secure communication protocols. API Keys are not exposed in the repository, and the application is kept updated with the latest SDK releases to mitigate security vulnerabilities.
* **Portability:** The codebase is designed to be easily adaptable to different platforms (Android and iOS) without significant changes, leveraging Flutter's inherent cross-platform capabilities.
* **Privacy:** On iOS, the application requests necessary permissions for App Tracking Transparency to comply with privacy guidelines for event tracking.

### 4.7. Data Models

The application utilizes three main data models, implemented using `freezed` for immutability and `json_serializable` for JSON serialization/deserialization. These models can be found in the `lib/models/` directory.

* **User Model (`user.dart`):** Represents the application user and their volunteer-related states.
    ```pseudocode
    enum VoluntariadoUserState { ... } // States related to user's volunteer participation

    class UserVoluntariado {
        id: String
        estado: VoluntariadoUserState
    }

    class User {
        id: String
        nombre: String
        apellido: String
        email: String
        hasSeenOnboarding: Bool (optional)
        voluntariados: List<UserVoluntariado> (optional) // List of volunteer opportunities the user is associated with
        likedVoluntariados: List<String> (optional)    // IDs of favorite volunteer opportunities
        telefono: String (optional)
        fechaNacimiento: DateTime (optional)
        genero: String (optional)
        imagenUrl: String (optional)
        fcmToken: String (optional) // Firebase Cloud Messaging token for push notifications
    }
    ```

* **Novedad (News) Model (`novedad.dart`):** Represents a news item.
    ```pseudocode
    class Novedad {
        id: String
        titulo: String
        resumen: String
        emisor: String
        imagenUrl: String
        descripcion: String
    }
    ```

* **Voluntariado (Volunteer Opportunity) Model (`voluntariado.dart`):** Represents a volunteer opportunity.
    ```pseudocode
    enum VoluntariadoStatus { ... } // States related to a volunteer opportunity's status

    class Voluntariado {
        id: String
        nombre: String
        tipo: String
        vacantes: int
        location: LatLng // Geographical coordinates (uses custom converter for Firestore)
        imageUrl: String
        descripcion: String
        resumen: String
        requisitos: String // Markdown-formatted text for requirements
    }
    ```

### 4.8. Project Structure

The `lib` directory is organized as follows:

```
.
├── assets                 # Static assets like images and icons
├── converters             # Custom type converters for data serialization
│   ├── geoPoint_converter.dart
│   └── latlng_converter.dart
├── firebase_options.dart  # Firebase configuration file
├── main.dart              # Main entry point of the Flutter application
├── models                 # Data models for User, Novedad, and Voluntariado, including generated Freezed and JSON files
│   ├── novedad.dart
│   ├── novedad.freezed.dart
│   ├── novedad.g.dart
│   ├── user.dart
│   ├── user.freezed.dart
│   ├── user.g.dart
│   ├── voluntariado.dart
│   ├── voluntariado.freezed.dart
│   └── voluntariado.g.dart
├── providers              # Riverpod providers for state management and data exposure
│   ├── auth_provider.dart
│   ├── home_providers.dart
│   ├── novedad_provider.dart
│   ├── user_provider.dart
│   └── voluntariado_provider.dart
├── router                   # Application routing configuration
│   ├── app_router.dart
│   └── go_router_observer.dart
├── services                 # Business logic and interactions with backend services (Firebase)
│   ├── auth_service.dart
│   ├── fcm_token_service.dart
│   ├── notification_service.dart
│   ├── novedad_service.dart
│   ├── user_service.dart
│   └── voluntariado_service.dart
└── shared                   # Reusable UI components and design system tokens
├── atoms                # Smallest, indivisible UI elements (e.g., icons, text)
│   ├── icons
│   │   ├── _app_icon.dart
│   │   └── app_icons.dart
│   └── symbols
│       ├── app_symbol_text.dart
│       └── app_wordmark.dart
├── cells                # Combinations of atoms forming self-contained UI components (e.g., cards, forms)
│   ├── cards
│   │   ├── card_foto.dart
│   │   ├── card_informacion.dart
│   │   ├── card_input.dart
│   │   ├── card_novedades.dart
│   │   ├── card_voluntariado.dart
│   │   └── card_voluntariado_actual.dart
│   ├── forms
│   │   ├── contact_data.dart
│   │   ├── login.dart
│   │   ├── personal_data.dart
│   │   └── register.dart
│   ├── header
│   │   ├── header.dart
│   │   ├── header_modal.dart
│   │   └── header_seccion.dart
│   └── modals
│       └── confirm_modal.dart
├── molecules            # Groups of atoms and/or cells functioning as a unit (e.g., buttons, input fields)
│   ├── buttons
│   │   ├── app_button.dart
│   │   ├── floating_button.dart
│   │   └── short_button.dart
│   ├── components
│   │   ├── foto_perfil.dart
│   │   └── vacants.dart
│   ├── input
│   │   ├── app_text_field.dart
│   │   ├── form_builder_app_text_field.dart
│   │   ├── form_builder_date_field.dart
│   │   ├── form_builder_password_field.dart
│   │   └── search_field.dart
│   ├── status_bar
│   │   └── status_bar.dart
│   └── tabs
│       └── tab.dart
├── todo_list.md         # Development TODO list
├── tokens               # Design system constants (colors, typography, spacing)
│   ├── border_radius.dart
│   ├── colors.dart
│   ├── grid.dart
│   ├── shadow.dart
│   └── typography.dart
├── widgets              # General purpose widgets
└── wireframes           # Page-level compositions of components
├── error
│   └── error_page.dart
├── home
│   ├── voluntariado_list.dart
│   ├── voluntariado_map_background.dart
│   └── voluntariados_page.dart
├── ingreso
│   ├── entry_page.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   └── welcome_page.dart
├── novedades
│   ├── novedad.dart
│   ├── novedad_detail.dart
│   └── novedades.dart
├── perfil
│   ├── editar_perfil.dart
│   ├── perfil_completo.dart
│   ├── perfil_incompleto.dart
│   └── perfil_wrapper.dart
└── voluntariados
└── voluntariado.dart
```

## 4.9. Dependencies (`pubspec.yaml`)

The following key dependencies were used in this project to enable scalable architecture, native device integration, Firebase backend services, and strong development tooling.

### Architecture & State Management
- `flutter_hooks`: Hook-based widget lifecycle and state handling.
- `flutter_riverpod`, `hooks_riverpod`: Robust, testable, and reactive state management.
- `go_router`: Declarative routing with built-in deep linking support.

### Firebase Integration
- `firebase_core`: Initializes Firebase.
- `firebase_auth`: User authentication.
- `cloud_firestore`: Real-time database.
- `firebase_storage`: Uploading and retrieving media.
- `firebase_messaging`: Push notification handling.
- `firebase_analytics`: Tracking user behavior.
- `firebase_crashlytics`: Real-time crash reporting.

### Device Access & Media
- `image_picker`: Allows users to take or select a photo for their profile.
- `permission_handler`: Manages runtime permissions (camera, storage, etc.).
- `path`, `path_provider`: For local file management.

### Maps & Navigation
- `google_maps_flutter`: Native Google Maps widget (not used but required for future maps integration).
- `maps_launcher`: Opens coordinates in native map apps.
- `url_launcher`: Opens external links (browser, phone, etc.).

### UI & Visuals
- `flutter_svg`: Renders SVG assets.
- `flutter_markdown`: Displays Markdown text (e.g., volunteer descriptions).
- `cached_network_image`: Efficient image caching and loading.
- `intl`: Date and number formatting (localized).
- `cupertino_icons`: iOS-style icons.
- `flutter_local_notifications`: Handles foreground push notifications.

### Forms & Input
- `flutter_form_builder`: Advanced form generation.
- `form_builder_validators`: Built-in validation rules (email, required, etc.).

### Sharing & External Actions
- `share_plus`: Native share dialogs for news or volunteer opportunities.

### Development & Testing
- `flutter_test`, `test`: Standard Flutter testing.
- `mockito`: Mocking dependencies in unit tests.
- `fake_cloud_firestore`, `firebase_auth_mocks`, `firebase_storage_mocks`: Mock Firebase services.
- `golden_toolkit`: Snapshot (golden) testing for widgets.
- `flutter_lints`: Static analysis and best practices.
- `build_runner`, `freezed`, `json_serializable`: Code generation for data classes and serialization.


These dependencies enable us to meet both functional requirements (like push notifications and real-time updates) and non-functional goals (maintainability, scalability, testability).

## 5. Installation and Setup

To set up the project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/ser_manos.git](https://github.com/your-username/ser_manos.git)
    cd ser_manos
    ```

2.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration:**
    * Follow the official Firebase documentation to set up a new Firebase project.
    * Add your Android and iOS apps to the Firebase project.
    * Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the correct directories:
        * `android/app/google-services.json`
        * `ios/Runner/GoogleService-Info.plist`
    * Ensure your Firebase project is configured for **Firebase Authentication**, **Cloud Firestore**, **Firebase Storage**, **Firebase Cloud Messaging**, **Firebase Analytics**, and **Firebase Crashlytics**.

4.  **Code Generation:**
    * Run the build runner to generate necessary files (e.g., for `freezed`, `json_serializable`):
        ```bash
        flutter pub run build_runner build --delete-conflicting-outputs
        ```

## 6. Running the Application

To run the application on a simulator or physical device:

1.  **Ensure you have a device or emulator running.**
2.  **Run the app:**
    ```bash
    flutter run
    ```

## 7. Development Team

* [Iñaki Bengolea](https://github.com/meursault00)
* [Agustin Gutierrez](https://github.com/AgustinGuti)
* [Christian Ijjas](https://github.com/cijjas)

## 8. Acknowledgements

* **ITBA** for providing the special practical assignment and guidance for *Desarrollo de Aplicaciones Móviles Multiplataforma*.
* The tutors for their invaluable support and feedback throughout the course:
    * [FrBernad](https://github.com/FrBernad)
    * [glpecile](https://github.com/glpecile)
    * [NicolasRampoldi](https://github.com/NicolasRampoldi)
* The open-source community.

## 9. License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---