# Flutter + GetX Reusable Template

A reusable Flutter + GetX project template with a clean, scalable architecture, API integration, state management, reusable widgets, storage, networking, and a complete CRUD API demo.

For every new project, you can reuse the `lib/` structure, merge the required dependencies into `pubspec.yaml`, run `flutter pub get`, and start developing.

---

## 🚀 Setup

### 1. Add Dependencies

Merge the following dependencies into your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  get_storage: ^2.1.1
```

Then run:

```bash
flutter pub get
```

### 2. Initialize GetStorage

Initialize `GetStorage` inside `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MyApp());
}
```

### 3. Run the Project

```bash
flutter run
```

---

# 📁 Full Folder Structure

```text
lib/
├── main.dart
│
└── app/
    │
    ├── bindings/
    │   └── initial_binding.dart
    │       # Registers global/permanent services
    │
    ├── core/
    │   ├── base_controller.dart
    │   │   # Base controller with runSafely()
    │   │   # Handles loading and errors automatically
    │   │
    │   └── base_repository.dart
    │       # Common API response and error handling
    │
    ├── data/
    │   │
    │   ├── models/
    │   │   ├── user_model.dart
    │   │   └── post_model.dart
    │   │
    │   ├── providers/
    │   │   └── api_provider.dart
    │   │       # Raw API endpoints
    │   │       # No business logic
    │   │
    │   └── repositories/
    │       ├── auth_repository.dart
    │       └── post_repository.dart
    │           # API business/data handling
    │           # Complete CRUD repository example
    │
    ├── modules/
    │   │
    │   ├── login/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   │
    │   ├── home/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   │
    │   ├── profile/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   │
    │   └── posts/
    │       ├── bindings/
    │       │   └── posts_binding.dart
    │       ├── controllers/
    │       │   └── posts_controller.dart
    │       └── views/
    │           └── posts_view.dart
    │
    ├── routes/
    │   ├── app_routes.dart
    │   └── app_pages.dart
    │
    ├── theme/
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   └── app_theme.dart
    │
    ├── utils/
    │   ├── validators.dart
    │   ├── extensions.dart
    │   └── helpers.dart
    │
    ├── widgets/
    │   ├── custom_button.dart
    │   ├── custom_textfield.dart
    │   ├── custom_appbar.dart
    │   ├── custom_snackbar.dart
    │   ├── loader.dart
    │   ├── empty_state_view.dart
    │   └── error_retry_view.dart
    │
    └── services/
        ├── storage_service.dart
        └── network_service.dart
```

---

# 🏗️ Architecture

The application follows a layered architecture:

```text
View
  ↓
Controller
  ↓
Repository
  ↓
Provider
  ↓
NetworkService (GetConnect)
  ↓
API
```

Each layer has a specific responsibility.

## View

The View is responsible only for the UI.

Responsibilities:

- Display UI
- Listen to controller state
- Handle user interactions
- Display loading/error/empty states

The View should never directly call an API or Repository.

Example:

```dart
Obx(() {
  return Text(controller.title.value);
});
```

## Controller

The Controller manages UI state and communicates with the Repository.

Responsibilities:

- Manage `.obs` reactive variables
- Handle user actions
- Manage loading states
- Call Repository methods
- Update UI state

The Controller should not directly call HTTP APIs.

## Repository

The Repository handles data/business logic between the Controller and Provider.

Responsibilities:

- Call Provider methods
- Convert JSON into Models
- Handle API responses
- Handle errors
- Return clean data to Controllers

## Provider

The Provider contains raw HTTP/API calls.

Responsibilities:

- GET requests
- POST requests
- PUT requests
- DELETE requests

The Provider should contain no business logic.

Example:

```dart
Future<Response> getPosts() {
  return get('/posts');
}
```

## NetworkService

`NetworkService` is responsible for common networking functionality using GetConnect.

Responsibilities:

- Base URL
- Authentication token
- HTTP configuration
- Interceptors
- Common network handling

---

# 🔄 Data Flow

The complete data flow is:

```text
User Interaction
      ↓
