# SocialBird

SocialBird is a Flutter desktop application inspired by social media platforms such as X (Twitter).

The project is being developed following modern Flutter architecture patterns, including:
- GoRouter
- Provider
- ChangeNotifier
- MVVM
- Form Validation

---

# Features Implemented

## Navigation

- Welcome screen
- Login screen
- Registration screen
- Home screen

Navigation is handled using **GoRouter**.

---

## Authentication

### Registration

Users can create an account by providing:

- Username
- Email
- Password
- Confirm Password

Validation includes:

- Username required
- Username length (3-20 characters)
- Username can contain:
  - a-z
  - A-Z
  - 0-9
  - underscore (_)
- Email format validation
- Password minimum length validation
- Password confirmation validation

---

### Login

Users can log in using:

- Email
- Password

Validation includes:

- Correct email format
- Password minimum length
- User credential verification through UserService

---

## State Management

The project uses:

- Provider
- ChangeNotifier

Current ViewModels:

- WelcomeViewModel
- LoginViewModel
- RegisterViewModel

Providers are registered globally in `main.dart` using `MultiProvider`.

---

## Architecture

Current project structure:

```text
lib/
├── models/
├── router/
├── services/
├── view_models/
├── views/
├── widgets/
└── main.dart
```

### Layers

#### Models

Responsible for application data.

Example:

```text
UserModel
```

#### Services

Responsible for business operations.

Example:

```text
UserService
```

Current responsibilities:

- Register user
- Login user
- Store users in memory

#### ViewModels

Responsible for UI logic.

Examples:

```text
LoginViewModel
RegisterViewModel
```

#### Views

Responsible for user interface.

Examples:

```text
LoginView
RegisterView
HomeView
WelcomeView
```

---

## Form Validation

The application uses:

```dart
Form
TextFormField
GlobalKey<FormState>
```

Validation is executed through:

```dart
_formKey.currentState!.validate();
```

Each field provides its own validator and returns:

- `null` -> valid input
- `String` -> validation error message

---

## Current Limitations

At the moment:

- User data is stored only in memory
- Data is lost after application restart
- No database integration yet
- No API integration yet

---

# Planned Features

## Provider Improvements

- Reactive UI updates
- Loading states
- Error states

## Drift Database

Planned:

- Local user storage
- CRUD operations
- StreamBuilder integration

## Dio + Repository Pattern

Planned:

- API communication
- JSON deserialization
- Remote data fetching

## Dependency Injection

Planned:

- get_it registration
- Service and repository injection

## UI Improvements

Planned:

- Password visibility toggle
- Loading indicators
- User profile page
- Feed functionality
- Post creation

---

# Build

Install dependencies:

```bash
flutter pub get
```

Run application:

```bash
flutter run
```

---

# Author

Krystian Płoski

Project
Flutter + Dart