# Flutter Secure Auth

A production-ready Flutter authentication and user management application built using **BLoC**, **Clean Architecture**, **JWT Authentication**, **Refresh Tokens**, and **Secure Local Storage**.

This project demonstrates how to build a scalable Flutter application that follows industry-standard architecture and engineering practices while providing a complete authentication lifecycle, profile management, and secure session handling.

---

## Features

### Authentication

* User Registration
* User Login
* JWT Access Token Authentication
* Refresh Token Support
* Automatic Token Refresh on Expiration
* Secure Token Storage using Flutter Secure Storage
* Logout Functionality

### Profile Management

* Fetch User Profile
* Update User Profile
* Soft Delete User Account
* Local Profile Caching
* Cache-First Loading Strategy

### Architecture

* Clean Architecture
* BLoC State Management
* Repository Pattern
* Data Source Separation
* Dependency Injection Ready
* Reusable Widgets and Components

### User Experience

* Animated Splash Screen
* Form Validation using Formz
* Global Navigation Service
* Confirmation Dialogs
* Loading States
* Error Handling
* Success and Failure Feedback

---

## Tech Stack

### Frontend

* Flutter
* Dart

### State Management

* flutter_bloc
* equatable
* formz

### Networking

* Dio
* JWT Authentication
* Refresh Token Interceptor

### Local Storage

* Flutter Secure Storage

### Functional Programming

* dartz (Either Pattern)

---

## Project Structure

```text
lib/
│
├── login/
│   ├── bloc/
│   ├── data/
│   ├── presentation/
│   └── model/
│
├── signup/
│   ├── bloc/
│   ├── data/
│   ├── presentation/
│   └── model/
│
├── splash/
│   ├── bloc/
│   ├── domain/
│   └── presentation/
│
├── profile/
│   ├── bloc/
│   ├── data/
│   │   ├── cache/
│   │   ├── repository/
│   │   └── model/
│   └── presentation/
│
├── landing/
│
└── utils/
    ├── network/
    ├── cache/
    ├── navigation/
    ├── dialogue/
    ├── common_model/
    └── widgets/
```

---

## Authentication Flow

```text
User Login
    │
    ▼
Receive JWT Access Token + Refresh Token
    │
    ▼
Store Securely in Flutter Secure Storage
    │
    ▼
Access Protected APIs
    │
    ▼
Access Token Expires
    │
    ▼
Interceptor Detects 401
    │
    ▼
Refresh Token API Call
    │
    ▼
Store New Tokens
    │
    ▼
Retry Original Request
```

---

## Profile Caching Strategy

To improve user experience and reduce unnecessary network calls, the profile module uses a cache-first strategy.

```text
Open Profile Screen
        │
        ▼
Check Local Cache
        │
 ┌──────┴──────┐
 │             │
 ▼             ▼
Found       Not Found
 │             │
 ▼             ▼
Show Cache   Call API
 │
 ▼
Refresh Cache in Background
```

Benefits:

* Faster profile loading
* Reduced API usage
* Better offline experience
* Improved perceived performance

---

## Security Features

### Secure Storage

All sensitive information is stored using:

```text
Flutter Secure Storage
```

Stored data:

* Access Token
* Refresh Token
* Cached Profile Data

### Token Refresh

The application automatically handles expired access tokens using a custom Dio interceptor.

Features:

* Automatic refresh token calls
* Queued request handling
* Retry failed requests
* Automatic logout when refresh token expires

### Soft Delete

User accounts are never permanently deleted immediately.

Instead:

```text
deleted = true
enabled = false
```

This allows:

* Audit trails
* Account recovery
* Regulatory compliance
* Safer account management

---

## Validation Rules

### Email Validation

* Must be a valid email format

### Password Validation

Requirements:

* Minimum 8 characters
* At least one uppercase letter
* At least one lowercase letter
* At least one digit
* At least one special character

Regex:

```regex
^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$
```

---

## Screens

### Splash Screen

* Animated splash image
* Authentication check
* App initialization

### Login Screen

* Email validation
* Password validation
* Secure authentication

### Signup Screen

* User registration
* Form validation
* Success handling

### Profile Screen

* View profile
* Update profile
* Delete account
* Logout

---

## Getting Started

### Clone Repository

```bash
git clone https://github.com/<username>/flutter-secure-auth.git
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Backend API Endpoints

### Authentication

```http
POST /auth/signup
POST /auth/login
POST /auth/refresh-token
```

### User

```http
GET    /users/profile
PUT    /users/profile
DELETE /users/profile
POST   /users/reset-password
```

---

## Key Learning Outcomes

This project demonstrates practical experience with:

* Flutter Application Architecture
* BLoC Pattern
* Clean Architecture Principles
* JWT Authentication
* Refresh Token Flow
* Secure Storage
* API Integration with Dio
* State Management
* Local Caching
* Error Handling
* Production-Ready Mobile Development

---

## Future Improvements

* Biometric Authentication
* Dark Mode Support
* Social Login (Google, Apple)
* Multi-language Support
* Offline Synchronization
* Unit Testing
* Integration Testing
* CI/CD Pipeline
* Dependency Injection Framework (GetIt)

---

## License

This project is available for educational and portfolio purposes.