View
      ↓
Controller
      ↓
Repository
      ↓
Provider
      ↓
NetworkService
      ↓
API
      ↓
NetworkService
      ↓
Provider
      ↓
Repository
      ↓
Controller
      ↓
View
```

This architecture keeps every layer independent and easier to test, maintain, and replace.

---

# 🌐 Posts Module — Real API CRUD Demo

The project includes a complete CRUD example using:

```text
https://jsonplaceholder.typicode.com
```

JSONPlaceholder is a free fake REST API useful for development and testing.

## CRUD Operations

| Action | HTTP Method | Implementation |
|---|---|---|
| List posts | GET | `PostsController.loadPosts()` |
| Pull to refresh | GET | `PostsController.refreshPosts()` |
| Add post | POST | Bottom sheet → `_submitAdd()` |
| Edit post | PUT | Edit icon → Bottom sheet → `_submitEdit()` |
| Delete post | DELETE | Swipe-to-delete → `deletePost()` |

# 📋 Posts Features

The Posts module demonstrates:

- GET API integration
- POST API integration
- PUT API integration
- DELETE API integration
- Pull-to-refresh
- Loading states
- Empty states
- Error states
- Retry functionality
- Per-item loading
- Add post form
- Edit post form
- Delete confirmation
- Optimistic UI
- Rollback on failure
- Success snackbars
- Error snackbars

## Loading State

The module supports full-screen loading when posts are initially loaded.

```text
Loading
   ↓
Posts Loaded
```

## Pull to Refresh

Users can pull down on the posts list to refresh the data.

```text
Pull Down
   ↓
GET /posts
   ↓
Updated Posts
```

## Add Post

Users can create a new post using the Add Post bottom sheet.

Flow:

```text
Add Button
   ↓
Bottom Sheet
   ↓
Enter Title + Body
   ↓
POST /posts
   ↓
Update UI
```

## Edit Post

Users can edit an existing post.

Flow:

```text
Edit Button
   ↓
Edit Bottom Sheet
   ↓
Update Title + Body
   ↓
PUT /posts/{id}
   ↓
Update UI
```

## Delete Post

Posts can be deleted using swipe-to-delete.

Flow:

```text
Swipe
   ↓
Confirmation Dialog
   ↓
DELETE /posts/{id}
   ↓
Remove From UI
```

The implementation uses optimistic UI with rollback if the API request fails.

---

# 🔔 Custom Snackbar

The project includes a reusable custom snackbar.

### Success

```dart
CustomSnackbar.success("Saved!");
```

### Error

```dart
CustomSnackbar.error("Failed to save");
```

### Warning

```dart
CustomSnackbar.warning("Check input");
```

### Info

```dart
CustomSnackbar.info("New update available");
```

---

# 🧩 Adding a New Feature Module

When adding a new feature, follow the same structure used by the Posts module.

For example, for a `products` feature:

```text
lib/
└── app/
    ├── data/
    │   ├── models/
    │   │   └── product_model.dart
    │   ├── providers/
    │   │   └── api_provider.dart
    │   └── repositories/
    │       └── product_repository.dart
    │
    └── modules/
        └── products/
            ├── bindings/
            │   └── products_binding.dart
            ├── controllers/
            │   └── products_controller.dart
            └── views/
                └── products_view.dart
