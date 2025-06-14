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
    * Opportunities can be ordered by proximity to the user (if location access is granted) and by creation date (newest to oldest).
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
    * **Unit Tests:** Developed to ensure the correctness of individual functions, methods, and Riverpod providers. This helps in maintaining code quality and preventing regressions.
    * **Golden Tests:** Implemented to verify the visual integrity of UI components across different platforms and screen sizes. This ensures a consistent user experience and adherence to the design system.

### 4.5. Monitoring and Events

* **Decision:** **Firebase Crashlytics** and **Firebase Analytics** are integrated for error monitoring and user metric tracking.
* **Argumentation:**
    * **Firebase Crashlytics:** Provides real-time crash reporting, allowing us to quickly identify and fix issues in production.
    * **Firebase Analytics:** Used to track key user actions and understand user behavior. We've selected the following 3 pertinent user actions for tracking:
        1.  **Volunteer Application (`volunteer_apply_event`):** Tracks when a user successfully applies for a volunteer opportunity. This metric is crucial for understanding user engagement with the core functionality.
        2.  **News Share (`news_share_event`):** Tracks when a user shares a news item. This helps assess the virality and reach of news content.
        3.  **Favorite Volunteer (`favorite_volunteer_event`):** Tracks when a user marks a volunteer opportunity as a favorite. This provides insight into popular opportunities and user preferences.

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

### 4.9. Dependencies (pubspec.yaml)

The following key dependencies were used in this project, many of which serve as future proof feature integration dependencies.

* `flutter_hooks`: For managing widget lifecycle and state with hooks.
* `flutter_riverpod`, `hooks_riverpod`: For robust state management.
* `go_router`: For declarative routing and deep linking.
* `http`: For making HTTP requests (if any direct API calls are made).
* `intl`: For internationalization and localization (though full i18n/l10n for cost and date fields were a special feature not chosen, `intl` was included for general date/number formatting).
* `flutter_svg`: For displaying SVG assets.
* `flutter_markdown`: For rendering rich text with Markdown for volunteer requirements.
* `cached_network_image`: For efficient image loading and caching.
* `Maps_flutter`: For displaying maps (if Google Maps special feature was chosen/implemented).
* `firebase_core`, `cloud_firestore`, `firebase_auth`, `firebase_analytics`, `firebase_crashlytics`, `firebase_storage`, `firebase_messaging`: Core Firebase SDKs for backend integration, analytics, crash reporting, storage, and messaging.
* `share_plus`: For sharing news content.
* `image_picker`: For allowing users to select profile pictures from their gallery or camera.
* `permission_handler`: For managing permissions (e.g., camera, location).
* `flutter_local_notifications`: For handling foreground push notifications.
* `flutter_form_builder`, `form_builder_validators`: For easily building and validating forms.
* `url_launcher`, `maps_launcher`: For launching external URLs and map applications.
* `freezed_annotation`, `json_annotation`, `freezed`, `json_serializable`: For code generation of immutable data classes and JSON serialization/deserialization.

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