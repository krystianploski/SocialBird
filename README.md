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

## Application icon

`SocialBirdIcon.jpg` is the source image for Android, iOS, Web, Windows, and
macOS launcher icons. To regenerate platform icon assets after changing the
source image, run:

```bash
dart run flutter_launcher_icons
```

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

## Posts

- Create text posts up to 280 characters from the home screen.
- Posts are trimmed, validated, and displayed newest first.
- The feed updates immediately through `PostViewModel` and Provider.
- Locally created posts are stored in SQLite through Drift.
- The home screen displays an inspirational quote fetched using Dio from
  `https://dummyjson.com/quotes/random`.
- Quotes use `QuoteModel.fromJson`, MVVM, and a repository; network and invalid
  response errors are shown with an option to retry.
- Posts are attributed to the active account: the registered username is
  shown as the author name and as a lowercase `@username` handle.
- Usernames are unique regardless of capitalization, so each handle identifies
  one account.
- Since registration currently asks for one username, that value is used for
  both the author's display name and handle. A separate display name can be
  added later if users should be able to use names with spaces or change them
  independently of their unique handle.

---

## State Management

The project uses:

- Provider
- ChangeNotifier

Current ViewModels:

- WelcomeViewModel
- LoginViewModel
- RegisterViewModel
- PostViewModel
- QuoteViewModel

Providers are registered globally in `main.dart` using `MultiProvider`.

---

## Architecture

Current project structure:

```text
lib/
├── db/
├── models/
├── repositories/
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

Examples:

```text
UserModel
PostModel
QuoteModel
```

#### Services

Responsible for business operations.

Examples:

```text
UserService
QuoteApiService
```

Current responsibilities:

- `UserService` registers and authenticates users using the local database.
- `QuoteApiService` fetches and parses a random quote with Dio.
- `PostRepository` stores and observes locally created posts using Drift.
- `QuoteRepository` provides quotes to `QuoteViewModel`.

#### ViewModels

Responsible for UI logic.

Examples:

```text
LoginViewModel
RegisterViewModel
PostViewModel
```

`HomeView` validates the post form and delegates local post creation to
`PostViewModel`; its inspiration section loads quotes through
`QuoteViewModel`.

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

- User data is stored in the local database on the current device
- Inspiration quotes come from the public DummyJSON API and are not user-created
  content

---

# Planned Features

## Provider Improvements

- Reactive UI updates
- Loading states
- Error states

## Dependency Injection

Planned:

- get_it registration
- Service and repository injection

## UI Improvements

Planned:

- Password visibility toggle
- Loading indicators
- User profile page
- Post likes and comments

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