```

## Step 1 — Create the Model

Create:

```text
data/models/<feature>_model.dart
```

Example:

```text
data/models/product_model.dart
```

The Model represents the API data.

## Step 2 — Add Provider Endpoint

Add the API endpoint inside:

```text
data/providers/
```

The Provider should only contain raw API calls.

## Step 3 — Create Repository

Create:

```text
data/repositories/<feature>_repository.dart
```

The Repository should:

- Call the Provider
- Convert JSON to Models
- Handle API responses
- Handle errors
- Return data to the Controller

## Step 4 — Register Dependencies

If the Provider or Repository needs to be permanent/global, register it inside:

```text
initial_binding.dart
```

## Step 5 — Create Module

Create:

```text
modules/<feature>/
```

Inside the module:

```text
bindings/
controllers/
views/
```

The Controller should extend:

```dart
BaseController
```

## Step 6 — Add Routes

Add the new route inside:

```text
app/routes/app_routes.dart
```

Then register the corresponding page inside:

```text
app/routes/app_pages.dart
```

---

# 🔐 Storage

The project uses:

```text
GetStorage
```

for local storage.

Example:

```dart
await GetStorage.init();
```

You can use the storage service for:

- Authentication tokens
- User information
- App settings
- Local preferences
- Session data

---

# 🔑 Authentication Token

The networking layer supports automatically attaching an authentication token to API requests.

Once the token is stored, the network interceptor can automatically attach it to requests.

Example header:

```text
Authorization: Bearer YOUR_TOKEN
```

---

# 🌍 Connect Your Real Backend

When you are ready to connect your actual backend API, update the base URL inside:

```text
network_service.dart
```

Change:

```dart
httpClient.baseUrl = 'https://api.yourapp.com';
```

to your actual API URL.

Example:

```dart
httpClient.baseUrl = 'https://api.example.com';
```

The rest of the architecture can remain the same.

---

# 🛠️ Recommended Development Flow

For a new feature, follow this flow:

```text
1. Create Model
        ↓
2. Create Provider API
        ↓
3. Create Repository
        ↓
4. Create Binding
        ↓
5. Create Controller
        ↓
6. Create View
        ↓
7. Add Route
        ↓
8. Test API
        ↓
9. Test UI States
```

---

# 📌 Development Rules

Follow these rules when developing new features.

## Rule 1 — Views should not call APIs

Avoid:

```dart
controller.get('/users');
```

The View should communicate with the Controller only.

## Rule 2 — Controllers should not contain HTTP calls

Avoid:

```dart
httpClient.get('/users');
```

The Controller should call the Repository.

## Rule 3 — Providers should not contain business logic

Provider:

```text
API communication only
```

Repository:

```text
Data processing + API response handling
```

## Rule 4 — Use Models

Avoid passing raw JSON throughout the application.

Prefer:

```dart
UserModel
PostModel
ProductModel
```

instead of:

```dart
Map<String, dynamic>
```

where practical.

## Rule 5 — Reuse Common Widgets

Use reusable widgets from:

```text
app/widgets/
```

instead of creating duplicate UI components throughout the application.

---

# 🧪 Testing

Before considering a feature complete, test:

- Initial loading
- Successful API response
- Empty response
- API error
- Retry
- Pull-to-refresh
- Form validation
- Create operation
- Update operation
- Delete operation
- Network failure
- Authentication failure
- UI state updates

---

# 📦 Main Dependencies

The core template uses:

```yaml
dependencies:
  flutter:
    sdk: flutter

  get: ^4.6.6
  get_storage: ^2.1.1
```

---

# 🚀 Quick Start

```bash
flutter pub get
flutter run
```

---

# 📖 Architecture Summary

```text
                    ┌─────────────┐
                    │    View     │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │ Controller  │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │ Repository  │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  Provider   │
                    └──────┬──────┘
                           │
                           ▼
                  ┌─────────────────┐
                  │ NetworkService  │
                  │   GetConnect    │
                  └───────┬─────────┘
                          │
                          ▼
                     ┌─────────┐
                     │   API   │
                     └─────────┘
```

---

# 🎯 Goal

The goal of this template is to provide a reusable and scalable starting point for Flutter applications using:

- Flutter
- GetX
- GetStorage
- GetConnect
- Repository Pattern
- API integration
- Modular architecture
- Reusable widgets
- Centralized networking
- Centralized error handling
- Reactive state management

This structure is designed to make new Flutter projects faster to start, easier to maintain, and easier to scale.

---
